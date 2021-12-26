-- For part 1 I used bruteforce method, hovewer, part 2 cannot be reasonably solved in brute force method

import System.IO
import Control.Monad
import Data.Char

main = do

    content <- readFile "input.txt"
    let list = map read (toIntList content []) :: [Int]

    let p1 = part1 list 80
    print p1


    let mapList = [count i list | i <- [0..8]]
    let generations = mapList : map evolve generations
    print $ sum $  generations !! 256
    


toIntList :: String -> [String] -> [String]
toIntList s acc =
    if null s then acc
    else
    let
        num = takeWhile isDigit s
        newS = drop (length num + 1) s
    in
        toIntList newS (num : acc)

addNew :: [Int] -> Int -> [Int]
addNew a 0 = a
addNew a c = addNew (9 : a) (c - 1)

renewOld :: [Int] -> Int -> [Int]
renewOld a 0 = a
renewOld a c = renewOld (7 : a) (c - 1)

part1 :: [Int] -> Int -> Int
part1 l c =
    if c == 0 then length l
    else
        let
            zc = length $ filter (== 0) l
            l1 = addNew l zc
            l1' = renewOld (filter (/= 0) l1) zc
            l2 =  map (+(-1)) l1'
        in
            part1 l2 (c - 1)


--Part 2
count :: Int -> [Int] -> Int
count v l = length $ filter (==v) l

evolve :: [Int] -> [Int]
evolve (x:xs) = nextList
    where iterList = xs ++ [x]
          nextList = (take 6 iterList) ++ [x + (iterList !! 6)] ++ (drop 7 iterList)

