module B_Control_Flow where
  
import A_Types

--________________________________________
-- Pattern matching

factorial :: Integer -> Integer
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n - 1)

isEmpty :: IntList -> Bool
isEmpty (Cons _ _) = False
isEmpty _ = True

--________________________________________
-- Guarded equations

factorial' :: Integer -> Integer
factorial' n
  | n <= 1     = 1
  | otherwise  = n * factorial' (n - 1)
 
--________________________________________
-- Conditional expressions

factorial'' :: Integer -> Integer
factorial'' n = if n <= 1 
                then 1 
                else n * factorial'' (n - 1)

--________________________________________    
-- Case expressions

isEmpty' :: IntList -> Bool
isEmpty' x = case x of 
  (Cons _ _) -> False
  _ -> True
  
--________________________________________       
-- Mix Patterns

keepOnlyEven :: IntList -> IntList
-- Pattern matching 
keepOnlyEven Empty = Empty 
keepOnlyEven (Cons x xs) 
-- Guards
  | even x    = Cons x (keepOnlyEven xs)
  | otherwise = keepOnlyEven xs
