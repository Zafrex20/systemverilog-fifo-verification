# FIFO Scoreboard Output

``` text
==================================================
                 SCOREBOARD
==================================================

-------------------------------------

[Transaction 1] RESET
FIFO SIZE      : 0 -> 0
RESULT         : PASS

FIFO SB COUNT  : 0
FIFO DUT COUNT : 0
RESULT         : PASS

EMPTY FLAG     : 1
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 2] WRITE
Data In        : 251
FIFO SIZE      : 0 -> 1
RESULT         : PASS

FIFO SB COUNT  : 1
FIFO DUT COUNT : 1
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 3] WRITE
Data In        : 181
FIFO SIZE      : 1 -> 2
RESULT         : PASS

FIFO SB COUNT  : 2
FIFO DUT COUNT : 2
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 4] WRITE
Data In        : 18
FIFO SIZE      : 2 -> 3
RESULT         : PASS

FIFO SB COUNT  : 3
FIFO DUT COUNT : 3
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 5] WRITE
Data In        : 143
FIFO SIZE      : 3 -> 4
RESULT         : PASS

FIFO SB COUNT  : 4
FIFO DUT COUNT : 4
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 6] WRITE
Data In        : 115
FIFO SIZE      : 4 -> 5
RESULT         : PASS

FIFO SB COUNT  : 5
FIFO DUT COUNT : 5
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 7] WRITE
Data In        : 11
FIFO SIZE      : 5 -> 6
RESULT         : PASS

FIFO SB COUNT  : 6
FIFO DUT COUNT : 6
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 8] WRITE
Data In        : 16
FIFO SIZE      : 6 -> 7
RESULT         : PASS

FIFO SB COUNT  : 7
FIFO DUT COUNT : 7
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 9] WRITE
Data In        : 7
FIFO SIZE      : 7 -> 8
RESULT         : PASS

FIFO SB COUNT  : 8
FIFO DUT COUNT : 8
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 1
RESULT         : PASS

-------------------------------------

[Transaction 10] WRITE - FIFO FULL
Data In        : 46
WRITE          : IGNORED
FIFO SIZE      : 8 -> 8
RESULT         : PASS

FIFO SB COUNT  : 8
FIFO DUT COUNT : 8
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 1
RESULT         : PASS

-------------------------------------

[Transaction 11] READ + WRITE - FULL
Read Expected  : 251
Read Actual    : 251
Write Data     : 11
FIFO SIZE      : 8 -> 8
RESULT         : PASS

FIFO SB COUNT  : 8
FIFO DUT COUNT : 8
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 1
RESULT         : PASS

-------------------------------------

[Transaction 12] READ
Expected       : 181
Actual         : 181
FIFO SIZE      : 8 -> 7
RESULT         : PASS

FIFO SB COUNT  : 7
FIFO DUT COUNT : 7
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 13] READ
Expected       : 18
Actual         : 18
FIFO SIZE      : 7 -> 6
RESULT         : PASS

FIFO SB COUNT  : 6
FIFO DUT COUNT : 6
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 14] READ
Expected       : 143
Actual         : 143
FIFO SIZE      : 6 -> 5
RESULT         : PASS

FIFO SB COUNT  : 5
FIFO DUT COUNT : 5
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 15] READ
Expected       : 115
Actual         : 115
FIFO SIZE      : 5 -> 4
RESULT         : PASS

FIFO SB COUNT  : 4
FIFO DUT COUNT : 4
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 16] READ
Expected       : 11
Actual         : 11
FIFO SIZE      : 4 -> 3
RESULT         : PASS

FIFO SB COUNT  : 3
FIFO DUT COUNT : 3
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 17] READ
Expected       : 16
Actual         : 16
FIFO SIZE      : 3 -> 2
RESULT         : PASS

FIFO SB COUNT  : 2
FIFO DUT COUNT : 2
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 18] READ
Expected       : 7
Actual         : 7
FIFO SIZE      : 2 -> 1
RESULT         : PASS

FIFO SB COUNT  : 1
FIFO DUT COUNT : 1
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 19] READ
Expected       : 11
Actual         : 11
FIFO SIZE      : 1 -> 0
RESULT         : PASS

FIFO SB COUNT  : 0
FIFO DUT COUNT : 0
RESULT         : PASS

EMPTY FLAG     : 1
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 20] READ - FIFO EMPTY
READ           : IGNORED
FIFO SIZE      : 0 -> 0
RESULT         : PASS

FIFO SB COUNT  : 0
FIFO DUT COUNT : 0
RESULT         : PASS

EMPTY FLAG     : 1
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

-------------------------------------

[Transaction 21] READ + WRITE - EMPTY
Read           : IGNORED
Write Data     : 31
FIFO SIZE      : 0 -> 1
RESULT         : PASS

FIFO SB COUNT  : 1
FIFO DUT COUNT : 1
RESULT         : PASS

EMPTY FLAG     : 0
RESULT         : PASS

FULL FLAG      : 0
RESULT         : PASS

==================================================
              END OF SCOREBOARD
==================================================
```
