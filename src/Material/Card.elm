module Material.Card exposing (title, view)

import Element exposing (Element, clip, column, fill, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Material.Elevation as Elevation
import Theme exposing (Theme)


view : Theme -> List (Element.Attribute msg) -> List (Element msg) -> Element msg
view theme attrs elements =
    column
        (List.append
            [ Elevation.z1
            , width fill
            , Background.color theme.surface
            , Font.color theme.onSurface
            , Border.rounded 4
            , clip
            ]
            attrs)
        elements


title : String -> Element msg
title text =
    Element.el 
        [ Font.size 20
        , Font.bold
        ] 
        (Element.text text )