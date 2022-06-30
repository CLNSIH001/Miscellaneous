#Author:    Sihle Calana
#StdNo:     CLNSIH001
#run:       python3 paging.py <integer>

#results are dependent on frames in the main memory (frame size), number of pages
#and Most Importantly On The RANDOMLY Generated Pages (Integer Arrray Values)

import argparse
from collections import deque
import sys
import random

def FIFO(size, pages):
    mainM = deque()
    faults = 0
    for i in range(len(pages)):
        pg = pages[i]
        valid = False
        for frame in range(len(mainM)):
            if pg == mainM[frame]:
                valid = True
                break
        if valid == False:
            if len(mainM) < size:
                faults += 1
                mainM.append(pg)
            else:
                faults += 1
                mainM.popleft()
                mainM.append(pg)
    return faults

def LRU(size, pages):
    mainM = deque()
    faults = 0
    for i in range(len(pages)):
        pg = pages[i]
        valid = False
        for frame in range(len(mainM)):
            if pg == mainM[frame]:
                valid = True
                mainM.remove(pg)
                mainM.append(pg)
                break
        if valid == False:
            if len(mainM) < size:
                mainM.append(pg)
                faults += 1
            else:
                faults += 1
                mainM.popleft()
                mainM.append(pg)
    return faults    

def time(iteration, frame, pages):
    distance = 0
    for page in range(iteration, len(pages)):
        if frame != pages[page]:
            distance += 1
        else:
            break
    return distance

def OPT(size, pages):
    mainM = []
    faults = 0
    for i in range(len(pages)):
        valid = False
        for frame in range(len(mainM)):
            if pages[i] == mainM[frame]:
                valid = True
                break
        if valid == False:
            if len(mainM) < size:
                faults += 1
                mainM.append(pages[i])
            else:
                page = max((time(i, frames, pages), frames) for frames in mainM)[1]
                faults += 1
                mainM.remove(page)
                mainM.append(pages[i])
    return faults

def main():
    booksize = [8, 128, 24, 32, 1024, 64, 512, 16, 256, 22, 2048]
    N = booksize[random.randint(0, 10)]
    pages = []
    for i in range(N):
        pages.append(random.randint(0, 9))
    size = int(sys.argv[1])
    #pages = [7, 0 , 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 0, 3, 2, 1, 2, 0, 1, 7, 0, 1]    #<------tested using array from lecture 7 and size 3
    print("For", len(pages), "pages:\n")
    print('FIFO', FIFO(size,pages), 'page faults.')
    print('LRU', LRU(size,pages), 'page faults.')
    print('OPT', OPT(size,pages), 'page faults.')

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('Usage: python3 paging.py [Frame Size]')
    else:
        main()
