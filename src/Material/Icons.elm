module Material.Icons exposing (add, add_circle, arrow_back, change_history, check, delete, download, edit, highlight, play_arrow, save)

import Element exposing (Element)
import Svg exposing (g, rect, svg)
import Svg.Attributes exposing (d, enableBackground, fill, height, viewBox, width)


add : Element msg
add =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" ] []
        , Svg.path [ d "M0 0h24v24H0z", fill "none" ] [] 
        ]

add_circle : Element msg
add_circle =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M0 0h24v24H0z", fill "none" ] []
        , Svg.path [ d "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11h-4v4h-2v-4H7v-2h4V7h2v4h4v2z" ] [] 
        ]

arrow_back : Element msg
arrow_back =
    Element.html <|
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "currentColor" ] 
        [ Svg.path [ fill "none", d "M0 0h24v24H0V0z" ] [], Svg.path 
            [ d """M19 11H7.83l4.88-4.88c.39-.39.39-1.03 0-1.42-.39-.39-1.02-.39-1.41 0l-6.59 6.59c-.39.39-.39 1.02 
                    0 1.41l6.59 6.59c.39.39 1.02.39 1.41 
                    0 .39-.39.39-1.02 0-1.41L7.83 13H19c.55 0 1-.45 1-1s-.45-1-1-1z""" ] 
            [] 
        ]

change_history : Element msg
change_history =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M12 7.77L18.39 18H5.61L12 7.77M12 4L2 20h20L12 4z" ] []
        , Svg.path [ d "M0 0h24v24H0V0z", fill "none" ] [] 
        ]

check : Element msg
check =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M0 0h24v24H0z", fill "none" ] []
        , Svg.path [ d "M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" ] [] 
        ]

delete : Element msg
delete =
    Element.html <|
    svg [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z" ] []
        , Svg.path [ d "M0 0h24v24H0z", fill "none" ] [] 
        ]

download : Element msg
download =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z" ] []
        , Svg.path [ d "M0 0h24v24H0z", fill "none" ] [] 
        ]

edit : Element msg
edit =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d """M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 
            0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z""" ] []
        , Svg.path [ d "M0 0h24v24H0z", fill "none" ] [] 
        ]

highlight : Element msg
highlight =
    Element.html <|
    svg
        [ enableBackground "new 0 0 24 24", height "24", width "24", viewBox "0 0 24 24", fill "currentColor" ]
        [ g [] [ rect [ fill "none", height "24", width "24" ] [] ], g [] [ g [] [ g [] 
            [ Svg.path 
                [ d """M6,14l3,3v5h6v-5l3-3V9H6V14z M11,2h2v3h-2V2z M3.5,5.88l1.41-1.41l2.12,2.12L5.62,8L3.5,5.88z 
                    M16.96,6.59l2.12-2.12 l1.41,1.41L18.38,8L16.96,6.59z"""
                ] [] ] ] ] 
        ]

play_arrow : Element msg
play_arrow =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M8 5v14l11-7z" ] [], Svg.path [ d "M0 0h24v24H0z", fill "none" ] [] ]

save : Element msg
save =
    Element.html <|
    svg 
        [ height "24", viewBox "0 0 24 24", width "24", fill "currentColor" ] 
        [ Svg.path [ d "M0 0h24v24H0z", fill "none" ] []
        , Svg.path [ d """M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 
                        16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z""" ] [] 
        ]