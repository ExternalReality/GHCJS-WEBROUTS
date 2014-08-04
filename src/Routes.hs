{-# LANGUAGE OverloadedStrings  #-}

module Routes where

import Data.Text
import Control.Applicative
import Web.Routes


data SiteMap = Home
             | Todos
             | Binding
             | Count Int
               deriving (Show)

instance PathInfo SiteMap where
  toPathSegments Home      = ["#home"]
  toPathSegments Todos     = ["#todos"]
  toPathSegments Binding   = ["#binding"]
  toPathSegments (Count o) = ["#count", pack . show $ o]

  fromPathSegments = Home    <$ segment "#home"    <|>
                     Todos   <$ segment "#todos"   <|>
                     Binding <$ segment "#binding" <|>
                     Count   <$ segment "#count"   <*> fromPathSegments
