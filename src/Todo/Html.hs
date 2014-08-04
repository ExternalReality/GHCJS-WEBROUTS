{-# LANGUAGE OverloadedStrings #-}

module Todo.Html (html, dynamicTodoListItem) where

import Data.Monoid
import Text.Blaze.Html5 hiding (html)
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.String
import Prelude hiding (div, span)

import Todo.Css (todoCss)
import Html.Components

html :: String
html = renderHtml html'

html' :: Html
html' = do 
  todoContainer
  css todoCss
 
todoContainer :: Html
todoContainer = div ! A.id "todo-container" $ do
  todoForm
  todoList
                                         
todoForm :: Html
todoForm = div ! A.id "todoForm" $ todoInput
 
todoInput :: Html
todoInput =
  input ! A.id  "todo-input" 
        ! A.type_ "text"
        ! A.placeholder "What do you need to do?"
 
todoList :: Html
todoList = ol ! A.id "todo-list" $ mempty

dynamicTodoListItem :: String -> String
dynamicTodoListItem text = renderHtml $ span ! A.class_ "todo-item" $ do
                             checkOffBox
                             todoText $ toHtml text

checkOffBox :: Html
checkOffBox = input ! A.class_ "check-off-box"
                    ! A.type_  "checkbox"
                         
todoText :: Html -> Html
todoText = span ! A.class_ "todo-text"
