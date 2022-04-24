module E_Type_Classes where 
  
class Listable a where
  toList :: a -> [Int]

instance Listable Int where
  toList x = [x]

  
instance Listable Bool where
  toList True  = [1]
  toList False = [0]
  
-- A class can also be extended
class Listable a => AAA a where
  isAAA :: a -> [Int]

 --________________________________________  
--Standard type classes
--Ord
--Num 
--Integral supports div mod
--Fractional  supports / recip
--Show
--Read
--Integral

--class Eq a where
--  (==) :: a -> a -> Bool
--  (/=) :: a -> a -> Bool
--  x /= y = not (x == y)


 --________________________________________  
-- Class constraint (Everything before the => symbol)

foo :: (Listable a, Eq a) => a -> a -> Bool
foo x y = sum (toList x) == sum (toList y) 

instance (Listable a, Listable b) => Listable (a,b) where
  toList (x,y) = toList x ++ toList y  
