module DOMQueries ( findInputElement
                  , getDocument
                  , getElementById
                  , findBody
                  ) where

import Control.Monad
import Data.Monoid
import GHCJS.DOM.Document
import GHCJS.DOM.HTMLInputElement
import Data.Maybe
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Element
import GHCJS.DOM.HTMLElement
import GHCJS.DOM

{-# INLINE findInputElement #-}
findInputElement :: (IsDocument a) => a -> String -> IO HTMLInputElement
findInputElement doc elementId = do
    htmlElement <- fromMaybe (error errMsg) `liftM`
                   documentQuerySelector doc ("input#" <> elementId)
    return $ castToHTMLInputElement htmlElement
  where
    errMsg = "Failed to find input element with id: " <> elementId

{-# INLINE getElementById #-}
getElementById :: (IsDocument a) => a -> String -> IO Element
getElementById doc elementId = fromMaybe (error errMsg) `liftM`
  documentGetElementById doc elementId
  where
    errMsg = "Cannot find Element!"

{-# INLINE getDocument #-}
getDocument :: (IsDOMWindow w) => w -> IO Document
getDocument webView =
  fromMaybe (error "could not get document") `liftM`
            webViewGetDomDocument webView

{-# INLINE findBody #-}
findBody :: (IsDocument a) => a -> IO HTMLElement
findBody doc =
  fromMaybe (error "could not get document body") `liftM`
            documentGetBody doc
