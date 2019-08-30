{-# LANGUAGE OverloadedStrings,
             OverloadedLabels #-}
module Main where

import qualified GI.Gtk as Gtk
import Data.GI.Base
import Data.GI.Base.ManagedPtr (unsafeCastTo)
import Data.Functor
import Data.Maybe (fromJust)

main :: IO ()
main = do
    Gtk.init Nothing
    
    --Construct a GtkBuilder instance and load our UI description
    ui <- Gtk.builderNewFromFile "builder.ui"
    
    --Connect signal handlers to the constructed widgets
    --Since *builderGetObject* only gets an *Object*, we should
    --use *castTo* or *unsafeCastTo* to get the correct widget type
    win <- Gtk.builderGetObject ui "window" >>= unsafeCastTo Gtk.Window . fromJust
    void $ on win #destroy Gtk.mainQuit
    
    btn1 <- Gtk.builderGetObject ui "button1" >>= unsafeCastTo Gtk.Button . fromJust
    void $ on btn1 #clicked printHello
    
    btn2 <- Gtk.builderGetObject ui "button2" >>= unsafeCastTo Gtk.Button . fromJust
    void $ on btn2 #clicked printHello
    
    btn3 <- Gtk.builderGetObject ui "quit" >>= unsafeCastTo Gtk.Button . fromJust
    void $ on btn3 #clicked Gtk.mainQuit
    
    #showAll win
    Gtk.main
    
printHello :: IO ()
printHello = putStrLn "Hello World"