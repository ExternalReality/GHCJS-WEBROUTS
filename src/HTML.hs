{-# LANGUAGE OverloadedStrings #-}

module HTML (html) where

import Data.Monoid
import Text.Blaze.Html5 hiding (html)
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.String
import Prelude hiding (div)

html :: String
html = renderHtml html'

html' :: Html
html' = do  todoForm
            todoList
            
todoForm :: Html
todoForm = div $ do               
  label ! A.for "todo_input" $ "New Todo: "
  input ! A.id "todo_input" ! A.type_ "text"

todoList :: Html
todoList = ol ! A.id "todo_list" $ mempt

