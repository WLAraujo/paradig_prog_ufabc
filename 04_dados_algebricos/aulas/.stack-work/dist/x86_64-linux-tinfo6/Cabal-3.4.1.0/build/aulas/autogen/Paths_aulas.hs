{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_aulas (
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

bindir     = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/bin"
libdir     = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/lib/x86_64-linux-ghc-9.0.2/aulas-0.1.0.0-4b11vIVwrVaKo1ceV9vUd3-aulas"
dynlibdir  = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/share/x86_64-linux-ghc-9.0.2/aulas-0.1.0.0"
libexecdir = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/libexec/x86_64-linux-ghc-9.0.2/aulas-0.1.0.0"
sysconfdir = "/home/wesleyla/paradig_prog_ufabc/04_dados_algebricos/aulas/.stack-work/install/x86_64-linux-tinfo6/4bfcc9308a89eed50156a4f039420f79df005b4cd1250f4fcd52189c078acfd3/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "aulas_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "aulas_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "aulas_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "aulas_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "aulas_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "aulas_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
