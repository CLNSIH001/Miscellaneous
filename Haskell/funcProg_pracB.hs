--data declaration of 8 states each with constructors taking a string and an index. Qs - start, Qa - accept, Qr - reject
data State = Qs [Char] Int| Q1 [Char] Int| Q2 [Char] Int| Q3 [Char] Int| Q4 [Char] Int | Q5 [Char] Int| Qa |Qr

--main function. produces 'a' if input is a palindrome, otherwise outputs 'b'
f xs = if (xs == []) || trans (Qs ('_':xs++['_']) 1) then 'a' else 'b'

-- replaces a character in the char list xs at index y with character w
-- char at y in the string xs is the input we are replacing with char w
replace w y xs = take y xs ++ w ++ drop (y+1) xs

trans Qa = True     --accept state
trans Qr = False    --reject state

-- (y-1) indicates moving control pointer head towards the left hand side of the tape
-- (y+1) indicates moving control pointer head towards the right hand side of the tape

--transittion function. Takes State and tape string in the form of list of chars
--function produces updated tape alphabet, next state and movement of the pointer
trans (Qs xs y) | xs!!y == 'a'  = trans (Q3 (replace ['_'] y xs) (y+1))
                | xs!!y == 'b'  = trans (Q1 (replace ['_'] y xs) (y+1))
                | xs!!y == '_'  = trans Qa
                | otherwise = trans Qr

trans (Q1 xs y) | xs!!y == 'a'  = trans (Q1 xs (y+1))   --replaces 'a' with 'a' so calling replace function not required.
                | xs!!y == 'b'  = trans (Q1 xs (y+1))   -- String is unchanged
                | xs!!y == '_'  = trans (Q2 xs (y-1))
                | otherwise = trans Qr

trans (Q2 xs y) | xs!!y == 'b'  = trans (Q5 (replace ['_'] y xs) (y-1))
                | xs!!y == '_'  = trans Qa
                | otherwise = trans Qr

trans (Q3 xs y) | xs!!y == 'a'  = trans (Q3 xs (y+1))
                | xs!!y == 'b'  = trans (Q3 xs (y+1))
                | xs!!y == '_'  = trans (Q4 xs (y-1))
                | otherwise = trans Qr

trans (Q4 xs y) | xs!!y == 'a'  = trans (Q5 (replace ['_'] y xs) (y-1))
                | xs!!y == '_'  = trans Qa
                | otherwise = trans Qr

trans (Q5 xs y) | xs!!y == 'a'  = trans (Q5 xs (y-1))   --loops for a & b chars while moving pointer to the left
                | xs!!y == 'b'  = trans (Q5 xs (y-1))
                | xs!!y == '_'  = trans (Qs xs (y+1))
                | otherwise = trans Qr
