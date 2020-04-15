module Page.Model exposing (Model, Msg, init, toSession, toTheme, view)

import Element exposing (Element, fill, fillPortion, height, px, spacing, width)
import Html exposing (Html)
import Models
import Page
import Session exposing (Session)
import Theme exposing (Theme)

type alias Model =
    { model : Models.Model
    , imageNumber : Int
    , session : Session
    , theme : Theme
    }

type Msg
    = NoOp

init : Session -> Theme -> Models.Model -> ( Model, Cmd Msg )
init session theme model =
    ( { model = model
      , imageNumber = 1
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
    , content = Page.wrapper model.theme.background (body model.model)
    }

body : Models.Model -> Element msg
body model =
    Element.column [ height fill ]
        [ Element.row 
            [ height (fillPortion 2)
            , Element.clip
            ] 
            [ image <| Models.getImage model
            ]
        , Element.row 
            [ height (fillPortion 1)
            , Element.clip
            ] 
            []
        ]
   


    -- Element.row 
    --     [ spacing 16 ] 
    --     <| List.map image model.images

image : String -> Element msg
image src =
    Element.image 
        []
        { src = src
        , description = ""
        }