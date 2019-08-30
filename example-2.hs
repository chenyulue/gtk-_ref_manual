{-# LANGUAGE OverloadedStrings, 
             OverloadedLabels #-}
module Main where

import qualified GI.Gtk as Gtk
import Data.GI.Base
import Data.Functor (void)

main :: IO ()
main = do
    --Create a new application
    app <- new Gtk.Application [ #applicationId := "org.gtk.example"
                            , #flags := []
                            ]
    --When get a *activate* signal, add a new window to the application
    void $ on app #activate $ addWin app
    --Run the application, and the *activate* signal is sent
    --If there are not any open windows in the application, it will shutdown
    --automatically if you don't force the application to stay alive
    void $ #run app Nothing
    
addWin :: Gtk.Application -> IO ()
addWin app = do
    --Create a new window, with its title set to "Window" and its border width set to 10 pixels
    win <- new Gtk.Window [ #title := "Window"
                        , #borderWidth := 10
                        ]
    --Construct the container that is going to pack our buttons
    grid <- new Gtk.Grid []
    --Pack the container in the window
    #add win grid
    
    btn1 <- new Gtk.Button [ #label := "Button 1"
                        ]
    on btn1 #clicked printHello
    
    --Place the first button in the grid cell (0,0), and make it fill
    --just 1 cell horizontally and verticaly (i.e. no spanning)
    #attach grid btn1 0 0 1 1
    
    btn2 <- new Gtk.Button [ #label := "Button 2"
                         ]
    on btn2 #clicked printHello
    
    --Place the second button in the grid cell (1,0), and make it fill
    --just 1 cell horizontally and vertically (i.e. no spanning)
    #attach grid btn2 1 0 1 1
    
    btn3 <- new Gtk.Button [ #label := "Quit"
                         ]
    on btn3 #clicked $ Gtk.widgetDestroy win
    
    --Place the Quit button in the grid cell (0,1), and make it 
    --span 2 columns
    #attach grid btn3 0 1 2 1
    
    --Now that we have finished packing our widgets, we show them all
    --in one go, by calling *widgetShowAll* on the window. This call 
    --recursively calls *widgetShow* on all widgets that are contained 
    --in the window, directly or indirectly
    #showAll win
    --Finally the window needs to be added to the application, otherwise
    --the window will be opened and then closed immediately
    #addWindow app win

printHello :: IO ()
printHello = putStrLn "Hello World"