main :: IO ()
main = putStrLn $ show (fib 42)

fib :: Int -> Int
fib x = 
  if x <= 1 then x 
  else fib (x - 1) + fib (x - 2)
