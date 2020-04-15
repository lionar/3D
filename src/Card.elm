module Card exposing (view)

import Element exposing (Element, clip, column, el, fill, height, px, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Material.Card as Card
import Material.Icons as Icon
import Models
import Route
import Theme exposing (Theme)


view : Theme -> Models.Model -> List (Element.Attribute msg) -> Element msg
view theme model attrs =
    Card.view theme 
        (List.append 
            [ width (px 350)
            , Element.pointer
            , Element.htmlAttribute <| 
                Html.Attributes.style "align-self" "stretch"
            ]
            attrs)
        [ link theme model
        , actions theme model.url model.tris
        ]

link : Theme -> Models.Model -> Element msg
link theme model =
    Element.link []
        { url = Route.toString <| Route.Model model.id
        , label = mainArea theme model
        }

mainArea : Theme -> Models.Model -> Element msg
mainArea theme model =
    column 
        [ Element.inFront (hover theme)
        ] 
        [ Element.image 
            [ width fill
            ]
            { src = Models.getImage model
            , description = ""
            }
        , content theme model
        ]

content : Theme -> Models.Model -> Element msg
content theme { description, title } =
    column 
        [ Element.padding 16
        , Element.spacingXY 0 16
        ] 
        [ column [] 
            [ Card.title title ]
        , column [] 
            [ Element.el 
                [ Font.size 14
                , Font.color theme.secondaryOnBackground
                , Font.medium
                ]
                <| Element.paragraph []
                    [ Element.text description ]
            ]
        ]

actions : Theme -> String -> Int -> Element msg
actions theme url tris =
    Element.row 
        [ width fill
        , Element.alignBottom
        , Element.padding 8
        ] 
        [ trisElement theme tris
        , Element.download
            [ width (px 48)
            , height (px 48)
            , Border.rounded 50 
            , clip
            , Element.padding 12
            , Font.color (Theme.highlight theme.kind 0.6)
            , Element.alignRight
            , Element.pointer
            , Element.mouseDown
                [ Background.color <| Theme.highlight theme.kind 0.12
                ]
            , Element.mouseOver 
                [ Background.color <| Theme.highlight theme.kind 0.04
                ]
            ]
            { url = url
            , label = Icon.download 
            } 
        ]

trisElement : Theme -> Int -> Element msg
trisElement theme tris =
    Element.row [] 
        [ el
            [ width (px 48)
            , height (px 48)
            , Border.rounded 50 
            , clip
            , Element.padding 12
            , Font.color (Theme.highlight theme.kind 0.6)
            ]
            Icon.change_history
        , el 
            [ Font.size 16
            , Font.medium
            ] <| text <| String.fromInt tris
        ]
    


hover : Theme -> Element msg
hover theme =
    el 
        [ width fill
        , height fill
        , Element.mouseDown
            [ Background.color <| Theme.highlight theme.kind 0.12
            ]
        , Element.mouseOver 
            [ Background.color <| Theme.highlight theme.kind 0.04
            ]
        ] <| Element.text ""