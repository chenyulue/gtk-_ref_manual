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
    --When runing this app, the *activate* signal is sent
    void $ #run app Nothing
    
    
addWin :: Gtk.Application -> IO ()
addWin app = do
    win <- new Gtk.Window [ #title := "Window"
                        , #defaultWidth := 200
                        , #defaultHeight := 200
                        ]   
    #showAll win
    #addWindow app win 