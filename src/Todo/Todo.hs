module Site where


todoHandler :: Handler ()
todoHandler = do
  context <- context `liftM` get

  liftIO $ do
    htmlElementSetInnerHTML context html
    doc <- fromJust `liftM` currentDocument

    todoInput <- findInputElement doc "todo_input"
    todoList  <- getElementById doc ("todo_list" :: String)

    elementOnkeydown todoInput $ do
      e <- event
      keyCode <- liftIO $ uiEventGetKeyCode e
      when (keyCode == 13) $ liftIO $ do 
        todoText <- htmlInputElementGetValue todoInput
        liElem   <- fromMaybe (error "could not create list element") `liftM` documentCreateElement doc ("li" :: String)
        nodeAppendChild todoList (Just liElem)
        htmlElementSetInnerHTML (castToHTMLElement liElem) (todoText :: String)
        htmlInputElementSetValue todoInput ("" :: String)

  return ()

