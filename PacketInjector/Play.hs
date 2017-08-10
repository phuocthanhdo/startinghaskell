{-# LANGUAGE OverloadedStrings #-}

module Play where

import Injector
import PacketGenerator
import qualified Data.ByteString.Char8 as C
import Data.ByteString (ByteString)
import Data.ByteString.Base16
-- import Data.List
import Network.Socket hiding (send, recv)
import Network.Socket.ByteString (recv, sendAll)
import Control.Monad
import Control.Concurrent

          
sendP :: String -> Integer -> IO ()
sendP uname n = do user <- getPlayer uname
                   conn <- joinWorld user
                   sendNTimes n conn tPacket
                   close conn

armyMis_ :: IO ()                  
armyMis_ = do bUsers <- players
              forM_ bUsers $ \u -> do
                forkIO $ do
                    tid <- myThreadId
                    conn <- joinWorld u
                    sendAll conn (armyRequest "3")
                    -- sendAll conn (armyRequest "1000218")
                    requestA conn tid

armyMis :: IO ()                  
armyMis  = do bUsers <- players
              forM_ bUsers $ \u -> do
                forkIO $ do
                    tid <- myThreadId
                    conn <- joinWorld u
                    sendAll conn armyBase
                    sendAll conn armyReward
                    sendAll conn armyMisList
                    listenA' conn tid

requestA :: Socket -> ThreadId -> IO ()
requestA conn t = do threadDelay 2000000
                     msg <- recv conn 2048
                     unless (C.isInfixOf "0300aa0801" $ encode msg) $ requestA conn t
                     when (C.isInfixOf "0300aa0801" $ encode msg) $ do
                         sendAll conn armyReward
                         sendAll conn armyMisList
                         listenA conn t
                    

listenA :: Socket -> ThreadId -> IO ()              
listenA conn t = do threadDelay 2000000
                    msg <- recv conn 2048
                    when (C.isInfixOf "0300a12905" $ encode msg) $ do
                        sendAll conn armyExit
                        threadDelay 1000000
                        C.putStrLn "exit Army!"
                        close conn
                        killThread t
                    unless (C.isInfixOf "2300e904" $ encode msg) $ listenA conn t
                    when (C.isInfixOf "2300e904" $ encode msg) $ do
                        sendAll conn armyBase
                        threadDelay 200000
                        forM_ (map (armyMisAward) ["1","2","3","4"]) $ \p -> do
                            sendAll conn p
                        threadDelay 1000000
                        recv conn 2048
                        forM_ (map (armyMisAccept) ["1","2","3","4"]) $ \p -> do
                            sendAll conn p
                        threadDelay 2000000
                        sendAll conn armyMisSpdUp
                        sendAll conn armyMisList
                        listenA conn t
                    
listenA' :: Socket -> ThreadId -> IO ()              
listenA' conn t = do    threadDelay 200000
                        msg <- recv conn 2048
                        when (C.isInfixOf "0300a12905" $ encode msg) $ do
                            C.putStrLn "done!"
                            close conn
                            killThread t
                        unless (C.isInfixOf "2300e904" $ encode msg) $ listenA' conn t
                        when (C.isInfixOf "2300e904" $ encode msg) $ do
                            forM_ (map (armyMisAward) ["1","2","3","4"]) $ \p -> do
                                sendAll conn p
                            threadDelay 1000000
                            forM_ (map (armyMisAccept) ["1","2","3","4"]) $ \p -> do
                                sendAll conn p
                            threadDelay 2000000
                            sendAll conn armyMisSpdUp
                            sendAll conn armyMisList
                            listenA' conn t

chapterOne = map (chapter) ["C01B02","C01B03","C01B04","C01B05","C01B06","C01B07","C01B08"]
chapterTwo = map (chapter) ["C02B01","C02B02","C02B03","C02B04","C02B05","C02B05","C02B07","C02B08","C02B09","C02B10"]


lvlup = do u <- getPlayer "itunes23"
           conn <- joinWorld u
           sendAll conn $ chapter "C01B02"
           listenU conn chapterTwo

listenU :: Socket -> [ByteString] -> IO ()           
listenU conn [] = do threadDelay 2000000
                     C.putStrLn "done!"
                     close conn
listenU conn chapter = do  threadDelay 4000000
                           msg <- recv conn 2048
                           unless (C.isInfixOf "0d00440700" $ encode msg) $ listenU conn chapter
                           when (C.isInfixOf "0d00440700" $ encode msg) $ do
                           sendAll conn copyBlock
                           sendAll conn $ head chapter
                           listenU conn $ tail chapter
