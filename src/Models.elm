module Models exposing (Model, getImage, getModel, models)

type alias Model =
    { id : String
    , title : String
    , description : String
    , images : List String
    , url : String
    , tris : Int
    }

models : List Model
models = 
    [ aspis
    , zenith
    ]

aspis : Model
aspis =
    { id = "1"
    , title = "Aspis"
    , description = "The aspis is an ancient greek shield and was the most important equipment of the ancient greek warriors."
    , images = [ "/assets/images/aspis/top back.jpg", "/assets/images/aspis/back.jpg" ]
    , url = "/resources/aspis.rar"
    , tris = 6120
    }

zenith : Model
zenith =
    { id = "2"
    , title = "Zenith"
    , description = "Zenith description"
    , images = [ "/assets/images/zenith/angle.jpg" ]
    , url = "/resources/zenith.rar"
    , tris = 0
    }

getImage : Model -> String
getImage model =
    let maybeImage = List.head model.images
    in case maybeImage of
        Nothing -> "/assets/images/not-found.png"
        Just image -> image

getModel : String -> Maybe Model
getModel id =
    List.head <| List.filter (isId id) models

isId : String -> Model -> Bool
isId id model =
    id == model.id