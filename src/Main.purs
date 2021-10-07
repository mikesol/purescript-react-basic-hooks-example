module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (Component, component, useState)
import React.Basic.Hooks as React
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

mkCounter :: Component Int
mkCounter = do
  component "Counter" \initialValue -> React.do
    counter /\ setCounter <- useState initialValue

    pure
      $ R.button
          { onClick: handler_ do
              setCounter (_ + 1)
          , children:
              [ R.text $ "Increment: " <> show counter ]
          }

main :: Effect Unit
main = do
  container <- getElementById "container" =<< (map toNonElementParentNode $ document =<< window)
  mkc <- mkCounter
  case container of
    Nothing -> throw "Container element not found."
    Just c  -> render (mkc 0) c