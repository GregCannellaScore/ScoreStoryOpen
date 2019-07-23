000100190527      /copy qcpylesrc,stdhspec
000200180128       ctl-opt bnddir('QC2LE');
000300151025       //****************************************************************
000400151025       //                                                               *
000500151031       // Program ID...... DSH0115R                                     *
000600151025       // Program Desc.... Process dashboard header.                    *
000700151025       //                                                               *
000800151025       // Written By...... Greg Cannella                                *
000900151031       // Date Written.... 10/25/15                                     *
001000151025       //                                                               *
001100151025       // Comments........                                              *
001200151025       //                                                               *
001300151025       //                                                               *
001400151025       //****************************************************************
001500151025       // Compile Options:                                              *
001600151025       //                                                               *
001700151025       //****************************************************************
001800151025       // Modifications:                                                *
001900151025       // Req#  By   Date      Modification                             *
002000151025       // 1234  xxx  xx/xx/xx                                           *
002100151025       //                                                               *
002200151025       //****************************************************************
002300151025       //------------------------------------------------
002400151025       // Files
002500180121       dcl-f dshhdrm usage(*input) keyed;
002600180121       dcl-f htmlbdm usage(*input) keyed;
002700180121       dcl-f dshdtlm usage(*input) keyed;
002800170522       dcl-f dshsecm usage(*input) keyed;
002900171001       dcl-f codecat usage(*input) keyed;
003000170924       dcl-f sqllog  usage(*output) rename(SQLLOG:SQLLOGR);
003100170603
003200151025
003300151025       //--Entry Prototype
003400151025       dcl-pr DSH0115R  extpgm('DSH0115R');
003500151226         widbname char(128);
003600160614         widbuser char(10);
003700170520         widbparm char(200);
003800180128         widbFile char(500);
003900151025       end-pr;
004000151025       dcl-pi DSH0115R;
004100151226         widbname char(128);
004200160614         widbuser char(10);
004300170520         widbparm char(200);
004400180128         widbFile char(500);
004500151025       end-pi;
004600151106
004700170304       //--External Prototypes
004800171001       // Format a chart
004900151108       dcl-pr DSH0120C  extpgm('DSH0120C');
005000151108         wichname char(20);
005100170524         widbuser char(10);
005200170524         widbparm char(200);
005300151106       end-pr;
005400151106
005500171001       // Get user's group
005600171001       dcl-pr DSH0117C  extpgm('DSH0117C');
005700171001         wiuser   char(10);
005800171001         wigroup  char(10);
005900171001       end-pr;
006000171001
006100190527       // declare constant
006200190527       dcl-c ccQuote const('''');
006300190527
006400151025       // Declare fields
006500180128       dcl-s SubValue varchar(1000000) inz;
006600180128       dcl-s SubValueP pointer INZ(%ADDR(SubValue));
006700180128       dcl-s SubWithHeading varchar(1000000) inz;
006800180128       dcl-s widbbody varchar(1000000) inz;
006900180129       dcl-s widbbodyP pointer INZ(%ADDR(widbbody));
007000151101       dcl-s SQLStatement char(2000);
007100151025       dcl-s SQLResult packed(15:5);
007200151027       dcl-s SQLResultText char(25);
007300151027       dcl-s IndicatorColor char(50);
007400170423       dcl-s FieldColHeading char(50);
007500151030       dcl-s x int(5);
007600151030       dcl-s TotalColumns int(5);
007700151030       dcl-s ColumnType char(1) dim(200);
007800151031       dcl-s Type int(5) ;
007900151031       dcl-s Length int(5) ;
008000151031       dcl-s Result_Ind int(5) ;
008100151031       dcl-s Precision int(5) ;
008200151031       dcl-s Scale int(5) ;
008300151031       dcl-s NumericValue char(20);
008400151101       dcl-s BigInt int(20);
008500151101       dcl-s Int int(10);
008600151101       dcl-s SmallInt int(5);
008700190527       dcl-s Float Float(8);
008800190527       dcl-s BinDec BinDec(4:0);
008900190527       dcl-s DateValue Date;
009000190527       dcl-s TimeValue Time;
009100190527       dcl-s TimeStampValue Timestamp;
009200190527       dcl-s VarGraphic Vargraph(5000);
009300151101       dcl-s BigIntNumeric packed(15:0);
009400180129       dcl-s UsrGroup char(10);
009500170522       dcl-s StarAll char(10) inz('*ALL');
009600180128       dcl-s tblCount zoned(2);
009700171001       dcl-s JMAUTMNT char(10) inz('JMAUTMNT');
009800171001       dcl-s MaintAuth char(1);
009900171016       dcl-s varChar1 varchar(32000);
010000180121       dcl-s LicError char(7);
010100180128       dcl-s ifsFilename char(500);
010200180128       dcl-s htmlFileName char(500);
010300180128       dcl-s FileDescr int(10);
010400180128       dcl-s RC int(10);
010500180128       dcl-s BufferLen int(10);
010600180128
010700180128       // Copybook with IFS functions and constants
010800180128      /copy *libl/qcpylesrc,IFSIO_H
010900170522
011000170521       // Incomming Parms
011100170521     D IncommingParms  ds           200
011200171010     D   PM1                   1     40
011300171010     D   PM2                  41     80
011400171010     D   PM3                  81    120
011500171010     D   PM4                 121    160
011600171010     D   PM5                 161    200
011700170521
011800170521
011900151031       // Declare all variations of fields
012000190527     D  ValueA         ds         32000
012100151031     D   ValueA1               1      1
012200151031     D   ValueA2               1      2
012300151031     D   ValueA3               1      3
012400151031     D   ValueA4               1      4
012500151031     D   ValueA5               1      5
012600151031     D   ValueA6               1      6
012700151031     D   ValueA7               1      7
012800151031     D   ValueA8               1      8
012900151031     D   ValueA9               1      9
013000151031     D   ValueA10              1     10
013100151031     D   ValueA11              1     11
013200151031     D   ValueA12              1     12
013300151031     D   ValueA13              1     13
013400151031     D   ValueA14              1     14
013500151031     D   ValueA15              1     15
013600151031     D   ValueA16              1     16
013700151031     D   ValueA17              1     17
013800151031     D   ValueA18              1     18
013900151031     D   ValueA19              1     19
014000151031     D   ValueA20              1     20
014100151031     D   ValueA21              1     21
014200151031     D   ValueA22              1     22
014300151031     D   ValueA23              1     23
014400151031     D   ValueA24              1     24
014500151031     D   ValueA25              1     25
014600151031     D   ValueA26              1     26
014700151031     D   ValueA27              1     27
014800151031     D   ValueA28              1     28
014900151031     D   ValueA29              1     29
015000151031     D   ValueA30              1     30
015100151031     D   ValueA31              1     31
015200151031     D   ValueA32              1     32
015300151031     D   ValueA33              1     33
015400151031     D   ValueA34              1     34
015500151031     D   ValueA35              1     35
015600151031     D   ValueA36              1     36
015700151031     D   ValueA37              1     37
015800151031     D   ValueA38              1     38
015900151031     D   ValueA39              1     39
016000151031     D   ValueA40              1     40
016100151031     D   ValueA41              1     41
016200151031     D   ValueA42              1     42
016300151031     D   ValueA43              1     43
016400151031     D   ValueA44              1     44
016500151031     D   ValueA45              1     45
016600151031     D   ValueA46              1     46
016700151031     D   ValueA47              1     47
016800151031     D   ValueA48              1     48
016900151031     D   ValueA49              1     49
017000151031     D   ValueA50              1     50
017100151031     D   ValueA51              1     51
017200151031     D   ValueA52              1     52
017300151031     D   ValueA53              1     53
017400151031     D   ValueA54              1     54
017500151031     D   ValueA55              1     55
017600151031     D   ValueA56              1     56
017700151031     D   ValueA57              1     57
017800151031     D   ValueA58              1     58
017900151031     D   ValueA59              1     59
018000151031     D   ValueA60              1     60
018100151031     D   ValueA61              1     61
018200151031     D   ValueA62              1     62
018300151031     D   ValueA63              1     63
018400151031     D   ValueA64              1     64
018500151031     D   ValueA65              1     65
018600151031     D   ValueA66              1     66
018700151031     D   ValueA67              1     67
018800151031     D   ValueA68              1     68
018900151031     D   ValueA69              1     69
019000151031     D   ValueA70              1     70
019100151031     D   ValueA71              1     71
019200151031     D   ValueA72              1     72
019300151031     D   ValueA73              1     73
019400151031     D   ValueA74              1     74
019500151031     D   ValueA75              1     75
019600151031     D   ValueA76              1     76
019700151031     D   ValueA77              1     77
019800151031     D   ValueA78              1     78
019900151031     D   ValueA79              1     79
020000151031     D   ValueA80              1     80
020100151031     D   ValueA81              1     81
020200151031     D   ValueA82              1     82
020300151031     D   ValueA83              1     83
020400151031     D   ValueA84              1     84
020500151031     D   ValueA85              1     85
020600151031     D   ValueA86              1     86
020700151031     D   ValueA87              1     87
020800151031     D   ValueA88              1     88
020900151031     D   ValueA89              1     89
021000151031     D   ValueA90              1     90
021100151031     D   ValueA91              1     91
021200151031     D   ValueA92              1     92
021300151031     D   ValueA93              1     93
021400151031     D   ValueA94              1     94
021500151031     D   ValueA95              1     95
021600151031     D   ValueA96              1     96
021700151031     D   ValueA97              1     97
021800151031     D   ValueA98              1     98
021900151031     D   ValueA99              1     99
022000151031     D   ValueA100             1    100
022100151229     D   ValueA101             1    101
022200151229     D   ValueA102             1    102
022300151229     D   ValueA103             1    103
022400151229     D   ValueA104             1    104
022500151229     D   ValueA105             1    105
022600151229     D   ValueA106             1    106
022700151229     D   ValueA107             1    107
022800151229     D   ValueA108             1    108
022900151229     D   ValueA109             1    109
023000151229     D   ValueA110             1    110
023100151229     D   ValueA111             1    111
023200151229     D   ValueA112             1    112
023300151229     D   ValueA113             1    113
023400151229     D   ValueA114             1    114
023500151229     D   ValueA115             1    115
023600151229     D   ValueA116             1    116
023700151229     D   ValueA117             1    117
023800151229     D   ValueA118             1    118
023900151229     D   ValueA119             1    119
024000151229     D   ValueA120             1    120
024100151229     D   ValueA121             1    121
024200151229     D   ValueA122             1    122
024300151229     D   ValueA123             1    123
024400151229     D   ValueA124             1    124
024500151229     D   ValueA125             1    125
024600151229     D   ValueA126             1    126
024700151229     D   ValueA127             1    127
024800151229     D   ValueA128             1    128
024900151229     D   ValueA129             1    129
025000151229     D   ValueA130             1    130
025100151229     D   ValueA131             1    131
025200151229     D   ValueA132             1    132
025300151229     D   ValueA133             1    133
025400151229     D   ValueA134             1    134
025500151229     D   ValueA135             1    135
025600151229     D   ValueA136             1    136
025700151229     D   ValueA137             1    137
025800151229     D   ValueA138             1    138
025900151229     D   ValueA139             1    139
026000151229     D   ValueA140             1    140
026100151229     D   ValueA141             1    141
026200151229     D   ValueA142             1    142
026300151229     D   ValueA143             1    143
026400151229     D   ValueA144             1    144
026500151229     D   ValueA145             1    145
026600151229     D   ValueA146             1    146
026700151229     D   ValueA147             1    147
026800151229     D   ValueA148             1    148
026900151229     D   ValueA149             1    149
027000151229     D   ValueA150             1    150
027100151229     D   ValueA151             1    151
027200151229     D   ValueA152             1    152
027300151229     D   ValueA153             1    153
027400151229     D   ValueA154             1    154
027500151229     D   ValueA155             1    155
027600151229     D   ValueA156             1    156
027700151229     D   ValueA157             1    157
027800151229     D   ValueA158             1    158
027900151229     D   ValueA159             1    159
028000151229     D   ValueA160             1    160
028100151229     D   ValueA161             1    161
028200151229     D   ValueA162             1    162
028300151229     D   ValueA163             1    163
028400151229     D   ValueA164             1    164
028500151229     D   ValueA165             1    165
028600151229     D   ValueA166             1    166
028700151229     D   ValueA167             1    167
028800151229     D   ValueA168             1    168
028900151229     D   ValueA169             1    169
029000151229     D   ValueA170             1    170
029100151229     D   ValueA171             1    171
029200151229     D   ValueA172             1    172
029300151229     D   ValueA173             1    173
029400151229     D   ValueA174             1    174
029500151229     D   ValueA175             1    175
029600151229     D   ValueA176             1    176
029700151229     D   ValueA177             1    177
029800151229     D   ValueA178             1    178
029900151229     D   ValueA179             1    179
030000151229     D   ValueA180             1    180
030100151229     D   ValueA181             1    181
030200151229     D   ValueA182             1    182
030300151229     D   ValueA183             1    183
030400151229     D   ValueA184             1    184
030500151229     D   ValueA185             1    185
030600151229     D   ValueA186             1    186
030700151229     D   ValueA187             1    187
030800151229     D   ValueA188             1    188
030900151229     D   ValueA189             1    189
031000151229     D   ValueA190             1    190
031100151229     D   ValueA191             1    191
031200151229     D   ValueA192             1    192
031300151229     D   ValueA193             1    193
031400151229     D   ValueA194             1    194
031500151229     D   ValueA195             1    195
031600151229     D   ValueA196             1    196
031700151229     D   ValueA197             1    197
031800151229     D   ValueA198             1    198
031900151229     D   ValueA199             1    199
032000151229     D   ValueA200             1    200
032100190527     D   ValueA32000           1  32000
032200190527
032300151031
032400190527     D  ValueN         DS            31
032500151101     D   ValueN1_0             1      1  0 inz(0)
032600151101     D   ValueN1_1             1      1  1 inz(.0)
032700151101     D   ValueN2_0             1      2  0 inz(0)
032800151101     D   ValueN2_1             1      2  1 inz(0)
032900151101     D   ValueN2_2             1      2  2 inz(.0)
033000151101     D   ValueN3_0             1      3  0 inz(0)
033100151101     D   ValueN3_1             1      3  1 inz(0)
033200151101     D   ValueN3_2             1      3  2 inz(0)
033300151101     D   ValueN3_3             1      3  3 inz(.0)
033400151101     D   ValueN4_0             1      4  0 inz(0)
033500151101     D   ValueN4_1             1      4  1 inz(0)
033600151101     D   ValueN4_2             1      4  2 inz(0)
033700151101     D   ValueN4_3             1      4  3 inz(0)
033800151101     D   ValueN4_4             1      4  4 inz(.0)
033900151101     D   ValueN5_0             1      5  0 inz(0)
034000151101     D   ValueN5_1             1      5  1 inz(0)
034100151101     D   ValueN5_2             1      5  2 inz(0)
034200151101     D   ValueN5_3             1      5  3 inz(0)
034300151101     D   ValueN5_4             1      5  4 inz(0)
034400151101     D   ValueN6_0             1      6  0 inz(0)
034500151101     D   ValueN6_1             1      6  1 inz(0)
034600151101     D   ValueN6_2             1      6  2 inz(0)
034700151101     D   ValueN6_3             1      6  3 inz(0)
034800151101     D   ValueN6_4             1      6  4 inz(0)
034900151101     D   ValueN7_0             1      7  0 inz(0)
035000151101     D   ValueN7_1             1      7  1 inz(0)
035100151101     D   ValueN7_2             1      7  2 inz(0)
035200151101     D   ValueN7_3             1      7  3 inz(0)
035300151101     D   ValueN7_4             1      7  4 inz(0)
035400151101     D   ValueN8_0             1      8  0 inz(0)
035500151101     D   ValueN8_1             1      8  1 inz(0)
035600151101     D   ValueN8_2             1      8  2 inz(0)
035700151101     D   ValueN8_3             1      8  3 inz(0)
035800151101     D   ValueN8_4             1      8  4 inz(0)
035900151101     D   ValueN9_0             1      9  0 inz(0)
036000151101     D   ValueN9_1             1      9  1 inz(0)
036100151101     D   ValueN9_2             1      9  2 inz(0)
036200151101     D   ValueN9_3             1      9  3 inz(0)
036300151101     D   ValueN9_4             1      9  4 inz(0)
036400151101     D   ValueN10_0            1     10  0 inz(0)
036500151101     D   ValueN10_1            1     10  1 inz(0)
036600151101     D   ValueN10_2            1     10  2 inz(0)
036700151101     D   ValueN10_3            1     10  3 inz(0)
036800151101     D   ValueN10_4            1     10  4 inz(0)
036900151101     D   ValueN11_0            1     11  0 inz(0)
037000151101     D   ValueN11_1            1     11  1 inz(0)
037100151101     D   ValueN11_2            1     11  2 inz(0)
037200151101     D   ValueN11_3            1     11  3 inz(0)
037300151101     D   ValueN11_4            1     11  4 inz(0)
037400151101     D   ValueN12_0            1     12  0 inz(0)
037500151101     D   ValueN12_1            1     12  1 inz(0)
037600151101     D   ValueN12_2            1     12  2 inz(0)
037700151101     D   ValueN12_3            1     12  3 inz(0)
037800151101     D   ValueN12_4            1     12  4 inz(0)
037900151101     D   ValueN13_0            1     13  0 inz(0)
038000151101     D   ValueN13_1            1     13  1 inz(0)
038100151101     D   ValueN13_2            1     13  2 inz(0)
038200151101     D   ValueN13_3            1     13  3 inz(0)
038300151101     D   ValueN13_4            1     13  4 inz(0)
038400151101     D   ValueN14_0            1     14  0 inz(0)
038500151101     D   ValueN14_1            1     14  1 inz(0)
038600151101     D   ValueN14_2            1     14  2 inz(0)
038700151101     D   ValueN14_3            1     14  3 inz(0)
038800151101     D   ValueN14_4            1     14  4 inz(0)
038900151101     D   ValueN15_0            1     15  0 inz(0)
039000151101     D   ValueN15_1            1     15  1 inz(0)
039100151101     D   ValueN15_2            1     15  2 inz(0)
039200151101     D   ValueN15_3            1     15  3 inz(0)
039300151101     D   ValueN15_4            1     15  4 inz(0)
039400190527     D   ValueN31_0            1     31  0 inz(0)
039500190527     D   ValueN31_1            1     31  1 inz(0)
039600190527     D   ValueN31_2            1     31  2 inz(0)
039700190527     D   ValueN31_3            1     31  3 inz(0)
039800190527     D   ValueN31_4            1     31  4 inz(0)
039900190527     D   ValueN31_5            1     31  5 inz(0)
040000190527     D   ValueN31_6            1     31  6 inz(0)
040100190527     D   ValueN31_7            1     31  7 inz(0)
040200190527     D   ValueN31_8            1     31  8 inz(0)
040300190527     D   ValueN31_9            1     31  9 inz(0)
040400190527     D   ValueN31_10           1     31 10 inz(0)
040500190527     D   ValueN31_11           1     31 11 inz(0)
040600190527     D   ValueN31_12           1     31 12 inz(0)
040700190527     D   ValueN31_13           1     31 13 inz(0)
040800190527     D   ValueN31_14           1     31 14 inz(0)
040900190527     D   ValueN31_15           1     31 15 inz(0)
041000190527     D   ValueN31_16           1     31 16 inz(0)
041100190527     D   ValueN31_17           1     31 17 inz(0)
041200190527     D   ValueN31_18           1     31 18 inz(0)
041300190527     D   ValueN31_19           1     31 19 inz(0)
041400190527     D   ValueN31_20           1     31 20 inz(0)
041500190527     D   ValueN31_21           1     31 21 inz(0)
041600190527     D   ValueN31_22           1     31 22 inz(0)
041700190527     D   ValueN31_23           1     31 23 inz(0)
041800190527     D   ValueN31_24           1     31 24 inz(0)
041900190527     D   ValueN31_25           1     31 25 inz(0)
042000190527     D   ValueN31_26           1     31 26 inz(0)
042100190527     D   ValueN31_27           1     31 27 inz(0)
042200190527     D   ValueN31_28           1     31 28 inz(0)
042300190527     D   ValueN31_29           1     31 29 inz(0)
042400190527     D   ValueN31_30           1     31 30 inz(0)
042500190527     D   ValueN31_31           1     31 31 inz(.0)
042600190527
042700170320     D PackedDS        DS
042800170320     D   ValueD1_0                    1P 0 inz(0)
042900170320     D   ValueD1_1                    1P 1 inz(.0)
043000180127     D   ValueD2_0                    2P 0 inz(0)
043100180127     D   ValueD2_1                    2P 1 inz(0)
043200180127     D   ValueD2_2                    2P 2 inz(.0)
043300170320     D   ValueD3_0                    3P 0 inz(0)
043400170320     D   ValueD3_1                    3P 1 inz(0)
043500170320     D   ValueD3_2                    3P 2 inz(0)
043600170320     D   ValueD3_3                    3P 3 inz(.0)
043700180127     D   ValueD4_0                    4P 0 inz(0)
043800180127     D   ValueD4_1                    4P 1 inz(0)
043900180127     D   ValueD4_2                    4P 2 inz(0)
044000180127     D   ValueD4_3                    4P 3 inz(0)
044100180127     D   ValueD4_4                    4P 4 inz(.0)
044200170320     D   ValueD5_0                    5P 0 inz(0)
044300170320     D   ValueD5_1                    5P 1 inz(0)
044400170320     D   ValueD5_2                    5P 2 inz(0)
044500170320     D   ValueD5_3                    5P 3 inz(0)
044600170320     D   ValueD5_4                    5P 4 inz(0)
044700170320     D   ValueD5_5                    5P 5 inz(.0)
044800180127     D   ValueD6_0                    6P 0 inz(0)
044900180127     D   ValueD6_1                    6P 1 inz(0)
045000180127     D   ValueD6_2                    6P 2 inz(0)
045100180127     D   ValueD6_3                    6P 3 inz(0)
045200180127     D   ValueD6_4                    6P 4 inz(0)
045300180127     D   ValueD6_5                    6P 5 inz(0)
045400180127     D   ValueD6_6                    6P 6 inz(.0)
045500170320     D   ValueD7_0                    7P 0 inz(0)
045600170320     D   ValueD7_1                    7P 1 inz(0)
045700170320     D   ValueD7_2                    7P 2 inz(0)
045800170320     D   ValueD7_3                    7P 3 inz(0)
045900170320     D   ValueD7_4                    7P 4 inz(0)
046000170320     D   ValueD7_5                    7P 5 inz(0)
046100170320     D   ValueD7_6                    7P 6 inz(0)
046200170320     D   ValueD7_7                    7P 7 inz(.0)
046300180127     D   ValueD8_0                    8P 0 inz(0)
046400180127     D   ValueD8_1                    8P 1 inz(0)
046500180127     D   ValueD8_2                    8P 2 inz(0)
046600180127     D   ValueD8_3                    8P 3 inz(0)
046700180127     D   ValueD8_4                    8P 4 inz(0)
046800180127     D   ValueD8_5                    8P 5 inz(0)
046900180127     D   ValueD8_6                    8P 6 inz(0)
047000180127     D   ValueD8_7                    8P 7 inz(0)
047100180127     D   ValueD8_8                    8P 8 inz(.0)
047200170320     D   ValueD9_0                    9P 0 inz(0)
047300170320     D   ValueD9_1                    9P 1 inz(0)
047400170320     D   ValueD9_2                    9P 2 inz(0)
047500170320     D   ValueD9_3                    9P 3 inz(0)
047600170320     D   ValueD9_4                    9P 4 inz(0)
047700170320     D   ValueD9_5                    9P 5 inz(0)
047800170320     D   ValueD9_6                    9P 6 inz(0)
047900170320     D   ValueD9_7                    9P 7 inz(0)
048000170320     D   ValueD9_8                    9P 8 inz(0)
048100170320     D   ValueD9_9                    9P 9 inz(.0)
048200180127     D   ValueD10_0                  10P 0 inz(0)
048300180127     D   ValueD10_1                  10P 1 inz(0)
048400180127     D   ValueD10_2                  10P 2 inz(0)
048500180127     D   ValueD10_3                  10P 3 inz(0)
048600180127     D   ValueD10_4                  10P 4 inz(0)
048700180127     D   ValueD10_5                  10P 5 inz(0)
048800180127     D   ValueD10_6                  10P 6 inz(0)
048900180127     D   ValueD10_7                  10P 7 inz(0)
049000180127     D   ValueD10_8                  10P 8 inz(0)
049100180127     D   ValueD10_9                  10P 9 inz(0)
049200180127     D   ValueD10_10                 10P10 inz(.0)
049300170320     D   ValueD11_0                  11P 0 inz(0)
049400170320     D   ValueD11_1                  11P 1 inz(0)
049500170320     D   ValueD11_2                  11P 2 inz(0)
049600170320     D   ValueD11_3                  11P 3 inz(0)
049700170320     D   ValueD11_4                  11P 4 inz(0)
049800170320     D   ValueD11_5                  11P 5 inz(0)
049900170320     D   ValueD11_6                  11P 6 inz(0)
050000170320     D   ValueD11_7                  11P 7 inz(0)
050100170320     D   ValueD11_8                  11P 8 inz(0)
050200170320     D   ValueD11_9                  11P 9 inz(0)
050300170320     D   ValueD11_10                 11P10 inz(0)
050400170320     D   ValueD11_11                 11P11 inz(.0)
050500180127     D   ValueD12_0                  12P 0 inz(0)
050600180127     D   ValueD12_1                  12P 1 inz(0)
050700180127     D   ValueD12_2                  12P 2 inz(0)
050800180127     D   ValueD12_3                  12P 3 inz(0)
050900180127     D   ValueD12_4                  12P 4 inz(0)
051000180127     D   ValueD12_5                  12P 5 inz(0)
051100180127     D   ValueD12_6                  12P 6 inz(0)
051200180127     D   ValueD12_7                  12P 7 inz(0)
051300180127     D   ValueD12_8                  12P 8 inz(0)
051400180127     D   ValueD12_9                  12P 9 inz(0)
051500180127     D   ValueD12_10                 12P10 inz(0)
051600180127     D   ValueD12_11                 12P11 inz(0)
051700180127     D   ValueD12_12                 12P12 inz(.0)
051800170320     D   ValueD13_0                  13P 0 inz(0)
051900170320     D   ValueD13_1                  13P 1 inz(0)
052000170320     D   ValueD13_2                  13P 2 inz(0)
052100170320     D   ValueD13_3                  13P 3 inz(0)
052200170320     D   ValueD13_4                  13P 4 inz(0)
052300170320     D   ValueD13_5                  13P 5 inz(0)
052400170320     D   ValueD13_6                  13P 6 inz(0)
052500170320     D   ValueD13_7                  13P 7 inz(0)
052600170320     D   ValueD13_8                  13P 8 inz(0)
052700170320     D   ValueD13_9                  13P 9 inz(0)
052800170320     D   ValueD13_10                 13P10 inz(0)
052900170320     D   ValueD13_11                 13P11 inz(0)
053000170320     D   ValueD13_12                 13P12 inz(0)
053100170320     D   ValueD13_13                 13P13 inz(.0)
053200180127     D   ValueD14_0                  14P 0 inz(0)
053300180127     D   ValueD14_1                  14P 1 inz(0)
053400180127     D   ValueD14_2                  14P 2 inz(0)
053500180127     D   ValueD14_3                  14P 3 inz(0)
053600180127     D   ValueD14_4                  14P 4 inz(0)
053700180127     D   ValueD14_5                  14P 5 inz(0)
053800180127     D   ValueD14_6                  14P 6 inz(0)
053900180127     D   ValueD14_7                  14P 7 inz(0)
054000180127     D   ValueD14_8                  14P 8 inz(0)
054100180127     D   ValueD14_9                  14P 9 inz(0)
054200180127     D   ValueD14_10                 14P10 inz(0)
054300180127     D   ValueD14_11                 14P11 inz(0)
054400180127     D   ValueD14_12                 14P12 inz(0)
054500180127     D   ValueD14_13                 14P13 inz(0)
054600180127     D   ValueD14_14                 14P14 inz(.0)
054700170320     D   ValueD15_0                  15P 0 inz(0)
054800170320     D   ValueD15_1                  15P 1 inz(0)
054900170320     D   ValueD15_2                  15P 2 inz(0)
055000170320     D   ValueD15_3                  15P 3 inz(0)
055100170320     D   ValueD15_4                  15P 4 inz(0)
055200170320     D   ValueD15_5                  15P 5 inz(0)
055300170320     D   ValueD15_6                  15P 6 inz(0)
055400170320     D   ValueD15_7                  15P 7 inz(0)
055500170320     D   ValueD15_8                  15P 8 inz(0)
055600170320     D   ValueD15_9                  15P 9 inz(0)
055700170320     D   ValueD15_10                 15P10 inz(0)
055800170320     D   ValueD15_11                 15P11 inz(0)
055900170320     D   ValueD15_12                 15P12 inz(0)
056000170320     D   ValueD15_13                 15P13 inz(0)
056100170320     D   ValueD15_14                 15P14 inz(0)
056200170320     D   ValueD15_15                 15P15 inz(.0)
056300190527     D   ValueD17_0                  17P 0 inz(0)
056400190527     D   ValueD17_1                  17P 1 inz(0)
056500190527     D   ValueD17_2                  17P 2 inz(0)
056600190527     D   ValueD17_3                  17P 3 inz(0)
056700190527     D   ValueD17_4                  17P 4 inz(0)
056800190527     D   ValueD17_5                  17P 5 inz(0)
056900190527     D   ValueD17_6                  17P 6 inz(0)
057000190527     D   ValueD17_7                  17P 7 inz(0)
057100190527     D   ValueD17_8                  17P 8 inz(0)
057200190527     D   ValueD17_9                  17P 9 inz(0)
057300190527     D   ValueD17_10                 17P10 inz(0)
057400190527     D   ValueD17_11                 17P11 inz(0)
057500190527     D   ValueD17_12                 17P12 inz(0)
057600190527     D   ValueD17_13                 17P13 inz(0)
057700190527     D   ValueD17_14                 17P14 inz(0)
057800190527     D   ValueD17_15                 17P15 inz(0)
057900190527     D   ValueD17_16                 17P16 inz(0)
058000190527     D   ValueD17_17                 17P17 inz(.0)
058100190527     D   ValueD19_0                  19P 0 inz(0)
058200190527     D   ValueD19_1                  19P 1 inz(0)
058300190527     D   ValueD19_2                  19P 2 inz(0)
058400190527     D   ValueD19_3                  19P 3 inz(0)
058500190527     D   ValueD19_4                  19P 4 inz(0)
058600190527     D   ValueD19_5                  19P 5 inz(0)
058700190527     D   ValueD19_6                  19P 6 inz(0)
058800190527     D   ValueD19_7                  19P 7 inz(0)
058900190527     D   ValueD19_8                  19P 8 inz(0)
059000190527     D   ValueD19_9                  19P 9 inz(0)
059100190527     D   ValueD19_10                 19P10 inz(0)
059200190527     D   ValueD19_11                 19P11 inz(0)
059300190527     D   ValueD19_12                 19P12 inz(0)
059400190527     D   ValueD19_13                 19P13 inz(0)
059500190527     D   ValueD19_14                 19P14 inz(0)
059600190527     D   ValueD19_15                 19P15 inz(0)
059700190527     D   ValueD19_16                 19P16 inz(0)
059800190527     D   ValueD19_17                 19P17 inz(0)
059900190527     D   ValueD19_18                 19P18 inz(0)
060000190527     D   ValueD19_19                 19P19 inz(.0)
060100190527     D   ValueD21_0                  21P 0 inz(0)
060200190527     D   ValueD21_1                  21P 1 inz(0)
060300190527     D   ValueD21_2                  21P 2 inz(0)
060400190527     D   ValueD21_3                  21P 3 inz(0)
060500190527     D   ValueD21_4                  21P 4 inz(0)
060600190527     D   ValueD21_5                  21P 5 inz(0)
060700190527     D   ValueD21_6                  21P 6 inz(0)
060800190527     D   ValueD21_7                  21P 7 inz(0)
060900190527     D   ValueD21_8                  21P 8 inz(0)
061000190527     D   ValueD21_9                  21P 9 inz(0)
061100190527     D   ValueD21_10                 21P10 inz(0)
061200190527     D   ValueD21_11                 21P11 inz(0)
061300190527     D   ValueD21_12                 21P12 inz(0)
061400190527     D   ValueD21_13                 21P13 inz(0)
061500190527     D   ValueD21_14                 21P14 inz(0)
061600190527     D   ValueD21_15                 21P15 inz(0)
061700190527     D   ValueD21_16                 21P16 inz(0)
061800190527     D   ValueD21_17                 21P17 inz(0)
061900190527     D   ValueD21_18                 21P18 inz(0)
062000190527     D   ValueD21_19                 21P19 inz(0)
062100190527     D   ValueD21_20                 21P20 inz(0)
062200190527     D   ValueD21_21                 21P21 inz(.0)
062300190527     D   ValueD23_0                  23P 0 inz(0)
062400190527     D   ValueD23_1                  23P 1 inz(0)
062500190527     D   ValueD23_2                  23P 2 inz(0)
062600190527     D   ValueD23_3                  23P 3 inz(0)
062700190527     D   ValueD23_4                  23P 4 inz(0)
062800190527     D   ValueD23_5                  23P 5 inz(0)
062900190527     D   ValueD23_6                  23P 6 inz(0)
063000190527     D   ValueD23_7                  23P 7 inz(0)
063100190527     D   ValueD23_8                  23P 8 inz(0)
063200190527     D   ValueD23_9                  23P 9 inz(0)
063300190527     D   ValueD23_10                 23P10 inz(0)
063400190527     D   ValueD23_11                 23P11 inz(0)
063500190527     D   ValueD23_12                 23P12 inz(0)
063600190527     D   ValueD23_13                 23P13 inz(0)
063700190527     D   ValueD23_14                 23P14 inz(0)
063800190527     D   ValueD23_15                 23P15 inz(0)
063900190527     D   ValueD23_16                 23P16 inz(0)
064000190527     D   ValueD23_17                 23P17 inz(0)
064100190527     D   ValueD23_18                 23P18 inz(0)
064200190527     D   ValueD23_19                 23P19 inz(0)
064300190527     D   ValueD23_20                 23P20 inz(0)
064400190527     D   ValueD23_21                 23P21 inz(0)
064500190527     D   ValueD23_22                 23P22 inz(0)
064600190527     D   ValueD23_23                 23P23 inz(.0)
064700190527     D   ValueD25_0                  25P 0 inz(0)
064800190527     D   ValueD25_1                  25P 1 inz(0)
064900190527     D   ValueD25_2                  25P 2 inz(0)
065000190527     D   ValueD25_3                  25P 3 inz(0)
065100190527     D   ValueD25_4                  25P 4 inz(0)
065200190527     D   ValueD25_5                  25P 5 inz(0)
065300190527     D   ValueD25_6                  25P 6 inz(0)
065400190527     D   ValueD25_7                  25P 7 inz(0)
065500190527     D   ValueD25_8                  25P 8 inz(0)
065600190527     D   ValueD25_9                  25P 9 inz(0)
065700190527     D   ValueD25_10                 25P10 inz(0)
065800190527     D   ValueD25_11                 25P11 inz(0)
065900190527     D   ValueD25_12                 25P12 inz(0)
066000190527     D   ValueD25_13                 25P13 inz(0)
066100190527     D   ValueD25_14                 25P14 inz(0)
066200190527     D   ValueD25_15                 25P15 inz(0)
066300190527     D   ValueD25_16                 25P16 inz(0)
066400190527     D   ValueD25_17                 25P17 inz(0)
066500190527     D   ValueD25_18                 25P18 inz(0)
066600190527     D   ValueD25_19                 25P19 inz(0)
066700190527     D   ValueD25_20                 25P20 inz(0)
066800190527     D   ValueD25_21                 25P21 inz(0)
066900190527     D   ValueD25_22                 25P22 inz(0)
067000190527     D   ValueD25_23                 25P23 inz(0)
067100190527     D   ValueD25_24                 25P24 inz(0)
067200190527     D   ValueD25_25                 25P25 inz(.0)
067300190527     D   ValueD27_0                  27P 0 inz(0)
067400190527     D   ValueD27_1                  27P 1 inz(0)
067500190527     D   ValueD27_2                  27P 2 inz(0)
067600190527     D   ValueD27_3                  27P 3 inz(0)
067700190527     D   ValueD27_4                  27P 4 inz(0)
067800190527     D   ValueD27_5                  27P 5 inz(0)
067900190527     D   ValueD27_6                  27P 6 inz(0)
068000190527     D   ValueD27_7                  27P 7 inz(0)
068100190527     D   ValueD27_8                  27P 8 inz(0)
068200190527     D   ValueD27_9                  27P 9 inz(0)
068300190527     D   ValueD27_10                 27P10 inz(0)
068400190527     D   ValueD27_11                 27P11 inz(0)
068500190527     D   ValueD27_12                 27P12 inz(0)
068600190527     D   ValueD27_13                 27P13 inz(0)
068700190527     D   ValueD27_14                 27P14 inz(0)
068800190527     D   ValueD27_15                 27P15 inz(0)
068900190527     D   ValueD27_16                 27P16 inz(0)
069000190527     D   ValueD27_17                 27P17 inz(0)
069100190527     D   ValueD27_18                 27P18 inz(0)
069200190527     D   ValueD27_19                 27P19 inz(0)
069300190527     D   ValueD27_20                 27P20 inz(0)
069400190527     D   ValueD27_21                 27P21 inz(0)
069500190527     D   ValueD27_22                 27P22 inz(0)
069600190527     D   ValueD27_23                 27P23 inz(0)
069700190527     D   ValueD27_24                 27P24 inz(0)
069800190527     D   ValueD27_25                 27P25 inz(0)
069900190527     D   ValueD27_26                 27P26 inz(0)
070000190527     D   ValueD27_27                 27P27 inz(.0)
070100190527     D   ValueD29_0                  29P 0 inz(0)
070200190527     D   ValueD29_1                  29P 1 inz(0)
070300190527     D   ValueD29_2                  29P 2 inz(0)
070400190527     D   ValueD29_3                  29P 3 inz(0)
070500190527     D   ValueD29_4                  29P 4 inz(0)
070600190527     D   ValueD29_5                  29P 5 inz(0)
070700190527     D   ValueD29_6                  29P 6 inz(0)
070800190527     D   ValueD29_7                  29P 7 inz(0)
070900190527     D   ValueD29_8                  29P 8 inz(0)
071000190527     D   ValueD29_9                  29P 9 inz(0)
071100190527     D   ValueD29_10                 29P10 inz(0)
071200190527     D   ValueD29_11                 29P11 inz(0)
071300190527     D   ValueD29_12                 29P12 inz(0)
071400190527     D   ValueD29_13                 29P13 inz(0)
071500190527     D   ValueD29_14                 29P14 inz(0)
071600190527     D   ValueD29_15                 29P15 inz(0)
071700190527     D   ValueD29_16                 29P16 inz(0)
071800190527     D   ValueD29_17                 29P17 inz(0)
071900190527     D   ValueD29_18                 29P18 inz(0)
072000190527     D   ValueD29_19                 29P19 inz(0)
072100190527     D   ValueD29_20                 29P20 inz(0)
072200190527     D   ValueD29_21                 29P21 inz(0)
072300190527     D   ValueD29_22                 29P22 inz(0)
072400190527     D   ValueD29_23                 29P23 inz(0)
072500190527     D   ValueD29_24                 29P24 inz(0)
072600190527     D   ValueD29_25                 29P25 inz(0)
072700190527     D   ValueD29_26                 29P26 inz(0)
072800190527     D   ValueD29_27                 29P27 inz(0)
072900190527     D   ValueD29_28                 29P28 inz(0)
073000190527     D   ValueD29_29                 29P29 inz(.0)
073100190527     D   ValueD31_0                  31P 0 inz(0)
073200190527     D   ValueD31_1                  31P 1 inz(0)
073300190527     D   ValueD31_2                  31P 2 inz(0)
073400190527     D   ValueD31_3                  31P 3 inz(0)
073500190527     D   ValueD31_4                  31P 4 inz(0)
073600190527     D   ValueD31_5                  31P 5 inz(0)
073700190527     D   ValueD31_6                  31P 6 inz(0)
073800190527     D   ValueD31_7                  31P 7 inz(0)
073900190527     D   ValueD31_8                  31P 8 inz(0)
074000190527     D   ValueD31_9                  31P 9 inz(0)
074100190527     D   ValueD31_10                 31P10 inz(0)
074200190527     D   ValueD31_11                 31P11 inz(0)
074300190527     D   ValueD31_12                 31P12 inz(0)
074400190527     D   ValueD31_13                 31P13 inz(0)
074500190527     D   ValueD31_14                 31P14 inz(0)
074600190527     D   ValueD31_15                 31P15 inz(0)
074700190527     D   ValueD31_16                 31P16 inz(0)
074800190527     D   ValueD31_17                 31P17 inz(0)
074900190527     D   ValueD31_18                 31P18 inz(0)
075000190527     D   ValueD31_19                 31P19 inz(0)
075100190527     D   ValueD31_20                 31P20 inz(0)
075200190527     D   ValueD31_21                 31P21 inz(0)
075300190527     D   ValueD31_22                 31P22 inz(0)
075400190527     D   ValueD31_23                 31P23 inz(0)
075500190527     D   ValueD31_24                 31P24 inz(0)
075600190527     D   ValueD31_25                 31P25 inz(0)
075700190527     D   ValueD31_26                 31P26 inz(0)
075800190527     D   ValueD31_27                 31P27 inz(0)
075900190527     D   ValueD31_28                 31P28 inz(0)
076000190527     D   ValueD31_29                 31P29 inz(0)
076100190527     D   ValueD31_30                 31P30 inz(0)
076200190527     D   ValueD31_31                 31P31 inz(.0)
076300151031
076400151030     D*      SQL DESCRIPTOR AREA
076500170423     D* SQLDA          DS
076600170423     D* SQLDAID                       8A
076700170423     D* SQLDABC                      10I 0
076800170423     D* SQLN                          5I 0
076900170423     D* SQLD                          5I 0
077000170423     D* SQL_VAR                      80A   DIM(SQL_NUM)
077100170423     D*                       33     48*
077200170423     D*                       49     64*
077300151030     D*
077400170423     D*SQLVAR          DS
077500170423     D* SQLTYPE                       5I 0
077600170423     D* SQLLEN                        5I 0
077700170423     D* SQLRES                       12A
077800170423     D* SQLINFO1                     16A
077900170423     D*  SQLDATA                       *   OVERLAY(SQLINFO1:1)
078000170423     D*  SQL_RESULT_SET_LOCATOR...
078100170423     D*                              20I 0 OVERLAY(SQLINFO1:1)
078200170423     D* SQLINFO2                     16A
078300170423     D*  SQLIND                        *   OVERLAY(SQLINFO2:1)
078400170423     D*  SQL_ROW_CHANGE...
078500170423     D*                              10I 0 OVERLAY(SQLINFO2:1)
078600170423     D*  SQL_RESULT_SET_ROWS...
078700170423     D*                              10I 0 OVERLAY(SQLINFO2:1)
078800170423     D* SQLNAMELEN                    5I 0
078900170423     D* SQLNAME                      30A
079000151030     D*  END OF SQLDA
079100151030     D*  EXTENDED SQLDA
079200170423     D*SQLVAR2         DS
079300170423     D* SQLLONGL               1      4I 0
079400170423     D* SQLRSVDL               5     32A
079500170423     D* SQLDATAL              33     48*
079600170423     D* SQLTNAMELN            49     50I 0
079700170423     D* SQLTNAME              51     80A
079800151030     D*  END OF EXTENDED SQLDA
079900151030
080000151030     D SQL_NUM         C                    const(200)
080100151030
080200180121      // Test for a valid license
080300180121     d QLZAREQ         pr                  ExtPgm('QLZAREQ')
080400180121     d  wiPID                        17a
080500180121     d  wiPIDFmt                      8a
080600180121     d  wiLUsr                       10a
080700180121     d  wiLUsrFmt                     8a
080800180121     d  wiError                      60a   varying
080900180121
081000180121     d  wiPID          s             17a
081100180121     d  wiPIDFmt       s              8a
081200180121     d  wiLUsr         s             10a
081300180121     d  wiLUsrFmt      s              8a
081400180121     d  wiError        s             60a   varying
081500180121
081600180121     d PIDDS           ds            17
081700180121     d  PIDProd                       7a
081800180121     d  PIDRls                        6a
081900180121     d  PIDFeat                       4a
082000180121
082100180121     d LUserDS         ds            10
082200180121     d  LUUser                       10a
082300180121
082400180804      // Test for a valid license
082500180804     d QLZARTV         pr                  ExtPgm('QLZARTV')
082600180804     d  wiRcvr                       23a
082700180804     d  wiRcvrL                      10i 0
082800180804     d  wiRcvrFmt                     8a
082900180804     d  wiPID2                       17a
083000180804     d  wiPIDFmt2                     8a
083100180804     d  wiError2                     60a   varying
083200180804
083300180804     d  wiRcvr         s             24a
083400180804     d  wiRcvrL        s             10i 0
083500180804     d  wiRcvrFmt      s              8a
083600180804     d  wiPID2         s             17a
083700180804     d  wiPIDFmt2      s              8a
083800180804     d  wiError2       s             60a   varying
083900180804
084000180804     d PRDDS           ds            24
084100180804     d  PRUsage                      10i 0
084200180804     d  PRUsageC                     10i 0
084300180804     d  PRUsageT                      2a
084400180804     d  PRCompT                       2a
084500180804     d  PRTerm                        6a
084600180804     d  PRRelease                     6a
084700180804
084800180121
084900180121      *******************************************************************
085000151025       // Program Body
085100170521       IncommingParms = widbparm;
085200170520
085300170522       // Get dashboard heading
085400180729       If %subst(widbname:1:4) <> 'USER';
085500180729         dbname = widbname;
085600180729         Chain (dbname) dshhdrm;
085700180729       Else;
085800180729         Chain ('USER') dshhdrm;
085900180729         dbname = widbname;
086000180729       Endif;
086100151025
086200170522       // Get user group
086300180129       dsh0117c (widbuser : usrgroup);
086400171001
086500171001       // See if user has authority to maintain dashboards
086600171001       cccatk = widbuser;
086700171001       MaintAuth = 'N';
086800171001       Chain (JMAUTMNT : CCCATk ) Codecat;
086900171001       If %found;
087000171001         MaintAuth = 'Y';
087100171001       Else;
087200180129         cccatk = UsrGroup;
087300171001         Chain (JMAUTMNT : CCCATk ) Codecat;
087400171001         If %found;
087500171001           MaintAuth = 'Y';
087600171001         Endif;
087700171001       Endif;
087800170522
087900170522       // Check dashboard security
088000180729       If %subst(widbname:1:4) <> 'USER';
088100180729         Chain (dbname:StarAll) dshsecm;
088200180729         If not %found;
088300180729           Chain (dbname:UsrGroup) dshsecm;
088400180729           If not %found;
088500180729             Chain (dbname:widbuser) dshsecm;
088600180729             If not %found;
088700180729                widbbody = 'You do not have access to dashboard ' +
088800170522                          %trim(widbname);
088900180729               exsr $WriteIfs;
089000180729               exsr $CloseIfs;
089100180729               *inlr = *on;
089200180729               Return;
089300180729             ENDIF;
089400180729           Endif;
089500180729         Endif;
089600180729       Endif;
089700170529
089800151025       // Get dashboard layout HTML
089900151025
090000170520       hxbodyname = dblayout;
090100151025
090200151025       chain (hxbodyname) htmlbdm;
090300151025       If %found;
090400171010         If dbname = 'TESTZZ';
090500170529           widbbody = widbname + widbuser + incommingparms + %trim(hxbody) ;
090600170521         Else;
090700170521           widbbody = %trim(hxbody) ;
090800170521         Endif;
090900151025       Else;
091000170521         widbbody = %trim(widbname) + ' not found';
091100151025       ENDIF;
091200151025
091300151025       // Get the dashboard details
091400151025
091500151025       ddname = dbname;
091600151025       setll ddname dshdtlm;
091700151025       reade ddname dshdtlm;
091800190527       tblCount = 1;
091900151025       dow not %eof;
092000151101         If ddprepgm <> *blanks;
092100151101           // Run pre-process program
092200151101     c                   Call      ddprepgm
092300151101         ENDIF;
092400151025         Select;
092500151025         When ddconturl <> *blanks;
092600151025           SubValue = 'Fill in value from a URL';
092700151025
092800151025         When ddprogram <> *blanks;
092900151025           SubValue = 'Fill in value baased on a program';
093000151025
093100170520
093200151025         //- SQL single Value ------------------------------
093300151025
093400151025         When ddsql <> *blanks and ddsqltype = 'N';
093500151027           EXSR $SQLSingleValue;
093600151106
093700151025         //- SQL Table ------------------------------
093800151025
093900151025         When ddsql <> *blanks and ddsqltype = 'T';
094000151030           EXSR $SQLTable;
094100151106
094200151025         //- HTML Constant ------------------------------
094300151025
094400151025         When ddhtml <> *blanks;
094500151025           SubValue = ddhtml;
094600151106           //- Chart ------------------------------
094700151106           If ddchart <> *blanks;
094800170524             DSH0120C (ddchart : widbuser : widbparm );
094900151106           Endif;
095000151106
095100151025         Other;
095200151025          SubValue = 'Incomplete definition check Dashboard:' + ddname +
095300151025                      ' Sub Name:' + ddsub;
095400151025         ENDSL;
095500170304         If ddheading <> ' ';
095600170522           SubWithHeading = '<h2>' + %trimr(ddheading);
095700190527             SubWithHeading = %Trim(SubWithHeading);
095800190527             If ddsql <> *blanks and ddsqltype = 'T';
095900190527             SubWithHeading = %trimr(SubWithHeading) +
096000190527               '&nbsp;&nbsp;&nbsp;&nbsp;'  +
096100190527               '<button class="button" onclick="exportTableToCSV(' + ccquote +
096200190527               '#tblfile' + %char(tblCount) + ccQuote + ',' + ccQuote +
096300190527               %trim(ddheading) + '.csv' + ccQuote + ')">Download</button>';
096400190527             Endif;
096500190527
096600190527           If MaintAuth = 'Y' ;
096700190527             SubWithHeading = %Trim(SubWithHeading) +
096800171001             '  <a href="/jerrymouse/maintdbdetail.php?DB=' + %trim(ddname) +
096900170522             '&SUB=' + %trim(ddsub) + '">' +
097000171001             '<img src="Images/maintenance.jpeg" alt="Maintain Detail"' +
097100170522             'style="width:20px;height:20px;border:0;"> </a>' ;
097200171001           //Else;
097300171001           //  SubWithHeading = %Trim(SubWithHeading) +
097400171001           //  '  MaintAuth = ' + %trim(MaintAuth) +
097500171001           //  '  User = ' + %trim(widbuser);
097600170522           ENDIF;
097700170522           SubWithHeading = %Trim(SubWithHeading) +
097800170522                 '</h2><br>' + %trimr(SubValue) ;
097900170304         Else;
098000170304           SubWithHeading = %trimr(SubValue);
098100170304         Endif;
098200151118         widbbody = %scanrpl(%trimr(ddsub):
098300151118                %trimr(SubWithHeading):widbbody);
098400151025         reade ddname dshdtlm;
098500190527         tblCount += 1;
098600151025       ENDDO;
098700180129
098800180129       exsr $WriteIfs;
098900180129       exsr $CloseIfs;
099000151025
099100151025       *inlr = *on;
099200180128       //************************************************************************
099300180128       // Subroutine = $WriteIfs
099400180128       //************************************************************************
099500180128       Begsr $WriteIfs;
099600180128         // Write the record to the IFS
099700180129         BufferLen = %len(%trimr(widbbody));
099800180129         RC = write(filedescr:widbbodyP + 4: BufferLen);
099900180128         clear SubValue;
100000180128       Endsr;
100100151027
100200180128       //************************************************************************
100300180128       // Subroutine = $CloseIfs
100400180128       //************************************************************************
100500180128       Begsr $CloseIfs;
100600180128         RC = Close(filedescr);
100700180128       Endsr;
100800180128
100900151027       //************************************************************************
101000151027       // Subroutine = $SQLSingleValue
101100151027       //************************************************************************
101200151027       Begsr $SQLSingleValue;
101300151027
101400151104           SQLResult = 0;
101500151027           SQLStatement = ddsql;
101600170520
101700170520         // Replace any variables in the sql statements
101800170520         SQLStatement = %scanrpl(':widbuser':
101900170520             %trimr(widbuser):SQLStatement);
102000170520         SQLStatement = %scanrpl(':widbparm':
102100170520             %trimr(widbparm):SQLStatement);
102200171010         SQLStatement = %scanrpl(':pm1':
102300171010             %trimr(pm1):SQLStatement);
102400171010         SQLStatement = %scanrpl(':pm2':
102500171010             %trimr(pm2):SQLStatement);
102600171010         SQLStatement = %scanrpl(':pm3':
102700171010             %trimr(pm3):SQLStatement);
102800171010         SQLStatement = %scanrpl(':pm4':
102900171010             %trimr(pm4):SQLStatement);
103000171010         SQLStatement = %scanrpl(':pm5':
103100171010             %trimr(pm5):SQLStatement);
103200170520
103300170604        exsr $LogSQL;
103400151108        exec sql prepare handle from :SQLStatement;
103500151108        exec sql declare OpenHandle cursor for handle;
103600151108        exec sql Open OpenHandle;
103700151108        exec sql fetch next from OpenHandle into :SQLResult;
103800151108        exec sql Close OpenHandle;
103900151027           If %int(SQLResult) - SQLResult <> 0;
104000151027             SQLResultText = %char(SqlResult);
104100151027           Else;
104200151027             SQLResultText = %char(%int(SqlResult));
104300151027           Endif;
104400160101           // Default to no color
104500170304           IndicatorColor = '<table class="table-white">';
104600151027           // Set color based on indicator values
104700160101           If ddredvalue <> 0 or ddylwvalue <> 0 or ddgrnvalue <> 0;
104800160101             // Green
104900160101             If ddgrnsign = '=' and SQLResult = ddgrnvalue;
105000160101               IndicatorColor = '<table class="table-Green">';
105100160101             ENDIF;
105200160101             If ddgrnsign = '<' and SQLResult < ddgrnvalue;
105300160101               IndicatorColor = '<table class="table-Green">';
105400160101             ENDIF;
105500160101             If ddgrnsign = '>' and SQLResult > ddgrnvalue;
105600160101               IndicatorColor = '<table class="table-Green">';
105700160101             ENDIF;
105800160101             If ddgrnsign = '<=' and SQLResult <= ddgrnvalue;
105900160101               IndicatorColor = '<table class="table-Green">';
106000160101             ENDIF;
106100160101             If ddgrnsign = '>=' and SQLResult >= ddgrnvalue;
106200160101               IndicatorColor = '<table class="table-Green">';
106300160101             ENDIF;
106400160101             If ddgrnsign = '<>' and SQLResult <> ddgrnvalue;
106500160101               IndicatorColor = '<table class="table-Green">';
106600160101             ENDIF;
106700151027             // Yellow
106800151027             If ddylwsign = '=' and SQLResult = ddylwvalue;
106900151027               IndicatorColor = '<table class="table-Yellow">';
107000151027             ENDIF;
107100151027             If ddylwsign = '>' and SQLResult > ddylwvalue;
107200151027               IndicatorColor = '<table class="table-Yellow">';
107300151027             ENDIF;
107400151027             If ddylwsign = '<' and SQLResult < ddylwvalue;
107500151027               IndicatorColor = '<table class="table-Yellow">';
107600151027             ENDIF;
107700160101             If ddylwsign = '<=' and SQLResult <= ddylwvalue;
107800160101               IndicatorColor = '<table class="table-Yellow">';
107900160101             ENDIF;
108000160101             If ddylwsign = '>=' and SQLResult >= ddylwvalue;
108100160101               IndicatorColor = '<table class="table-Yellow">';
108200160101             ENDIF;
108300160101             If ddylwsign = '<>' and SQLResult <> ddylwvalue;
108400160101               IndicatorColor = '<table class="table-Yellow">';
108500160101             ENDIF;
108600151027             // Red
108700151027             If ddredsign = '=' and SQLResult = ddredvalue;
108800151027               IndicatorColor = '<table class="table-Red">';
108900151027             ENDIF;
109000151027             If ddredsign = '>' and SQLResult > ddredvalue;
109100151027               IndicatorColor = '<table class="table-Red">';
109200151027             ENDIF;
109300151027             If ddredsign = '<' and SQLResult < ddredvalue;
109400151027               IndicatorColor = '<table class="table-Red">';
109500151027             ENDIF;
109600160101             If ddredsign = '<=' and SQLResult <= ddredvalue;
109700160101               IndicatorColor = '<table class="table-Red">';
109800160101             ENDIF;
109900160101             If ddredsign = '>=' and SQLResult >= ddredvalue;
110000160101               IndicatorColor = '<table class="table-Red">';
110100160101             ENDIF;
110200160101             If ddredsign = '<>' and SQLResult <> ddredvalue;
110300160101               IndicatorColor = '<table class="table-Red">';
110400160101             ENDIF;
110500151027           ENDIF;
110600180121           If ddjustval = 'Y';
110700180121             SubValue = %trim(SQLResultText);
110800180121           Else;
110900180121             SubValue = '<center>' + %trim(IndicatorColor) +
111000180121                       '<tr><td>'
111100151027                       + %trim(SQLResultText) +
111200171126                       '</td></tr></table></center>';
111300180121           Endif;
111400151027       ENDSR;
111500151027
111600151027
111700151027       //************************************************************************
111800151027       // Subroutine = $SQLTable
111900151027       //************************************************************************
112000151030       Begsr $SQLTable;
112100151030
112200151030
112300151030
112400151030           SQLStatement = ddsql;
112500170423           //SQLN = 100;
112600151030
112700170520        // Replace any variables in the sql statements
112800170520         SQLStatement = %scanrpl(':widbuser':
112900170520             %trimr(widbuser):SQLStatement);
113000170520         SQLStatement = %scanrpl(':widbparm':
113100170520             %trimr(widbparm):SQLStatement);
113200171010         SQLStatement = %scanrpl(':pm1':
113300171010             %trimr(pm1):SQLStatement);
113400171010         SQLStatement = %scanrpl(':pm2':
113500171010             %trimr(pm2):SQLStatement);
113600171010         SQLStatement = %scanrpl(':pm3':
113700171010             %trimr(pm3):SQLStatement);
113800171010         SQLStatement = %scanrpl(':pm4':
113900171010             %trimr(pm4):SQLStatement);
114000171010         SQLStatement = %scanrpl(':pm5':
114100171010             %trimr(pm5):SQLStatement);
114200170520
114300170604       exsr $LogSQL;
114400151031       exec sql prepare handleT from :SQLStatement;
114500151031       exec sql declare OpenHandleT cursor for handleT;
114600151031       exec sql Open OpenHandleT;
114700170423       // Define max number of columns and allocate memory
114800151031       exec SQL ALLOCATE DESCRIPTOR 'Values' WITH MAX 200;
114900170423       // Fill the descriptor with data.
115000170423       exec SQL describe handleT using descriptor 'Values';
115100170423       // Find out how many columns exist.
115200170423       exec SQL GET DESCRIPTOR 'Values' :TotalColumns = COUNT;
115300170423       If SQLCOD = 0;
115400180131           SubValue = '<table class="table-sortable"><tr>';
115500190527              SubValue = '<table id="tblfile' + %char(tblCount) +
115600190527                '" class="table-sortable"><tr>';
115700190527           for x = 1 to TotalColumns;
115800170503             // Formulate the heading
115900170423             exec SQL GET DESCRIPTOR 'Values' value :x
116000170423                   :FieldColHeading = DB2_COLUMN_NAME;
116100170423             SubValue = %trimr(SubValue) + '<th>' +
116200170423                   %trimr(FieldColHeading) + '</th>';
116300151030
116400151030           ENDFOR;
116500151031           SubValue = %trimr(SubValue) + '</tr>';
116600151031
116700151031
116800151031
116900151031           // Get the values and fill into table.
117000170423       //    sqldabc = 16+sqln*80;
117100151031       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
117200151031           Dow sqlcode = 0;
117300151031             SubValue = %trimr(SubValue) + '<tr>';
117400151031             for x = 1 to TotalColumns;
117500151031       exec sql GET DESCRIPTOR 'Values' VALUE :x
117600170423                        :type = TYPE,
117700170423                        :length = LENGTH,
117800170423                        :result_ind = INDICATOR,
117900170423                        :scale = SCALE,
118000170423                        :precision = PRECISION ;
118100151031               Select;
118200151031               When Type = 1;
118300151031                 Exsr $Alpha;
118400151101                 SubValue = %trimr(SubValue) +
118500151031                         '<td>' +
118600151229                         %trim(ValueA) +
118700151031                         '</td>';
118800151229     ******              %subst(ValueA:1:length) +
118900151031
119000151101               When Type = 2 or Type = 4;
119100151031                 Exsr $Numeric;
119200151031
119300151031                 SubValue = %trimr(SubValue) +
119400151101                         '<td align="Right">' +
119500151031                         %trim(NumericValue) +
119600151031                         '</td>';
119700151031
119800151031               When Type = 3 ;
119900151031                 Exsr $Decimal; // AKA Packed
120000151031
120100151031                 SubValue = %trimr(SubValue) +
120200151101                         '<td align="Right">' +
120300151031                         %trim(NumericValue) +
120400151031                         '</td>';
120500171016
120600171016               //varchar
120700171016               When Type = 12;
120800171016                 exec sql GET DESCRIPTOR 'Values' VALUE :x
120900171016                         :Varchar1 = DATA;
121000171016                 SubValue = %trimr(SubValue) +
121100171016                         '<td>' +
121200171016                         %trim(varchar1) +
121300171016                         '</td>';
121400151031
121500190527               //varGraphic
121600190527               When Type = -96;
121700190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
121800190527                         :VarGraphic = DATA;
121900190527                 SubValue = %trimr(SubValue) +
122000190527                         '<td>' +
122100190527                         %trim(%char(varGraphic)) +
122200190527                         '</td>';
122300190527
122400190527               When Type = 25 ;
122500151101                 Exsr $BigInt; // Big Integer
122600151101
122700151101                 SubValue = %trimr(SubValue) +
122800151101                         '<td align="Right">' +
122900151101                         %trim(NumericValue) +
123000151101                         '</td>';
123100151101
123200151101               When Type = 5 ;
123300151101                 Exsr $SmallInt; // Small Integer
123400151101
123500151101                 SubValue = %trimr(SubValue) +
123600151101                         '<td align="Right">' +
123700151101                         %trim(NumericValue) +
123800151101                         '</td>';
123900151101
124000151101               When Type = 4 ;
124100151101                 Exsr $Int; // Integer
124200151101
124300151101                 SubValue = %trimr(SubValue) +
124400151101                         '<td align="Right">' +
124500151101                         %trim(NumericValue) +
124600151101                         '</td>';
124700190527
124800190527               When Type = 6 ;
124900190527                 Exsr $Float; // Float
125000190527
125100190527                 SubValue = %trimr(SubValue) +
125200190527                      '<td align="Right">' +
125300190527                      %trim(NumericValue) +
125400190527                      '</td>';
125500190527
125600190527               When Type = 9 ;
125700190527                 Exsr $DateTime; // Date Time
125800190527
125900190527                 SubValue = %trimr(SubValue) +
126000190527                      '<td align="Right">' +
126100190527                      %trim(NumericValue) +
126200190527                      '</td>';
126300190527
126400151031               Other;
126500151031                 SubValue = %trimr(SubValue) +
126600190527                         '<td>Undefined Type =' + %char(type) + '</td>' ;
126700151031               ENDSL;
126800151031
126900151031             Endfor;
127000151031             SubValue = %trimr(SubValue) + '</tr>';
127100151031       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
127200151031           ENDDO;
127300151229         Endif;
127400151031     c/exec sql
127500151031     c+     Close OpenHandleT
127600151031     c/end-exec
127700151031
127800151031
127900151030
128000151031           SubValue = %trimr(SubValue) + '</table>';
128100151030
128200151030       Endsr;
128300151031
128400151031       //************************************************************************
128500151031       // Subroutine = $Alpha - Get alpha descriptor
128600151031       //************************************************************************
128700151031       Begsr $Alpha;
128800151031
128900160405               clear ValueA;
129000151031               Select;
129100151031               When length = 1;
129200151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
129300151031                         :ValueA1 = DATA;
129400170503               When length = 2;
129500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
129600151031                         :ValueA2 = DATA;
129700151031
129800151031               When length = 3;
129900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130000151031                         :ValueA3 = DATA;
130100151031
130200151031               When length = 4;
130300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130400151031                         :ValueA4 = DATA;
130500151031
130600151031               When length = 5;
130700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130800151031                         :ValueA5 = DATA;
130900151031
131000151031               When length = 6;
131100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
131200151031                         :ValueA6 = DATA;
131300151031
131400151031               When length = 7;
131500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
131600151031                         :ValueA7 = DATA;
131700151031
131800151031               When length = 8;
131900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132000151031                         :ValueA8 = DATA;
132100151031
132200151031               When length = 9;
132300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132400151031                         :ValueA9 = DATA;
132500151031
132600151031               When length = 10;
132700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132800151031                         :ValueA10 = DATA;
132900151031
133000151031               When length = 11;
133100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
133200151031                         :ValueA11 = DATA;
133300151031
133400151031               When length = 12;
133500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
133600151031                         :ValueA12 = DATA;
133700151031
133800151031               When length = 13;
133900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134000151031                         :ValueA13 = DATA;
134100151031
134200151031               When length = 14;
134300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134400151031                         :ValueA14 = DATA;
134500151031
134600151031               When length = 15;
134700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134800151031                         :ValueA15 = DATA;
134900151031
135000151031               When length = 16;
135100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
135200151031                         :ValueA16 = DATA;
135300151031
135400151031               When length = 17;
135500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
135600151031                         :ValueA17 = DATA;
135700151031
135800151031               When length = 18;
135900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136000151031                         :ValueA18 = DATA;
136100151031
136200151031               When length = 19;
136300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136400151031                         :ValueA19 = DATA;
136500151031
136600151031               When length = 20;
136700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136800151031                         :ValueA20 = DATA;
136900151101
137000151101               When length = 21;
137100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
137200151101                         :ValueA21 = DATA;
137300151101
137400151101               When length = 22;
137500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
137600151101                         :ValueA22 = DATA;
137700151101
137800151101               When length = 23;
137900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138000151101                         :ValueA23 = DATA;
138100151101
138200151101               When length = 24;
138300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138400151101                         :ValueA24 = DATA;
138500151101
138600151101               When length = 25;
138700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138800151101                         :ValueA25 = DATA;
138900151101
139000151101               When length = 26;
139100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
139200151101                         :ValueA26 = DATA;
139300151101
139400151101               When length = 27;
139500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
139600151101                         :ValueA27 = DATA;
139700151101
139800151101               When length = 28;
139900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140000151101                         :ValueA28 = DATA;
140100151101
140200151101               When length = 29;
140300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140400151101                         :ValueA29 = DATA;
140500151101
140600151101               When length = 30;
140700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140800151101                         :ValueA30 = DATA;
140900151101
141000151101               When length = 31;
141100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
141200151101                         :ValueA31 = DATA;
141300151101
141400151101               When length = 32;
141500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
141600151101                         :ValueA32 = DATA;
141700151101
141800151101               When length = 33;
141900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142000151101                         :ValueA33 = DATA;
142100151101
142200151101               When length = 34;
142300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142400151101                         :ValueA34 = DATA;
142500151101
142600151101               When length = 35;
142700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142800151101                         :ValueA35 = DATA;
142900151101
143000151101               When length = 36;
143100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
143200151101                         :ValueA36 = DATA;
143300151101
143400151101               When length = 37;
143500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
143600151101                         :ValueA37 = DATA;
143700151101
143800151101               When length = 38;
143900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144000151101                         :ValueA38 = DATA;
144100151101
144200151101               When length = 39;
144300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144400151101                         :ValueA39 = DATA;
144500151101
144600151101               When length = 40;
144700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144800151101                         :ValueA40 = DATA;
144900151101
145000151101               When length = 41;
145100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
145200151101                         :ValueA41 = DATA;
145300151101
145400151101               When length = 42;
145500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
145600151101                         :ValueA42 = DATA;
145700151101
145800151101               When length = 43;
145900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146000151101                         :ValueA43 = DATA;
146100151101
146200151101               When length = 44;
146300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146400151101                         :ValueA44 = DATA;
146500151101
146600151101               When length = 45;
146700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146800151101                         :ValueA45 = DATA;
146900151101
147000151101               When length = 46;
147100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
147200151101                         :ValueA46 = DATA;
147300151101
147400151101               When length = 47;
147500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
147600151101                         :ValueA47 = DATA;
147700151101
147800151101               When length = 48;
147900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148000151101                         :ValueA48 = DATA;
148100151101
148200151101               When length = 49;
148300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148400151101                         :ValueA49 = DATA;
148500151101
148600151101               When length = 50;
148700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148800151101                         :ValueA50 = DATA;
148900151101
149000151101               When length = 51;
149100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
149200151101                         :ValueA51 = DATA;
149300151101
149400151101               When length = 52;
149500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
149600151101                         :ValueA52 = DATA;
149700151101
149800151101               When length = 53;
149900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150000151101                         :ValueA53 = DATA;
150100151101
150200151101               When length = 54;
150300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150400151101                         :ValueA54 = DATA;
150500151101
150600151101               When length = 55;
150700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150800151101                         :ValueA55 = DATA;
150900151101
151000151101               When length = 56;
151100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
151200151101                         :ValueA56 = DATA;
151300151101
151400151101               When length = 57;
151500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
151600151101                         :ValueA57 = DATA;
151700151101
151800151101               When length = 58;
151900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152000151101                         :ValueA58 = DATA;
152100151101
152200151101               When length = 59;
152300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152400151101                         :ValueA59 = DATA;
152500151101
152600151101               When length = 60;
152700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152800151101                         :ValueA60 = DATA;
152900151101
153000151101               When length = 61;
153100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
153200151101                         :ValueA61 = DATA;
153300151101
153400151101               When length = 62;
153500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
153600151101                         :ValueA62 = DATA;
153700151101
153800151101               When length = 63;
153900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154000151101                         :ValueA63 = DATA;
154100151101
154200151101               When length = 64;
154300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154400151101                         :ValueA64 = DATA;
154500151101
154600151101               When length = 65;
154700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154800151101                         :ValueA65 = DATA;
154900151101
155000151101               When length = 66;
155100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
155200151101                         :ValueA66 = DATA;
155300151101
155400151101               When length = 67;
155500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
155600151101                         :ValueA67 = DATA;
155700151101
155800151101               When length = 68;
155900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156000151101                         :ValueA68 = DATA;
156100151101
156200151101               When length = 69;
156300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156400151101                         :ValueA69 = DATA;
156500151101
156600151101               When length = 70;
156700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156800151101                         :ValueA70 = DATA;
156900151101
157000151101               When length = 71;
157100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
157200151101                         :ValueA71 = DATA;
157300151101
157400151101               When length = 72;
157500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
157600151101                         :ValueA72 = DATA;
157700151101
157800151101               When length = 73;
157900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158000151101                         :ValueA73 = DATA;
158100151101
158200151101               When length = 74;
158300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158400151101                         :ValueA74 = DATA;
158500151101
158600151101               When length = 75;
158700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158800151101                         :ValueA75 = DATA;
158900151101
159000151101               When length = 76;
159100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
159200151101                         :ValueA76 = DATA;
159300151101
159400151101               When length = 77;
159500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
159600151101                         :ValueA77 = DATA;
159700151101
159800151101               When length = 78;
159900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160000151101                         :ValueA78 = DATA;
160100151101
160200151101               When length = 79;
160300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160400151101                         :ValueA79 = DATA;
160500151101
160600151101               When length = 80;
160700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160800151101                         :ValueA80 = DATA;
160900151101
161000151101               When length = 81;
161100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
161200151101                         :ValueA81 = DATA;
161300151101
161400151101               When length = 82;
161500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
161600151101                         :ValueA82 = DATA;
161700151101
161800151101               When length = 83;
161900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162000151101                         :ValueA83 = DATA;
162100151101
162200151101               When length = 84;
162300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162400151101                         :ValueA84 = DATA;
162500151101
162600151101               When length = 85;
162700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162800151101                         :ValueA85 = DATA;
162900151101
163000151101               When length = 86;
163100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
163200151101                         :ValueA86 = DATA;
163300151101
163400151101               When length = 87;
163500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
163600151101                         :ValueA87 = DATA;
163700151101
163800151101               When length = 88;
163900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164000151101                         :ValueA88 = DATA;
164100151101
164200151101               When length = 89;
164300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164400151101                         :ValueA89 = DATA;
164500151101
164600151101               When length = 90;
164700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164800151101                         :ValueA90 = DATA;
164900151101
165000151101               When length = 91;
165100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
165200151101                         :ValueA91 = DATA;
165300151101
165400151101               When length = 92;
165500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
165600151101                         :ValueA92 = DATA;
165700151101
165800151101               When length = 93;
165900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166000151101                         :ValueA93 = DATA;
166100151101
166200151101               When length = 94;
166300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166400151101                         :ValueA94 = DATA;
166500151101
166600151101               When length = 95;
166700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166800151101                         :ValueA95 = DATA;
166900151101
167000151101               When length = 96;
167100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
167200151101                         :ValueA96 = DATA;
167300151101
167400151101               When length = 97;
167500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
167600151101                         :ValueA97 = DATA;
167700151101
167800151101               When length = 98;
167900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168000151101                         :ValueA98 = DATA;
168100151101
168200151101               When length = 99;
168300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168400151101                         :ValueA99 = DATA;
168500151101
168600151101               When length = 100;
168700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168800151101                         :ValueA100 = DATA;
168900151229
169000151229               When length = 101;
169100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
169200151229                         :ValueA101 = DATA;
169300151229
169400151229               When length = 102;
169500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
169600151229                         :ValueA102 = DATA;
169700151229
169800151229               When length = 103;
169900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170000151229                         :ValueA103 = DATA;
170100151229
170200151229               When length = 104;
170300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170400151229                         :ValueA104 = DATA;
170500151229
170600151229               When length = 105;
170700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170800151229                         :ValueA105 = DATA;
170900151229
171000151229               When length = 106;
171100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
171200151229                         :ValueA106 = DATA;
171300151229
171400151229               When length = 107;
171500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
171600151229                         :ValueA107 = DATA;
171700151229
171800151229               When length = 108;
171900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172000151229                         :ValueA108 = DATA;
172100151229
172200151229               When length = 109;
172300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172400151229                         :ValueA109 = DATA;
172500151229
172600151229               When length = 110;
172700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172800151229                         :ValueA110 = DATA;
172900151229
173000151229               When length = 111;
173100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
173200151229                         :ValueA111 = DATA;
173300151229
173400151229               When length = 112;
173500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
173600151229                         :ValueA112 = DATA;
173700151229
173800151229               When length = 113;
173900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174000151229                         :ValueA113 = DATA;
174100151229
174200151229               When length = 114;
174300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174400151229                         :ValueA114 = DATA;
174500151229
174600151229               When length = 115;
174700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174800151229                         :ValueA115 = DATA;
174900151229
175000151229               When length = 116;
175100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
175200151229                         :ValueA116 = DATA;
175300151229
175400151229               When length = 117;
175500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
175600151229                         :ValueA117 = DATA;
175700151229
175800151229               When length = 118;
175900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176000151229                         :ValueA118 = DATA;
176100151229
176200151229               When length = 119;
176300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176400151229                         :ValueA119 = DATA;
176500151229
176600151229               When length = 120;
176700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176800151229                         :ValueA120 = DATA;
176900151229
177000151229               When length = 121;
177100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
177200151229                         :ValueA121 = DATA;
177300151229
177400151229               When length = 122;
177500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
177600151229                         :ValueA122 = DATA;
177700151229
177800151229               When length = 123;
177900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178000151229                         :ValueA123 = DATA;
178100151229
178200151229               When length = 124;
178300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178400151229                         :ValueA124 = DATA;
178500151229
178600151229               When length = 125;
178700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178800151229                         :ValueA125 = DATA;
178900151229
179000151229               When length = 126;
179100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
179200151229                         :ValueA126 = DATA;
179300151229
179400151229               When length = 127;
179500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
179600151229                         :ValueA127 = DATA;
179700151229
179800151229               When length = 128;
179900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
180000151229                         :ValueA128 = DATA;
180100151229
180200151229               When length = 129;
180300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
180400151229                         :ValueA129 = DATA;
180500151229
180600151229               When length = 130;
180700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
180800151229                         :ValueA130 = DATA;
180900151229
181000151229               When length = 131;
181100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
181200151229                         :ValueA131 = DATA;
181300151229
181400151229               When length = 132;
181500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
181600151229                         :ValueA132 = DATA;
181700151229
181800151229               When length = 133;
181900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
182000151229                         :ValueA133 = DATA;
182100151229
182200151229               When length = 134;
182300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
182400151229                         :ValueA134 = DATA;
182500151229
182600151229               When length = 135;
182700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
182800151229                         :ValueA135 = DATA;
182900151229
183000151229               When length = 136;
183100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
183200151229                         :ValueA136 = DATA;
183300151229
183400151229               When length = 137;
183500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
183600151229                         :ValueA137 = DATA;
183700151229
183800151229               When length = 138;
183900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
184000151229                         :ValueA138 = DATA;
184100151229
184200151229               When length = 139;
184300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
184400151229                         :ValueA139 = DATA;
184500151229
184600151229               When length = 140;
184700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
184800151229                         :ValueA140 = DATA;
184900151229
185000151229               When length = 141;
185100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
185200151229                         :ValueA141 = DATA;
185300151229
185400151229               When length = 142;
185500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
185600151229                         :ValueA142 = DATA;
185700151229
185800151229               When length = 143;
185900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
186000151229                         :ValueA143 = DATA;
186100151229
186200151229               When length = 144;
186300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
186400151229                         :ValueA144 = DATA;
186500151229
186600151229               When length = 145;
186700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
186800151229                         :ValueA145 = DATA;
186900151229
187000151229               When length = 146;
187100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
187200151229                         :ValueA146 = DATA;
187300151229
187400151229               When length = 147;
187500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
187600151229                         :ValueA147 = DATA;
187700151229
187800151229               When length = 148;
187900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
188000151229                         :ValueA148 = DATA;
188100151229
188200151229               When length = 149;
188300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
188400151229                         :ValueA149 = DATA;
188500151229
188600151229               When length = 150;
188700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
188800151229                         :ValueA150 = DATA;
188900151229
189000151229               When length = 151;
189100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
189200151229                         :ValueA151 = DATA;
189300151229
189400151229               When length = 152;
189500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
189600151229                         :ValueA152 = DATA;
189700151229
189800151229               When length = 153;
189900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
190000151229                         :ValueA153 = DATA;
190100151229
190200151229               When length = 154;
190300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
190400151229                         :ValueA154 = DATA;
190500151229
190600151229               When length = 155;
190700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
190800151229                         :ValueA155 = DATA;
190900151229
191000151229               When length = 156;
191100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
191200151229                         :ValueA156 = DATA;
191300151229
191400151229               When length = 157;
191500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
191600151229                         :ValueA157 = DATA;
191700151229
191800151229               When length = 158;
191900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
192000151229                         :ValueA158 = DATA;
192100151229
192200151229               When length = 159;
192300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
192400151229                         :ValueA159 = DATA;
192500151229
192600151229               When length = 160;
192700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
192800151229                         :ValueA160 = DATA;
192900151229
193000151229               When length = 161;
193100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
193200151229                         :ValueA161 = DATA;
193300151229
193400151229               When length = 162;
193500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
193600151229                         :ValueA162 = DATA;
193700151229
193800151229               When length = 163;
193900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
194000151229                         :ValueA163 = DATA;
194100151229
194200151229               When length = 164;
194300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
194400151229                         :ValueA164 = DATA;
194500151229
194600151229               When length = 165;
194700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
194800151229                         :ValueA165 = DATA;
194900151229
195000151229               When length = 166;
195100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
195200151229                         :ValueA166 = DATA;
195300151229
195400151229               When length = 167;
195500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
195600151229                         :ValueA167 = DATA;
195700151229
195800151229               When length = 168;
195900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
196000151229                         :ValueA168 = DATA;
196100151229
196200151229               When length = 169;
196300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
196400151229                         :ValueA169 = DATA;
196500151229
196600151229               When length = 170;
196700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
196800151229                         :ValueA170 = DATA;
196900151229
197000151229               When length = 171;
197100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
197200151229                         :ValueA171 = DATA;
197300151229
197400151229               When length = 172;
197500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
197600151229                         :ValueA172 = DATA;
197700151229
197800151229               When length = 173;
197900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
198000151229                         :ValueA173 = DATA;
198100151229
198200151229               When length = 174;
198300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
198400151229                         :ValueA174 = DATA;
198500151229
198600151229               When length = 175;
198700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
198800151229                         :ValueA175 = DATA;
198900151229
199000151229               When length = 176;
199100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
199200151229                         :ValueA176 = DATA;
199300151229
199400151229               When length = 177;
199500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
199600151229                         :ValueA177 = DATA;
199700151229
199800151229               When length = 178;
199900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
200000151229                         :ValueA178 = DATA;
200100151229
200200151229               When length = 179;
200300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
200400151229                         :ValueA179 = DATA;
200500151229
200600151229               When length = 180;
200700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
200800151229                         :ValueA180 = DATA;
200900151229
201000151229               When length = 181;
201100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
201200151229                         :ValueA181 = DATA;
201300151229
201400151229               When length = 182;
201500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
201600151229                         :ValueA182 = DATA;
201700151229
201800151229               When length = 183;
201900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
202000151229                         :ValueA183 = DATA;
202100151229
202200151229               When length = 184;
202300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
202400151229                         :ValueA184 = DATA;
202500151229
202600151229               When length = 185;
202700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
202800151229                         :ValueA185 = DATA;
202900151229
203000151229               When length = 186;
203100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
203200151229                         :ValueA186 = DATA;
203300151229
203400151229               When length = 187;
203500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
203600151229                         :ValueA187 = DATA;
203700151229
203800151229               When length = 188;
203900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
204000151229                         :ValueA188 = DATA;
204100151229
204200151229               When length = 189;
204300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
204400151229                         :ValueA189 = DATA;
204500151229
204600151229               When length = 190;
204700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
204800151229                         :ValueA190 = DATA;
204900151229
205000151229               When length = 191;
205100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
205200151229                         :ValueA191 = DATA;
205300151229
205400151229               When length = 192;
205500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
205600151229                         :ValueA192 = DATA;
205700151229
205800151229               When length = 193;
205900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
206000151229                         :ValueA193 = DATA;
206100151229
206200151229               When length = 194;
206300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
206400151229                         :ValueA194 = DATA;
206500151229
206600151229               When length = 195;
206700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
206800151229                         :ValueA195 = DATA;
206900151229
207000151229               When length = 196;
207100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
207200151229                         :ValueA196 = DATA;
207300151229
207400151229               When length = 197;
207500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
207600151229                         :ValueA197 = DATA;
207700151229
207800151229               When length = 198;
207900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
208000151229                         :ValueA198 = DATA;
208100151229
208200151229               When length = 199;
208300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
208400151229                         :ValueA199 = DATA;
208500151229
208600151229               When length = 200;
208700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
208800151229                         :ValueA200 = DATA;
208900190527
209000190527               When length > 201;
209100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
209200190527                         :ValueA32000 = DATA;
209300190527
209400190527               Other;
209500190527                 ValueA32000 = 'Length=' + %char(length);
209600151031               Endsl;
209700151031
209800151031       Endsr;
209900151031
210000151031       //************************************************************************
210100151031       // Subroutine = $Numeric - Get numeric descriptor
210200151031       //************************************************************************
210300151031       Begsr $Numeric;
210400151031
210500170320               clear ValueN;
210600151031               Select;
210700151101           // 1
210800180127               When precision = 1 and scale = 0;
210900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
211000151101                         :ValueN1_0 = DATA;
211100151101               NumericValue = %editc(ValueN1_0:'K');
211200151101
211300180127               When precision = 1 and scale = 1;
211400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
211500151101                         :ValueN1_1 = DATA;
211600151101               NumericValue = %editc(ValueN1_1:'K');
211700151101           // 2
211800180127               When precision = 2 and scale = 0;
211900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
212000151101                         :ValueN2_0 = DATA;
212100151101               NumericValue = %editc(ValueN2_0:'K');
212200151101
212300180127               When precision = 2 and scale = 1;
212400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
212500151101                         :ValueN2_1 = DATA;
212600151101               NumericValue = %editc(ValueN2_1:'K');
212700151101
212800180127               When precision = 2 and scale = 2;
212900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
213000151101                         :ValueN2_2 = DATA;
213100151101               NumericValue = %editc(ValueN2_2:'K');
213200151101
213300151101            // 3
213400180127               When precision = 3 and scale = 0;
213500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
213600151101                         :ValueN3_0 = DATA;
213700151101               NumericValue = %editc(ValueN3_0:'K');
213800151101
213900180127               When precision = 3 and scale = 1;
214000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
214100151101                         :ValueN3_1 = DATA;
214200151101               NumericValue = %editc(ValueN3_1:'K');
214300151101
214400180127               When precision = 3 and scale = 2;
214500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
214600151101                         :ValueN3_2 = DATA;
214700151101               NumericValue = %editc(ValueN3_2:'K');
214800151101
214900180127               When precision = 3 and scale = 3;
215000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
215100151101                         :ValueN3_3 = DATA;
215200151101               NumericValue = %editc(ValueN3_3:'K');
215300151101
215400151101            // 4
215500180127               When precision = 4 and scale = 0;
215600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
215700151101                         :ValueN4_0 = DATA;
215800151101               NumericValue = %editc(ValueN4_0:'K');
215900151101
216000180127               When precision = 4 and scale = 1;
216100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
216200151101                         :ValueN4_1 = DATA;
216300151101               NumericValue = %editc(ValueN4_1:'K');
216400151101
216500180127               When precision = 4 and scale = 2;
216600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
216700151101                         :ValueN4_2 = DATA;
216800151101               NumericValue = %editc(ValueN4_2:'K');
216900151101
217000180127               When precision = 4 and scale = 3;
217100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217200151101                         :ValueN4_3 = DATA;
217300151101               NumericValue = %editc(ValueN4_3:'K');
217400151101
217500180127               When precision = 4 and scale = 4;
217600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217700151101                         :ValueN4_4 = DATA;
217800151101               NumericValue = %editc(ValueN4_4:'K');
217900151101
218000151101            // 5
218100180127               When precision = 5 and scale = 0;
218200151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
218300151101                         :ValueN5_0 = DATA;
218400151101               NumericValue = %editc(ValueN5_0:'K');
218500151101
218600180127               When precision = 5 and scale = 1;
218700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
218800151101                         :ValueN5_1 = DATA;
218900151101               NumericValue = %editc(ValueN5_1:'K');
219000151101
219100180127               When precision = 5 and scale = 2;
219200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
219300151101                         :ValueN5_2 = DATA;
219400151101               NumericValue = %editc(ValueN5_2:'K');
219500151101
219600180127               When precision = 5 and scale = 3;
219700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
219800151101                         :ValueN5_3 = DATA;
219900151101               NumericValue = %editc(ValueN5_3:'K');
220000151101
220100180127               When precision = 5 and scale = 4;
220200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
220300151101                         :ValueN5_4 = DATA;
220400151101               NumericValue = %editc(ValueN5_4:'K');
220500151101
220600151101            // 6
220700180127               When precision = 6 and scale = 0;
220800151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
220900151101                         :ValueN6_0 = DATA;
221000151101               NumericValue = %editc(ValueN6_0:'K');
221100151101
221200180127               When precision = 6 and scale = 1;
221300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
221400151101                         :ValueN6_1 = DATA;
221500151101               NumericValue = %editc(ValueN6_1:'K');
221600151101
221700180127               When precision = 6 and scale = 2;
221800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
221900151101                         :ValueN6_2 = DATA;
222000151101               NumericValue = %editc(ValueN6_2:'K');
222100151101
222200180127               When precision = 6 and scale = 3;
222300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
222400151101                         :ValueN6_3 = DATA;
222500151101               NumericValue = %editc(ValueN6_3:'K');
222600151101
222700180127               When precision = 6 and scale = 4;
222800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
222900151101                         :ValueN6_4 = DATA;
223000151101               NumericValue = %editc(ValueN6_4:'K');
223100151101
223200151101            // 7
223300180127               When precision = 7 and scale = 0;
223400151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
223500151101                         :ValueN7_0 = DATA;
223600151101               NumericValue = %editc(ValueN7_0:'K');
223700151101
223800180127               When precision = 7 and scale = 1;
223900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
224000151101                         :ValueN7_1 = DATA;
224100151101               NumericValue = %editc(ValueN7_1:'K');
224200151101
224300180127               When precision = 7 and scale = 2;
224400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
224500151101                         :ValueN7_2 = DATA;
224600151101               NumericValue = %editc(ValueN7_2:'K');
224700151101
224800180127               When precision = 7 and scale = 3;
224900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
225000151101                         :ValueN7_3 = DATA;
225100151101               NumericValue = %editc(ValueN7_3:'K');
225200151101
225300180127               When precision = 7 and scale = 4;
225400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
225500151101                         :ValueN7_4 = DATA;
225600151101               NumericValue = %editc(ValueN7_4:'K');
225700151101
225800151101            // 8
225900180127               When precision = 8 and scale = 0;
226000151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
226100151101                         :ValueN8_0 = DATA;
226200151101               NumericValue = %editc(ValueN8_0:'K');
226300151101
226400180127               When precision = 8 and scale = 1;
226500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
226600151101                         :ValueN8_1 = DATA;
226700151101               NumericValue = %editc(ValueN8_1:'K');
226800151101
226900180127               When precision = 8 and scale = 2;
227000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
227100151101                         :ValueN8_2 = DATA;
227200151101               NumericValue = %editc(ValueN8_2:'K');
227300151101
227400180127               When precision = 8 and scale = 3;
227500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
227600151101                         :ValueN8_3 = DATA;
227700151101               NumericValue = %editc(ValueN8_3:'K');
227800151101
227900180127               When precision = 8 and scale = 4;
228000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
228100151101                         :ValueN8_4 = DATA;
228200151101               NumericValue = %editc(ValueN8_4:'K');
228300151101
228400151101            // 9
228500180127               When precision = 9 and scale = 0;
228600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
228700151101                         :ValueN9_0 = DATA;
228800151101               NumericValue = %editc(ValueN9_0:'K');
228900151101
229000180127               When precision = 9 and scale = 1;
229100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
229200151101                         :ValueN9_1 = DATA;
229300151101               NumericValue = %editc(ValueN9_1:'K');
229400151101
229500180127               When precision = 9 and scale = 2;
229600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
229700151101                         :ValueN9_2 = DATA;
229800151101               NumericValue = %editc(ValueN9_2:'K');
229900151101
230000180127               When precision = 9 and scale = 3;
230100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
230200151101                         :ValueN9_3 = DATA;
230300151101               NumericValue = %editc(ValueN9_3:'K');
230400151101
230500180127               When precision = 9 and scale = 4;
230600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
230700151101                         :ValueN9_4 = DATA;
230800151101               NumericValue = %editc(ValueN9_4:'K');
230900151101
231000151101            // 10
231100180127               When precision = 10 and scale = 0;
231200151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
231300151101                         :ValueN10_0 = DATA;
231400151101               NumericValue = %editc(ValueN10_0:'K');
231500151101
231600180127               When precision = 10 and scale = 1;
231700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
231800151101                         :ValueN10_1 = DATA;
231900151101               NumericValue = %editc(ValueN10_1:'K');
232000151101
232100180127               When precision = 10 and scale = 2;
232200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
232300151101                         :ValueN10_2 = DATA;
232400151101               NumericValue = %editc(ValueN10_2:'K');
232500151101
232600180127               When precision = 10 and scale = 3;
232700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
232800151101                         :ValueN10_3 = DATA;
232900151101               NumericValue = %editc(ValueN10_3:'K');
233000151101
233100180127               When precision = 10 and scale = 4;
233200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
233300151101                         :ValueN10_4 = DATA;
233400151101               NumericValue = %editc(ValueN10_4:'K');
233500151101
233600151101            // 11
233700180127               When precision = 11 and scale = 0;
233800151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
233900151101                         :ValueN11_0 = DATA;
234000151101               NumericValue = %editc(ValueN11_0:'K');
234100151031
234200180127               When precision = 11 and scale = 1;
234300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
234400151101                         :ValueN11_1 = DATA;
234500151101               NumericValue = %editc(ValueN11_1:'K');
234600151101
234700180127               When precision = 11 and scale = 2;
234800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
234900151101                         :ValueN11_2 = DATA;
235000151101               NumericValue = %editc(ValueN11_2:'K');
235100151101
235200180127               When precision = 11 and scale = 3;
235300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
235400151101                         :ValueN11_3 = DATA;
235500151101               NumericValue = %editc(ValueN11_3:'K');
235600151101
235700180127               When precision = 11 and scale = 4;
235800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
235900151101                         :ValueN11_4 = DATA;
236000151101               NumericValue = %editc(ValueN11_4:'K');
236100151101
236200151101            // 12
236300180127               When precision = 12 and scale = 0;
236400151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
236500151101                         :ValueN12_0 = DATA;
236600151101               NumericValue = %editc(ValueN12_0:'K');
236700151101
236800180127               When precision = 12 and scale = 1;
236900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
237000151101                         :ValueN12_1 = DATA;
237100151101               NumericValue = %editc(ValueN12_1:'K');
237200151101
237300180127               When precision = 12 and scale = 2;
237400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
237500151101                         :ValueN12_2 = DATA;
237600151101               NumericValue = %editc(ValueN12_2:'K');
237700151101
237800180127               When precision = 12 and scale = 3;
237900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
238000151101                         :ValueN12_3 = DATA;
238100151101               NumericValue = %editc(ValueN12_3:'K');
238200151101
238300180127               When precision = 12 and scale = 4;
238400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
238500151101                         :ValueN12_4 = DATA;
238600151101               NumericValue = %editc(ValueN12_4:'K');
238700151101
238800151101            // 13
238900180127               When precision = 13 and scale = 0;
239000151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
239100151101                         :ValueN13_0 = DATA;
239200151101               NumericValue = %editc(ValueN13_0:'K');
239300151101
239400180127               When precision = 13 and scale = 1;
239500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
239600151101                         :ValueN13_1 = DATA;
239700151101               NumericValue = %editc(ValueN13_1:'K');
239800151101
239900180127               When precision = 13 and scale = 2;
240000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
240100151101                         :ValueN13_2 = DATA;
240200151101               NumericValue = %editc(ValueN13_2:'K');
240300151101
240400180127               When precision = 13 and scale = 3;
240500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
240600151101                         :ValueN13_3 = DATA;
240700151101               NumericValue = %editc(ValueN13_3:'K');
240800151101
240900180127               When precision = 13 and scale = 4;
241000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
241100151101                         :ValueN13_4 = DATA;
241200151101               NumericValue = %editc(ValueN13_4:'K');
241300151101
241400151101            // 14
241500180127               When precision = 14 and scale = 0;
241600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
241700151101                         :ValueN14_0 = DATA;
241800151101               NumericValue = %editc(ValueN14_0:'K');
241900151101
242000180127               When precision = 14 and scale = 1;
242100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
242200151101                         :ValueN14_1 = DATA;
242300151101               NumericValue = %editc(ValueN14_1:'K');
242400151101
242500180127               When precision = 14 and scale = 2;
242600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
242700151101                         :ValueN14_2 = DATA;
242800151101               NumericValue = %editc(ValueN14_2:'K');
242900151101
243000180127               When precision = 14 and scale = 3;
243100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
243200151101                         :ValueN14_3 = DATA;
243300151101               NumericValue = %editc(ValueN14_3:'K');
243400151101
243500180127               When precision = 14 and scale = 4;
243600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
243700151101                         :ValueN14_4 = DATA;
243800151101               NumericValue = %editc(ValueN14_4:'K');
243900151101
244000151101            // 15
244100180127               When precision = 15 and scale = 0;
244200151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
244300151101                         :ValueN15_0 = DATA;
244400151101               NumericValue = %editc(ValueN15_0:'K');
244500151101
244600180127               When precision = 15 and scale = 1;
244700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
244800151101                         :ValueN15_1 = DATA;
244900151101               NumericValue = %editc(ValueN15_1:'K');
245000151101
245100180127               When precision = 15 and scale = 2;
245200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
245300151101                         :ValueN15_2 = DATA;
245400151101               NumericValue = %editc(ValueN15_2:'K');
245500151101
245600180127               When precision = 15 and scale = 3;
245700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
245800151101                         :ValueN15_3 = DATA;
245900151101               NumericValue = %editc(ValueN15_3:'K');
246000151101
246100180127               When precision = 15 and scale = 4;
246200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
246300151101                         :ValueN15_4 = DATA;
246400151101               NumericValue = %editc(ValueN15_4:'K');
246500151101
246600190527               // > 15
246700190527               When length > 15 and scale = 0;
246800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
246900190527                         :ValueN31_0 = DATA;
247000190527               NumericValue = %editc(ValueN31_0:'K');
247100190527
247200190527               When length > 15 and scale = 1;
247300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
247400190527                         :ValueN31_1 = DATA;
247500190527               NumericValue = %editc(ValueN31_1:'K');
247600190527
247700190527               When length > 15 and scale = 2;
247800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
247900190527                         :ValueN31_2 = DATA;
248000190527               NumericValue = %editc(ValueN31_2:'K');
248100190527
248200190527               When length > 15 and scale = 3;
248300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
248400190527                         :ValueN31_3 = DATA;
248500190527               NumericValue = %editc(ValueN31_3:'K');
248600190527
248700190527               When length > 15 and scale = 4;
248800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
248900190527                         :ValueN31_4 = DATA;
249000190527               NumericValue = %editc(ValueN31_4:'K');
249100190527
249200190527               When length > 15 and scale = 5;
249300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
249400190527                         :ValueN31_5 = DATA;
249500190527               NumericValue = %editc(ValueN31_5:'K');
249600190527
249700190527               When length > 15 and scale = 6;
249800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
249900190527                         :ValueN31_6 = DATA;
250000190527               NumericValue = %editc(ValueN31_6:'K');
250100190527
250200190527               When length > 15 and scale = 7;
250300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
250400190527                         :ValueN31_7 = DATA;
250500190527               NumericValue = %editc(ValueN31_7:'K');
250600190527
250700190527               When length > 15 and scale = 8;
250800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
250900190527                         :ValueN31_8 = DATA;
251000190527               NumericValue = %editc(ValueN31_8:'K');
251100190527
251200190527               When length > 15 and scale = 9;
251300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
251400190527                         :ValueN31_9 = DATA;
251500190527               NumericValue = %editc(ValueN31_9:'K');
251600190527
251700190527               When length > 15 and scale = 10;
251800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
251900190527                         :ValueN31_10 = DATA;
252000190527               NumericValue = %editc(ValueN31_10:'K');
252100190527
252200190527               When length > 15 and scale = 11;
252300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
252400190527                         :ValueN31_11 = DATA;
252500190527               NumericValue = %editc(ValueN31_11:'K');
252600190527
252700190527               When length > 15 and scale = 12;
252800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
252900190527                         :ValueN31_12 = DATA;
253000190527               NumericValue = %editc(ValueN31_12:'K');
253100190527
253200190527               When length > 15 and scale = 13;
253300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
253400190527                         :ValueN31_13 = DATA;
253500190527               NumericValue = %editc(ValueN31_13:'K');
253600190527
253700190527               When length > 15 and scale = 14;
253800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
253900190527                         :ValueN31_14 = DATA;
254000190527               NumericValue = %editc(ValueN31_14:'K');
254100190527
254200190527               When length > 15 and scale = 15;
254300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
254400190527                         :ValueN31_15 = DATA;
254500190527               NumericValue = %editc(ValueN31_15:'K');
254600190527
254700190527               When length > 15 and scale = 16;
254800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
254900190527                         :ValueN31_16 = DATA;
255000190527               NumericValue = %editc(ValueN31_16:'K');
255100190527
255200190527               When length > 15 and scale = 17;
255300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255400190527                         :ValueN31_17 = DATA;
255500190527               NumericValue = %editc(ValueN31_17:'K');
255600190527
255700190527               When length > 15 and scale = 18;
255800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255900190527                         :ValueN31_18 = DATA;
256000190527               NumericValue = %editc(ValueN31_18:'K');
256100190527
256200190527               When length > 15 and scale = 19;
256300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256400190527                         :ValueN31_19 = DATA;
256500190527               NumericValue = %editc(ValueN31_19:'K');
256600190527
256700190527               When length > 15 and scale = 20;
256800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256900190527                         :ValueN31_20 = DATA;
257000190527               NumericValue = %editc(ValueN31_20:'K');
257100190527
257200190527               When length > 15 and scale = 21;
257300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
257400190527                         :ValueN31_21 = DATA;
257500190527               NumericValue = %editc(ValueN31_21:'K');
257600190527
257700190527               When length > 15 and scale = 22;
257800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
257900190527                         :ValueN31_22 = DATA;
258000190527               NumericValue = %editc(ValueN31_22:'K');
258100190527
258200190527               When length > 15 and scale = 23;
258300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
258400190527                         :ValueN31_23 = DATA;
258500190527               NumericValue = %editc(ValueN31_23:'K');
258600190527
258700190527               When length > 15 and scale = 24;
258800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
258900190527                         :ValueN31_24 = DATA;
259000190527               NumericValue = %editc(ValueN31_24:'K');
259100190527
259200190527               When length > 15 and scale = 25;
259300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
259400190527                         :ValueN31_25 = DATA;
259500190527               NumericValue = %editc(ValueN31_25:'K');
259600190527
259700190527               When length > 15 and scale = 26;
259800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
259900190527                         :ValueN31_26 = DATA;
260000190527               NumericValue = %editc(ValueN31_26:'K');
260100190527
260200190527               When length > 15 and scale = 27;
260300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
260400190527                         :ValueN31_27 = DATA;
260500190527               NumericValue = %editc(ValueN31_27:'K');
260600190527
260700190527               When length > 15 and scale = 28;
260800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
260900190527                         :ValueN31_28 = DATA;
261000190527               NumericValue = %editc(ValueN31_28:'K');
261100190527
261200190527               When length > 15 and scale = 29;
261300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
261400190527                         :ValueN31_29 = DATA;
261500190527               NumericValue = %editc(ValueN31_29:'K');
261600190527
261700190527               When length > 15 and scale = 30;
261800190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
261900190527                         :ValueN31_30 = DATA;
262000190527               NumericValue = %editc(ValueN31_30:'K');
262100190527
262200190527               When length > 15 and scale = 31;
262300190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
262400190527                         :ValueN31_31 = DATA;
262500190527               NumericValue = %editc(ValueN31_31:'K');
262600190527
262700151101               Other;
262800151101                 NumericValue = *blanks;
262900151031               Endsl;
263000151031
263100151031       ENDSR;
263200151031
263300151031       //************************************************************************
263400151031       // Subroutine = $Decimal - Get numeric descriptor
263500151031       //************************************************************************
263600151031       Begsr $Decimal;
263700151031
263800190527             Length = (Precision/2)+1;
263900190527             Clear PackedDS;
264000190527             Select;
264100190527
264200190527
264300190527           // 1
264400190527             When precision = 1;
264500151031               Select;
264600190527               When scale = 0;
264700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
264800151101                         :ValueD1_0 = DATA;
264900151101                 NumericValue = %editc(ValueD1_0:'K');
265000151101
265100190527               When scale = 1;
265200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
265300151101                         :ValueD1_1 = DATA;
265400151101                 NumericValue = %editc(ValueD1_1:'K');
265500190527               Endsl;
265600151031
265700151101           // 2
265800190527             When precision = 2;
265900190527               Select;
266000190527               When scale = 0;
266100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
266200180127                         :ValueD2_0 = DATA;
266300180127                 NumericValue = %editc(ValueD2_0:'K');
266400151031
266500190527               When scale = 1;
266600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
266700180127                         :ValueD2_1 = DATA;
266800180127                 NumericValue = %editc(ValueD2_1:'K');
266900151101
267000190527               When scale = 2;
267100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
267200180127                         :ValueD2_2 = DATA;
267300180127                 NumericValue = %editc(ValueD2_2:'K');
267400190527               Endsl;
267500180127
267600180127           // 3
267700190527             When precision = 3;
267800190527               Select;
267900190527               When scale = 0;
268000180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
268100180127                         :ValueD3_0 = DATA;
268200180127                 NumericValue = %editc(ValueD3_0:'K');
268300180127
268400190527               When scale = 1;
268500180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
268600180127                         :ValueD3_1 = DATA;
268700180127                 NumericValue = %editc(ValueD3_1:'K');
268800180127
268900190527               When scale = 2;
269000180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
269100180127                         :ValueD3_2 = DATA;
269200180127                 NumericValue = %editc(ValueD3_2:'K');
269300151101
269400190527               When scale = 3;
269500180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
269600180127                         :ValueD3_3 = DATA;
269700180127                 NumericValue = %editc(ValueD3_3:'K');
269800190527               Endsl;
269900180127
270000180127           // 4
270100190527             When precision = 4;
270200190527               Select;
270300190527               When scale = 0;
270400180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
270500180127                         :ValueD4_0 = DATA;
270600180127                 NumericValue = %editc(ValueD4_0:'K');
270700180127
270800190527               When scale = 1;
270900180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
271000180127                         :ValueD4_1 = DATA;
271100180127                 NumericValue = %editc(ValueD4_1:'K');
271200180127
271300190527               When scale = 2;
271400180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
271500180127                         :ValueD4_2 = DATA;
271600180127                 NumericValue = %editc(ValueD4_2:'K');
271700180127
271800190527               When scale = 3;
271900180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
272000180127                         :ValueD4_3 = DATA;
272100180127                 NumericValue = %editc(ValueD4_3:'K');
272200180127
272300190527               When scale = 4;
272400180127                 exec sql GET DESCRIPTOR 'Values' VALUE :x
272500180127                         :ValueD4_4 = DATA;
272600180127                 NumericValue = %editc(ValueD4_4:'K');
272700190527               Endsl;
272800180127
272900180127           // 5
273000190527             When precision = 5;
273100190527               Select;
273200190527               When scale = 0;
273300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
273400151101                         :ValueD5_0 = DATA;
273500151101                 NumericValue = %editc(ValueD5_0:'K');
273600151031
273700190527               When scale = 1;
273800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
273900151101                         :ValueD5_1 = DATA;
274000151101                 NumericValue = %editc(ValueD5_1:'K');
274100151101
274200190527               When scale = 2;
274300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
274400151101                         :ValueD5_2 = DATA;
274500151101                 NumericValue = %editc(ValueD5_2:'K');
274600151101
274700190527               When scale = 3;
274800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
274900151101                         :ValueD5_3 = DATA;
275000151101                 NumericValue = %editc(ValueD5_3:'K');
275100151101
275200190527               When scale = 4;
275300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
275400151101                         :ValueD5_4 = DATA;
275500151101                 NumericValue = %editc(ValueD5_4:'K');
275600151101
275700190527               When scale = 5;
275800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
275900151101                         :ValueD5_5 = DATA;
276000151101                 NumericValue = %editc(ValueD5_5:'K');
276100190527               Endsl;
276200151101
276300180128           // 6
276400190527             When precision = 6;
276500190527               Select;
276600190527               When scale = 0;
276700180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
276800180128                         :ValueD6_0 = DATA;
276900180128                 NumericValue = %editc(ValueD6_0:'K');
277000180128
277100190527               When scale = 1;
277200180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
277300180128                         :ValueD6_1 = DATA;
277400180128                 NumericValue = %editc(ValueD6_1:'K');
277500180128
277600190527               When scale = 2;
277700180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
277800180128                         :ValueD6_2 = DATA;
277900180128                 NumericValue = %editc(ValueD6_2:'K');
278000180128
278100190527               When scale = 3;
278200180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
278300180128                         :ValueD6_3 = DATA;
278400180128                 NumericValue = %editc(ValueD6_3:'K');
278500180128
278600190527               When scale = 4;
278700180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
278800180128                         :ValueD6_4 = DATA;
278900180128                 NumericValue = %editc(ValueD6_4:'K');
279000180128
279100190527               When scale = 5;
279200180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
279300180128                         :ValueD6_5 = DATA;
279400180128                 NumericValue = %editc(ValueD6_5:'K');
279500180128
279600190527               When scale = 6;
279700180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
279800180128                         :ValueD6_6 = DATA;
279900180128                 NumericValue = %editc(ValueD6_6:'K');
280000190527               Endsl;
280100180128
280200180127           // 7
280300190527             When precision = 7;
280400190527               Select;
280500190527               When scale = 0;
280600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
280700151101                         :ValueD7_0 = DATA;
280800151101                 NumericValue = %editc(ValueD7_0:'K');
280900151031
281000190527               When scale = 1;
281100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
281200151101                         :ValueD7_1 = DATA;
281300151101                 NumericValue = %editc(ValueD7_1:'K');
281400151101
281500190527               When scale = 2;
281600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
281700151101                         :ValueD7_2 = DATA;
281800151101                 NumericValue = %editc(ValueD7_2:'K');
281900151101
282000190527               When scale = 3;
282100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
282200151101                         :ValueD7_3 = DATA;
282300151101                 NumericValue = %editc(ValueD7_3:'K');
282400151101
282500190527               When scale = 4;
282600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
282700151101                         :ValueD7_4 = DATA;
282800151101                 NumericValue = %editc(ValueD7_4:'K');
282900151101
283000190527               When scale = 5;
283100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
283200151101                         :ValueD7_5 = DATA;
283300151101                 NumericValue = %editc(ValueD7_5:'K');
283400151101
283500190527               When scale = 6;
283600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
283700151101                         :ValueD7_6 = DATA;
283800151101                 NumericValue = %editc(ValueD7_6:'K');
283900151101
284000190527               When scale = 7;
284100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
284200151101                         :ValueD7_7 = DATA;
284300151101                 NumericValue = %editc(ValueD7_7:'K');
284400190527               Endsl;
284500151101
284600180128           // 8
284700190527             When precision = 8;
284800190527               Select;
284900190527               When scale = 0;
285000180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
285100180128                         :ValueD8_0 = DATA;
285200180128                 NumericValue = %editc(ValueD8_0:'K');
285300180128
285400190527               When scale = 1;
285500180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
285600180128                         :ValueD8_1 = DATA;
285700180128                 NumericValue = %editc(ValueD8_1:'K');
285800180128
285900190527               When scale = 2;
286000180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
286100180128                         :ValueD8_2 = DATA;
286200180128                 NumericValue = %editc(ValueD8_2:'K');
286300180128
286400190527               When scale = 3;
286500180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
286600180128                         :ValueD8_3 = DATA;
286700180128                 NumericValue = %editc(ValueD8_3:'K');
286800180128
286900190527               When scale = 4;
287000180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
287100180128                         :ValueD8_4 = DATA;
287200180128                 NumericValue = %editc(ValueD8_4:'K');
287300180128
287400190527               When scale = 5;
287500180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
287600180128                         :ValueD8_5 = DATA;
287700180128                 NumericValue = %editc(ValueD8_5:'K');
287800180128
287900190527               When scale = 6;
288000180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
288100180128                         :ValueD8_6 = DATA;
288200180128                 NumericValue = %editc(ValueD8_6:'K');
288300180128
288400190527               When scale = 7;
288500180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
288600180128                         :ValueD8_7 = DATA;
288700180128                 NumericValue = %editc(ValueD8_7:'K');
288800180128
288900190527               When scale = 8;
289000180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
289100180128                         :ValueD8_8 = DATA;
289200180128                 NumericValue = %editc(ValueD8_8:'K');
289300190527               Endsl;
289400180128
289500180127           // 9
289600190527             When precision = 9;
289700190527               Select;
289800190527               When scale = 0;
289900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
290000151101                         :ValueD9_0 = DATA;
290100151101                 NumericValue = %editc(ValueD9_0:'K');
290200151031
290300190527               When scale = 1;
290400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
290500151101                         :ValueD9_1 = DATA;
290600151101                 NumericValue = %editc(ValueD9_1:'K');
290700151101
290800190527               When scale = 2;
290900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
291000151101                         :ValueD9_2 = DATA;
291100151101                 NumericValue = %editc(ValueD9_2:'K');
291200151101
291300190527               When scale = 3;
291400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
291500151101                         :ValueD9_3 = DATA;
291600151101                 NumericValue = %editc(ValueD9_3:'K');
291700151101
291800190527               When scale = 4;
291900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
292000151101                         :ValueD9_4 = DATA;
292100151101                 NumericValue = %editc(ValueD9_4:'K');
292200151101
292300190527               When scale = 5;
292400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
292500151101                         :ValueD9_5 = DATA;
292600151101                 NumericValue = %editc(ValueD9_5:'K');
292700151101
292800190527               When scale = 6;
292900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
293000151101                         :ValueD9_6 = DATA;
293100151101                 NumericValue = %editc(ValueD9_6:'K');
293200151101
293300190527               When scale = 7;
293400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
293500151101                         :ValueD9_7 = DATA;
293600151101                 NumericValue = %editc(ValueD9_7:'K');
293700151101
293800190527               When scale = 8;
293900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
294000151101                         :ValueD9_8 = DATA;
294100151101                 NumericValue = %editc(ValueD9_8:'K');
294200151101
294300190527               When scale = 9;
294400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
294500151101                         :ValueD9_9 = DATA;
294600151101                 NumericValue = %editc(ValueD9_9:'K');
294700190527               Endsl;
294800151101
294900180128           // 10
295000190527             When precision = 10;
295100190527               Select;
295200190527               When scale = 0;
295300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
295400180128                         :ValueD10_0 = DATA;
295500180128                 NumericValue = %editc(ValueD10_0:'K');
295600180128
295700190527               When scale = 1;
295800180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
295900180128                         :ValueD10_1 = DATA;
296000180128                 NumericValue = %editc(ValueD10_1:'K');
296100180128
296200190527               When scale = 2;
296300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
296400180128                         :ValueD10_2 = DATA;
296500180128                 NumericValue = %editc(ValueD10_2:'K');
296600180128
296700190527               When scale = 3;
296800180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
296900180128                         :ValueD10_3 = DATA;
297000180128                 NumericValue = %editc(ValueD10_3:'K');
297100180128
297200190527               When scale = 4;
297300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
297400180128                         :ValueD10_4 = DATA;
297500180128                 NumericValue = %editc(ValueD10_4:'K');
297600180128
297700190527               When scale = 5;
297800180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
297900180128                         :ValueD10_5 = DATA;
298000180128                 NumericValue = %editc(ValueD10_5:'K');
298100180128
298200190527               When scale = 6;
298300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
298400180128                         :ValueD10_6 = DATA;
298500180128                 NumericValue = %editc(ValueD10_6:'K');
298600180128
298700190527               When scale = 7;
298800180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
298900180128                         :ValueD10_7 = DATA;
299000180128                 NumericValue = %editc(ValueD10_7:'K');
299100180128
299200190527               When scale = 8;
299300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
299400180128                         :ValueD10_8 = DATA;
299500180128                 NumericValue = %editc(ValueD10_8:'K');
299600180128
299700190527               When scale = 9;
299800180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
299900180128                         :ValueD10_9 = DATA;
300000180128                 NumericValue = %editc(ValueD10_9:'K');
300100180128
300200190527               When scale = 10;
300300180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
300400180128                         :ValueD10_10 = DATA;
300500180128                 NumericValue = %editc(ValueD10_10:'K');
300600190527               Endsl;
300700180128
300800180127           // 11
300900190527             When precision = 11;
301000190527               Select;
301100190527               When scale = 0;
301200151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
301300151101                         :ValueD11_0 = DATA;
301400151101                 NumericValue = %editc(ValueD11_0:'K');
301500151031
301600190527               When scale = 1;
301700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
301800151101                         :ValueD11_1 = DATA;
301900151101                 NumericValue = %editc(ValueD11_1:'K');
302000151101
302100190527               When scale = 2;
302200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
302300151101                         :ValueD11_2 = DATA;
302400151101                 NumericValue = %editc(ValueD11_2:'K');
302500151101
302600190527               When scale = 3;
302700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
302800151101                         :ValueD11_3 = DATA;
302900151101                 NumericValue = %editc(ValueD11_3:'K');
303000151101
303100190527               When scale = 4;
303200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
303300151101                         :ValueD11_4 = DATA;
303400151101                 NumericValue = %editc(ValueD11_4:'K');
303500151101
303600190527               When scale = 5;
303700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
303800151101                         :ValueD11_5 = DATA;
303900151101                 NumericValue = %editc(ValueD11_5:'K');
304000151101
304100190527               When scale = 6;
304200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
304300151101                         :ValueD11_6 = DATA;
304400151101                 NumericValue = %editc(ValueD11_6:'K');
304500151101
304600190527               When scale = 7;
304700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
304800151101                         :ValueD11_7 = DATA;
304900151101                 NumericValue = %editc(ValueD11_7:'K');
305000151101
305100190527               When scale = 8;
305200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
305300151101                         :ValueD11_8 = DATA;
305400151101                 NumericValue = %editc(ValueD11_8:'K');
305500151101
305600190527               When scale = 9;
305700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
305800151101                         :ValueD11_9 = DATA;
305900151101                 NumericValue = %editc(ValueD11_9:'K');
306000151101
306100190527               When scale = 10;
306200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
306300151101                         :ValueD11_10 = DATA;
306400151101                 NumericValue = %editc(ValueD11_10:'K');
306500151101
306600190527               When scale = 11;
306700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
306800151101                         :ValueD11_11 = DATA;
306900151101                 NumericValue = %editc(ValueD11_11:'K');
307000190527               Endsl;
307100151101
307200180128           // 12
307300190527             When precision = 12;
307400190527               Select;
307500190527               When scale = 0;
307600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
307700180128                         :ValueD12_0 = DATA;
307800180128                 NumericValue = %editc(ValueD12_0:'K');
307900180128
308000190527               When scale = 1;
308100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
308200180128                         :ValueD12_1 = DATA;
308300180128                 NumericValue = %editc(ValueD12_1:'K');
308400180128
308500190527               When scale = 2;
308600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
308700180128                         :ValueD12_2 = DATA;
308800180128                 NumericValue = %editc(ValueD12_2:'K');
308900180128
309000190527               When scale = 3;
309100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
309200180128                         :ValueD12_3 = DATA;
309300180128                 NumericValue = %editc(ValueD12_3:'K');
309400180128
309500190527               When scale = 4;
309600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
309700180128                         :ValueD12_4 = DATA;
309800180128                 NumericValue = %editc(ValueD12_4:'K');
309900180128
310000190527               When scale = 5;
310100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
310200180128                         :ValueD12_5 = DATA;
310300180128                 NumericValue = %editc(ValueD12_5:'K');
310400180128
310500190527               When scale = 6;
310600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
310700180128                         :ValueD12_6 = DATA;
310800180128                 NumericValue = %editc(ValueD12_6:'K');
310900180128
311000190527               When scale = 7;
311100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
311200180128                         :ValueD12_7 = DATA;
311300180128                 NumericValue = %editc(ValueD12_7:'K');
311400180128
311500190527               When scale = 8;
311600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
311700180128                         :ValueD12_8 = DATA;
311800180128                 NumericValue = %editc(ValueD12_8:'K');
311900180128
312000190527               When scale = 9;
312100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
312200180128                         :ValueD12_9 = DATA;
312300180128                 NumericValue = %editc(ValueD12_9:'K');
312400180128
312500190527               When scale = 10;
312600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
312700180128                         :ValueD12_10 = DATA;
312800180128                 NumericValue = %editc(ValueD12_10:'K');
312900180128
313000190527               When scale = 11;
313100180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
313200180128                         :ValueD12_11 = DATA;
313300180128                 NumericValue = %editc(ValueD12_11:'K');
313400180128
313500190527               When scale = 12;
313600180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
313700180128                         :ValueD12_12 = DATA;
313800180128                 NumericValue = %editc(ValueD12_12:'K');
313900190527               Endsl;
314000180128
314100180127           // 13
314200190527             When precision = 13;
314300190527               Select;
314400190527               When scale = 0;
314500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
314600151101                         :ValueD13_0 = DATA;
314700151101                 NumericValue = %editc(ValueD13_0:'K');
314800151031
314900190527               When scale = 1;
315000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
315100151101                         :ValueD13_1 = DATA;
315200151101                 NumericValue = %editc(ValueD13_1:'K');
315300151101
315400190527               When scale = 2;
315500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
315600151101                         :ValueD13_2 = DATA;
315700151101                 NumericValue = %editc(ValueD13_2:'K');
315800151101
315900190527               When scale = 3;
316000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
316100151101                         :ValueD13_3 = DATA;
316200151101                 NumericValue = %editc(ValueD13_3:'K');
316300151101
316400190527               When scale = 4;
316500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
316600151101                         :ValueD13_4 = DATA;
316700151101                 NumericValue = %editc(ValueD13_4:'K');
316800151101
316900190527               When scale = 5;
317000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
317100151101                         :ValueD13_5 = DATA;
317200151101                 NumericValue = %editc(ValueD13_5:'K');
317300151101
317400190527               When scale = 6;
317500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
317600151101                         :ValueD13_6 = DATA;
317700151101                 NumericValue = %editc(ValueD13_6:'K');
317800151101
317900190527               When scale = 7;
318000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
318100151101                         :ValueD13_7 = DATA;
318200151101                 NumericValue = %editc(ValueD13_7:'K');
318300151101
318400190527               When scale = 8;
318500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
318600151101                         :ValueD13_8 = DATA;
318700151101                 NumericValue = %editc(ValueD13_8:'K');
318800151101
318900190527               When scale = 9;
319000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
319100151101                         :ValueD13_9 = DATA;
319200151101                 NumericValue = %editc(ValueD13_9:'K');
319300151101
319400190527               When scale = 10;
319500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
319600151101                         :ValueD13_10 = DATA;
319700151101                 NumericValue = %editc(ValueD13_10:'K');
319800151101
319900190527               When scale = 11;
320000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
320100151101                         :ValueD13_11 = DATA;
320200151101                 NumericValue = %editc(ValueD13_11:'K');
320300151101
320400190527               When scale = 12;
320500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
320600151101                         :ValueD13_12 = DATA;
320700151101                 NumericValue = %editc(ValueD13_12:'K');
320800151101
320900190527               When scale = 13;
321000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
321100151101                         :ValueD13_13 = DATA;
321200151101                 NumericValue = %editc(ValueD13_13:'K');
321300190527               Endsl;
321400151101
321500180128           // 14
321600190527             When precision = 14;
321700190527               Select;
321800190527               When scale = 0;
321900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
322000180128                         :ValueD14_0 = DATA;
322100180128                 NumericValue = %editc(ValueD14_0:'K');
322200180128
322300190527               When scale = 1;
322400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
322500180128                         :ValueD14_1 = DATA;
322600180128                 NumericValue = %editc(ValueD14_1:'K');
322700180128
322800190527               When scale = 2;
322900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
323000180128                         :ValueD14_2 = DATA;
323100180128                 NumericValue = %editc(ValueD14_2:'K');
323200180128
323300190527               When scale = 3;
323400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
323500180128                         :ValueD14_3 = DATA;
323600180128                 NumericValue = %editc(ValueD14_3:'K');
323700180128
323800190527               When scale = 4;
323900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
324000180128                         :ValueD14_4 = DATA;
324100180128                 NumericValue = %editc(ValueD14_4:'K');
324200180128
324300190527               When scale = 5;
324400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
324500180128                         :ValueD14_5 = DATA;
324600180128                 NumericValue = %editc(ValueD14_5:'K');
324700180128
324800190527               When scale = 6;
324900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
325000180128                         :ValueD14_6 = DATA;
325100180128                 NumericValue = %editc(ValueD14_6:'K');
325200180128
325300190527               When scale = 7;
325400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
325500180128                         :ValueD14_7 = DATA;
325600180128                 NumericValue = %editc(ValueD14_7:'K');
325700180128
325800190527               When scale = 8;
325900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
326000180128                         :ValueD14_8 = DATA;
326100180128                 NumericValue = %editc(ValueD14_8:'K');
326200180128
326300190527               When scale = 9;
326400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
326500180128                         :ValueD14_9 = DATA;
326600180128                 NumericValue = %editc(ValueD14_9:'K');
326700180128
326800190527               When scale = 10;
326900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
327000180128                         :ValueD14_10 = DATA;
327100180128                 NumericValue = %editc(ValueD14_10:'K');
327200180128
327300190527               When scale = 11;
327400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
327500180128                         :ValueD14_11 = DATA;
327600180128                 NumericValue = %editc(ValueD14_11:'K');
327700180128
327800190527               When scale = 12;
327900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
328000180128                         :ValueD14_12 = DATA;
328100180128                 NumericValue = %editc(ValueD14_12:'K');
328200180128
328300190527               When scale = 13;
328400180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
328500180128                         :ValueD14_13 = DATA;
328600180128                 NumericValue = %editc(ValueD14_13:'K');
328700180128
328800190527               When scale = 14;
328900180128                 exec sql GET DESCRIPTOR 'Values' VALUE :x
329000180128                         :ValueD14_14 = DATA;
329100180128                 NumericValue = %editc(ValueD14_14:'K');
329200190527               Endsl;
329300180128
329400180127           // 15
329500190527             When precision = 15;
329600190527               Select;
329700190527               When scale = 0;
329800151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
329900151101                         :ValueD15_0 = DATA;
330000151101                 NumericValue = %editc(ValueD15_0:'K');
330100151101
330200190527               When scale = 1;
330300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
330400151101                         :ValueD15_1 = DATA;
330500151101                 NumericValue = %editc(ValueD15_1:'K');
330600151101
330700190527               When scale = 2;
330800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
330900151101                         :ValueD15_2 = DATA;
331000151101                 NumericValue = %editc(ValueD15_2:'K');
331100151101
331200190527               When scale = 3;
331300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
331400151101                         :ValueD15_3 = DATA;
331500151101                 NumericValue = %editc(ValueD15_3:'K');
331600151101
331700190527               When scale = 4;
331800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
331900151101                         :ValueD15_4 = DATA;
332000151101                 NumericValue = %editc(ValueD15_4:'K');
332100151101
332200190527               When scale = 5;
332300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
332400151101                         :ValueD15_5 = DATA;
332500151101                 NumericValue = %editc(ValueD15_5:'K');
332600151101
332700190527               When scale = 6;
332800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
332900151101                         :ValueD15_6 = DATA;
333000151101                 NumericValue = %editc(ValueD15_6:'K');
333100151101
333200190527               When scale = 7;
333300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
333400151101                         :ValueD15_7 = DATA;
333500151101                 NumericValue = %editc(ValueD15_7:'K');
333600151101
333700190527               When scale = 8;
333800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
333900151101                         :ValueD15_8 = DATA;
334000151101                 NumericValue = %editc(ValueD15_8:'K');
334100151101
334200190527               When scale = 9;
334300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
334400151101                         :ValueD15_9 = DATA;
334500151101                 NumericValue = %editc(ValueD15_9:'K');
334600151101
334700190527               When scale = 10;
334800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
334900151101                         :ValueD15_10 = DATA;
335000151101                 NumericValue = %editc(ValueD15_10:'K');
335100151101
335200190527               When scale = 11;
335300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
335400151101                         :ValueD15_11 = DATA;
335500151101                 NumericValue = %editc(ValueD15_11:'K');
335600151101
335700190527               When scale = 12;
335800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
335900151101                         :ValueD15_12 = DATA;
336000151101                 NumericValue = %editc(ValueD15_12:'K');
336100151101
336200190527               When scale = 13;
336300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
336400151101                         :ValueD15_13 = DATA;
336500151101                 NumericValue = %editc(ValueD15_13:'K');
336600151101
336700190527               When scale = 14;
336800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
336900151101                         :ValueD15_14 = DATA;
337000151101                 NumericValue = %editc(ValueD15_14:'K');
337100151101
337200190527               When scale = 15;
337300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
337400151101                         :ValueD15_15 = DATA;
337500151101                 NumericValue = %editc(ValueD15_15:'K');
337600190527               Endsl;
337700190527            // 17
337800190527             When Precision =17;
337900190527             Select;
338000190527               When scale = 0;
338100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
338200190527                         :ValueD17_0  = DATA;
338300190527                 NumericValue = %editc(ValueD17_0 :'K');
338400190527
338500190527               When scale = 1;
338600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
338700190527                         :ValueD17_1  = DATA;
338800190527                 NumericValue = %editc(ValueD17_1 :'K');
338900190527
339000190527               When scale = 2;
339100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
339200190527                         :ValueD17_2  = DATA;
339300190527                 NumericValue = %editc(ValueD17_2 :'K');
339400190527
339500190527               When scale = 3;
339600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
339700190527                         :ValueD17_3  = DATA;
339800190527                 NumericValue = %editc(ValueD17_3 :'K');
339900190527
340000190527               When scale = 4;
340100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
340200190527                         :ValueD17_4  = DATA;
340300190527                 NumericValue = %editc(ValueD17_4 :'K');
340400190527
340500190527               When scale = 5;
340600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
340700190527                         :ValueD17_5  = DATA;
340800190527                 NumericValue = %editc(ValueD17_5 :'K');
340900190527
341000190527               When scale = 6;
341100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
341200190527                         :ValueD17_6  = DATA;
341300190527                 NumericValue = %editc(ValueD17_6 :'K');
341400190527
341500190527               When scale = 7;
341600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
341700190527                         :ValueD17_7  = DATA;
341800190527                 NumericValue = %editc(ValueD17_7 :'K');
341900190527
342000190527               When scale = 8;
342100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
342200190527                         :ValueD17_8  = DATA;
342300190527                 NumericValue = %editc(ValueD17_8 :'K');
342400190527
342500190527               When scale = 9;
342600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
342700190527                         :ValueD17_9  = DATA;
342800190527                 NumericValue = %editc(ValueD17_9 :'K');
342900190527
343000190527               When scale = 10;
343100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
343200190527                         :ValueD17_10  = DATA;
343300190527                 NumericValue = %editc(ValueD17_10 :'K');
343400190527
343500190527               When scale = 11;
343600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
343700190527                         :ValueD17_11  = DATA;
343800190527                 NumericValue = %editc(ValueD17_11 :'K');
343900190527
344000190527               When scale = 12;
344100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
344200190527                         :ValueD17_12  = DATA;
344300190527                 NumericValue = %editc(ValueD17_12 :'K');
344400190527
344500190527               When scale = 13;
344600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
344700190527                         :ValueD17_13  = DATA;
344800190527                 NumericValue = %editc(ValueD17_13 :'K');
344900190527
345000190527               When scale = 14;
345100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
345200190527                         :ValueD17_14  = DATA;
345300190527                 NumericValue = %editc(ValueD17_14 :'K');
345400190527
345500190527               When scale = 15;
345600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
345700190527                         :ValueD17_15  = DATA;
345800190527                 NumericValue = %editc(ValueD17_15 :'K');
345900190527
346000190527               When scale = 16;
346100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
346200190527                         :ValueD17_16  = DATA;
346300190527                 NumericValue = %editc(ValueD17_16 :'K');
346400190527
346500190527               When scale = 17;
346600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
346700190527                         :ValueD17_17  = DATA;
346800190527                 NumericValue = %editc(ValueD17_17 :'K');
346900190527
347000190527               Endsl;
347100190527
347200190527           // 19
347300190527             When Precision =19;
347400190527             Select;
347500190527               When scale = 0;
347600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
347700190527                         :ValueD19_0  = DATA;
347800190527                 NumericValue = %editc(ValueD19_0 :'K');
347900190527
348000190527               When scale = 1;
348100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
348200190527                         :ValueD19_1  = DATA;
348300190527                 NumericValue = %editc(ValueD19_1 :'K');
348400190527
348500190527               When scale = 2;
348600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
348700190527                         :ValueD19_2  = DATA;
348800190527                 NumericValue = %editc(ValueD19_2 :'K');
348900190527
349000190527               When scale = 3;
349100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
349200190527                         :ValueD19_3  = DATA;
349300190527                 NumericValue = %editc(ValueD19_3 :'K');
349400190527
349500190527               When scale = 4;
349600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
349700190527                         :ValueD19_4  = DATA;
349800190527                 NumericValue = %editc(ValueD19_4 :'K');
349900190527
350000190527               When scale = 5;
350100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
350200190527                         :ValueD19_5  = DATA;
350300190527                 NumericValue = %editc(ValueD19_5 :'K');
350400190527
350500190527               When scale = 6;
350600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
350700190527                         :ValueD19_6  = DATA;
350800190527                 NumericValue = %editc(ValueD19_6 :'K');
350900190527
351000190527               When scale = 7;
351100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
351200190527                         :ValueD19_7  = DATA;
351300190527                 NumericValue = %editc(ValueD19_7 :'K');
351400190527
351500190527               When scale = 8;
351600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
351700190527                         :ValueD19_8  = DATA;
351800190527                 NumericValue = %editc(ValueD19_8 :'K');
351900190527
352000190527               When scale = 9;
352100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
352200190527                         :ValueD19_9  = DATA;
352300190527                 NumericValue = %editc(ValueD19_9 :'K');
352400190527
352500190527               When scale = 10;
352600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
352700190527                         :ValueD19_10  = DATA;
352800190527                 NumericValue = %editc(ValueD19_10 :'K');
352900190527
353000190527               When scale = 11;
353100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
353200190527                         :ValueD19_11  = DATA;
353300190527                 NumericValue = %editc(ValueD19_11 :'K');
353400190527
353500190527               When scale = 12;
353600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
353700190527                         :ValueD19_12  = DATA;
353800190527                 NumericValue = %editc(ValueD19_12 :'K');
353900190527
354000190527               When scale = 13;
354100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
354200190527                         :ValueD19_13  = DATA;
354300190527                 NumericValue = %editc(ValueD19_13 :'K');
354400190527
354500190527               When scale = 14;
354600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
354700190527                         :ValueD19_14  = DATA;
354800190527                 NumericValue = %editc(ValueD19_14 :'K');
354900190527
355000190527               When scale = 15;
355100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
355200190527                         :ValueD19_15  = DATA;
355300190527                 NumericValue = %editc(ValueD19_15 :'K');
355400190527
355500190527               When scale = 16;
355600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
355700190527                         :ValueD19_16  = DATA;
355800190527                 NumericValue = %editc(ValueD19_16 :'K');
355900190527
356000190527               When scale = 17;
356100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
356200190527                         :ValueD19_17  = DATA;
356300190527                 NumericValue = %editc(ValueD19_17 :'K');
356400190527
356500190527               When scale = 18;
356600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
356700190527                         :ValueD19_18  = DATA;
356800190527                 NumericValue = %editc(ValueD19_18 :'K');
356900190527
357000190527               When scale = 19;
357100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
357200190527                         :ValueD19_19  = DATA;
357300190527                 NumericValue = %editc(ValueD19_19 :'K');
357400190527
357500190527               Endsl;
357600190527
357700190527           // 21
357800190527             When Precision =21;
357900190527             Select;
358000190527               When scale = 0;
358100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
358200190527                         :ValueD21_0  = DATA;
358300190527                 NumericValue = %editc(ValueD21_0 :'K');
358400190527
358500190527               When scale = 1;
358600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
358700190527                         :ValueD21_1  = DATA;
358800190527                 NumericValue = %editc(ValueD21_1 :'K');
358900190527
359000190527               When scale = 2;
359100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
359200190527                         :ValueD21_2  = DATA;
359300190527                 NumericValue = %editc(ValueD21_2 :'K');
359400190527
359500190527               When scale = 3;
359600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
359700190527                         :ValueD21_3  = DATA;
359800190527                 NumericValue = %editc(ValueD21_3 :'K');
359900190527
360000190527               When scale = 4;
360100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
360200190527                         :ValueD21_4  = DATA;
360300190527                 NumericValue = %editc(ValueD21_4 :'K');
360400190527
360500190527               When scale = 5;
360600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
360700190527                         :ValueD21_5  = DATA;
360800190527                 NumericValue = %editc(ValueD21_5 :'K');
360900190527
361000190527               When scale = 6;
361100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
361200190527                         :ValueD21_6  = DATA;
361300190527                 NumericValue = %editc(ValueD21_6 :'K');
361400190527
361500190527               When scale = 7;
361600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
361700190527                         :ValueD21_7  = DATA;
361800190527                 NumericValue = %editc(ValueD21_7 :'K');
361900190527
362000190527               When scale = 8;
362100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
362200190527                         :ValueD21_8  = DATA;
362300190527                 NumericValue = %editc(ValueD21_8 :'K');
362400190527
362500190527               When scale = 9;
362600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
362700190527                         :ValueD21_9  = DATA;
362800190527                 NumericValue = %editc(ValueD21_9 :'K');
362900190527
363000190527               When scale = 10;
363100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
363200190527                         :ValueD21_10  = DATA;
363300190527                 NumericValue = %editc(ValueD21_10 :'K');
363400190527
363500190527               When scale = 11;
363600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
363700190527                         :ValueD21_11  = DATA;
363800190527                 NumericValue = %editc(ValueD21_11 :'K');
363900190527
364000190527               When scale = 12;
364100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
364200190527                         :ValueD21_12  = DATA;
364300190527                 NumericValue = %editc(ValueD21_12 :'K');
364400190527
364500190527               When scale = 13;
364600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
364700190527                         :ValueD21_13  = DATA;
364800190527                 NumericValue = %editc(ValueD21_13 :'K');
364900190527
365000190527               When scale = 14;
365100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
365200190527                         :ValueD21_14  = DATA;
365300190527                 NumericValue = %editc(ValueD21_14 :'K');
365400190527
365500190527               When scale = 15;
365600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
365700190527                         :ValueD21_15  = DATA;
365800190527                 NumericValue = %editc(ValueD21_15 :'K');
365900190527
366000190527               When scale = 16;
366100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
366200190527                         :ValueD21_16  = DATA;
366300190527                 NumericValue = %editc(ValueD21_16 :'K');
366400190527
366500190527               When scale = 17;
366600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
366700190527                         :ValueD21_17  = DATA;
366800190527                 NumericValue = %editc(ValueD21_17 :'K');
366900190527
367000190527               When scale = 18;
367100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
367200190527                         :ValueD21_18  = DATA;
367300190527                 NumericValue = %editc(ValueD21_18 :'K');
367400190527
367500190527               When scale = 19;
367600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
367700190527                         :ValueD21_19  = DATA;
367800190527                 NumericValue = %editc(ValueD21_19 :'K');
367900190527
368000190527               When scale = 20;
368100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
368200190527                         :ValueD21_20  = DATA;
368300190527                 NumericValue = %editc(ValueD21_20 :'K');
368400190527
368500190527               When scale = 21;
368600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
368700190527                         :ValueD21_21  = DATA;
368800190527                 NumericValue = %editc(ValueD21_21 :'K');
368900190527
369000190527               Endsl;
369100190527
369200190527           // 23
369300190527             When Precision =23;
369400190527             Select;
369500190527               When scale = 0;
369600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
369700190527                         :ValueD23_0  = DATA;
369800190527                 NumericValue = %editc(ValueD23_0 :'K');
369900190527
370000190527               When scale = 1;
370100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
370200190527                         :ValueD23_1  = DATA;
370300190527                 NumericValue = %editc(ValueD23_1 :'K');
370400190527
370500190527               When scale = 2;
370600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
370700190527                         :ValueD23_2  = DATA;
370800190527                 NumericValue = %editc(ValueD23_2 :'K');
370900190527
371000190527               When scale = 3;
371100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
371200190527                         :ValueD23_3  = DATA;
371300190527                 NumericValue = %editc(ValueD23_3 :'K');
371400190527
371500190527               When scale = 4;
371600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
371700190527                         :ValueD23_4  = DATA;
371800190527                 NumericValue = %editc(ValueD23_4 :'K');
371900190527
372000190527               When scale = 5;
372100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
372200190527                         :ValueD23_5  = DATA;
372300190527                 NumericValue = %editc(ValueD23_5 :'K');
372400190527
372500190527               When scale = 6;
372600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
372700190527                         :ValueD23_6  = DATA;
372800190527                 NumericValue = %editc(ValueD23_6 :'K');
372900190527
373000190527               When scale = 7;
373100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
373200190527                         :ValueD23_7  = DATA;
373300190527                 NumericValue = %editc(ValueD23_7 :'K');
373400190527
373500190527               When scale = 8;
373600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
373700190527                         :ValueD23_8  = DATA;
373800190527                 NumericValue = %editc(ValueD23_8 :'K');
373900190527
374000190527               When scale = 9;
374100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
374200190527                         :ValueD23_9  = DATA;
374300190527                 NumericValue = %editc(ValueD23_9 :'K');
374400190527
374500190527               When scale = 10;
374600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
374700190527                         :ValueD23_10  = DATA;
374800190527                 NumericValue = %editc(ValueD23_10 :'K');
374900190527
375000190527               When scale = 11;
375100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
375200190527                         :ValueD23_11  = DATA;
375300190527                 NumericValue = %editc(ValueD23_11 :'K');
375400190527
375500190527               When scale = 12;
375600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
375700190527                         :ValueD23_12  = DATA;
375800190527                 NumericValue = %editc(ValueD23_12 :'K');
375900190527
376000190527               When scale = 13;
376100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
376200190527                         :ValueD23_13  = DATA;
376300190527                 NumericValue = %editc(ValueD23_13 :'K');
376400190527
376500190527               When scale = 14;
376600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
376700190527                         :ValueD23_14  = DATA;
376800190527                 NumericValue = %editc(ValueD23_14 :'K');
376900190527
377000190527               When scale = 15;
377100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
377200190527                         :ValueD23_15  = DATA;
377300190527                 NumericValue = %editc(ValueD23_15 :'K');
377400190527
377500190527               When scale = 16;
377600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
377700190527                         :ValueD23_16  = DATA;
377800190527                 NumericValue = %editc(ValueD23_16 :'K');
377900190527
378000190527               When scale = 17;
378100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
378200190527                         :ValueD23_17  = DATA;
378300190527                 NumericValue = %editc(ValueD23_17 :'K');
378400190527
378500190527               When scale = 18;
378600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
378700190527                         :ValueD23_18  = DATA;
378800190527                 NumericValue = %editc(ValueD23_18 :'K');
378900190527
379000190527               When scale = 19;
379100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
379200190527                         :ValueD23_19  = DATA;
379300190527                 NumericValue = %editc(ValueD23_19 :'K');
379400190527
379500190527               When scale = 20;
379600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
379700190527                         :ValueD23_20  = DATA;
379800190527                 NumericValue = %editc(ValueD23_20 :'K');
379900190527
380000190527               When scale = 21;
380100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
380200190527                         :ValueD23_21  = DATA;
380300190527                 NumericValue = %editc(ValueD23_21 :'K');
380400190527
380500190527               When scale = 22;
380600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
380700190527                         :ValueD23_22  = DATA;
380800190527                 NumericValue = %editc(ValueD23_22 :'K');
380900190527
381000190527               When scale = 23;
381100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
381200190527                         :ValueD23_23  = DATA;
381300190527                 NumericValue = %editc(ValueD23_23 :'K');
381400190527
381500190527               Endsl;
381600190527
381700190527           // 25
381800190527             When Precision =25;
381900190527             Select;
382000190527               When scale = 0;
382100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
382200190527                         :ValueD25_0  = DATA;
382300190527                 NumericValue = %editc(ValueD25_0 :'K');
382400190527
382500190527               When scale = 1;
382600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
382700190527                         :ValueD25_1  = DATA;
382800190527                 NumericValue = %editc(ValueD25_1 :'K');
382900190527
383000190527               When scale = 2;
383100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
383200190527                         :ValueD25_2  = DATA;
383300190527                 NumericValue = %editc(ValueD25_2 :'K');
383400190527
383500190527               When scale = 3;
383600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
383700190527                         :ValueD25_3  = DATA;
383800190527                 NumericValue = %editc(ValueD25_3 :'K');
383900190527
384000190527               When scale = 4;
384100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
384200190527                         :ValueD25_4  = DATA;
384300190527                 NumericValue = %editc(ValueD25_4 :'K');
384400190527
384500190527               When scale = 5;
384600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
384700190527                         :ValueD25_5  = DATA;
384800190527                 NumericValue = %editc(ValueD25_5 :'K');
384900190527
385000190527               When scale = 6;
385100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
385200190527                         :ValueD25_6  = DATA;
385300190527                 NumericValue = %editc(ValueD25_6 :'K');
385400190527
385500190527               When scale = 7;
385600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
385700190527                         :ValueD25_7  = DATA;
385800190527                 NumericValue = %editc(ValueD25_7 :'K');
385900190527
386000190527               When scale = 8;
386100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
386200190527                         :ValueD25_8  = DATA;
386300190527                 NumericValue = %editc(ValueD25_8 :'K');
386400190527
386500190527               When scale = 9;
386600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
386700190527                         :ValueD25_9  = DATA;
386800190527                 NumericValue = %editc(ValueD25_9 :'K');
386900190527
387000190527               When scale = 10;
387100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
387200190527                         :ValueD25_10  = DATA;
387300190527                 NumericValue = %editc(ValueD25_10 :'K');
387400190527
387500190527               When scale = 11;
387600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
387700190527                         :ValueD25_11  = DATA;
387800190527                 NumericValue = %editc(ValueD25_11 :'K');
387900190527
388000190527               When scale = 12;
388100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
388200190527                         :ValueD25_12  = DATA;
388300190527                 NumericValue = %editc(ValueD25_12 :'K');
388400190527
388500190527               When scale = 13;
388600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
388700190527                         :ValueD25_13  = DATA;
388800190527                 NumericValue = %editc(ValueD25_13 :'K');
388900190527
389000190527               When scale = 14;
389100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
389200190527                         :ValueD25_14  = DATA;
389300190527                 NumericValue = %editc(ValueD25_14 :'K');
389400190527
389500190527               When scale = 15;
389600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
389700190527                         :ValueD25_15  = DATA;
389800190527                 NumericValue = %editc(ValueD25_15 :'K');
389900190527
390000190527               When scale = 16;
390100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
390200190527                         :ValueD25_16  = DATA;
390300190527                 NumericValue = %editc(ValueD25_16 :'K');
390400190527
390500190527               When scale = 17;
390600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
390700190527                         :ValueD25_17  = DATA;
390800190527                 NumericValue = %editc(ValueD25_17 :'K');
390900190527
391000190527               When scale = 18;
391100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
391200190527                         :ValueD25_18  = DATA;
391300190527                 NumericValue = %editc(ValueD25_18 :'K');
391400190527
391500190527               When scale = 19;
391600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
391700190527                         :ValueD25_19  = DATA;
391800190527                 NumericValue = %editc(ValueD25_19 :'K');
391900190527
392000190527               When scale = 20;
392100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
392200190527                         :ValueD25_20  = DATA;
392300190527                 NumericValue = %editc(ValueD25_20 :'K');
392400190527
392500190527               When scale = 21;
392600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
392700190527                         :ValueD25_21  = DATA;
392800190527                 NumericValue = %editc(ValueD25_21 :'K');
392900190527
393000190527               When scale = 22;
393100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
393200190527                         :ValueD25_22  = DATA;
393300190527                 NumericValue = %editc(ValueD25_22 :'K');
393400190527
393500190527               When scale = 23;
393600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
393700190527                         :ValueD25_23  = DATA;
393800190527                 NumericValue = %editc(ValueD25_23 :'K');
393900190527
394000190527               When scale = 24;
394100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
394200190527                         :ValueD25_24  = DATA;
394300190527                 NumericValue = %editc(ValueD25_24 :'K');
394400190527
394500190527               When scale = 25;
394600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
394700190527                         :ValueD25_25  = DATA;
394800190527                 NumericValue = %editc(ValueD25_25 :'K');
394900190527
395000190527               Endsl;
395100190527
395200190527           // 27
395300190527             When Precision =27;
395400190527             Select;
395500190527               When scale = 0;
395600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
395700190527                         :ValueD27_0  = DATA;
395800190527                 NumericValue = %editc(ValueD27_0 :'K');
395900190527
396000190527               When scale = 1;
396100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
396200190527                         :ValueD27_1  = DATA;
396300190527                 NumericValue = %editc(ValueD27_1 :'K');
396400190527
396500190527               When scale = 2;
396600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
396700190527                         :ValueD27_2  = DATA;
396800190527                 NumericValue = %editc(ValueD27_2 :'K');
396900190527
397000190527               When scale = 3;
397100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
397200190527                         :ValueD27_3  = DATA;
397300190527                 NumericValue = %editc(ValueD27_3 :'K');
397400190527
397500190527               When scale = 4;
397600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
397700190527                         :ValueD27_4  = DATA;
397800190527                 NumericValue = %editc(ValueD27_4 :'K');
397900190527
398000190527               When scale = 5;
398100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
398200190527                         :ValueD27_5  = DATA;
398300190527                 NumericValue = %editc(ValueD27_5 :'K');
398400190527
398500190527               When scale = 6;
398600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
398700190527                         :ValueD27_6  = DATA;
398800190527                 NumericValue = %editc(ValueD27_6 :'K');
398900190527
399000190527               When scale = 7;
399100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
399200190527                         :ValueD27_7  = DATA;
399300190527                 NumericValue = %editc(ValueD27_7 :'K');
399400190527
399500190527               When scale = 8;
399600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
399700190527                         :ValueD27_8  = DATA;
399800190527                 NumericValue = %editc(ValueD27_8 :'K');
399900190527
400000190527               When scale = 9;
400100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
400200190527                         :ValueD27_9  = DATA;
400300190527                 NumericValue = %editc(ValueD27_9 :'K');
400400190527
400500190527               When scale = 10;
400600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
400700190527                         :ValueD27_10  = DATA;
400800190527                 NumericValue = %editc(ValueD27_10 :'K');
400900190527
401000190527               When scale = 11;
401100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
401200190527                         :ValueD27_11  = DATA;
401300190527                 NumericValue = %editc(ValueD27_11 :'K');
401400190527
401500190527               When scale = 12;
401600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
401700190527                         :ValueD27_12  = DATA;
401800190527                 NumericValue = %editc(ValueD27_12 :'K');
401900190527
402000190527               When scale = 13;
402100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
402200190527                         :ValueD27_13  = DATA;
402300190527                 NumericValue = %editc(ValueD27_13 :'K');
402400190527
402500190527               When scale = 14;
402600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
402700190527                         :ValueD27_14  = DATA;
402800190527                 NumericValue = %editc(ValueD27_14 :'K');
402900190527
403000190527               When scale = 15;
403100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
403200190527                         :ValueD27_15  = DATA;
403300190527                 NumericValue = %editc(ValueD27_15 :'K');
403400190527
403500190527               When scale = 16;
403600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
403700190527                         :ValueD27_16  = DATA;
403800190527                 NumericValue = %editc(ValueD27_16 :'K');
403900190527
404000190527               When scale = 17;
404100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
404200190527                         :ValueD27_17  = DATA;
404300190527                 NumericValue = %editc(ValueD27_17 :'K');
404400190527
404500190527               When scale = 18;
404600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
404700190527                         :ValueD27_18  = DATA;
404800190527                 NumericValue = %editc(ValueD27_18 :'K');
404900190527
405000190527               When scale = 19;
405100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
405200190527                         :ValueD27_19  = DATA;
405300190527                 NumericValue = %editc(ValueD27_19 :'K');
405400190527
405500190527               When scale = 20;
405600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
405700190527                         :ValueD27_20  = DATA;
405800190527                 NumericValue = %editc(ValueD27_20 :'K');
405900190527
406000190527               When scale = 21;
406100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
406200190527                         :ValueD27_21  = DATA;
406300190527                 NumericValue = %editc(ValueD27_21 :'K');
406400190527
406500190527               When scale = 22;
406600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
406700190527                         :ValueD27_22  = DATA;
406800190527                 NumericValue = %editc(ValueD27_22 :'K');
406900190527
407000190527               When scale = 23;
407100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
407200190527                         :ValueD27_23  = DATA;
407300190527                 NumericValue = %editc(ValueD27_23 :'K');
407400190527
407500190527               When scale = 24;
407600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
407700190527                         :ValueD27_24  = DATA;
407800190527                 NumericValue = %editc(ValueD27_24 :'K');
407900190527
408000190527               When scale = 25;
408100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
408200190527                         :ValueD27_25  = DATA;
408300190527                 NumericValue = %editc(ValueD27_25 :'K');
408400190527
408500190527               When scale = 26;
408600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
408700190527                         :ValueD27_26  = DATA;
408800190527                 NumericValue = %editc(ValueD27_26 :'K');
408900190527
409000190527               When scale = 27;
409100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
409200190527                         :ValueD27_27  = DATA;
409300190527                 NumericValue = %editc(ValueD27_27 :'K');
409400190527
409500190527               Endsl;
409600190527
409700190527           // 29
409800190527             When Precision =29;
409900190527             Select;
410000190527               When scale = 0;
410100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
410200190527                         :ValueD29_0  = DATA;
410300190527                 NumericValue = %editc(ValueD29_0 :'K');
410400190527
410500190527               When scale = 1;
410600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
410700190527                         :ValueD29_1  = DATA;
410800190527                 NumericValue = %editc(ValueD29_1 :'K');
410900190527
411000190527               When scale = 2;
411100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
411200190527                         :ValueD29_2  = DATA;
411300190527                 NumericValue = %editc(ValueD29_2 :'K');
411400190527
411500190527               When scale = 3;
411600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
411700190527                         :ValueD29_3  = DATA;
411800190527                 NumericValue = %editc(ValueD29_3 :'K');
411900190527
412000190527               When scale = 4;
412100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
412200190527                         :ValueD29_4  = DATA;
412300190527                 NumericValue = %editc(ValueD29_4 :'K');
412400190527
412500190527               When scale = 5;
412600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
412700190527                         :ValueD29_5  = DATA;
412800190527                 NumericValue = %editc(ValueD29_5 :'K');
412900190527
413000190527               When scale = 6;
413100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
413200190527                         :ValueD29_6  = DATA;
413300190527                 NumericValue = %editc(ValueD29_6 :'K');
413400190527
413500190527               When scale = 7;
413600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
413700190527                         :ValueD29_7  = DATA;
413800190527                 NumericValue = %editc(ValueD29_7 :'K');
413900190527
414000190527               When scale = 8;
414100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
414200190527                         :ValueD29_8  = DATA;
414300190527                 NumericValue = %editc(ValueD29_8 :'K');
414400190527
414500190527               When scale = 9;
414600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
414700190527                         :ValueD29_9  = DATA;
414800190527                 NumericValue = %editc(ValueD29_9 :'K');
414900190527
415000190527               When scale = 10;
415100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
415200190527                         :ValueD29_10  = DATA;
415300190527                 NumericValue = %editc(ValueD29_10 :'K');
415400190527
415500190527               When scale = 11;
415600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
415700190527                         :ValueD29_11  = DATA;
415800190527                 NumericValue = %editc(ValueD29_11 :'K');
415900190527
416000190527               When scale = 12;
416100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
416200190527                         :ValueD29_12  = DATA;
416300190527                 NumericValue = %editc(ValueD29_12 :'K');
416400190527
416500190527               When scale = 13;
416600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
416700190527                         :ValueD29_13  = DATA;
416800190527                 NumericValue = %editc(ValueD29_13 :'K');
416900190527
417000190527               When scale = 14;
417100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
417200190527                         :ValueD29_14  = DATA;
417300190527                 NumericValue = %editc(ValueD29_14 :'K');
417400190527
417500190527               When scale = 15;
417600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
417700190527                         :ValueD29_15  = DATA;
417800190527                 NumericValue = %editc(ValueD29_15 :'K');
417900190527
418000190527               When scale = 16;
418100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
418200190527                         :ValueD29_16  = DATA;
418300190527                 NumericValue = %editc(ValueD29_16 :'K');
418400190527
418500190527               When scale = 17;
418600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
418700190527                         :ValueD29_17  = DATA;
418800190527                 NumericValue = %editc(ValueD29_17 :'K');
418900190527
419000190527               When scale = 18;
419100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
419200190527                         :ValueD29_18  = DATA;
419300190527                 NumericValue = %editc(ValueD29_18 :'K');
419400190527
419500190527               When scale = 19;
419600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
419700190527                         :ValueD29_19  = DATA;
419800190527                 NumericValue = %editc(ValueD29_19 :'K');
419900190527
420000190527               When scale = 20;
420100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
420200190527                         :ValueD29_20  = DATA;
420300190527                 NumericValue = %editc(ValueD29_20 :'K');
420400190527
420500190527               When scale = 21;
420600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
420700190527                         :ValueD29_21  = DATA;
420800190527                 NumericValue = %editc(ValueD29_21 :'K');
420900190527
421000190527               When scale = 22;
421100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
421200190527                         :ValueD29_22  = DATA;
421300190527                 NumericValue = %editc(ValueD29_22 :'K');
421400190527
421500190527               When scale = 23;
421600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
421700190527                         :ValueD29_23  = DATA;
421800190527                 NumericValue = %editc(ValueD29_23 :'K');
421900190527
422000190527               When scale = 24;
422100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
422200190527                         :ValueD29_24  = DATA;
422300190527                 NumericValue = %editc(ValueD29_24 :'K');
422400190527
422500190527               When scale = 25;
422600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
422700190527                         :ValueD29_25  = DATA;
422800190527                 NumericValue = %editc(ValueD29_25 :'K');
422900190527
423000190527               When scale = 26;
423100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
423200190527                         :ValueD29_26  = DATA;
423300190527                 NumericValue = %editc(ValueD29_26 :'K');
423400190527
423500190527               When scale = 27;
423600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
423700190527                         :ValueD29_27  = DATA;
423800190527                 NumericValue = %editc(ValueD29_27 :'K');
423900190527
424000190527               When scale = 28;
424100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
424200190527                         :ValueD29_28  = DATA;
424300190527                 NumericValue = %editc(ValueD29_28 :'K');
424400190527
424500190527               When scale = 29;
424600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
424700190527                         :ValueD29_29  = DATA;
424800190527                 NumericValue = %editc(ValueD29_29 :'K');
424900190527
425000190527               Endsl;
425100190527
425200190527           // 31
425300190527             When Precision =31;
425400190527             Select;
425500190527               When scale = 0;
425600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
425700190527                         :ValueD31_0  = DATA;
425800190527                 NumericValue = %editc(ValueD31_0 :'K');
425900190527
426000190527               When scale = 1;
426100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
426200190527                         :ValueD31_1  = DATA;
426300190527                 NumericValue = %editc(ValueD31_1 :'K');
426400190527
426500190527               When scale = 2;
426600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
426700190527                         :ValueD31_2  = DATA;
426800190527                 NumericValue = %editc(ValueD31_2 :'K');
426900190527
427000190527               When scale = 3;
427100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
427200190527                         :ValueD31_3  = DATA;
427300190527                 NumericValue = %editc(ValueD31_3 :'K');
427400190527
427500190527               When scale = 4;
427600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
427700190527                         :ValueD31_4  = DATA;
427800190527                 NumericValue = %editc(ValueD31_4 :'K');
427900190527
428000190527               When scale = 5;
428100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
428200190527                         :ValueD31_5  = DATA;
428300190527                 NumericValue = %editc(ValueD31_5 :'K');
428400190527
428500190527               When scale = 6;
428600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
428700190527                         :ValueD31_6  = DATA;
428800190527                 NumericValue = %editc(ValueD31_6 :'K');
428900190527
429000190527               When scale = 7;
429100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
429200190527                         :ValueD31_7  = DATA;
429300190527                 NumericValue = %editc(ValueD31_7 :'K');
429400190527
429500190527               When scale = 8;
429600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
429700190527                         :ValueD31_8  = DATA;
429800190527                 NumericValue = %editc(ValueD31_8 :'K');
429900190527
430000190527               When scale = 9;
430100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
430200190527                         :ValueD31_9  = DATA;
430300190527                 NumericValue = %editc(ValueD31_9 :'K');
430400190527
430500190527               When scale = 10;
430600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
430700190527                         :ValueD31_10  = DATA;
430800190527                 NumericValue = %editc(ValueD31_10 :'K');
430900190527
431000190527               When scale = 11;
431100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
431200190527                         :ValueD31_11  = DATA;
431300190527                 NumericValue = %editc(ValueD31_11 :'K');
431400190527
431500190527               When scale = 12;
431600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
431700190527                         :ValueD31_12  = DATA;
431800190527                 NumericValue = %editc(ValueD31_12 :'K');
431900190527
432000190527               When scale = 13;
432100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
432200190527                         :ValueD31_13  = DATA;
432300190527                 NumericValue = %editc(ValueD31_13 :'K');
432400190527
432500190527               When scale = 14;
432600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
432700190527                         :ValueD31_14  = DATA;
432800190527                 NumericValue = %editc(ValueD31_14 :'K');
432900190527
433000190527               When scale = 15;
433100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
433200190527                         :ValueD31_15  = DATA;
433300190527                 NumericValue = %editc(ValueD31_15 :'K');
433400190527
433500190527               When scale = 16;
433600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
433700190527                         :ValueD31_16  = DATA;
433800190527                 NumericValue = %editc(ValueD31_16 :'K');
433900190527
434000190527               When scale = 17;
434100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
434200190527                         :ValueD31_17  = DATA;
434300190527                 NumericValue = %editc(ValueD31_17 :'K');
434400190527
434500190527               When scale = 18;
434600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
434700190527                         :ValueD31_18  = DATA;
434800190527                 NumericValue = %editc(ValueD31_18 :'K');
434900190527
435000190527               When scale = 19;
435100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
435200190527                         :ValueD31_19  = DATA;
435300190527                 NumericValue = %editc(ValueD31_19 :'K');
435400190527
435500190527               When scale = 20;
435600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
435700190527                         :ValueD31_20  = DATA;
435800190527                 NumericValue = %editc(ValueD31_20 :'K');
435900190527
436000190527               When scale = 21;
436100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
436200190527                         :ValueD31_21  = DATA;
436300190527                 NumericValue = %editc(ValueD31_21 :'K');
436400190527
436500190527               When scale = 22;
436600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
436700190527                         :ValueD31_22  = DATA;
436800190527                 NumericValue = %editc(ValueD31_22 :'K');
436900190527
437000190527               When scale = 23;
437100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
437200190527                         :ValueD31_23  = DATA;
437300190527                 NumericValue = %editc(ValueD31_23 :'K');
437400190527
437500190527               When scale = 24;
437600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
437700190527                         :ValueD31_24  = DATA;
437800190527                 NumericValue = %editc(ValueD31_24 :'K');
437900190527
438000190527               When scale = 25;
438100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
438200190527                         :ValueD31_25  = DATA;
438300190527                 NumericValue = %editc(ValueD31_25 :'K');
438400190527
438500190527               When scale = 26;
438600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
438700190527                         :ValueD31_26  = DATA;
438800190527                 NumericValue = %editc(ValueD31_26 :'K');
438900190527
439000190527               When scale = 27;
439100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
439200190527                         :ValueD31_27  = DATA;
439300190527                 NumericValue = %editc(ValueD31_27 :'K');
439400190527
439500190527               When scale = 28;
439600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
439700190527                         :ValueD31_28  = DATA;
439800190527                 NumericValue = %editc(ValueD31_28 :'K');
439900190527
440000190527               When scale = 29;
440100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
440200190527                         :ValueD31_29  = DATA;
440300190527                 NumericValue = %editc(ValueD31_29 :'K');
440400190527
440500190527               When scale = 30;
440600190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
440700190527                         :ValueD31_30  = DATA;
440800190527                 NumericValue = %editc(ValueD31_30 :'K');
440900190527
441000190527               When scale = 31;
441100190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
441200190527                         :ValueD31_31  = DATA;
441300190527                 NumericValue = %editc(ValueD31_31 :'K');
441400190527             Endsl;
441500190527
441600190527             Other;
441700190527               NumericValue = 'Length=' + %char(Length) +
441800190527                 ' Precision=' + %char(Precision) +
441900190527                 ' Scale=' + %Char(Scale);
442000190527
442100190527             Endsl;
442200151031       ENDSR;
442300151031
442400151101
442500151101       //************************************************************************
442600151101       // Subroutine = $BigInt - Get big integer
442700151101       //************************************************************************
442800151101       Begsr $BigInt;
442900151101
443000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
443100151101                         :BigInt = DATA;
443200151101                 BigIntNumeric = BigInt;
443300151101                 NumericValue = %editc(BigIntNumeric:'K');
443400151101
443500151101       ENDSR;
443600151101
443700151101       //************************************************************************
443800151101       // Subroutine = $SmallInt - Get small integer
443900151101       //************************************************************************
444000151101       Begsr $SmallInt;
444100151101
444200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
444300151101                         :SmallInt = DATA;
444400151101                 BigIntNumeric = SmallInt;
444500151101                 NumericValue = %editc(BigIntNumeric:'K');
444600151101
444700151101       ENDSR;
444800190527
444900190527       //************************************************************************
445000190527       // Subroutine = $Float - Get floating decimal
445100190527       //************************************************************************
445200190527       Begsr $Float;
445300190527
445400190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
445500190527                         :Float = DATA;
445600190527                 NumericValue = %char(Float);
445700190527
445800190527       ENDSR;
445900190527
446000190527
446100190527       //************************************************************************
446200190527       // Subroutine = $DateTime - Get Date Time
446300190527       //************************************************************************
446400190527       Begsr $DateTime;
446500190527
446600190527               Select;
446700190527
446800190527               When Length = 8;
446900190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
447000190527                         :DateValue = DATA;
447100190527                 NumericValue = %char(DateValue);
447200190527
447300190527               When Length = 26;
447400190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
447500190527                         :TimeStampValue = DATA;
447600190527                 NumericValue = %char(%subdt(TimeStampValue:*M)) + '/' +
447700190527                                %char(%subdt(TimeStampValue:*D)) + '/' +
447800190527                                %char(%subdt(TimeStampValue:*Y)) + ' ' +
447900190527                                %char(%subdt(TimeStampValue:*H)) + ':' +
448000190527                                %char(%subdt(TimeStampValue:*MN)) + ':' +
448100190527                                %char(%subdt(TimeStampValue:*S));
448200190527
448300190527               Other;
448400190527                 NumericValue = 'Type=Date Length=' + %char(Length) +
448500190527                   ' Precision=' + %char(Precision) +
448600190527                   ' Scale=' + %Char(Scale);
448700190527
448800190527               Endsl;
448900190527
449000190527       ENDSR;
449100190527
449200170604       //************************************************************************
449300170604       // Subroutine = $LogSQL - Log the SQL statement
449400170604       //************************************************************************
449500170604       Begsr $LogSQL;
449600170604
449700170604            Clear SQLLOGR;
449800170604            SQState = SQLStatement;
449900170604            SQUSER = dsuser;
450000170604            If 1 = 2;
450100170604              write sqllogr;
450200170604            Endif;
450300170604
450400170604       ENDSR;
450500151101
450600151101       //************************************************************************
450700151101       // Subroutine = $Int - Get integer
450800151101       //************************************************************************
450900151101       Begsr $Int;
451000151101
451100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
451200151101                         :Int = DATA;
451300151101                 BigIntNumeric = Int;
451400151101                 NumericValue = %editc(BigIntNumeric:'K');
451500151101
451600151101       ENDSR;
451700151101
451800180128       //************************************************************************
451900180128       // Subroutine = $BuildIfsFile
452000180128       //************************************************************************
452100180128       Begsr $BuildIfsFile;
452200180128
452300180129         ifsFileName = '/www/zendsvr6/htdocs/JerryMouse/DBCache/' +
452400180128                       %trim(widbuser) + %trim(widbname) + '.html';
452500180128         widbFile = ifsFilename;
452600180128         FileDescr = open64(%trim(ifsFileName)
452700180128                     : O_Creat + O_Trunc + O_CodePage + O_WRonly
452800180128                     : M_RWX : CP_ISO8859_1);
452900180128
453000180128         If FileDescr = -1;
453100180128           Return;
453200180128         Endif;
453300180128
453400180129         RC = close(FileDescr);
453500180129         If RC = -1;
453600180129           Return;
453700180129         Endif;
453800180128
453900180129         FileDescr = open64(%trimr(ifsFileName)
454000180129                     : O_WROnly + O_TextData);
454100180128
454200180129         If FileDescr = -1;
454300180129           Return;
454400180129         Endif;
454500180128
454600180128       Endsr;
454700180128
454800180121       //************************************************************************
454900180121       // Subroutine = *INZSR - Check License
455000180121       //************************************************************************
455100180121       Begsr *INZSR;
455200180731
455300180731       exsr $BuildIfsFile;
455400180731
455500180121       ENDSR;
