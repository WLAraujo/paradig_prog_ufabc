{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_coloracao_gulosos (
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

bindir     = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/bin"
libdir     = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/lib/x86_64-linux-ghc-9.0.2/coloracao-gulosos-0.1.0.0-6NBPiiDIbvlIg2SggKVpjU-coloracao-gulosos"
dynlibdir  = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/share/x86_64-linux-ghc-9.0.2/coloracao-gulosos-0.1.0.0"
libexecdir = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/libexec/x86_64-linux-ghc-9.0.2/coloracao-gulosos-0.1.0.0"
sysconfdir = "/home/wesleyla/paradig_prog_ufabc/projeto_final/22-q2-paradigmas-projeto-final-WLAraujo/coloracao-gulosos/.stack-work/install/x86_64-linux-tinfo6/66a6def4bb4821bf0fcaf45c49c0486f9f02f929c05a7b57471cd919d806fe56/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "coloracao_gulosos_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "coloracao_gulosos_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "coloracao_gulosos_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "coloracao_gulosos_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "coloracao_gulosos_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "coloracao_gulosos_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
