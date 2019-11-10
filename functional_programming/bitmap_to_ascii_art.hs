import Codec.BMP
import Data.ByteString
import Data.Either
import GHC.Word
import System.IO.Unsafe

loadBitmap :: FilePath -> [[(Int, Int, Int)]]
loadBitmap filename = repackAs2DList (either returnEmptyOnError processDataOnBMP (unsafePerformIO (readBMP filename)))

returnEmptyOnError :: Error -> ([(Int, Int, Int)], (Int, Int))
returnEmptyOnError _ = ([], (0, 0))

processDataOnBMP :: BMP -> ([(Int, Int, Int)], (Int, Int))
processDataOnBMP bmp = ((parseIntoRGBVals (convertToInts (unpack (unpackBMPToRGBA32 bmp)))), (bmpDimensions bmp))

convertToInts :: [Word8] -> [Int]
convertToInts [] = []
convertToInts (h:t) = (fromIntegral (toInteger h)) : (convertToInts t)

parseIntoRGBVals :: [Int] -> [(Int, Int, Int)]
parseIntoRGBVals [] = []
parseIntoRGBVals (h:i:j:_:t) = (h,i,j) : (parseIntoRGBVals t)

repackAs2DList :: ([(Int, Int, Int)], (Int, Int)) -> [[(Int, Int, Int)]]
repackAs2DList (pixels, (width, height)) = (Prelude.reverse (repackAs2DList' pixels width height))

repackAs2DList' :: [(Int, Int, Int)] -> Int -> Int -> [[(Int, Int, Int)]]
repackAs2DList' []  width  height = []
repackAs2DList' pixels width height = (Prelude.take width pixels) : (repackAs2DList' (Prelude.drop width pixels) width height)

showAsASCIIArt :: [[Char]] -> IO ()
showAsASCIIArt pixels = Prelude.putStr (unlines pixels)

-- Part 1: "Custom Palette ASCII Art "

convertToASCIIArt :: [Char] -> Bool -> [[(Int, Int, Int)]] -> [[Char]]
convertToASCIIArt [] _ _ = []
convertToASCIIArt _ _ [] = []
convertToASCIIArt gray leftVright (x:xs) =
 if leftVright
  then (convertRow gray x (len gray)) : (convertToASCIIArt gray leftVright xs)
  else (convertRow (reverseList gray) x (len gray)) : (convertToASCIIArt gray leftVright xs)

convertRow :: [Char] -> [(Int, Int, Int)] -> Int -> String
convertRow [] _ _ = []
convertRow _ [] _ = []
convertRow gray (x:xs) strLen = [getASCIIChar gray (lum x) strLen] ++ (convertRow gray xs strLen)


-- Return ASCII Char from 'grayscale' string -- getASCIIChar ".-+*#" (lum (int, int, int))
getASCIIChar :: String -> Int -> Int -> Char
getASCIIChar str lum strLen
 | lum == 0 = str!!0
 | otherwise = str!!(round (fromIntegral lum  / (100 / fromIntegral (strLen - 1))))


-- Caluclates grayscale percentage
lum :: (Int, Int, Int) -> Int
lum (r, g, b) =  round (((((0.3 * fromIntegral r) + (0.59 * fromIntegral g) + (0.11 * fromIntegral b))/255)) * 100)


-- Flipes the list
reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]

-- Returns Length of the String
len :: (Num b) => [a] -> b
len [] = 0
len (_:xs) = 1 + len xs
