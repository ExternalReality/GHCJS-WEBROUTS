{-# LANGUAGE OverloadedStrings #-}

module Template.Html (html) where

import Data.Monoid
import Prelude hiding (div, head)
import Text.Blaze.Html.Renderer.String
import Text.Blaze.Html5 hiding (html)
import Web.Routes
import Network.URI hiding (path)
import Data.Text hiding (drop)

import Routes

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Template.Css as C

html :: String
html = renderHtml html'

html' :: Html
html' = H.html $
  body $ do
    navigationArea
    pageContentContext
    css

css :: Html
css = style $ toHtml C.css
    
navigationArea :: Html
navigationArea = 
  nav ! A.id "navigationArea"    $ do
    navigationLink Home      "Home"
    navigationLink Binding   "Binding"
    navigationLink Todos     "Todos"
    navigationLink (Count 3) "Count"

navigationLink :: SiteMap -> Text -> Html 
navigationLink route text =
  a ! A.href (path route) 
    ! A.class_ "navigation-link" $ 
      toHtml text

path :: SiteMap -> AttributeValue
path sm = preEscapedToValue $ 
  "file:///home/external-reality/dev/todo-client/.cabal-sandbox/bin/todo-client.js_.jsexe/index_d.html" <>
  drop 1 (unEscapeString . unpack . toPathInfo $ sm)

pageContentContext :: Html
pageContentContext = div ! A.id "context" $ mempty
