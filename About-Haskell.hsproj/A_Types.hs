module A_Types where

--________________________________________
-- Int - Fixed precision integer
-- Integer - Arbitrary precision integer

x :: Int
x = 3
  
--________________________________________
--Type synonyms
type Name = String
type Age = Int
type Person = (Name, Age)  

type AssocList k v = [(k,v)] 
--________________________________________
--New Type
newtype Nat = N Int

--________________________________________

data IntList -- type constructor 
  = Empty -- value constructor
  | Cons Int IntList -- value constructor
  deriving Show

list :: IntList  
list = Cons 1 (Cons (-2) (Cons 3 Empty))
  
--________________________________________

data Car = Car {
  make :: String, 
  model :: String, 
  year :: Int
} deriving (Show)  

car :: Car
car = Car { 
  make = "Ford", 
  model = "Mustang", 
  year = 1967
}  
  
--________________________________________
-- Tuples

point :: (Int, Int)
point = (1, 3)

--________________________________________
-- Maybe
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

--________________________________________

{-
Nested comments
-}
