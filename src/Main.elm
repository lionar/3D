module Main exposing (main)

import Api
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html
import Json.Decode exposing (Value)
import Models
import Page
import Page.Home as Home
import Page.Model as ModelPage
import Page.Blank as Blank
import Page.Login as Login
import Page.NotFound as NotFound
import Page.Register as Register
import Route exposing (Route)
import Session exposing (Session)
import Theme exposing (Theme)
import Url exposing (Url)
import Viewer exposing (Viewer)



-- NOTE: Based on discussions around how asset management features
-- like code splitting and lazy loading have been shaping up, it's possible
-- that most of this file may become unnecessary in a future release of Elm.
-- Avoid putting things in this module unless there is no alternative!
-- See https://discourse.elm-lang.org/t/elm-spa-in-0-19/1800/2 for more.


type Model
    = Redirect Session
    | NotFound Session
    | Home Home.Model
    | ModelPage ModelPage.Model
    | Login Login.Model
    | Register Register.Model



-- MODEL


init : Maybe Viewer -> Url -> Nav.Key -> ( Model, Cmd Msg )
init maybeViewer url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromViewer navKey maybeViewer))



-- VIEW


view : Model -> Document Msg
view model =
    let
        viewPage toMsg config =
            let
                { title, body } =
                    Page.view config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            Page.view Blank.view

        NotFound _ ->
            Page.view NotFound.view

        Home home ->
            viewPage GotHomeMsg (Home.view home)

        ModelPage pageModel ->
            viewPage GotModelMsg (ModelPage.view pageModel)

        Login login ->
            viewPage GotLoginMsg (Login.view login)

        Register register ->
            viewPage GotRegisterMsg (Register.view register)

-- UPDATE


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | GotHomeMsg Home.Msg
    | GotModelMsg ModelPage.Msg
    | GotLoginMsg Login.Msg
    | GotRegisterMsg Register.Msg
    | GotSession Session


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Home home ->
            Home.toSession home

        ModelPage pageModel ->
            ModelPage.toSession pageModel

        Login login ->
            Login.toSession login

        Register register ->
            Register.toSession register

toTheme : Model -> Theme
toTheme page =
    case page of
        Redirect _ ->
            Theme.dark

        NotFound _ ->
            Theme.dark

        Login _ ->
            Theme.dark

        Home home ->
            Home.toTheme home

        ModelPage pageModel ->
            ModelPage.toTheme pageModel

        Register _ ->
            Theme.dark

changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model

        theme =
            toTheme model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Root ->
            ( model, Route.replaceUrl (Session.navKey session) Route.Home )

        Just Route.Home ->
            Home.init session theme
                |> updateWith Home GotHomeMsg model

        Just (Route.Model id) ->
            let maybeModel = Models.getModel id
            in case maybeModel of
                Nothing -> ( model, Route.replaceUrl (Session.navKey session) Route.Home )
                Just model3D ->
                    ModelPage.init session theme model3D
                        |> updateWith ModelPage GotModelMsg model

        Just Route.Logout ->
            ( model, Api.logout )

        Just Route.Login ->
            Login.init session
                |> updateWith Login GotLoginMsg model

        Just Route.Register ->
            Register.init session
                |> updateWith Register GotRegisterMsg model

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    if String.startsWith "/resources" url.path then
                        ( model, Nav.load url.path )
                    else case url.fragment of
                            Nothing ->
                                -- If we got a link that didn't include a fragment,
                                -- it's from one of those (href "") attributes that
                                -- we have to include to make the RealWorld CSS work.
                                --
                                -- In an application doing path routing instead of
                                -- fragment-based routing, this entire
                                -- `case url.fragment of` expression this comment
                                -- is inside would be unnecessary.
                                ( model, Cmd.none )

                            Just _ ->
                                ( model
                                , Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url)
                                )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( GotLoginMsg subMsg, Login login ) ->
            Login.update subMsg login
                |> updateWith Login GotLoginMsg model

        ( GotRegisterMsg subMsg, Register register ) ->
            Register.update subMsg register
                |> updateWith Register GotRegisterMsg model

        ( GotSession session, Redirect _ ) ->
            ( Redirect session
            , Route.replaceUrl (Session.navKey session) Route.Home
            )

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg _ ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        NotFound _ ->
            Sub.none

        Redirect _ ->
            Session.changes GotSession (Session.navKey (toSession model))

        Login login ->
            Sub.map GotLoginMsg (Login.subscriptions login)

        Home _ ->
            Sub.none

        ModelPage _ ->
            Sub.none

        Register register ->
            Sub.map GotRegisterMsg (Register.subscriptions register)


-- MAIN


main : Program Value Model Msg
main =
    Api.application Viewer.decoder
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
