{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_projeto_test (
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

bindir     = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/bin"
libdir     = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/lib/x86_64-linux-ghc-9.0.2/projeto-test-0.1.0.0-48HE5aI2bP132Z3YzXVk5c-projeto-test"
dynlibdir  = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/share/x86_64-linux-ghc-9.0.2/projeto-test-0.1.0.0"
libexecdir = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/libexec/x86_64-linux-ghc-9.0.2/projeto-test-0.1.0.0"
sysconfdir = "/home/wesleyla/paradig_prog_ufabc/projeto_teste/projeto-test/.stack-work/install/x86_64-linux-tinfo6/64b5a5760b7d83565032dff43e4b3f8abdf9c880e5d3c508b7231c1750417cd4/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "projeto_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "projeto_test_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "projeto_test_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "projeto_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "projeto_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "projeto_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
