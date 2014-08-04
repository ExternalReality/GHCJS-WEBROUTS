{-# LANGUAGE OverloadedStrings #-}

module Binding.Html (html) where 

import Prelude hiding (div)
import Text.Blaze.Html
import Text.Blaze.Html.Renderer.String
import Text.Blaze.Html5 hiding (em, html)
import qualified Text.Blaze.Html5.Attributes as A

import qualified Binding.Css as C (formCss)
import Html.Components (css, labeledInputField)

html :: String
html = renderHtml content    

content :: Html
content = do
  nameForm
  css C.formCss

nameForm :: Html
nameForm = section ! A.id "formContainer" $ do
    form $ do
      labeledInputField "firstNameInput" "First Name" False
      labeledInputField "lastNameInput"  "Last Name" False
      labeledInputField "fullNameInput"  "Full Name" True
    advertisement

advertisement :: Html
advertisement =  div ! A.id "ad" $ "Powered by GHCJS"
