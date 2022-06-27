{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import Forms
import Database

-- base
import Data.Maybe (fromMaybe)

-- bytestring
import Data.ByteString.Char8 (unpack)

-- hasql
import Hasql.Connection
import Hasql.Session (run, statement)

-- rel8
import Rel8 (select)

main :: IO ()
main = do
  connection <- acquire "host=localhost port=5432 dbname=db user=user password=pwd"
  either
    (fail . unpack . fromMaybe "unable to connect to the database")
    (\connection' -> do
      response <- run (statement () . select $ answersBySetId) connection'
      print response)
    connection
  -- answers <- askMultiple [whatIsYourName, howOldAreYou]
  -- print answers
