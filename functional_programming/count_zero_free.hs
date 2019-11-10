-- COMP3007
-- Assignment 4
-- Tarek Sanger
-- 101059686

-- Question 1: "Counting Zerofrees"
-- Haskell

-- Tail Call Optimized 
countZerofree:: [Int] -> Int
countZerofree [] = 0
countZerofree lst = countZerofree' lst 0
  where
    countZerofree' [] n = n
    countZerofree' (x:xs) n
      | containsZero (abs' x) = countZerofree' xs n
      | otherwise = countZerofree' xs (n+1)


containsZero:: Int -> Bool
containsZero n
 | (n `mod'` 10) == 0 = True
 | (n `div` 10) == 0 = False
 | (n /= 0) = containsZero((n `div` 10))
 | otherwise = False


abs':: Int -> Int
abs' 0 = 0
abs' n
 | n > 0 = n
 | otherwise = n * (-1)


mod':: Int -> Int -> Int
mod' a b = a - (b * (a `div` b))
