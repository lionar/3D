module Theme exposing (Kind(..), Theme, dark, highlight, light, switch)

import Element exposing (Color, rgb255, rgba255)
import Material.Color


type Kind
    = Light
    | Dark


type alias Theme =
    { kind : Kind
    , primary : Color
    , secondary : Color
    , surface : Color
    , background : Color
    , onPrimary : Color
    , onSecondary : Color
    , onSurface : Color
    , onBackground : Color
    , secondaryOnBackground : Color
    , error : Color
    }


light : Theme
light =
    { kind = Light
    , primary = Material.Color.deepPurpleA700
    , secondary = Material.Color.tealA400
    , surface = Material.Color.white
    , background = Material.Color.white
    , onPrimary = Material.Color.white
    , onSecondary = Material.Color.black
    , onSurface = Material.Color.black
    , onBackground = Material.Color.black
    , secondaryOnBackground = rgba255 0 0 0 0.54
    , error = rgb255 176 0 32
    }


dark : Theme
dark =
    { kind = Dark
    , primary = Material.Color.deepPurpleA700
    , secondary = Material.Color.tealA400
    , surface = rgb255 66 66 66
    , background = rgb255 48 48 48
    , onPrimary = Material.Color.white
    , onSecondary = Material.Color.black
    , onSurface = Material.Color.white
    , onBackground = Material.Color.white
    , secondaryOnBackground = rgba255 255 255 255 0.54
    , error = Material.Color.red500
    }


highlight : Kind -> Float -> Color
highlight kind alpha =
    case kind of
        Light ->
            rgba255 0 0 0 alpha

        Dark ->
            rgba255 255 255 255 alpha


switch : Kind -> Theme
switch kind =
    case kind of
        Light ->
            dark

        Dark ->
            light
