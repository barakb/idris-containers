||| Testing Stacks using silly stupid tests
module Test.AVL.Set

import Test.Generic
import Test.Random

import Data.AVL.Set

list1 : List Integer
list1 = rndListIntU 123456789 (0,100) 30

list2 : List Integer
list2 = rndListIntU 987654321 (101,200) 30


set1' : Set Integer
set1' = Set.insert 101 $ Set.fromList list1

set1 : Set Integer
set1 = Set.fromList list1

set2 : Set Integer
set2 = Set.fromList list2


-- ------------------------------------------------------------ [ Construction ]
partial
testBuilding : IO ()
testBuilding = genericTest
    (Just "List, Building" )
    (Set.size set1 == 30 && (sorted $ Set.toList $ Set.fromList list1))
    True
    (==)

-- ---------------------------------------------------------------- [ Updating ]

partial
testUpdate : IO ()
testUpdate = genericTest
    (Just "Insert")
    (Set.size set1' == 31 && Set.size set1 == 30)
    True
    (==)


partial
testMerge : IO ()
testMerge = genericTest
    (Just "Union")
    (Set.size $ Set.union set1 set2)
    (60)
    (==)

partial
testDiff : IO ()
testDiff = genericTest
   (Just "Difference")
   (Set.toList $ Set.difference (Set.fromList [1,2,3]) (Set.fromList [2,3,4]))
   [1]
   (==)

partial
testIntersection : IO ()
testIntersection = genericTest
    (Just "Intersection")
    (Set.size $ Set.intersection set1 set1)
    30
    (==)

partial
testContains : IO ()
testContains = genericTest
    (Just "Contains")
    (Set.contains 102 $ set1)
    (False)
    (==)

partial
runTest : IO ()
runTest = do
    putStrLn "Testing Set"
    putStrLn infoLine
    runTests [
        testBuilding
      , testUpdate
      , testMerge
      , testContains
      , testDiff
      , testIntersection
    ]

-- --------------------------------------------------------------------- [ EOF ]
