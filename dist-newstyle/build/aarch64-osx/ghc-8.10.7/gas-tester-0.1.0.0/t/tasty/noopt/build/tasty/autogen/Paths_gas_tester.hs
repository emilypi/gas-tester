{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_gas_tester (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/emilypillmore/.cabal/bin"
libdir     = "/Users/emilypillmore/.cabal/lib/aarch64-osx-ghc-8.10.7/gas-tester-0.1.0.0-inplace-tasty"
dynlibdir  = "/Users/emilypillmore/.cabal/lib/aarch64-osx-ghc-8.10.7"
datadir    = "/Users/emilypillmore/.cabal/share/aarch64-osx-ghc-8.10.7/gas-tester-0.1.0.0"
libexecdir = "/Users/emilypillmore/.cabal/libexec/aarch64-osx-ghc-8.10.7/gas-tester-0.1.0.0"
sysconfdir = "/Users/emilypillmore/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "gas_tester_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "gas_tester_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "gas_tester_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "gas_tester_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "gas_tester_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "gas_tester_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
