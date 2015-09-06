{-# LANGUAGE OverloadedStrings #-}

import qualified Network.Wai              as Wai
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.HTTP.Types       as HTTP
import           Prelude

main :: IO ()
main = do
    let port = 3000
    putStrLn $ "Listening on port " ++ show port
    Warp.run port app

app :: Wai.Application
app _req res = res $ Wai.responseLBS HTTP.status200 [] "Hello World!"
