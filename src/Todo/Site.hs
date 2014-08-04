module Todo.Site (todoHandler) where

import Control.Monad
import Control.Monad.Trans.State
import Control.Monad.Trans
import Data.Maybe
import GHCJS.DOM 
import GHCJS.DOM.Document
import GHCJS.DOM.Element
import GHCJS.DOM.EventM
import GHCJS.DOM.HTMLElement (htmlElementSetInnerHTML)
import GHCJS.DOM.HTMLInputElement (htmlInputElementGetValue, htmlInputElementSetValue)
import GHCJS.DOM.Node
import GHCJS.DOM.Types
import GHCJS.DOM.UIEvent

import DOMQueries
import Todo.Html (html, dynamicTodoListItem)
import Types

todoHandler :: Handler ()
todoHandler = do
  ctx <- context `liftM` get

  liftIO $ do
    htmlElementSetInnerHTML ctx html
    doc <- fromJust `liftM` currentDocument

    todoInput <- findInputElement doc "todo-input"
    todoList  <- getElementById doc ("todo-list" :: String)

    elementOnkeydown todoInput $ do
      e <- event
      keyCode <- liftIO $ uiEventGetKeyCode e
      when (keyCode == 13) $ liftIO $ do 
        todoText <- htmlInputElementGetValue todoInput
        liElem   <- fromMaybe (error "could not create list element") `liftM` documentCreateElement doc ("li" :: String)
        nodeAppendChild todoList (Just liElem)
        let item = dynamicTodoListItem todoText
        htmlElementSetInnerHTML (castToHTMLElement liElem) item
        htmlInputElementSetValue todoInput ("" :: String)

  return ()
