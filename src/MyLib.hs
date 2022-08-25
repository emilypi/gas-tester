{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module MyLib
( Gas(..)
, intCost
, sizeOfInt
) where


import Control.DeepSeq

import Data.Int
import Data.Decimal


newtype Gas = Gas { getGas :: Int64 }
  deriving (Eq,Ord,Num,Real,Integral,Enum,NFData)


sizeOfInt :: Integer -> Int64
sizeOfInt i = ceiling ((logBase 100000 (realToFrac i)) :: Double)

intCost :: Integer -> Gas
intCost !a
  | (abs a) < threshold = 0
  | otherwise =
    let !nbytes = (ceiling (logBase @Double 2 (fromIntegral (abs a))) + 1) `quot` 8
    in (nbytes * nbytes) `quot` 100
  where
  threshold :: Integer
  threshold = (10 :: Integer) ^ (30 :: Integer)
