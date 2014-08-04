{-# LANGUAGE OverloadedStrings #-}

module Todo.Css (todoCss) where 

import Clay

import Css.Colors 

todoCss :: Css 
todoCss = do
  todoContainer
  inputCss
  formLabelCss
  todoInputCss
  todoListCss

todoContainer :: Css
todoContainer = "#todo-container" ?
 do background   niceGrey
    display      inlineBlock
    border       solid (px 1) containerGrey
    borderRadius (px 5) (px 5) (px 5) (px 5)
    margin       (em 0.75) (em 0.75) (em 0.75) (em 0.75)
    padding      (px 10) (px 10) (px 10) (px 10)

todoInputCss :: Css
todoInputCss = "#todo-input" ? do
    margin auto auto auto auto

todoListCss :: Css
todoListCss = "#todo-list" ? 
  do    
    paddingLeft  (px 0)
    listStyleType none
    demoFont
    fontColor coolBreezeGrey
    todoText              
               
todoText :: Css
todoText = ".todo-text" ? paddingLeft (px 5) 

inputCss :: Css
inputCss = "input" ?
  do padding    (px 9) (px 9) (px 9) (px 9)
     demoFont
     border     solid (px 1) coolBreezeGrey
     outline    solid (px 0) (rgba 0 0 0 255)    
     background white
     boxShadow  (px 0) (px 0) (px 8) (rgba 0 0 0 10)
     background $
       linearGradient (straight sideTop)
	 [ (white , pct 0.1)
	 , ("#eeeeee", pct 14.9)
	 , (white, pct 85.0)
	 ]

formLabelCss :: Css
formLabelCss = "form label" ?
  do marginLeft (px 10)
     fontSize (px 13)           
     color coolBreezeGrey

demoFont :: Css 
demoFont = do 
  fontFamily ["Verdana", "Tahoma"] [sansSerif]
  fontSize   (px 12)
