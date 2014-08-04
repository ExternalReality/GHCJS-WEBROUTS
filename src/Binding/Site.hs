module Binding.Site (bindingHandler) where

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.State
import Data.Maybe
import Data.Monoid ((<>))
import FRP.Sodium hiding (split)
import GHCJS.DOM 
import GHCJS.DOM.Element
import GHCJS.DOM.EventM
import GHCJS.DOM.HTMLElement (htmlElementSetInnerHTML)
import GHCJS.DOM.HTMLInputElement (htmlInputElementGetValue, htmlInputElementSetValue)
import GHCJS.DOM.Types

import DOMQueries

import Binding.Html (html)
import Types

bindingHandler :: Handler ()
bindingHandler = do
  context <- context `liftM` get

  liftIO $ do
    htmlElementSetInnerHTML context html
    doc <- fromJust `liftM` currentDocument

    firstNameInputField <- findInputElement doc "firstNameInput"
    lastNameInputField  <- findInputElement doc "lastNameInput"
    fullNameInputField  <- findInputElement doc "fullNameInput"
    
    (firstNameEvents, fire) <- sync newEvent
    (lastNameEvents, fire') <- sync newEvent
     
    elementOnkeyup firstNameInputField $ publishInputValues fire
    elementOnkeyup lastNameInputField  $ publishInputValues fire'

    let fullNameEvents = firstNameEvents <> lastNameEvents

    sync $ listen fullNameEvents $ const $ do
      val  <- htmlInputElementGetValue firstNameInputField                             
      val' <- htmlInputElementGetValue lastNameInputField
      htmlInputElementSetValue fullNameInputField $ val <> " " <> val'                             

  return ()

publishInputValues :: (IsHTMLInputElement a) => (String -> Reactive ()) 
                                             -> EventM UIEvent a ()
publishInputValues push = do
      t <- target
      liftIO $ do 
        val <- htmlInputElementGetValue (castToHTMLInputElement t)                             
        sync $ push val
