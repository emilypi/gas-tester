module Main where

import Test.Tasty
import Test.Tasty.QuickCheck

import MyLib

main :: IO ()
main = defaultMain $ testGroup "props"
  [ testProperty "integer sizeOf" $ \i ->
      sizeOfInt i == sizeOfInt i
  , testProperty "integer cost" $ \i ->
      intCost i == intCost i
  ]
