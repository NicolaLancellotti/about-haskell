module F_Functions where  
  
--________________________________________    
-- Closures
greaterThan100 :: [Integer] -> [Integer]
greaterThan100 xs = filter (\x -> x > 100) xs

--________________________________________    
-- Function composition

foo :: (b -> c) -> (a -> b) -> (a -> c)
foo f g = \x -> f (g x)

myTest :: [Integer] -> Bool
myTest xs = even (length (greaterThan100 xs))

myTest' :: [Integer] -> Bool
myTest' = even . length . greaterThan100

--________________________________________
-- Currying and partial application
-- All functions in Haskell take only one argument

-- Arrows associate to the right,
-- Function application, in turn, is left-associative.

-- \x y z -> ... 
-- is really just syntax sugar for
-- \x -> (\y -> (\z -> ...)).  

--  Likewise, the function definition
--  f x y z = ... 
--  is syntax sugar for
--  f = \x -> (\y -> (\z -> ...)).

multThree :: (Num a) => a -> a -> a -> a  
multThree x y z = x * y * z  

compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred x = compare 100 x  
--compareWithHundred = compare 100
--Notice that the x is on the right hand side on both sides of the equation.

--if # is an operator, then 
--(#)  is equivalent to  \x -> (\y -> x # y)
--(x #) is equivalent to  \y -> x # y
--(# y) is equivalent to  \x -> x # y

greaterThan100_3 xs = filter (>100) xs
divideByTen :: (Floating a) => a -> a  
divideByTen = (/10)    

tenDividedBy :: (Floating a) => a -> a  
tenDividedBy = (10/)    
    
flip' :: (a -> b -> c) -> b -> a -> c  
flip' f y x = f x y 
--________________________________________
-- Errors
top :: [a] -> a
top (x:xs) = x
top [] = error "empty list"
