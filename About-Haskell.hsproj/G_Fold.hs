module G_Fold where

--------------------------------------- 
-- Foldr
-- x0 # (x1 # (x2 # v))
-- f(x0 f(x1 f(x2 v)))
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ v [] =  v
foldr' f v (x:xs) = f x (foldr' f v xs)

---------------------------------------
-- Foldl
-- ((v # x0) # x1) # x2
-- f(f(f(v x0) x1) x2)
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ v [] =  v
foldl' f v (x:xs) = foldl' f (f v x) xs

---------------------------------------
-- Length
lengthR = foldr' (\_ v -> v + 1) 0
lengthL = foldl' (\v _ -> v + 1) 0

---------------------------------------
-- Reverse
reverseR = foldr' (\x xs -> xs ++ [x]) []
reverseL = foldl' (\xs x -> x : xs) []

---------------------------------------
-- Map
mapR f = foldr (\x xs -> f x : xs) []
mapL f = foldl (\xs x -> xs ++ [f x]) []

map' f xs = [f x | x <- xs]

map'' _ [] = []
map'' f (x:xs) = f x : map'' f xs

---------------------------------------
-- Filter
filterR p = foldr (\x xs -> if p x then x : xs else xs ) []
filterL p = foldl' (\xs x -> if p x then xs ++ [x] else xs ) []

filter' p xs = [x | x <- xs, p x]

filter'' _ [] = []
filter'' p (x:xs) = if p x then x:k else k 
  where k = filter'' p xs
