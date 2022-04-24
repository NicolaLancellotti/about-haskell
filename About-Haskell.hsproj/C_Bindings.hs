module C_Bindings where
  
import A_Types
--________________________________________
-- As pattern

top :: IntList -> String
top l@(Cons x _) = "The top element of (" ++ show l ++ ") is " ++ show x

--________________________________________
-- Where bindings

factorial :: Integer -> Integer
factorial n 
  | greaterThenOne = n * factorial (n - 1)
  | otherwise = 1
  where greaterThenOne =  n > 1
  
initials :: String -> String -> String  
initials firstname lastname = [f] ++ [l]
    where ((f:_), (l:_)) = (firstname, lastname)  

     
--Local functions     
pluralise :: String -> [Int] -> [String]
pluralise word counts = map plural counts
    where plural 0 = "no " ++ word ++ "s"
          plural 1 = "one " ++ word
          plural n = show n ++ " " ++ word ++ "s"
          
--________________________________________       
-- Let bindings

cylinder :: Float -> Float -> Float  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea  
    
-- explicit structuring
foo = let { a = 1;  b = 2; 
        c = 3 }
      in a + b + c
