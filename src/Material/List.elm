module Material.List exposing (Item, icon, link, singleElement, singleLine, text, twoLine)

import Element exposing (Element, fill, width, height, px, column, paddingXY, el, row, mouseOver, centerY, centerX, link, spacing)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Material.Icons
import Theme exposing (Theme)

type alias Item =
    { first : String
    , second : String
    , url : Maybe String
    }

singleLine : Theme -> List Item -> Element msg
singleLine theme items =
    column 
        [ width fill
        , Font.color theme.onBackground
        , paddingXY 0 8
        ]
        <| List.map (element theme) items

element : Theme -> Item -> Element msg
element theme item =
    case item.url of
        Nothing ->
            singleElement
                []
                [ icon theme [] Material.Icons.play_arrow 
                , text theme item.first
                ]
        Just url ->
            link theme url 
                (singleElement
                    []
                    [ icon theme [] Material.Icons.play_arrow 
                    , text theme item.first
                    ]
                ) 

singleElement : List (Element.Attribute msg) -> List (Element msg) -> Element msg
singleElement attrs elements =
    row 
        (List.append [ width fill
        , height (px 56)
        , Font.size 16
        , centerY
        ] attrs)
        [ row 
            [ width fill
            , height fill
            , spacing 24
            ] 
            elements
        ]

icon : Theme -> List (Element.Attribute msg) -> Element msg -> Element msg
icon theme attrs icon_ =
    el
        (List.append
            [ height fill
            , Element.paddingEach
                { top = 0
                , right = 0
                , bottom = 0
                , left = 16
                }
            , Font.color <| Theme.highlight theme.kind 0.44
            ] attrs)
                <| el 
                [ centerY
                ] icon_

text : Theme -> String -> Element msg
text theme txt =
    el 
        [ height fill
        , width fill
        , Element.paddingEach
            { top = 0
            , right = 16
            , bottom = 0
            , left = 0
            }
        , Border.widthEach
            { bottom = 1
            , left = 0
            , right = 0
            , top = 0
            }
        , Border.color <| Theme.highlight theme.kind 0.12
        ] <| el 
            [ Element.centerY
            ] 
            <| Element.text txt





-- Two line lists


twoLine : Theme -> List Item -> Element msg
twoLine theme items =
    column 
        [ width fill
        , Font.color theme.onBackground
        , paddingXY 0 8
        ]
        <| List.map (twoLineElement theme) items


twoLineElement : Theme -> Item -> Element msg
twoLineElement theme item =
    case item.url of
        Nothing ->
            twoElement theme item.first item.second
        Just url ->
            link theme url (twoElement theme item.first item.second) 

twoElement : Theme -> String -> String -> Element msg
twoElement theme text1 text2 =
    row 
        [ width fill, spacing 32 ] 
        [ el 
            [ centerY
            , centerX
            , Font.color <| Theme.highlight theme.kind 0.38
            ] 
            Material.Icons.play_arrow 
        , column 
            [ width fill
            , height (px 72)
            , Element.spacingXY 0 4
            ] 
            [ row 
                [ width fill
                , Font.size 16
                , centerY   
                ] 
                [ el 
                    [ Element.centerY
                    ] <| Element.text text1
                ]
            , row 
                [ width fill
                , Font.size 14
                , Font.color <| Theme.highlight theme.kind 0.54
                , centerY
                ] 
                [ el 
                    [ Element.centerY
                    ] <| Element.text text2
                ]
            ]
        ]


link : Theme -> String -> Element msg -> Element msg 
link theme url el =
    Element.el [ width fill ] <|
        Element.link 
            [ width fill
            , Element.pointer
            , Element.focused
                [ Background.color <| Theme.highlight theme.kind 0.12
                ]
            , Element.mouseDown
                [ Background.color <| Theme.highlight theme.kind 0.16
                ]
            , mouseOver
                [ Background.color <| Theme.highlight theme.kind 0.04 
                ]
            ]
            { url = url
            , label = el
            }