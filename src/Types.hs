module Types (Handler, HandlerState(..)) where

import Control.Monad.Trans.State
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Document
import GHCJS.DOM.HTMLElement

type Handler = StateT HandlerState IO

data HandlerState = HandlerState { window   :: DOMWindow
                                 , document :: Document
                                 , context  :: HTMLElement
                                 }

