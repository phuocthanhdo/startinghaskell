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

newUser :: ByteString -> ByteString
newUser uname = C.append (hexEnterSerialize $ C.length s) s
                where s = C.append "new_user "
                        $ C.append  uname " 1 2\NUL" 

chapter :: ByteString -> ByteString                
chapter c = C.append (hexSerialize $ C.length s) s
                where s = C.append "copy enter "
                        $ C.append  c " 1\NUL"

xchapter :: ByteString -> ByteString                
xchapter c = C.append (hexSerialize $ C.length s) s
                where s = C.append "xb_copy enter "
                        $ C.append  c "\NUL"                        
                                         
copyBlock :: ByteString
copyBlock = C.append (hexSerialize $ C.length s) s
                where s = "copy block\NUL"

firstReward :: ByteString                
firstReward = C.append (hexSerialize $ C.length s) s
                where s = "activity_reward 326 0\NUL"

useEnergy :: ByteString                
useEnergy = C.append (hexSerialize $ C.length s) s
                where s = "prop_use 1022 2\NUL"               
                
choiceCombat idx = C.append (hexSerialize $ C.length s) s
                    where s = C.append "choice_combat 0| "
                            $ C.append idx "#| -1\NUL"

                    