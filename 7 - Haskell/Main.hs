
import System.IO
import Data.Char
import Data.List


main = do
    content <- readFile "input.txt"
    let list = map read (toIntList content []) :: [Int]

    print $ part1 list
    print $ part2 list

toIntList :: String -> [String] -> [String]
toIntList s acc =
    if null s then acc
    else
    let
        num = takeWhile isDigit s
        newS = drop (length num + 1) s
    in
        toIntList newS (num : acc)

part1 :: [Int] -> Int
part1 l =
    let
        mi = minimum l
        mx = maximum l
        a = [f x l | x <- [mi..mx]]
    in
        minimum a

f :: Int -> [Int] -> Int
f x l = sum $ map (\d -> abs (d - x)) l

part2 :: [Int] -> Int
part2 l =
    let
        mi = minimum l
        mx = maximum l
        a = [g x l | x <- [mi..mx]]
    in
        minimum a

g :: Int -> [Int] -> Int
g x l = sum $ map ((\x -> x * (x + 1) `div` 2) . (\d -> abs (d - x))) l
