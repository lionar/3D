module Page.Home exposing (Model, Msg, init, toSession, toTheme, view)

import Card
import Element exposing (Element, column, fill, height, maximum, row, scrollbarY, spacing, width)
import Html exposing (Html)
import Models exposing (models)
import Page
import Session exposing (Session)
import Theme exposing (Theme)

type alias Model =
    { models : List Models.Model
    , session : Session
    , theme : Theme
    }

type Msg
    = NoOp

init : Session -> Theme -> ( Model, Cmd Msg )
init session theme =
    ( { models = models 
      , theme = theme
      , session = session
      }
    , Cmd.none
    )

toSession : Model -> Session
toSession model =
    model.session

toTheme : Model -> Theme
toTheme model =
    model.theme

view : Model -> { title : String, content : Html msg }
view model =
    { title = "Schemes"
    , content = body model
    }

body : Model -> Html msg
body model =
    Page.wrapper model.theme.background
    <|
        column
            [ width fill
            , height fill
            , Element.padding 16
            ]
            [ column
                [ width <| maximum 1200 fill
                , height fill
                , scrollbarY
                , Element.paddingEach
                    { top = 0
                    , right = 0
                    , bottom = 72
                    , left = 0
                    }
                ]
                [ row 
                    [ spacing 16
                    ]
                    <| List.map (card model.theme) model.models
                ]                
            ]

card : Theme -> Models.Model -> Element msg
card theme model =
    Card.view 
        theme 
        model
        [ Element.alignTop ]
