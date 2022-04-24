module D_Generics where
  
data List t = Empty | Cons t (List t)
  deriving Show

filterList :: (t -> Bool) -> List t -> List t  
filterList _ Empty = Empty
filterList p (Cons x xs)
  | p x       = Cons x (filterList p xs)
  | otherwise = filterList p xs
