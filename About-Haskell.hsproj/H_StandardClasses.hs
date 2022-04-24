module H_StandardClasses where 
  
import Data.Char

--________________________________________
-- Functors
{-
class Functor f where
  fmap :: (a -> b) -> f a -> f b
  
instance Functor Maybe where
  -- fmap :: (a -> b) -> Maybe a -> Maybe b
  fmap _ Nothing = Nothing
  fmap g (Just x) = Just (g x)

instance Functor [] where
  -- fmap :: (a -> b) -> [a] -> [b]
  fmap = map
-}

{-
Functor laws:
fmap id = id
fmap (g . h) = fmap g . fmap h
-}

-- Generic functions
inc :: Functor f => f Int -> f Int
inc = fmap (+1)

--________________________________________
-- Applicatives
-- Mapping to functions with multiple arguments
-- Abstracting the idea of applying pure functions to
--  effectful arguments
-- effects: possibility of failure, having many ways
--  to succeed, or performing input/output actions.

{-
class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  
instance Applicative Maybe where
  -- pure :: a -> Maybe a
  pure = Just

  -- (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
  Nothing <*> _ = Nothing
  (Just g) <*> mx = fmap g mx
  
instance Applicative [] where
  -- pure :: a -> [a]
  pure x = [x]
  
  -- (<*>) :: [a -> b] -> [a] -> [b]
  gs <*> xs = [g x | g <- gs, x <- xs]
  gs <*> xs = [x | g <- gs, x <- fmap g xs] -- Nicola
-}

{-
Applicative laws:
pure id <*> x = x
pure (g x) = pure g <*> pure x
x <*> pure y = pure (\g ->g y) <*> x
x <*> (y <*> z) = (pure (.) <*> x <*> y) <*> z
-}

-- Generic functions
sequenceA' :: Applicative f => [f a] -> f [a]
sequenceA' [] = pure []
sequenceA' (x : xs) = pure (:) <*> x <*> sequenceA' xs

getChars :: Int -> IO String
getChars n = sequenceA (replicate n getChar)

--________________________________________
-- Monads

{-
class Applicative m => Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b -- bind
  
  return = pure
  
instance Monad Maybe where
  -- (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
  Nothing >>= _ = Nothing
  (Just x) >>= f = f x
  
instance Monad [] where
  -- (>>=) :: [a] -> (a -> [b]) -> [b]
  xs >>= f = [y | x <- xs, y <- f x]
-}

{-
Monads laws:
return x >>= f = f x 
mx >>= return = mx
(mx >>= f) >>= g = mx >>= (\x -> (f x >>= g))
-}

{-
m1 >>= \x1 ->
m2 >>= \x2 ->
...
mn >>= \xn ->
f x1 x2 ... xn

do  x1 <- m1
    x2 <- m2
    ...
    xn <- mn
    f x1 x2 ... xn
-}

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv n m = Just (n `div` m)

conv :: Char -> Maybe Int 
conv c 
    | isDigit c = Just (digitToInt c) 
    | otherwise = Nothing

--________________________________________
-- IO
{-
instance Functor IO where
  -- fmap :: (a -> b) -> IO a -> IO b
  fmap g mx = do {x <- mx; return (g x)}
  
instance Applicative IO where
  -- pure :: a -> IO a
  pure = return
  
  -- (<*>) :: IO (a -> b) -> IO a -> IO b
  mg <*> mx = do {g <- mg; x <- mx; return (g x)}
  
instance Monad IO where
  -- return :: a -> IO a
  return x = ...
  
  -- (>>=) :: IO a -> (a -> IO b) -> IO b
  mx >>= f = ...
-}


-- Interactive Programming              
-- A sequence of IO actions can be combined
-- into a single composite action using 
-- the do notation
test :: IO (Char, Char)
test = do 
  x <- getChar
  _ <- getChar
  getChar -- is the same as _ <- getChar
  y <- getChar
  return (x, y)

-- Perform a list of action in sequence
-- discarding their result values and returning
-- no result
-- sequence_ :: [IO a] ->IO ()
putStr' :: String -> IO ()
putStr' s = sequence_ [putChar c | c <- s]

--________________________________________
-- Monoids

{-
class Monoid a where
  mempty :: a
  mappend :: a -> a -> a
  
  mconcat :: [a] -> a
  mconcat = foldr mappend mempty
-}

--________________________________________
-- Foldables

{-
class Foldable t where
  foldMap :: Monoid b => (a -> b) -> t a -> b
  foldr   :: (a -> b -> b) -> b -> t a -> b
  
  fold    :: Monoid a => t a -> a
  foldl   :: (a -> b -> a) -> a -> t b -> a
  etc
-}

--________________________________________
-- Traversables

{-
class (Functor t, Foldable t) => Traversable t where
  traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)
  sequenceA :: Applicative f => t (f a) -> f (t a)
  mapM :: Monad m => (a -> m b) -> t a -> m (t b)
  sequence :: Monad m => t (m a) -> m (t a)
-}
