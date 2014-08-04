{-# LANGUAGE OverloadedStrings #-}

module Html.Components (css, labeledInputField) where

import Text.Blaze.Html
import Text.Blaze.Html5 hiding (em, html)

import qualified Clay as C
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

css :: C.Css -> Html
css sheet = H.style $ toHtml $ C.render sheet

labeledInputField :: AttributeValue -> Html -> Bool -> Html 
labeledInputField id_ label_ readonly = p $ do 
  input ! A.type_ "text" 
        ! A.maxlength "10" 
        ! A.id id_
        !? (readonly, A.readonly "")
  label label_
