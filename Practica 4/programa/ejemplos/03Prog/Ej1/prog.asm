STORE [1001] 1
STORE [1002] 7
STORE [1003] 10
STORE [1004] 17
COPY [201] [11]
COPY [202] [12]
SUB [202] [1001]
JUMPP [202] [1003]
JUMPP [1001] [1004]
COPY [0] [202]
COPY [1] [202]
SUM [0] [1001]
SUM [1] [1001]
WRITE [201]
SUB [201] [1001]
JUMPP [1001] [1002]
