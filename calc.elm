module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String exposing (..)


main =
    beginnerProgramm
        { model = init
        , view = view
        , update = update
        }



--Model


type alias Calculator =
    { add : Float -> Float -> Float
    , minus : Float -> Float -> Float
    , times : Float -> Float -> Float
    , divide : Float -> Float -> Float
    }


calculator : Calculator
calculator =
    { add = (\x y -> x + y)
    , minus = (\x y -> x - y)
    , times = (\x y -> x * y)
    , divide = (\x y -> x / y)
    }


type alias Model =
    { display : String
    , function : Float -> Float -> Float
    , saveValue : Float
    , append : Bool
    }


init : Model
init =
    { display = ""
    , function = (\x y -> y)
    , saveValue = 0
    , append = True
    }


parseFloat : String -> Float
parseFloat input =
    Result.withDefault 0 (String.toFloat input)


operation : Model -> (Float -> Float -> Float) -> Model
operation model function =
    { model
        | function = function
        , saveValue = (parseFloat model.display)
        , append = False
    }



--update


type Msg
    = None
    | Divide
    | Times
    | Minus
    | Add
    | Equal
    | Decimal
    | Zero
    | Number Int
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        None ->
            model

        Clear ->
            init

        Number number ->
            updateDisplay model number

        Decimal ->
            decimal model

        Zero ->
            zero model

        Divide ->
            operation model calculator.divide

        Times ->
            operation model calculator.times

        Add ->
            operation model calculator.add

        Minus ->
            operation model calculator.minus

        Equal ->
            equal model


updateDisplay : Model -> Int -> Model



--view
