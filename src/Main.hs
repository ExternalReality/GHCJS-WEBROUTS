{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE TemplateHaskell    #-}
{-# LANGUAGE RecordWildCards    #-}

module Main where

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.State
import Data.ByteString.Char8 hiding (putStrLn, concat)
import Data.Maybe
import Data.Monoid ((<>))
import GHCJS.DOM 
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Document
import GHCJS.DOM.HTMLElement (htmlElementSetInnerHTML)
import GHCJS.DOM.Types
import GHCJS.Foreign
import GHCJS.Types
import JavaScript.JQuery hiding (target)
import Web.Routes

import Binding.Site (bindingHandler)
import DOMQueries
import Routes 
import Todo.Site (todoHandler)
import Types
import qualified Data.Text.IO as TIO
import qualified Template.Html as T (html)

foreign import javascript unsafe "window.location.hash" hash_url :: IO JSString

main :: IO ()
main = runWebGUI $ \ webView ->
  do body <- findBody =<< getDocument webView
     htmlElementSetInnerHTML body T.html
     initState <- initializeHandlerState "context"
     let site = mkSitePI (runRouteT routes)
     domWindowOnhashchange webView $
       liftIO $
         do url <- liftIO hash_url
            unbind "#context"
            let eitherHandler
                  = runSite "hello" site $ decodePathInfo (pack . fromJSString $ url)
            let handler = either error id eitherHandler
            evalStateT handler initState
     return ()

routes :: SiteMap -> RouteT SiteMap Handler ()
routes url = case url of
  Home      -> liftIO $ TIO.putStrLn $ toPathInfo url
  Todos     -> lift todoHandler
  Binding   -> lift bindingHandler
  (Count o) -> liftIO $ putStrLn $ "This is the number" <> show o

initializeHandlerState :: String -> IO HandlerState
initializeHandlerState contextId = do
   window   <- fromMaybe (error "Cannot get current window") `liftM` currentWindow
   document <- fromMaybe (error "Cannot get current document") `liftM` currentDocument
   context  <- fromMaybe (error "Cannot get context") `liftM` documentQuerySelector document ("#" <> contextId)
   
   return $ HandlerState window document (castToHTMLElement context)
