{-# LANGUAGE OverloadedStrings #-}

module Template.Css (css) where 

import Data.Text.Lazy
import Clay

css :: String
css = unpack . render $ navigationLink

navigationLink :: Css
navigationLink = ".navigation-link" ?
  do 
    backgroundColor "#f9f9f9"
    padding (px 10) (px 10) (px 10) (px 10) 
    marginRight (px 10)                    
    fontSize (px 16)
    textIndent $ indent (px 0)
    border     solid (px 1) "#CDCDCD"
    fontFamily ["Verdana", "Tahoma"] [sansSerif]
    fontStyle normal
    height (px 35)
    lineHeight (px 35)
    width (px 100)
    textDecoration none
    textAlign $ alignSide sideCenter
    textShadow (px 1) (px 1) (px 0) "#ffffff"
    background ("#FFFFFF" :: Color)
    boxShadow  (px 0) (px 0) (px 8) (rgba 0 0 0 10)
    background $
      linearGradient (straight sideTop)
        [ ("#ffffff", pct 0.1)
	, ("#eeeeee", pct 14.9)
	, ("#ffffff", pct 85.0)
	]


-- ..navigationLink:hover {
-- 	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #e9e9e9), color-stop(1, #f9f9f9) );
-- 	background:-moz-linear-gradient( center top, #e9e9e9 5%, #f9f9f9 100% );
-- 	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#e9e9e9', endColorstr='#f9f9f9');
-- 	background-color:#e9e9e9;
-- }..navigationLink:active {
-- 	position:relative;
-- 	top:1px;
-- }</style>
-- /* This button was generated using CSSButtonGenerator.com */
