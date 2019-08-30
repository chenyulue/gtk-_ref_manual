{-# LANGUAGE OverloadedStrings, 
             OverloadedLabels #-}
module Main where

import qualified GI.Gtk as Gtk
import Data.GI.Base
import Data.Functor (void)

main :: IO ()
main = do
    app <- new Gtk.Application [ #applicationId := "org.gtk.example"
                            , #flags := []
                            ]
    void $ on app #activate $ addWin app
    void $ #run app Nothing
    
addWin :: Gtk.Application -> IO ()
addWin app = do
    win <- new Gtk.Window [ #title := "Window"
                        , #defaultWidth := 200
                        , #defaultHeight := 200
                        ]
    btn <- new Gtk.Button [ #label := "Hello World"
                        ]
    on btn #clicked $ printHello >> Gtk.widgetDestroy win
    
    box <- new Gtk.ButtonBox [ #orientation := Gtk.OrientationHorizontal]
    #add box btn
    #add win box
    
    #showAll win
    #addWindow app win

printHello :: IO ()
printHello = putStrLn "Hello World"    