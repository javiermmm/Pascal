STORE [100] 1
STORE [101] 179
STORE [102] 196
STORE [103] 217
STORE [104] 191
STORE [105] 218
STORE [106] 192
STORE [500] 27
STORE [501] 31
STORE [502] 33
STORE [503] 37
STORE [504] 90
STORE [505] 38
STORE [506] 66
STORE [507] 45
STORE [508] 51
STORE [509] 64
STORE [510] 59
STORE [511] 200
STORE [512] 67
STORE [513] 77
STORE [514] 83
STORE [515] 88
COPY [300] [10]
COPY [301] [11]
COPY [302] [12]
COPY [303] [302]
SUB [303] [100]
JUMPP [303] [501]
JUMPP [100] [511]
JUMPZ [303] [502]
JUMPP [100] [503]
COPY [1] [300]
COPY [0] [301]
WRITE [104]
JUMPP [100] [504]
STORE [304] 0
COPY [303] [304]
SUB [303] [302]
JUMPP [303] [506]
COPY [1] [300]
SUM [1] [304]
JUMPZ [304] [507]
JUMPP [100] [508]
COPY [0] [301]
WRITE [102]
SUM [0] [302]
SUB [0] [100]
WRITE [106]
JUMPP [100] [509]
SUM [303] [100]
JUMPZ [303] [510]
COPY [0] [301]
WRITE [102]
SUM [0] [302]
SUB [0] [100]
WRITE [102]
JUMPP [100] [509]
COPY [0] [301]
WRITE [104]
SUM [0] [302]
SUB [0] [100]
WRITE [103]
SUM [304] [100]
JUMPP [100] [505]
STORE [304] 1
COPY [303] [304]
SUB [303] [302]
SUM [303] [100]
JUMPP [303] [504]
COPY [0] [301]
SUM [0] [304]
COPY [303] [304]
SUB [303] [100]
JUMPZ [303] [513]
JUMPP [100] [514]
COPY [1] [300]
WRITE [105]
SUM [1] [302]
SUB [1] [100]
WRITE [101]
JUMPP [100] [515]
COPY [1] [300]
WRITE [101]
SUM [1] [302]
SUB [1] [100]
WRITE [101]
SUM [304] [100]
JUMPP [100] [512]
SUB [302] [100]
SUB [302] [100]
SUM [300] [100]
SUM [301] [100]
JUMPP [100] [500]
