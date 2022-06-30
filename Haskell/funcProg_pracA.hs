--Part A
--Q1
bf [ ] = [ ]
bf [x] = [abs x]
bf (x:y:xs) = (abs x) : y : bf xs
df [ ] = [ ]
df [x] = [x + 1]
df (x:y:xs) = (x + 1) : y : df xs

gf f [] = []
gf f [x] = [f x]
gf f (x:y:xs) = f x : y : gf f xs
propgf xs = bf xs == gf abs xs&& df xs == gf (+1) xs

--Q2
data Suit = Hearts | Clubs | Diamonds | Spades
    deriving Eq
data Rank = Numeric Int | Jack | Queen | King | Ace
    deriving Eq
data Card = NormalCard Rank Suit | Joker
    deriving Eq

countAces [] = 0
countAces (x:xs) | x == Joker   =1 + countAces xs
                 | x == NormalCard Ace Hearts    =1 + countAces xs
                 | x == NormalCard Ace Clubs    =1 + countAces xs
                 | x == NormalCard Ace Diamonds    =1 + countAces xs
                 | x == NormalCard Ace Spades   =1 + countAces xs
                 | otherwise        = countAces xs

--Q3
sort [] = []
sort (x:xs) = sort less ++ [x] ++ sort more
    where   less = [a| a<-xs, a<=x]
            more = [b| b<-xs, b>x]

--Q4
cp [[]] = []
cp (xs:ys:_) = [[x,y]| x<-xs, y<-ys]

--Q5
data Nat = Zero | Succ Nat
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n