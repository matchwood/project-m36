{-# LANGUAGE OverloadedStrings #-}
module ProjectM36.DataTypes.Day where
import ProjectM36.Base
import ProjectM36.DataTypes.Primitive
import ProjectM36.AtomFunctions.Primitive
import qualified Data.HashSet as HS
import Data.Time.Calendar

dayAtomType :: AtomType
dayAtomType = ConstructedAtomType "Day" [intAtomType]

dayFunctions :: AtomFunctions
dayFunctions = HS.fromList [
  AtomFunction { atomFuncName = "fromGregorian",
                 atomFuncType = [intAtomType, intAtomType, intAtomType, dayAtomType],
                 atomFunc = \(year:month:day:_) -> ConstructedAtom "Day" dayAtomType [Atom (fromGregorian (fromIntegral (unsafeCast year::Int)) (unsafeCast month) (unsafeCast day))]
                   }
  ]
