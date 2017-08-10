{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ScopedTypeVariables , OverloadedStrings #-}

module PacketGenerator where

import Serializer
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as C

rankReward :: ByteString
rankReward = C.append (hexSerialize $ C.length s) s
                where s = "rankList reward 8\NUL"

armyBase :: ByteString
armyBase = C.append (hexSerialize $ C.length s) s
                where s = "army base 0\NUL"

armyReward :: ByteString 
armyReward = C.append (hexSerialize $ C.length s) s
                where s = "army armyFoundation_award\NUL"

armyMisAward :: ByteString -> ByteString
armyMisAward n = C.append (hexSerialize $ C.length s) s
                    where s = C.append "army misaward "
                            $ C.append n "\NUL"

armyMisAccept :: ByteString -> ByteString
armyMisAccept n = C.append (hexSerialize $ C.length s) s
                    where s = C.append "army misaccept "
                            $ C.append n "\NUL" 

armyMisList :: ByteString
armyMisList = C.append (hexSerialize $ C.length s) s
                where s = "army mislist\NUL"

armyMisSpdUp :: ByteString
armyMisSpdUp = C.append (hexSerialize $ C.length s) s
                 where s = "army misAcc\NUL"

armyExit :: ByteString
armyExit = C.append (hexSerialize $ C.length s) s
                where s = "army exit \NUL"

armyRequest :: ByteString -> ByteString
armyRequest idx = C.append (hexSerialize $ C.length s) s
                    where s = C.append "army request "
                            $ C.append idx "\NUL"    

tPacket :: ByteString
tPacket = C.append (hexSerialize $ C.length s) s
             where s = "store 8 2\NUL"

bet100 :: ByteString -> ByteString
bet100 idx = C.append (hexSerialize $ C.length s) s
                where s = C.append "crossserverwar betting "
                        $ C.append idx " 100\NUL"

bet1000 :: ByteString -> ByteString
bet1000 idx = C.append (hexSerialize $ C.length s) s
                where s = C.append "crossserverwar betting "
                         $ C.append idx " 1000\NUL"                        
iniHunt :: ByteString
iniHunt = C.append (hexSerialize $ C.length s) s
                where s = "teamHunt 1\NUL"

renewHunt :: ByteString       
renewHunt = C.append (hexSerialize $ C.length s) s
                where s = "teamHunt 15 0,1,2\NUL"

openRoom :: ByteString -> ByteString                
openRoom idx = C.append (hexSerialize $ C.length s) s
                where s = C.append "teamHunt 3 "
                        $ C.append  idx "\NUL"

goHunt :: ByteString -> ByteString                        
goHunt idx = C.append (hexSerialize $ C.length s) s
                where s = C.append "teamHunt 10 "
                        $ C.append  idx "\NUL" 

chapter :: ByteString -> ByteString                
chapter c = C.append (hexSerialize $ C.length s) s
                where s = C.append "copy enter "
                        $ C.append  c " 1\NUL"
                                         
copyBlock :: ByteString
copyBlock = C.append (hexSerialize $ C.length s) s
                where s = "copy block\NUL"
                
choiceCombat0 = C.append (hexSerialize $ C.length s) s
                    where s = "choice_combat 0| 344716#| -1\NUL"

                    