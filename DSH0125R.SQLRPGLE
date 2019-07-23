000100190527      /copy qcpylesrc,stdhspec
000200171027       ctl-opt bnddir('QC2LE');
000300151025       //****************************************************************
000400151025       //                                                               *
000500171027       // Program ID...... DSH0125R                                     *
000600171027       // Program Desc.... Process dashboard header 32000+ bytes        *
000700151025       //                                                               *
000800171027       // Written By...... Bob Eacott                                   *
000900171027       // Date Written.... 10/25/17                                     *
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
002500151025       dcl-f dshhdrm usage(*input) keyed rename(dshhdrm:dshhdrmr);
002600151025       dcl-f htmlbdm usage(*input) keyed;
002700151025       dcl-f dshdtlm usage(*input) keyed rename(dshdtlm:dshdtlmr);
002800170522       dcl-f usefile usage(*input) keyed;
002900170522       dcl-f dshsecm usage(*input) keyed;
003000180929       dcl-f custmf  usage(*input) keyed;
003100180929       dcl-f codecat usage(*input) keyed;
003200170603       dcl-f sqllog  usage(*output);
003300170603
003400151025
003500151025       //--Entry Prototype
003600171027       dcl-pr DSH0125R  extpgm('DSH0125R');
003700151226         widbname char(128);
003800160614         widbuser char(10);
003900170520         widbparm char(200);
004000171027         widbFile char(500);
004100151025       end-pr;
004200171027       dcl-pi DSH0125R;
004300151226         widbname char(128);
004400160614         widbuser char(10);
004500170520         widbparm char(200);
004600171027         widbFile char(500);
004700151025       end-pi;
004800151106
004900170304       //--External Prototypes
005000151106
005100151108       dcl-pr DSH0120C  extpgm('DSH0120C');
005200151108         wichname char(20);
005300170524         widbuser char(10);
005400170524         widbparm char(200);
005500151106       end-pr;
005600151106
005700190514       // declare constant
005800190514       dcl-c ccQuote const('''');
005900190514
006000151025       // Declare fields
006100171027       dcl-s SubValue varchar(1000000) inz;
006200171027       dcl-s subValueP pointer INZ(%ADDR(subvalue));
006300171027       dcl-s SubWithHeading varchar(1000000) inz;
006400171027       dcl-s widbbody varchar(1000000) inz;
006500151101       dcl-s SQLStatement char(2000);
006600151025       dcl-s SQLResult packed(15:5);
006700151027       dcl-s SQLResultText char(25);
006800151027       dcl-s IndicatorColor char(50);
006900170423       dcl-s FieldColHeading char(50);
007000151030       dcl-s x int(5);
007100151030       dcl-s TotalColumns int(5);
007200151030       dcl-s ColumnType char(1) dim(200);
007300151031       dcl-s Type int(5) ;
007400151031       dcl-s Length int(5) ;
007500151031       dcl-s Result_Ind int(5) ;
007600151031       dcl-s Precision int(5) ;
007700151031       dcl-s Scale int(5) ;
007800190526       dcl-s NumericValue char(50);
007900151101       dcl-s BigInt int(20);
008000151101       dcl-s Int int(10);
008100151101       dcl-s SmallInt int(5);
008101190526       dcl-s Float Float(8);
008102190526       dcl-s BinDec BinDec(4:0);
008103190527       dcl-s DateValue Date;
008104190527       dcl-s TimeValue Time;
008105190527       dcl-s TimeStampValue Timestamp;
008106190527       dcl-s VarGraphic Vargraph(5000);
008200190527       dcl-s BigIntNumeric packed(20);
008300171027       dcl-s wwGroup char(10);
008400170522       dcl-s StarAll char(10) inz('*ALL');
008500171013       dcl-s tblCount zoned(2);
008600171016       dcl-s varChar1 varchar(32000);
008700171027       dcl-s ifsFileName char(100);
008800171027       dcl-s htmlFileName char(100);
008900171027       dcl-s FileDescr int(10);
009000171027       dcl-s RC int(10);
009100171027       dcl-s BufferLen int(10);
009200180929       dcl-s MaintAccess char(1);
009300171027
009400171027       //copybook with IFS functions and constants
009500171027      /copy *libl/QCPYLESRC,IFSIO_H
009600171027
009700170521       // Incomming Parms
009800170521     D IncommingParms  ds           200
009900170521     D   PMCust                1      7  0
010000170521     D   PMVendor              8     12  0
010100170521     D   PMStyle              13     26
010200170521     D   PMStyle10            27     36
010300170521     D   PMCorp               37     41  0
010400170521     D   PMCategory           42     51
010500170521     D   PMSls                52     54  0
010600170604     D   PMBuyer              55     59  0
010700170604     D   PMRegion             60     60
010800170604     D   PMFromDate           61     67  0
010900170604     D   PMToDate             68     74  0
011000171114     D   PMLane               75     77
011100171114     D   PMStatus             78     78
011200180406     D   PMV1                101    130
011300180406     D   PMV2                131    160
011400180406     D   PMV3                161    190
011500170521
011600151031       // Declare all variations of fields
011700190526     D  ValueA         ds         32000
011800151031     D   ValueA1               1      1
011900151031     D   ValueA2               1      2
012000151031     D   ValueA3               1      3
012100151031     D   ValueA4               1      4
012200151031     D   ValueA5               1      5
012300151031     D   ValueA6               1      6
012400151031     D   ValueA7               1      7
012500151031     D   ValueA8               1      8
012600151031     D   ValueA9               1      9
012700151031     D   ValueA10              1     10
012800151031     D   ValueA11              1     11
012900151031     D   ValueA12              1     12
013000151031     D   ValueA13              1     13
013100151031     D   ValueA14              1     14
013200151031     D   ValueA15              1     15
013300151031     D   ValueA16              1     16
013400151031     D   ValueA17              1     17
013500151031     D   ValueA18              1     18
013600151031     D   ValueA19              1     19
013700151031     D   ValueA20              1     20
013800151031     D   ValueA21              1     21
013900151031     D   ValueA22              1     22
014000151031     D   ValueA23              1     23
014100151031     D   ValueA24              1     24
014200151031     D   ValueA25              1     25
014300151031     D   ValueA26              1     26
014400151031     D   ValueA27              1     27
014500151031     D   ValueA28              1     28
014600151031     D   ValueA29              1     29
014700151031     D   ValueA30              1     30
014800151031     D   ValueA31              1     31
014900151031     D   ValueA32              1     32
015000151031     D   ValueA33              1     33
015100151031     D   ValueA34              1     34
015200151031     D   ValueA35              1     35
015300151031     D   ValueA36              1     36
015400151031     D   ValueA37              1     37
015500151031     D   ValueA38              1     38
015600151031     D   ValueA39              1     39
015700151031     D   ValueA40              1     40
015800151031     D   ValueA41              1     41
015900151031     D   ValueA42              1     42
016000151031     D   ValueA43              1     43
016100151031     D   ValueA44              1     44
016200151031     D   ValueA45              1     45
016300151031     D   ValueA46              1     46
016400151031     D   ValueA47              1     47
016500151031     D   ValueA48              1     48
016600151031     D   ValueA49              1     49
016700151031     D   ValueA50              1     50
016800151031     D   ValueA51              1     51
016900151031     D   ValueA52              1     52
017000151031     D   ValueA53              1     53
017100151031     D   ValueA54              1     54
017200151031     D   ValueA55              1     55
017300151031     D   ValueA56              1     56
017400151031     D   ValueA57              1     57
017500151031     D   ValueA58              1     58
017600151031     D   ValueA59              1     59
017700151031     D   ValueA60              1     60
017800151031     D   ValueA61              1     61
017900151031     D   ValueA62              1     62
018000151031     D   ValueA63              1     63
018100151031     D   ValueA64              1     64
018200151031     D   ValueA65              1     65
018300151031     D   ValueA66              1     66
018400151031     D   ValueA67              1     67
018500151031     D   ValueA68              1     68
018600151031     D   ValueA69              1     69
018700151031     D   ValueA70              1     70
018800151031     D   ValueA71              1     71
018900151031     D   ValueA72              1     72
019000151031     D   ValueA73              1     73
019100151031     D   ValueA74              1     74
019200151031     D   ValueA75              1     75
019300151031     D   ValueA76              1     76
019400151031     D   ValueA77              1     77
019500151031     D   ValueA78              1     78
019600151031     D   ValueA79              1     79
019700151031     D   ValueA80              1     80
019800151031     D   ValueA81              1     81
019900151031     D   ValueA82              1     82
020000151031     D   ValueA83              1     83
020100151031     D   ValueA84              1     84
020200151031     D   ValueA85              1     85
020300151031     D   ValueA86              1     86
020400151031     D   ValueA87              1     87
020500151031     D   ValueA88              1     88
020600151031     D   ValueA89              1     89
020700151031     D   ValueA90              1     90
020800151031     D   ValueA91              1     91
020900151031     D   ValueA92              1     92
021000151031     D   ValueA93              1     93
021100151031     D   ValueA94              1     94
021200151031     D   ValueA95              1     95
021300151031     D   ValueA96              1     96
021400151031     D   ValueA97              1     97
021500151031     D   ValueA98              1     98
021600151031     D   ValueA99              1     99
021700151031     D   ValueA100             1    100
021800151229     D   ValueA101             1    101
021900151229     D   ValueA102             1    102
022000151229     D   ValueA103             1    103
022100151229     D   ValueA104             1    104
022200151229     D   ValueA105             1    105
022300151229     D   ValueA106             1    106
022400151229     D   ValueA107             1    107
022500151229     D   ValueA108             1    108
022600151229     D   ValueA109             1    109
022700151229     D   ValueA110             1    110
022800151229     D   ValueA111             1    111
022900151229     D   ValueA112             1    112
023000151229     D   ValueA113             1    113
023100151229     D   ValueA114             1    114
023200151229     D   ValueA115             1    115
023300151229     D   ValueA116             1    116
023400151229     D   ValueA117             1    117
023500151229     D   ValueA118             1    118
023600151229     D   ValueA119             1    119
023700151229     D   ValueA120             1    120
023800151229     D   ValueA121             1    121
023900151229     D   ValueA122             1    122
024000151229     D   ValueA123             1    123
024100151229     D   ValueA124             1    124
024200151229     D   ValueA125             1    125
024300151229     D   ValueA126             1    126
024400151229     D   ValueA127             1    127
024500151229     D   ValueA128             1    128
024600151229     D   ValueA129             1    129
024700151229     D   ValueA130             1    130
024800151229     D   ValueA131             1    131
024900151229     D   ValueA132             1    132
025000151229     D   ValueA133             1    133
025100151229     D   ValueA134             1    134
025200151229     D   ValueA135             1    135
025300151229     D   ValueA136             1    136
025400151229     D   ValueA137             1    137
025500151229     D   ValueA138             1    138
025600151229     D   ValueA139             1    139
025700151229     D   ValueA140             1    140
025800151229     D   ValueA141             1    141
025900151229     D   ValueA142             1    142
026000151229     D   ValueA143             1    143
026100151229     D   ValueA144             1    144
026200151229     D   ValueA145             1    145
026300151229     D   ValueA146             1    146
026400151229     D   ValueA147             1    147
026500151229     D   ValueA148             1    148
026600151229     D   ValueA149             1    149
026700151229     D   ValueA150             1    150
026800151229     D   ValueA151             1    151
026900151229     D   ValueA152             1    152
027000151229     D   ValueA153             1    153
027100151229     D   ValueA154             1    154
027200151229     D   ValueA155             1    155
027300151229     D   ValueA156             1    156
027400151229     D   ValueA157             1    157
027500151229     D   ValueA158             1    158
027600151229     D   ValueA159             1    159
027700151229     D   ValueA160             1    160
027800151229     D   ValueA161             1    161
027900151229     D   ValueA162             1    162
028000151229     D   ValueA163             1    163
028100151229     D   ValueA164             1    164
028200151229     D   ValueA165             1    165
028300151229     D   ValueA166             1    166
028400151229     D   ValueA167             1    167
028500151229     D   ValueA168             1    168
028600151229     D   ValueA169             1    169
028700151229     D   ValueA170             1    170
028800151229     D   ValueA171             1    171
028900151229     D   ValueA172             1    172
029000151229     D   ValueA173             1    173
029100151229     D   ValueA174             1    174
029200151229     D   ValueA175             1    175
029300151229     D   ValueA176             1    176
029400151229     D   ValueA177             1    177
029500151229     D   ValueA178             1    178
029600151229     D   ValueA179             1    179
029700151229     D   ValueA180             1    180
029800151229     D   ValueA181             1    181
029900151229     D   ValueA182             1    182
030000151229     D   ValueA183             1    183
030100151229     D   ValueA184             1    184
030200151229     D   ValueA185             1    185
030300151229     D   ValueA186             1    186
030400151229     D   ValueA187             1    187
030500151229     D   ValueA188             1    188
030600151229     D   ValueA189             1    189
030700151229     D   ValueA190             1    190
030800151229     D   ValueA191             1    191
030900151229     D   ValueA192             1    192
031000151229     D   ValueA193             1    193
031100151229     D   ValueA194             1    194
031200151229     D   ValueA195             1    195
031300151229     D   ValueA196             1    196
031400151229     D   ValueA197             1    197
031500151229     D   ValueA198             1    198
031600151229     D   ValueA199             1    199
031700151229     D   ValueA200             1    200
031800190526     D   ValueA32000           1  32000
031900151031
032000190526     D  ValueN         DS            31
032100151101     D   ValueN1_0             1      1  0 inz(0)
032200151101     D   ValueN1_1             1      1  1 inz(.0)
032300151101     D   ValueN2_0             1      2  0 inz(0)
032400151101     D   ValueN2_1             1      2  1 inz(0)
032500151101     D   ValueN2_2             1      2  2 inz(.0)
032600151101     D   ValueN3_0             1      3  0 inz(0)
032700151101     D   ValueN3_1             1      3  1 inz(0)
032800151101     D   ValueN3_2             1      3  2 inz(0)
032900151101     D   ValueN3_3             1      3  3 inz(.0)
033000151101     D   ValueN4_0             1      4  0 inz(0)
033100151101     D   ValueN4_1             1      4  1 inz(0)
033200151101     D   ValueN4_2             1      4  2 inz(0)
033300151101     D   ValueN4_3             1      4  3 inz(0)
033400151101     D   ValueN4_4             1      4  4 inz(.0)
033500151101     D   ValueN5_0             1      5  0 inz(0)
033600151101     D   ValueN5_1             1      5  1 inz(0)
033700151101     D   ValueN5_2             1      5  2 inz(0)
033800151101     D   ValueN5_3             1      5  3 inz(0)
033900151101     D   ValueN5_4             1      5  4 inz(0)
034000151101     D   ValueN6_0             1      6  0 inz(0)
034100151101     D   ValueN6_1             1      6  1 inz(0)
034200151101     D   ValueN6_2             1      6  2 inz(0)
034300151101     D   ValueN6_3             1      6  3 inz(0)
034400151101     D   ValueN6_4             1      6  4 inz(0)
034500151101     D   ValueN7_0             1      7  0 inz(0)
034600151101     D   ValueN7_1             1      7  1 inz(0)
034700151101     D   ValueN7_2             1      7  2 inz(0)
034800151101     D   ValueN7_3             1      7  3 inz(0)
034900151101     D   ValueN7_4             1      7  4 inz(0)
035000151101     D   ValueN8_0             1      8  0 inz(0)
035100151101     D   ValueN8_1             1      8  1 inz(0)
035200151101     D   ValueN8_2             1      8  2 inz(0)
035300151101     D   ValueN8_3             1      8  3 inz(0)
035400151101     D   ValueN8_4             1      8  4 inz(0)
035500151101     D   ValueN9_0             1      9  0 inz(0)
035600151101     D   ValueN9_1             1      9  1 inz(0)
035700151101     D   ValueN9_2             1      9  2 inz(0)
035800151101     D   ValueN9_3             1      9  3 inz(0)
035900151101     D   ValueN9_4             1      9  4 inz(0)
036000151101     D   ValueN10_0            1     10  0 inz(0)
036100151101     D   ValueN10_1            1     10  1 inz(0)
036200151101     D   ValueN10_2            1     10  2 inz(0)
036300151101     D   ValueN10_3            1     10  3 inz(0)
036400151101     D   ValueN10_4            1     10  4 inz(0)
036500151101     D   ValueN11_0            1     11  0 inz(0)
036600151101     D   ValueN11_1            1     11  1 inz(0)
036700151101     D   ValueN11_2            1     11  2 inz(0)
036800151101     D   ValueN11_3            1     11  3 inz(0)
036900151101     D   ValueN11_4            1     11  4 inz(0)
037000151101     D   ValueN12_0            1     12  0 inz(0)
037100151101     D   ValueN12_1            1     12  1 inz(0)
037200151101     D   ValueN12_2            1     12  2 inz(0)
037300151101     D   ValueN12_3            1     12  3 inz(0)
037400151101     D   ValueN12_4            1     12  4 inz(0)
037500151101     D   ValueN13_0            1     13  0 inz(0)
037600151101     D   ValueN13_1            1     13  1 inz(0)
037700151101     D   ValueN13_2            1     13  2 inz(0)
037800151101     D   ValueN13_3            1     13  3 inz(0)
037900151101     D   ValueN13_4            1     13  4 inz(0)
038000151101     D   ValueN14_0            1     14  0 inz(0)
038100151101     D   ValueN14_1            1     14  1 inz(0)
038200151101     D   ValueN14_2            1     14  2 inz(0)
038300151101     D   ValueN14_3            1     14  3 inz(0)
038400151101     D   ValueN14_4            1     14  4 inz(0)
038500151101     D   ValueN15_0            1     15  0 inz(0)
038600151101     D   ValueN15_1            1     15  1 inz(0)
038700151101     D   ValueN15_2            1     15  2 inz(0)
038800151101     D   ValueN15_3            1     15  3 inz(0)
038900151101     D   ValueN15_4            1     15  4 inz(0)
038901190526     D   ValueN31_0            1     31  0 inz(0)
038902190526     D   ValueN31_1            1     31  1 inz(0)
038903190526     D   ValueN31_2            1     31  2 inz(0)
038904190526     D   ValueN31_3            1     31  3 inz(0)
038905190526     D   ValueN31_4            1     31  4 inz(0)
038906190526     D   ValueN31_5            1     31  5 inz(0)
038907190526     D   ValueN31_6            1     31  6 inz(0)
038908190526     D   ValueN31_7            1     31  7 inz(0)
038909190526     D   ValueN31_8            1     31  8 inz(0)
038910190526     D   ValueN31_9            1     31  9 inz(0)
038911190526     D   ValueN31_10           1     31 10 inz(0)
038912190526     D   ValueN31_11           1     31 11 inz(0)
038913190526     D   ValueN31_12           1     31 12 inz(0)
038914190526     D   ValueN31_13           1     31 13 inz(0)
038915190526     D   ValueN31_14           1     31 14 inz(0)
038916190526     D   ValueN31_15           1     31 15 inz(0)
038917190526     D   ValueN31_16           1     31 16 inz(0)
038918190526     D   ValueN31_17           1     31 17 inz(0)
038919190526     D   ValueN31_18           1     31 18 inz(0)
038920190526     D   ValueN31_19           1     31 19 inz(0)
038921190526     D   ValueN31_20           1     31 20 inz(0)
038922190526     D   ValueN31_21           1     31 21 inz(0)
038923190526     D   ValueN31_22           1     31 22 inz(0)
038924190526     D   ValueN31_23           1     31 23 inz(0)
038925190526     D   ValueN31_24           1     31 24 inz(0)
038926190526     D   ValueN31_25           1     31 25 inz(0)
038927190526     D   ValueN31_26           1     31 26 inz(0)
038928190526     D   ValueN31_27           1     31 27 inz(0)
038929190526     D   ValueN31_28           1     31 28 inz(0)
038930190526     D   ValueN31_29           1     31 29 inz(0)
038931190526     D   ValueN31_30           1     31 30 inz(0)
038932190526     D   ValueN31_31           1     31 31 inz(.0)
039000151031
039100170320     D PackedDS        DS
039200170320     D   ValueD1_0                    1P 0 inz(0)
039300170320     D   ValueD1_1                    1P 1 inz(.0)
039400170320     D   ValueD3_0                    3P 0 inz(0)
039500170320     D   ValueD3_1                    3P 1 inz(0)
039600170320     D   ValueD3_2                    3P 2 inz(0)
039700170320     D   ValueD3_3                    3P 3 inz(.0)
039800170320     D   ValueD5_0                    5P 0 inz(0)
039900170320     D   ValueD5_1                    5P 1 inz(0)
040000170320     D   ValueD5_2                    5P 2 inz(0)
040100170320     D   ValueD5_3                    5P 3 inz(0)
040200170320     D   ValueD5_4                    5P 4 inz(0)
040300170320     D   ValueD5_5                    5P 5 inz(.0)
040400170320     D   ValueD7_0                    7P 0 inz(0)
040500170320     D   ValueD7_1                    7P 1 inz(0)
040600170320     D   ValueD7_2                    7P 2 inz(0)
040700170320     D   ValueD7_3                    7P 3 inz(0)
040800170320     D   ValueD7_4                    7P 4 inz(0)
040900170320     D   ValueD7_5                    7P 5 inz(0)
041000170320     D   ValueD7_6                    7P 6 inz(0)
041100170320     D   ValueD7_7                    7P 7 inz(.0)
041200170320     D   ValueD9_0                    9P 0 inz(0)
041300170320     D   ValueD9_1                    9P 1 inz(0)
041400170320     D   ValueD9_2                    9P 2 inz(0)
041500170320     D   ValueD9_3                    9P 3 inz(0)
041600170320     D   ValueD9_4                    9P 4 inz(0)
041700170320     D   ValueD9_5                    9P 5 inz(0)
041800170320     D   ValueD9_6                    9P 6 inz(0)
041900170320     D   ValueD9_7                    9P 7 inz(0)
042000170320     D   ValueD9_8                    9P 8 inz(0)
042100170320     D   ValueD9_9                    9P 9 inz(.0)
042200170320     D   ValueD11_0                  11P 0 inz(0)
042300170320     D   ValueD11_1                  11P 1 inz(0)
042400170320     D   ValueD11_2                  11P 2 inz(0)
042500170320     D   ValueD11_3                  11P 3 inz(0)
042600170320     D   ValueD11_4                  11P 4 inz(0)
042700170320     D   ValueD11_5                  11P 5 inz(0)
042800170320     D   ValueD11_6                  11P 6 inz(0)
042900170320     D   ValueD11_7                  11P 7 inz(0)
043000170320     D   ValueD11_8                  11P 8 inz(0)
043100170320     D   ValueD11_9                  11P 9 inz(0)
043200170320     D   ValueD11_10                 11P10 inz(0)
043300170320     D   ValueD11_11                 11P11 inz(.0)
043400170320     D   ValueD13_0                  13P 0 inz(0)
043500170320     D   ValueD13_1                  13P 1 inz(0)
043600170320     D   ValueD13_2                  13P 2 inz(0)
043700170320     D   ValueD13_3                  13P 3 inz(0)
043800170320     D   ValueD13_4                  13P 4 inz(0)
043900170320     D   ValueD13_5                  13P 5 inz(0)
044000170320     D   ValueD13_6                  13P 6 inz(0)
044100170320     D   ValueD13_7                  13P 7 inz(0)
044200170320     D   ValueD13_8                  13P 8 inz(0)
044300170320     D   ValueD13_9                  13P 9 inz(0)
044400170320     D   ValueD13_10                 13P10 inz(0)
044500170320     D   ValueD13_11                 13P11 inz(0)
044600170320     D   ValueD13_12                 13P12 inz(0)
044700170320     D   ValueD13_13                 13P13 inz(.0)
044800170320     D   ValueD15_0                  15P 0 inz(0)
044900170320     D   ValueD15_1                  15P 1 inz(0)
045000170320     D   ValueD15_2                  15P 2 inz(0)
045100170320     D   ValueD15_3                  15P 3 inz(0)
045200170320     D   ValueD15_4                  15P 4 inz(0)
045300170320     D   ValueD15_5                  15P 5 inz(0)
045400170320     D   ValueD15_6                  15P 6 inz(0)
045500170320     D   ValueD15_7                  15P 7 inz(0)
045600170320     D   ValueD15_8                  15P 8 inz(0)
045700170320     D   ValueD15_9                  15P 9 inz(0)
045800170320     D   ValueD15_10                 15P10 inz(0)
045900170320     D   ValueD15_11                 15P11 inz(0)
046000170320     D   ValueD15_12                 15P12 inz(0)
046100170320     D   ValueD15_13                 15P13 inz(0)
046200170320     D   ValueD15_14                 15P14 inz(0)
046300170320     D   ValueD15_15                 15P15 inz(.0)
046301190527     D   ValueD17_0                  17P 0 inz(0)
046302190527     D   ValueD17_1                  17P 1 inz(0)
046303190527     D   ValueD17_2                  17P 2 inz(0)
046304190527     D   ValueD17_3                  17P 3 inz(0)
046305190527     D   ValueD17_4                  17P 4 inz(0)
046306190527     D   ValueD17_5                  17P 5 inz(0)
046307190527     D   ValueD17_6                  17P 6 inz(0)
046308190527     D   ValueD17_7                  17P 7 inz(0)
046309190527     D   ValueD17_8                  17P 8 inz(0)
046310190527     D   ValueD17_9                  17P 9 inz(0)
046311190527     D   ValueD17_10                 17P10 inz(0)
046312190527     D   ValueD17_11                 17P11 inz(0)
046313190527     D   ValueD17_12                 17P12 inz(0)
046314190527     D   ValueD17_13                 17P13 inz(0)
046315190527     D   ValueD17_14                 17P14 inz(0)
046316190527     D   ValueD17_15                 17P15 inz(0)
046317190527     D   ValueD17_16                 17P16 inz(0)
046318190527     D   ValueD17_17                 17P17 inz(.0)
046319190527     D   ValueD19_0                  19P 0 inz(0)
046320190527     D   ValueD19_1                  19P 1 inz(0)
046321190527     D   ValueD19_2                  19P 2 inz(0)
046322190527     D   ValueD19_3                  19P 3 inz(0)
046323190527     D   ValueD19_4                  19P 4 inz(0)
046324190527     D   ValueD19_5                  19P 5 inz(0)
046325190527     D   ValueD19_6                  19P 6 inz(0)
046326190527     D   ValueD19_7                  19P 7 inz(0)
046327190527     D   ValueD19_8                  19P 8 inz(0)
046328190527     D   ValueD19_9                  19P 9 inz(0)
046329190527     D   ValueD19_10                 19P10 inz(0)
046330190527     D   ValueD19_11                 19P11 inz(0)
046331190527     D   ValueD19_12                 19P12 inz(0)
046332190527     D   ValueD19_13                 19P13 inz(0)
046333190527     D   ValueD19_14                 19P14 inz(0)
046334190527     D   ValueD19_15                 19P15 inz(0)
046335190527     D   ValueD19_16                 19P16 inz(0)
046336190527     D   ValueD19_17                 19P17 inz(0)
046337190527     D   ValueD19_18                 19P18 inz(0)
046338190527     D   ValueD19_19                 19P19 inz(.0)
046339190527     D   ValueD21_0                  21P 0 inz(0)
046340190527     D   ValueD21_1                  21P 1 inz(0)
046341190527     D   ValueD21_2                  21P 2 inz(0)
046342190527     D   ValueD21_3                  21P 3 inz(0)
046343190527     D   ValueD21_4                  21P 4 inz(0)
046344190527     D   ValueD21_5                  21P 5 inz(0)
046345190527     D   ValueD21_6                  21P 6 inz(0)
046346190527     D   ValueD21_7                  21P 7 inz(0)
046347190527     D   ValueD21_8                  21P 8 inz(0)
046348190527     D   ValueD21_9                  21P 9 inz(0)
046349190527     D   ValueD21_10                 21P10 inz(0)
046350190527     D   ValueD21_11                 21P11 inz(0)
046351190527     D   ValueD21_12                 21P12 inz(0)
046352190527     D   ValueD21_13                 21P13 inz(0)
046353190527     D   ValueD21_14                 21P14 inz(0)
046354190527     D   ValueD21_15                 21P15 inz(0)
046355190527     D   ValueD21_16                 21P16 inz(0)
046356190527     D   ValueD21_17                 21P17 inz(0)
046357190527     D   ValueD21_18                 21P18 inz(0)
046358190527     D   ValueD21_19                 21P19 inz(0)
046359190527     D   ValueD21_20                 21P20 inz(0)
046360190527     D   ValueD21_21                 21P21 inz(.0)
046361190527     D   ValueD23_0                  23P 0 inz(0)
046362190527     D   ValueD23_1                  23P 1 inz(0)
046363190527     D   ValueD23_2                  23P 2 inz(0)
046364190527     D   ValueD23_3                  23P 3 inz(0)
046365190527     D   ValueD23_4                  23P 4 inz(0)
046366190527     D   ValueD23_5                  23P 5 inz(0)
046367190527     D   ValueD23_6                  23P 6 inz(0)
046368190527     D   ValueD23_7                  23P 7 inz(0)
046369190527     D   ValueD23_8                  23P 8 inz(0)
046370190527     D   ValueD23_9                  23P 9 inz(0)
046371190527     D   ValueD23_10                 23P10 inz(0)
046372190527     D   ValueD23_11                 23P11 inz(0)
046373190527     D   ValueD23_12                 23P12 inz(0)
046374190527     D   ValueD23_13                 23P13 inz(0)
046375190527     D   ValueD23_14                 23P14 inz(0)
046376190527     D   ValueD23_15                 23P15 inz(0)
046377190527     D   ValueD23_16                 23P16 inz(0)
046378190527     D   ValueD23_17                 23P17 inz(0)
046379190527     D   ValueD23_18                 23P18 inz(0)
046380190527     D   ValueD23_19                 23P19 inz(0)
046381190527     D   ValueD23_20                 23P20 inz(0)
046382190527     D   ValueD23_21                 23P21 inz(0)
046383190527     D   ValueD23_22                 23P22 inz(0)
046384190527     D   ValueD23_23                 23P23 inz(.0)
046385190527     D   ValueD25_0                  25P 0 inz(0)
046386190527     D   ValueD25_1                  25P 1 inz(0)
046387190527     D   ValueD25_2                  25P 2 inz(0)
046388190527     D   ValueD25_3                  25P 3 inz(0)
046389190527     D   ValueD25_4                  25P 4 inz(0)
046390190527     D   ValueD25_5                  25P 5 inz(0)
046391190527     D   ValueD25_6                  25P 6 inz(0)
046392190527     D   ValueD25_7                  25P 7 inz(0)
046393190527     D   ValueD25_8                  25P 8 inz(0)
046394190527     D   ValueD25_9                  25P 9 inz(0)
046395190527     D   ValueD25_10                 25P10 inz(0)
046396190527     D   ValueD25_11                 25P11 inz(0)
046397190527     D   ValueD25_12                 25P12 inz(0)
046398190527     D   ValueD25_13                 25P13 inz(0)
046399190527     D   ValueD25_14                 25P14 inz(0)
046400190527     D   ValueD25_15                 25P15 inz(0)
046401190527     D   ValueD25_16                 25P16 inz(0)
046402190527     D   ValueD25_17                 25P17 inz(0)
046403190527     D   ValueD25_18                 25P18 inz(0)
046404190527     D   ValueD25_19                 25P19 inz(0)
046405190527     D   ValueD25_20                 25P20 inz(0)
046406190527     D   ValueD25_21                 25P21 inz(0)
046407190527     D   ValueD25_22                 25P22 inz(0)
046408190527     D   ValueD25_23                 25P23 inz(0)
046409190527     D   ValueD25_24                 25P24 inz(0)
046410190527     D   ValueD25_25                 25P25 inz(.0)
046411190527     D   ValueD27_0                  27P 0 inz(0)
046412190527     D   ValueD27_1                  27P 1 inz(0)
046413190527     D   ValueD27_2                  27P 2 inz(0)
046414190527     D   ValueD27_3                  27P 3 inz(0)
046415190527     D   ValueD27_4                  27P 4 inz(0)
046416190527     D   ValueD27_5                  27P 5 inz(0)
046417190527     D   ValueD27_6                  27P 6 inz(0)
046418190527     D   ValueD27_7                  27P 7 inz(0)
046419190527     D   ValueD27_8                  27P 8 inz(0)
046420190527     D   ValueD27_9                  27P 9 inz(0)
046421190527     D   ValueD27_10                 27P10 inz(0)
046422190527     D   ValueD27_11                 27P11 inz(0)
046423190527     D   ValueD27_12                 27P12 inz(0)
046424190527     D   ValueD27_13                 27P13 inz(0)
046425190527     D   ValueD27_14                 27P14 inz(0)
046426190527     D   ValueD27_15                 27P15 inz(0)
046427190527     D   ValueD27_16                 27P16 inz(0)
046428190527     D   ValueD27_17                 27P17 inz(0)
046429190527     D   ValueD27_18                 27P18 inz(0)
046430190527     D   ValueD27_19                 27P19 inz(0)
046431190527     D   ValueD27_20                 27P20 inz(0)
046432190527     D   ValueD27_21                 27P21 inz(0)
046433190527     D   ValueD27_22                 27P22 inz(0)
046434190527     D   ValueD27_23                 27P23 inz(0)
046435190527     D   ValueD27_24                 27P24 inz(0)
046436190527     D   ValueD27_25                 27P25 inz(0)
046437190527     D   ValueD27_26                 27P26 inz(0)
046438190527     D   ValueD27_27                 27P27 inz(.0)
046439190527     D   ValueD29_0                  29P 0 inz(0)
046440190527     D   ValueD29_1                  29P 1 inz(0)
046441190527     D   ValueD29_2                  29P 2 inz(0)
046442190527     D   ValueD29_3                  29P 3 inz(0)
046443190527     D   ValueD29_4                  29P 4 inz(0)
046444190527     D   ValueD29_5                  29P 5 inz(0)
046445190527     D   ValueD29_6                  29P 6 inz(0)
046446190527     D   ValueD29_7                  29P 7 inz(0)
046447190527     D   ValueD29_8                  29P 8 inz(0)
046448190527     D   ValueD29_9                  29P 9 inz(0)
046449190527     D   ValueD29_10                 29P10 inz(0)
046450190527     D   ValueD29_11                 29P11 inz(0)
046451190527     D   ValueD29_12                 29P12 inz(0)
046452190527     D   ValueD29_13                 29P13 inz(0)
046453190527     D   ValueD29_14                 29P14 inz(0)
046454190527     D   ValueD29_15                 29P15 inz(0)
046455190527     D   ValueD29_16                 29P16 inz(0)
046456190527     D   ValueD29_17                 29P17 inz(0)
046457190527     D   ValueD29_18                 29P18 inz(0)
046458190527     D   ValueD29_19                 29P19 inz(0)
046459190527     D   ValueD29_20                 29P20 inz(0)
046460190527     D   ValueD29_21                 29P21 inz(0)
046461190527     D   ValueD29_22                 29P22 inz(0)
046462190527     D   ValueD29_23                 29P23 inz(0)
046463190527     D   ValueD29_24                 29P24 inz(0)
046464190527     D   ValueD29_25                 29P25 inz(0)
046465190527     D   ValueD29_26                 29P26 inz(0)
046466190527     D   ValueD29_27                 29P27 inz(0)
046467190527     D   ValueD29_28                 29P28 inz(0)
046468190527     D   ValueD29_29                 29P29 inz(.0)
046469190526     D   ValueD31_0                  31P 0 inz(0)
046470190526     D   ValueD31_1                  31P 1 inz(0)
046471190526     D   ValueD31_2                  31P 2 inz(0)
046472190526     D   ValueD31_3                  31P 3 inz(0)
046473190526     D   ValueD31_4                  31P 4 inz(0)
046474190526     D   ValueD31_5                  31P 5 inz(0)
046475190526     D   ValueD31_6                  31P 6 inz(0)
046476190526     D   ValueD31_7                  31P 7 inz(0)
046477190526     D   ValueD31_8                  31P 8 inz(0)
046478190526     D   ValueD31_9                  31P 9 inz(0)
046479190526     D   ValueD31_10                 31P10 inz(0)
046480190526     D   ValueD31_11                 31P11 inz(0)
046481190526     D   ValueD31_12                 31P12 inz(0)
046482190526     D   ValueD31_13                 31P13 inz(0)
046483190526     D   ValueD31_14                 31P14 inz(0)
046484190526     D   ValueD31_15                 31P15 inz(0)
046485190526     D   ValueD31_16                 31P16 inz(0)
046486190526     D   ValueD31_17                 31P17 inz(0)
046487190526     D   ValueD31_18                 31P18 inz(0)
046488190526     D   ValueD31_19                 31P19 inz(0)
046489190526     D   ValueD31_20                 31P20 inz(0)
046490190526     D   ValueD31_21                 31P21 inz(0)
046491190526     D   ValueD31_22                 31P22 inz(0)
046492190526     D   ValueD31_23                 31P23 inz(0)
046493190526     D   ValueD31_24                 31P24 inz(0)
046494190526     D   ValueD31_25                 31P25 inz(0)
046495190526     D   ValueD31_26                 31P26 inz(0)
046496190526     D   ValueD31_27                 31P27 inz(0)
046497190526     D   ValueD31_28                 31P28 inz(0)
046498190526     D   ValueD31_29                 31P29 inz(0)
046499190526     D   ValueD31_30                 31P30 inz(0)
046500190526     D   ValueD31_31                 31P31 inz(.0)
046501151031
046502151030
046600151025       // Program Body
046700170521       IncommingParms = widbparm;
046800171027
046900170522       // Get dashboard heading
047000180603       If %subst(widbname:1:4) <> 'USER';
047100180603         dbname = widbname;
047200180603         Chain (dbname) dshhdrm;
047300180603       Else;
047400180603         Chain ('USER') dshhdrm;
047500180603         dbname = widbname;
047600180603       Endif;
047700180603
047800171027       exsr BuildIfsFile;
047900171027
048000170522       // Get user group
048100170522       Chain (widbuser) usefile;
048200170522       If %found;
048300171027         wwGroup = upgrpf;
048400170522       Else;
048500171027         wwGroup = *blanks;
048600170522       ENDIF;
048700170522
048800170522       // Check dashboard security
048900180603       If %subst(widbname:1:4) <> 'USER';
049000180603         Chain (dbname:StarAll) dshsecm;
049100180603         If not %found;
049200180603           Chain (dbname:wwGroup) dshsecm;
049300180603           If not %found;
049400180603             Chain (dbname:widbuser) dshsecm;
049500180603             If not %found;
049600180603                subValue = 'You do not have access to dashboard ' +
049700180603                            %trim(widbname);
049800180603                exsr $writeIfs;
049900180603                exsr $CloseIfs;
050000180603               *inlr = *on;
050100180603               Return;
050200180603             ENDIF;
050300180603           Endif;
050400180603         ENDIF;
050500180603       Endif;
050600180929
050700180929       // Check to see if user has access to maintain dashboards
050800180929       MaintAccess = 'N';
050900180929       cccatc = 'DSHMAINT';
051000180929       cccatk = widbuser;
051100180929       Chain (cccatc:cccatk) codecat;
051200180929       If %found;
051300180929         MaintAccess = 'Y';
051400180929       ENDIF;
051500180929       cccatk = wwgroup;
051600180929       Chain (cccatc:cccatk) codecat;
051700180929       If %found;
051800180929         MaintAccess = 'Y';
051900180929       ENDIF;
052000180929
052100180929
052200170529       // If a sales person is signed on, force PMSls to be the same as user profile.
052300180802rae    if wwgroup <> 'SALES4';
052400180802       //If (widbuser >= 'S000' and widbuser <= 'S438') or
052500180802       //   (widbuser >= 'S440' and widbuser <= 'S999');
052600180802       If (widbuser >= 'S000' and widbuser <= 'S050') or
052700180802          (widbuser >= 'S052' and widbuser <= 'S438') or
052800180802          (widbuser >= 'S440' and widbuser <= 'S442') or
052900180802          (widbuser >= 'S444' and widbuser <= 'S999');
053000170529          pmsls = %dec(%subst(widbuser:2:3):3:0);
053100170529
053200170529       // Check any parm that connects to a sales person to see if that parm is valid
053300170529       // for the currently signed on sales person.
053400170529          // Customer has to exist in the territory to see it.
053500170529          If pmcust <> 0;
053600170529            Chain (pmcust) custmf;
053700170529            If %found and pmsls <> sls;
053800171027              subValue = 'You do not have access to dashboard ' +
053900170529                 %trim(widbname) + ' Your Sales # ' + %char(pmsls) +
054000170529                 ' Customer # ' + %char(pmcust) +
054100170529                 ' Customer Sales # ' + %char(sls);
054200171027              exsr $writeIfs;
054300171027              exsr $CloseIfs;
054400170529             *inlr = *on;
054500170529             Return;
054600170529            ENDIF;
054700170529          ENDIF;
054800170529
054900170529       ENDIF;
055000171114rae    endif;
055100171114
055200151025       // Get dashboard layout HTML
055300151025
055400170520       hxbodyname = dblayout;
055500151025
055600151025       chain (hxbodyname) htmlbdm;
055700151025       If %found;
055800170521         If dbname = 'WHS001';
055900170529           widbbody = widbname + widbuser + incommingparms + %trim(hxbody) ;
056000170521         Else;
056100170521           widbbody = %trim(hxbody) ;
056200170521         Endif;
056300151025       Else;
056400180603         widbbody = %trim(hxbodyname) + ' not found';
056500180603       ENDIF;
056600151025
056700151025       // Get the dashboard details
056800180603       ddname = dbname;
056900151025       setll ddname dshdtlm;
057000151025       reade ddname dshdtlm;
057100171013       tblCount = 1;
057200151025       dow not %eof;
057300151101         If ddprepgm <> *blanks;
057400151101           // Run pre-process program
057500151101     c                   Call      ddprepgm
057600190501     c                   Parm                    widbuser
057700190503     c                   Parm                    pmv1
057800151101         ENDIF;
057900151025         Select;
058000151025         When ddconturl <> *blanks;
058100151025           SubValue = 'Fill in value from a URL';
058200151025
058300151025         When ddprogram <> *blanks;
058400151025           SubValue = 'Fill in value baased on a program';
058500151025
058600170520
058700151025         //- SQL single Value ------------------------------
058800151025
058900151025         When ddsql <> *blanks and ddsqltype = 'N';
059000151027           EXSR $SQLSingleValue;
059100151106
059200151025         //- SQL Table ------------------------------
059300151025
059400151025         When ddsql <> *blanks and ddsqltype = 'T';
059500151030           EXSR $SQLTable;
059600151106
059700151025         //- HTML Constant ------------------------------
059800151025
059900151025         When ddhtml <> *blanks;
060000151025           SubValue = ddhtml;
060100151106           //- Chart ------------------------------
060200151106           If ddchart <> *blanks;
060300170524             DSH0120C (ddchart : widbuser : widbparm );
060400151106           Endif;
060500151106
060600151025         Other;
060700151025          SubValue = 'Incomplete definition check Dashboard:' + ddname +
060800151025                      ' Sub Name:' + ddsub;
060900151025         ENDSL;
061000171027
061100170304         If ddheading <> ' ';
061200190514           SubWithHeading = '<h2>' + %trimr(ddheading);
061300190514           if ddsql <> *blanks and ddsqltype = 'T';
061400190514             SubWithHeading = %trimr(SubWithHeading) +
061500190514              '&nbsp;&nbsp;&nbsp;&nbsp;'  +
061600190514              '<button class="button" onclick="exportTableToCSV(' + ccquote +
061700190515              '#tblfile' + %char(tblCount) + ccQuote + ',' + ccQuote +
061800190515              %trim(ddheading) + '.csv' + ccQuote + ')">Download</button>';
061900190514           endif;
062000180929           If MaintAccess = 'Y' ;
062100170522             SubWithHeading = %Trim(SubWithHeading) +
062200170522             '  <a href="/dashboards/maintdbdetail.php?DB=' + %trim(ddname) +
062300170522             '&SUB=' + %trim(ddsub) + '">' +
062400170522             '<img src="/Images/maintenance.jpeg" alt="Maintain Detail"' +
062500170522             'style="width:20px;height:20px;border:0;"> </a>' ;
062600170522           ENDIF;
062700170522           SubWithHeading = %Trim(SubWithHeading) +
062800170522                 '</h2><br>' + %trimr(SubValue) ;
062900170304         Else;
063000170304           SubWithHeading = %trimr(SubValue);
063100171027         Endif;
063200171027
063300151118         widbbody = %scanrpl(%trimr(ddsub):
063400151118                %trimr(SubWithHeading):widbbody);
063500171027
063600151025         reade ddname dshdtlm;
063700171013         tblCount += 1;
063800151025       ENDDO;
063900151025
064000171027       subValue = widbBody;
064100171027       exsr $WriteIfs;
064200171027       exsr $CloseIfs;
064300171027
064400151025       *inlr = *on;
064500151027
064600171027       begsr $WriteIfs;
064700171027
064800171027         // Write the record to the ifs
064900171027         BufferLen = %len(%trimr(subvalue));
065000171030         RC = write(filedescr: subValueP + 4: BufferLen);
065100171027         clear subvalue;
065200171027
065300171027       endsr;
065400171027       begsr $CloseIfs;
065500171027
065600171027         RC = close(FileDescr);
065700171027
065800171027       endsr;
065900151027       //************************************************************************
066000151027       // Subroutine = $SQLSingleValue
066100151027       //************************************************************************
066200151027       Begsr $SQLSingleValue;
066300151027
066400151104           SQLResult = 0;
066500151027           SQLStatement = ddsql;
066600170520
066700170520         // Replace any variables in the sql statements
066800170520         SQLStatement = %scanrpl(':widbuser':
066900170520             %trimr(widbuser):SQLStatement);
067000170520         SQLStatement = %scanrpl(':widbparm':
067100170520             %trimr(widbparm):SQLStatement);
067200170524         SQLStatement = %scanrpl(':pmcust':
067300170524             %trimr(%char(pmcust)):SQLStatement);
067400170524         SQLStatement = %scanrpl(':pmvendor':
067500170524             %trimr(%char(pmvendor)):SQLStatement);
067600170524         SQLStatement = %scanrpl(':pmstyle':
067700170524             %trimr(pmstyle):SQLStatement);
067800170524         SQLStatement = %scanrpl(':pmstyle10':
067900170524             %trimr(pmstyle10):SQLStatement);
068000170524         SQLStatement = %scanrpl(':pmcorp':
068100170524             %trimr(%char(pmcorp)):SQLStatement);
068200170524         SQLStatement = %scanrpl(':pmcategory':
068300170524             %trimr(pmcategory):SQLStatement);
068400170524         SQLStatement = %scanrpl(':pmsls':
068500170524             %trimr(%char(pmsls)):SQLStatement);
068600170524         SQLStatement = %scanrpl(':pmbuyer':
068700170524             %trimr(%char(pmbuyer)):SQLStatement);
068800170524         SQLStatement = %scanrpl(':pmregion':
068900170524             %trimr(pmregion):SQLStatement);
069000170524         SQLStatement = %scanrpl(':pmfromdate':
069100170524             %trimr(%char(pmfromdate)):SQLStatement);
069200170524         SQLStatement = %scanrpl(':pmtodate':
069300170524             %trimr(%char(pmtodate)):SQLStatement);
069400171114         SQLStatement = %scanrpl(':pmlane':
069500171114             %trimr(pmlane):SQLStatement);
069600171114         SQLStatement = %scanrpl(':pmstatus':
069700171114             %trimr(pmstatus):SQLStatement);
069800180406         SQLStatement = %scanrpl(':pmv1':
069900180406             %trimr(pmv1):SQLStatement);
070000180406         SQLStatement = %scanrpl(':pmv2':
070100180406             %trimr(pmv2):SQLStatement);
070200180406         SQLStatement = %scanrpl(':pmv3':
070300180406             %trimr(pmv3):SQLStatement);
070400170520
070500180406         // Replace any %20 with a blank.
070600180406         SQLStatement = %scanrpl('%20':
070700180406             ' ':SQLStatement);
070800180406
070900170604        exsr $LogSQL;
071000151108        exec sql prepare handle from :SQLStatement;
071100151108        exec sql declare OpenHandle cursor for handle;
071200151108        exec sql Open OpenHandle;
071300151108        exec sql fetch next from OpenHandle into :SQLResult;
071400151108        exec sql Close OpenHandle;
071500151027           If %int(SQLResult) - SQLResult <> 0;
071600151027             SQLResultText = %char(SqlResult);
071700151027           Else;
071800151027             SQLResultText = %char(%int(SqlResult));
071900151027           Endif;
072000160101           // Default to no color
072100170304           IndicatorColor = '<table class="table-white">';
072200151027           // Set color based on indicator values
072300160101           If ddredvalue <> 0 or ddylwvalue <> 0 or ddgrnvalue <> 0;
072400160101             // Green
072500160101             If ddgrnsign = '=' and SQLResult = ddgrnvalue;
072600160101               IndicatorColor = '<table class="table-Green">';
072700160101             ENDIF;
072800160101             If ddgrnsign = '<' and SQLResult < ddgrnvalue;
072900160101               IndicatorColor = '<table class="table-Green">';
073000160101             ENDIF;
073100160101             If ddgrnsign = '>' and SQLResult > ddgrnvalue;
073200160101               IndicatorColor = '<table class="table-Green">';
073300160101             ENDIF;
073400160101             If ddgrnsign = '<=' and SQLResult <= ddgrnvalue;
073500160101               IndicatorColor = '<table class="table-Green">';
073600160101             ENDIF;
073700160101             If ddgrnsign = '>=' and SQLResult >= ddgrnvalue;
073800160101               IndicatorColor = '<table class="table-Green">';
073900160101             ENDIF;
074000160101             If ddgrnsign = '<>' and SQLResult <> ddgrnvalue;
074100160101               IndicatorColor = '<table class="table-Green">';
074200160101             ENDIF;
074300151027             // Yellow
074400151027             If ddylwsign = '=' and SQLResult = ddylwvalue;
074500151027               IndicatorColor = '<table class="table-Yellow">';
074600151027             ENDIF;
074700151027             If ddylwsign = '>' and SQLResult > ddylwvalue;
074800151027               IndicatorColor = '<table class="table-Yellow">';
074900151027             ENDIF;
075000151027             If ddylwsign = '<' and SQLResult < ddylwvalue;
075100151027               IndicatorColor = '<table class="table-Yellow">';
075200151027             ENDIF;
075300160101             If ddylwsign = '<=' and SQLResult <= ddylwvalue;
075400160101               IndicatorColor = '<table class="table-Yellow">';
075500160101             ENDIF;
075600160101             If ddylwsign = '>=' and SQLResult >= ddylwvalue;
075700160101               IndicatorColor = '<table class="table-Yellow">';
075800160101             ENDIF;
075900160101             If ddylwsign = '<>' and SQLResult <> ddylwvalue;
076000160101               IndicatorColor = '<table class="table-Yellow">';
076100160101             ENDIF;
076200151027             // Red
076300151027             If ddredsign = '=' and SQLResult = ddredvalue;
076400151027               IndicatorColor = '<table class="table-Red">';
076500151027             ENDIF;
076600151027             If ddredsign = '>' and SQLResult > ddredvalue;
076700151027               IndicatorColor = '<table class="table-Red">';
076800151027             ENDIF;
076900151027             If ddredsign = '<' and SQLResult < ddredvalue;
077000151027               IndicatorColor = '<table class="table-Red">';
077100151027             ENDIF;
077200160101             If ddredsign = '<=' and SQLResult <= ddredvalue;
077300160101               IndicatorColor = '<table class="table-Red">';
077400160101             ENDIF;
077500160101             If ddredsign = '>=' and SQLResult >= ddredvalue;
077600160101               IndicatorColor = '<table class="table-Red">';
077700160101             ENDIF;
077800160101             If ddredsign = '<>' and SQLResult <> ddredvalue;
077900160101               IndicatorColor = '<table class="table-Red">';
078000160101             ENDIF;
078100151027           ENDIF;
078200151027           SubValue = '<center>' + %trim(IndicatorColor) +
078300151027                       '<tr><td><strong>'
078400151027                       + %trim(SQLResultText) +
078500151027                       '</strong></td></tr></table></center>';
078600151027
078700151027       ENDSR;
078800151027
078900151027
079000151027       //************************************************************************
079100151027       // Subroutine = $SQLTable
079200151027       //************************************************************************
079300151030       Begsr $SQLTable;
079400151030
079500151030
079600151030
079700151030           SQLStatement = ddsql;
079800170423           //SQLN = 100;
079900151030
080000170520        // Replace any variables in the sql statements
080100170520         SQLStatement = %scanrpl(':widbuser':
080200170520             %trimr(widbuser):SQLStatement);
080300170520         SQLStatement = %scanrpl(':widbparm':
080400170520             %trimr(widbparm):SQLStatement);
080500170524         SQLStatement = %scanrpl(':pmcust':
080600170524             %trimr(%char(pmcust)):SQLStatement);
080700170524         SQLStatement = %scanrpl(':pmvendor':
080800170524             %trimr(%char(pmvendor)):SQLStatement);
080900170524         SQLStatement = %scanrpl(':pmstyle':
081000170524             %trimr(pmstyle):SQLStatement);
081100170524         SQLStatement = %scanrpl(':pmstyle10':
081200170524             %trimr(pmstyle10):SQLStatement);
081300170524         SQLStatement = %scanrpl(':pmcorp':
081400170524             %trimr(%char(pmcorp)):SQLStatement);
081500170524         SQLStatement = %scanrpl(':pmcategory':
081600170524             %trimr(pmcategory):SQLStatement);
081700170524         SQLStatement = %scanrpl(':pmsls':
081800171129             %trimr(%editc(pmsls:'X')):SQLStatement);
081900170524         SQLStatement = %scanrpl(':pmbuyer':
082000170524             %trimr(%char(pmbuyer)):SQLStatement);
082100170524         SQLStatement = %scanrpl(':pmregion':
082200170524             %trimr(pmregion):SQLStatement);
082300170524         SQLStatement = %scanrpl(':pmfromdate':
082400170524             %trimr(%char(pmfromdate)):SQLStatement);
082500170524         SQLStatement = %scanrpl(':pmtodate':
082600170524             %trimr(%char(pmtodate)):SQLStatement);
082700171114         SQLStatement = %scanrpl(':pmlane':
082800171114             %trimr(pmlane):SQLStatement);
082900171114         SQLStatement = %scanrpl(':pmstatus':
083000171114             %trimr(pmstatus):SQLStatement);
083100180406         SQLStatement = %scanrpl(':pmv1':
083200180406             %trimr(pmv1):SQLStatement);
083300180406         SQLStatement = %scanrpl(':pmv2':
083400180406             %trimr(pmv2):SQLStatement);
083500180406         SQLStatement = %scanrpl(':pmv3':
083600180406             %trimr(pmv3):SQLStatement);
083700171114
083800170604       exsr $LogSQL;
083900151031       exec sql prepare handleT from :SQLStatement;
084000151031       exec sql declare OpenHandleT cursor for handleT;
084100151031       exec sql Open OpenHandleT;
084200170423       // Define max number of columns and allocate memory
084300151031       exec SQL ALLOCATE DESCRIPTOR 'Values' WITH MAX 200;
084400170423       // Fill the descriptor with data.
084500170423       exec SQL describe handleT using descriptor 'Values';
084600170423       // Find out how many columns exist.
084700170423       exec SQL GET DESCRIPTOR 'Values' :TotalColumns = COUNT;
084800170423       If SQLCOD = 0;
084900171016           if ddsortcol = 'Y';
085000190514              SubValue = '<table id="tblfile' + %char(tblCount) +
085100190514                '" class="table-sortable"><tr>';
085200171016           else;
085300190514              SubValue = '<table id="tblfile' + %char(tblCount) +
085400190514                '"  class="table-all-lines"><tr>';
085500171013           endif;
085600151030           for x = 1 to TotalColumns;
085700170503             // Formulate the heading
085800170423             exec SQL GET DESCRIPTOR 'Values' value :x
085900170423                   :FieldColHeading = DB2_COLUMN_NAME;
086000171013               SubValue = %trimr(SubValue) + '<th>' +
086100170423                   %trimr(FieldColHeading) + '</th>';
086200151030
086300151030           ENDFOR;
086400151031           SubValue = %trimr(SubValue) + '</tr>';
086500151031
086600151031
086700151031
086800151031           // Get the values and fill into table.
086900170423       //    sqldabc = 16+sqln*80;
087000151031       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
087100151031           Dow sqlcode = 0;
087200151031             SubValue = %trimr(SubValue) + '<tr>';
087300151031             for x = 1 to TotalColumns;
087400151031       exec sql GET DESCRIPTOR 'Values' VALUE :x
087500170423                        :type = TYPE,
087600170423                        :length = LENGTH,
087700170423                        :result_ind = INDICATOR,
087800170423                        :scale = SCALE,
087900170423                        :precision = PRECISION ;
088000151031               Select;
088100151031               When Type = 1;
088200151031                 Exsr $Alpha;
088300151101                 SubValue = %trimr(SubValue) +
088400151031                         '<td>' +
088500151229                         %trim(ValueA) +
088600151031                         '</td>';
088700151229     ******              %subst(ValueA:1:length) +
088800151031
088900190526               When Type = 2;
089000151031                 Exsr $Numeric;
089100151031
089200170828                 If ddnumpos = 'C';
089300170828                    SubValue = %trimr(SubValue) +
089400170828                         '<td align="Center">' +
089500170828                         %trim(NumericValue) +
089600190526                         '</td>';
089700170828                 Else;
089800170828                    SubValue = %trimr(SubValue) +
089900170828                         '<td align="Right">' +
090000170828                         %trim(NumericValue) +
090100190526                         '</td>';
090200170828                 EndIf;
090300151031
090400151031               When Type = 3 ;
090500170828                 Exsr $Decimal; // AKA Packed
090600170828
090700170828                 If ddnumpos = 'C';
090800170828                    SubValue = %trimr(SubValue) +
090900170828                         '<td align="Center">' +
091000170828                         %trim(NumericValue) +
091100190526                         '</td>';
091200170828                 Else;
091300170828                    SubValue = %trimr(SubValue) +
091400151101                         '<td align="Right">' +
091500151031                         %trim(NumericValue) +
091600190526                         '</td>';
091700170828                 Endif;
091800170828
091900171016               //varchar
092000171016               When Type = 12;
092100171016                 exec sql GET DESCRIPTOR 'Values' VALUE :x
092200171016                         :Varchar1 = DATA;
092300171016                 SubValue = %trimr(SubValue) +
092400171016                         '<td>' +
092500171016                         %trim(varchar1) +
092600171016                         '</td>';
092700171016
092701190527               //varGraphic
092702190527               When Type = -96;
092703190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
092704190527                         :VarGraphic = DATA;
092705190527                 SubValue = %trimr(SubValue) +
092706190527                         '<td>' +
092707190527                         %trim(%char(varGraphic)) +
092708190527                         '</td>';
092709190527
092800190526               When Type = 25;
092900151101                 Exsr $BigInt; // Big Integer
093000151101
093100170828                 If ddnumpos = 'C';
093200170828                    SubValue = %trimr(SubValue) +
093300170828                         '<td align="Center">' +
093400170828                         %trim(NumericValue) +
093500190526                         '</td>';
093600170828                 Else;
093700170828                    SubValue = %trimr(SubValue) +
093800170828                         '<td align="Right">' +
093900170828                         %trim(NumericValue) +
094000190526                         '</td>';
094100170828                 Endif;
094200151101
094300190526               When Type = 5;
094400151101                 Exsr $SmallInt; // Small Integer
094500151101
094600170828                 If ddnumpos = 'C';
094700170828                    SubValue = %trimr(SubValue) +
094800170828                         '<td align="Center">' +
094900170828                         %trim(NumericValue) +
095000190526                         '</td>';
095100170828                 Else;
095200170828                    SubValue = %trimr(SubValue) +
095300170828                         '<td align="Right">' +
095400170828                         %trim(NumericValue) +
095500190526                         '</td>';
095600170828                 Endif;
095700170828
095701190526               When Type = 6 ;
095702190526                 Exsr $Float; // Float
095703190527
095704190527                 If ddnumpos = 'C';
095705190527                    SubValue = %trimr(SubValue) +
095706190527                         '<td align="Center">' +
095707190527                         %trim(NumericValue) +
095708190527                         '</td>';
095709190527                 Else;
095710190527                    SubValue = %trimr(SubValue) +
095711190527                         '<td align="Right">' +
095712190527                         %trim(NumericValue) +
095713190527                         '</td>';
095714190527                 Endif;
095715190526
095716190527               When Type = 9 ;
095717190527                 Exsr $DateTime; // Date Time
095718190527
095719190526                 If ddnumpos = 'C';
095720190526                    SubValue = %trimr(SubValue) +
095721190526                         '<td align="Center">' +
095722190526                         %trim(NumericValue) +
095723190526                         '</td>';
095724190526                 Else;
095725190526                    SubValue = %trimr(SubValue) +
095726190526                         '<td align="Right">' +
095727190526                         %trim(NumericValue) +
095728190526                         '</td>';
095729190526                 Endif;
095730190526
095800190526               When Type = 4;
095900151101                 Exsr $Int; // Integer
096000151101
096100170828                 If ddnumpos = 'C';
096200170828                    SubValue = %trimr(SubValue) +
096300170828                         '<td align="Center">' +
096400170828                         %trim(NumericValue) +
096500190526                         '</td>';
096600170828                 Else;
096700170828                    SubValue = %trimr(SubValue) +
096800170828                         '<td align="Right">' +
096900170828                         %trim(NumericValue) +
097000190526                         '</td>';
097100170828                 Endif;
097200170828
097300151031               Other;
097400151031                 SubValue = %trimr(SubValue) +
097500190526                         '<td>Undefined Type =' + %char(type) + '</td>' ;
097600151031               ENDSL;
098000151031
098100151031             Endfor;
098200151031             SubValue = %trimr(SubValue) + '</tr>';
098300151031       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
098400151031           ENDDO;
098500151229         Endif;
098600151031     c/exec sql
098700151031     c+     Close OpenHandleT
098800151031     c/end-exec
098900151031
099000151031
099100151030
099200151031           SubValue = %trimr(SubValue) + '</table>';
099300151030
099400151030       Endsr;
099500151031
099600151031       //************************************************************************
099700151031       // Subroutine = $Alpha - Get alpha descriptor
099800151031       //************************************************************************
099900151031       Begsr $Alpha;
100000151031
100100160405               clear ValueA;
100200151031               Select;
100300151031               When length = 1;
100400151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
100500151031                         :ValueA1 = DATA;
100600170503               When length = 2;
100700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
100800151031                         :ValueA2 = DATA;
100900151031
101000151031               When length = 3;
101100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
101200151031                         :ValueA3 = DATA;
101300151031
101400151031               When length = 4;
101500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
101600151031                         :ValueA4 = DATA;
101700151031
101800151031               When length = 5;
101900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
102000151031                         :ValueA5 = DATA;
102100151031
102200151031               When length = 6;
102300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
102400151031                         :ValueA6 = DATA;
102500151031
102600151031               When length = 7;
102700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
102800151031                         :ValueA7 = DATA;
102900151031
103000151031               When length = 8;
103100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
103200151031                         :ValueA8 = DATA;
103300151031
103400151031               When length = 9;
103500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
103600151031                         :ValueA9 = DATA;
103700151031
103800151031               When length = 10;
103900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
104000151031                         :ValueA10 = DATA;
104100151031
104200151031               When length = 11;
104300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
104400151031                         :ValueA11 = DATA;
104500151031
104600151031               When length = 12;
104700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
104800151031                         :ValueA12 = DATA;
104900151031
105000151031               When length = 13;
105100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
105200151031                         :ValueA13 = DATA;
105300151031
105400151031               When length = 14;
105500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
105600151031                         :ValueA14 = DATA;
105700151031
105800151031               When length = 15;
105900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
106000151031                         :ValueA15 = DATA;
106100151031
106200151031               When length = 16;
106300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
106400151031                         :ValueA16 = DATA;
106500151031
106600151031               When length = 17;
106700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
106800151031                         :ValueA17 = DATA;
106900151031
107000151031               When length = 18;
107100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
107200151031                         :ValueA18 = DATA;
107300151031
107400151031               When length = 19;
107500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
107600151031                         :ValueA19 = DATA;
107700151031
107800151031               When length = 20;
107900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
108000151031                         :ValueA20 = DATA;
108100151101
108200151101               When length = 21;
108300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
108400151101                         :ValueA21 = DATA;
108500151101
108600151101               When length = 22;
108700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
108800151101                         :ValueA22 = DATA;
108900151101
109000151101               When length = 23;
109100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
109200151101                         :ValueA23 = DATA;
109300151101
109400151101               When length = 24;
109500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
109600151101                         :ValueA24 = DATA;
109700151101
109800151101               When length = 25;
109900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
110000151101                         :ValueA25 = DATA;
110100151101
110200151101               When length = 26;
110300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
110400151101                         :ValueA26 = DATA;
110500151101
110600151101               When length = 27;
110700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
110800151101                         :ValueA27 = DATA;
110900151101
111000151101               When length = 28;
111100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
111200151101                         :ValueA28 = DATA;
111300151101
111400151101               When length = 29;
111500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
111600151101                         :ValueA29 = DATA;
111700151101
111800151101               When length = 30;
111900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
112000151101                         :ValueA30 = DATA;
112100151101
112200151101               When length = 31;
112300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
112400151101                         :ValueA31 = DATA;
112500151101
112600151101               When length = 32;
112700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
112800151101                         :ValueA32 = DATA;
112900151101
113000151101               When length = 33;
113100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
113200151101                         :ValueA33 = DATA;
113300151101
113400151101               When length = 34;
113500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
113600151101                         :ValueA34 = DATA;
113700151101
113800151101               When length = 35;
113900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
114000151101                         :ValueA35 = DATA;
114100151101
114200151101               When length = 36;
114300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
114400151101                         :ValueA36 = DATA;
114500151101
114600151101               When length = 37;
114700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
114800151101                         :ValueA37 = DATA;
114900151101
115000151101               When length = 38;
115100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
115200151101                         :ValueA38 = DATA;
115300151101
115400151101               When length = 39;
115500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
115600151101                         :ValueA39 = DATA;
115700151101
115800151101               When length = 40;
115900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
116000151101                         :ValueA40 = DATA;
116100151101
116200151101               When length = 41;
116300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
116400151101                         :ValueA41 = DATA;
116500151101
116600151101               When length = 42;
116700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
116800151101                         :ValueA42 = DATA;
116900151101
117000151101               When length = 43;
117100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
117200151101                         :ValueA43 = DATA;
117300151101
117400151101               When length = 44;
117500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
117600151101                         :ValueA44 = DATA;
117700151101
117800151101               When length = 45;
117900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
118000151101                         :ValueA45 = DATA;
118100151101
118200151101               When length = 46;
118300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
118400151101                         :ValueA46 = DATA;
118500151101
118600151101               When length = 47;
118700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
118800151101                         :ValueA47 = DATA;
118900151101
119000151101               When length = 48;
119100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
119200151101                         :ValueA48 = DATA;
119300151101
119400151101               When length = 49;
119500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
119600151101                         :ValueA49 = DATA;
119700151101
119800151101               When length = 50;
119900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
120000151101                         :ValueA50 = DATA;
120100151101
120200151101               When length = 51;
120300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
120400151101                         :ValueA51 = DATA;
120500151101
120600151101               When length = 52;
120700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
120800151101                         :ValueA52 = DATA;
120900151101
121000151101               When length = 53;
121100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
121200151101                         :ValueA53 = DATA;
121300151101
121400151101               When length = 54;
121500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
121600151101                         :ValueA54 = DATA;
121700151101
121800151101               When length = 55;
121900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
122000151101                         :ValueA55 = DATA;
122100151101
122200151101               When length = 56;
122300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
122400151101                         :ValueA56 = DATA;
122500151101
122600151101               When length = 57;
122700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
122800151101                         :ValueA57 = DATA;
122900151101
123000151101               When length = 58;
123100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
123200151101                         :ValueA58 = DATA;
123300151101
123400151101               When length = 59;
123500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
123600151101                         :ValueA59 = DATA;
123700151101
123800151101               When length = 60;
123900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
124000151101                         :ValueA60 = DATA;
124100151101
124200151101               When length = 61;
124300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
124400151101                         :ValueA61 = DATA;
124500151101
124600151101               When length = 62;
124700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
124800151101                         :ValueA62 = DATA;
124900151101
125000151101               When length = 63;
125100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
125200151101                         :ValueA63 = DATA;
125300151101
125400151101               When length = 64;
125500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
125600151101                         :ValueA64 = DATA;
125700151101
125800151101               When length = 65;
125900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
126000151101                         :ValueA65 = DATA;
126100151101
126200151101               When length = 66;
126300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
126400151101                         :ValueA66 = DATA;
126500151101
126600151101               When length = 67;
126700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
126800151101                         :ValueA67 = DATA;
126900151101
127000151101               When length = 68;
127100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
127200151101                         :ValueA68 = DATA;
127300151101
127400151101               When length = 69;
127500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
127600151101                         :ValueA69 = DATA;
127700151101
127800151101               When length = 70;
127900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
128000151101                         :ValueA70 = DATA;
128100151101
128200151101               When length = 71;
128300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
128400151101                         :ValueA71 = DATA;
128500151101
128600151101               When length = 72;
128700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
128800151101                         :ValueA72 = DATA;
128900151101
129000151101               When length = 73;
129100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
129200151101                         :ValueA73 = DATA;
129300151101
129400151101               When length = 74;
129500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
129600151101                         :ValueA74 = DATA;
129700151101
129800151101               When length = 75;
129900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130000151101                         :ValueA75 = DATA;
130100151101
130200151101               When length = 76;
130300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130400151101                         :ValueA76 = DATA;
130500151101
130600151101               When length = 77;
130700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
130800151101                         :ValueA77 = DATA;
130900151101
131000151101               When length = 78;
131100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
131200151101                         :ValueA78 = DATA;
131300151101
131400151101               When length = 79;
131500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
131600151101                         :ValueA79 = DATA;
131700151101
131800151101               When length = 80;
131900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132000151101                         :ValueA80 = DATA;
132100151101
132200151101               When length = 81;
132300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132400151101                         :ValueA81 = DATA;
132500151101
132600151101               When length = 82;
132700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
132800151101                         :ValueA82 = DATA;
132900151101
133000151101               When length = 83;
133100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
133200151101                         :ValueA83 = DATA;
133300151101
133400151101               When length = 84;
133500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
133600151101                         :ValueA84 = DATA;
133700151101
133800151101               When length = 85;
133900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134000151101                         :ValueA85 = DATA;
134100151101
134200151101               When length = 86;
134300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134400151101                         :ValueA86 = DATA;
134500151101
134600151101               When length = 87;
134700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
134800151101                         :ValueA87 = DATA;
134900151101
135000151101               When length = 88;
135100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
135200151101                         :ValueA88 = DATA;
135300151101
135400151101               When length = 89;
135500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
135600151101                         :ValueA89 = DATA;
135700151101
135800151101               When length = 90;
135900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136000151101                         :ValueA90 = DATA;
136100151101
136200151101               When length = 91;
136300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136400151101                         :ValueA91 = DATA;
136500151101
136600151101               When length = 92;
136700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
136800151101                         :ValueA92 = DATA;
136900151101
137000151101               When length = 93;
137100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
137200151101                         :ValueA93 = DATA;
137300151101
137400151101               When length = 94;
137500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
137600151101                         :ValueA94 = DATA;
137700151101
137800151101               When length = 95;
137900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138000151101                         :ValueA95 = DATA;
138100151101
138200151101               When length = 96;
138300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138400151101                         :ValueA96 = DATA;
138500151101
138600151101               When length = 97;
138700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
138800151101                         :ValueA97 = DATA;
138900151101
139000151101               When length = 98;
139100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
139200151101                         :ValueA98 = DATA;
139300151101
139400151101               When length = 99;
139500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
139600151101                         :ValueA99 = DATA;
139700151101
139800151101               When length = 100;
139900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140000151101                         :ValueA100 = DATA;
140100151229
140200151229               When length = 101;
140300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140400151229                         :ValueA101 = DATA;
140500151229
140600151229               When length = 102;
140700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
140800151229                         :ValueA102 = DATA;
140900151229
141000151229               When length = 103;
141100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
141200151229                         :ValueA103 = DATA;
141300151229
141400151229               When length = 104;
141500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
141600151229                         :ValueA104 = DATA;
141700151229
141800151229               When length = 105;
141900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142000151229                         :ValueA105 = DATA;
142100151229
142200151229               When length = 106;
142300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142400151229                         :ValueA106 = DATA;
142500151229
142600151229               When length = 107;
142700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
142800151229                         :ValueA107 = DATA;
142900151229
143000151229               When length = 108;
143100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
143200151229                         :ValueA108 = DATA;
143300151229
143400151229               When length = 109;
143500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
143600151229                         :ValueA109 = DATA;
143700151229
143800151229               When length = 110;
143900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144000151229                         :ValueA110 = DATA;
144100151229
144200151229               When length = 111;
144300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144400151229                         :ValueA111 = DATA;
144500151229
144600151229               When length = 112;
144700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
144800151229                         :ValueA112 = DATA;
144900151229
145000151229               When length = 113;
145100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
145200151229                         :ValueA113 = DATA;
145300151229
145400151229               When length = 114;
145500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
145600151229                         :ValueA114 = DATA;
145700151229
145800151229               When length = 115;
145900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146000151229                         :ValueA115 = DATA;
146100151229
146200151229               When length = 116;
146300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146400151229                         :ValueA116 = DATA;
146500151229
146600151229               When length = 117;
146700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
146800151229                         :ValueA117 = DATA;
146900151229
147000151229               When length = 118;
147100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
147200151229                         :ValueA118 = DATA;
147300151229
147400151229               When length = 119;
147500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
147600151229                         :ValueA119 = DATA;
147700151229
147800151229               When length = 120;
147900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148000151229                         :ValueA120 = DATA;
148100151229
148200151229               When length = 121;
148300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148400151229                         :ValueA121 = DATA;
148500151229
148600151229               When length = 122;
148700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
148800151229                         :ValueA122 = DATA;
148900151229
149000151229               When length = 123;
149100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
149200151229                         :ValueA123 = DATA;
149300151229
149400151229               When length = 124;
149500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
149600151229                         :ValueA124 = DATA;
149700151229
149800151229               When length = 125;
149900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150000151229                         :ValueA125 = DATA;
150100151229
150200151229               When length = 126;
150300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150400151229                         :ValueA126 = DATA;
150500151229
150600151229               When length = 127;
150700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
150800151229                         :ValueA127 = DATA;
150900151229
151000151229               When length = 128;
151100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
151200151229                         :ValueA128 = DATA;
151300151229
151400151229               When length = 129;
151500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
151600151229                         :ValueA129 = DATA;
151700151229
151800151229               When length = 130;
151900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152000151229                         :ValueA130 = DATA;
152100151229
152200151229               When length = 131;
152300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152400151229                         :ValueA131 = DATA;
152500151229
152600151229               When length = 132;
152700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
152800151229                         :ValueA132 = DATA;
152900151229
153000151229               When length = 133;
153100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
153200151229                         :ValueA133 = DATA;
153300151229
153400151229               When length = 134;
153500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
153600151229                         :ValueA134 = DATA;
153700151229
153800151229               When length = 135;
153900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154000151229                         :ValueA135 = DATA;
154100151229
154200151229               When length = 136;
154300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154400151229                         :ValueA136 = DATA;
154500151229
154600151229               When length = 137;
154700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
154800151229                         :ValueA137 = DATA;
154900151229
155000151229               When length = 138;
155100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
155200151229                         :ValueA138 = DATA;
155300151229
155400151229               When length = 139;
155500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
155600151229                         :ValueA139 = DATA;
155700151229
155800151229               When length = 140;
155900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156000151229                         :ValueA140 = DATA;
156100151229
156200151229               When length = 141;
156300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156400151229                         :ValueA141 = DATA;
156500151229
156600151229               When length = 142;
156700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
156800151229                         :ValueA142 = DATA;
156900151229
157000151229               When length = 143;
157100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
157200151229                         :ValueA143 = DATA;
157300151229
157400151229               When length = 144;
157500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
157600151229                         :ValueA144 = DATA;
157700151229
157800151229               When length = 145;
157900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158000151229                         :ValueA145 = DATA;
158100151229
158200151229               When length = 146;
158300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158400151229                         :ValueA146 = DATA;
158500151229
158600151229               When length = 147;
158700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
158800151229                         :ValueA147 = DATA;
158900151229
159000151229               When length = 148;
159100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
159200151229                         :ValueA148 = DATA;
159300151229
159400151229               When length = 149;
159500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
159600151229                         :ValueA149 = DATA;
159700151229
159800151229               When length = 150;
159900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160000151229                         :ValueA150 = DATA;
160100151229
160200151229               When length = 151;
160300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160400151229                         :ValueA151 = DATA;
160500151229
160600151229               When length = 152;
160700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
160800151229                         :ValueA152 = DATA;
160900151229
161000151229               When length = 153;
161100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
161200151229                         :ValueA153 = DATA;
161300151229
161400151229               When length = 154;
161500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
161600151229                         :ValueA154 = DATA;
161700151229
161800151229               When length = 155;
161900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162000151229                         :ValueA155 = DATA;
162100151229
162200151229               When length = 156;
162300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162400151229                         :ValueA156 = DATA;
162500151229
162600151229               When length = 157;
162700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
162800151229                         :ValueA157 = DATA;
162900151229
163000151229               When length = 158;
163100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
163200151229                         :ValueA158 = DATA;
163300151229
163400151229               When length = 159;
163500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
163600151229                         :ValueA159 = DATA;
163700151229
163800151229               When length = 160;
163900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164000151229                         :ValueA160 = DATA;
164100151229
164200151229               When length = 161;
164300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164400151229                         :ValueA161 = DATA;
164500151229
164600151229               When length = 162;
164700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
164800151229                         :ValueA162 = DATA;
164900151229
165000151229               When length = 163;
165100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
165200151229                         :ValueA163 = DATA;
165300151229
165400151229               When length = 164;
165500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
165600151229                         :ValueA164 = DATA;
165700151229
165800151229               When length = 165;
165900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166000151229                         :ValueA165 = DATA;
166100151229
166200151229               When length = 166;
166300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166400151229                         :ValueA166 = DATA;
166500151229
166600151229               When length = 167;
166700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
166800151229                         :ValueA167 = DATA;
166900151229
167000151229               When length = 168;
167100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
167200151229                         :ValueA168 = DATA;
167300151229
167400151229               When length = 169;
167500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
167600151229                         :ValueA169 = DATA;
167700151229
167800151229               When length = 170;
167900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168000151229                         :ValueA170 = DATA;
168100151229
168200151229               When length = 171;
168300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168400151229                         :ValueA171 = DATA;
168500151229
168600151229               When length = 172;
168700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
168800151229                         :ValueA172 = DATA;
168900151229
169000151229               When length = 173;
169100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
169200151229                         :ValueA173 = DATA;
169300151229
169400151229               When length = 174;
169500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
169600151229                         :ValueA174 = DATA;
169700151229
169800151229               When length = 175;
169900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170000151229                         :ValueA175 = DATA;
170100151229
170200151229               When length = 176;
170300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170400151229                         :ValueA176 = DATA;
170500151229
170600151229               When length = 177;
170700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
170800151229                         :ValueA177 = DATA;
170900151229
171000151229               When length = 178;
171100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
171200151229                         :ValueA178 = DATA;
171300151229
171400151229               When length = 179;
171500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
171600151229                         :ValueA179 = DATA;
171700151229
171800151229               When length = 180;
171900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172000151229                         :ValueA180 = DATA;
172100151229
172200151229               When length = 181;
172300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172400151229                         :ValueA181 = DATA;
172500151229
172600151229               When length = 182;
172700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
172800151229                         :ValueA182 = DATA;
172900151229
173000151229               When length = 183;
173100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
173200151229                         :ValueA183 = DATA;
173300151229
173400151229               When length = 184;
173500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
173600151229                         :ValueA184 = DATA;
173700151229
173800151229               When length = 185;
173900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174000151229                         :ValueA185 = DATA;
174100151229
174200151229               When length = 186;
174300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174400151229                         :ValueA186 = DATA;
174500151229
174600151229               When length = 187;
174700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
174800151229                         :ValueA187 = DATA;
174900151229
175000151229               When length = 188;
175100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
175200151229                         :ValueA188 = DATA;
175300151229
175400151229               When length = 189;
175500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
175600151229                         :ValueA189 = DATA;
175700151229
175800151229               When length = 190;
175900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176000151229                         :ValueA190 = DATA;
176100151229
176200151229               When length = 191;
176300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176400151229                         :ValueA191 = DATA;
176500151229
176600151229               When length = 192;
176700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
176800151229                         :ValueA192 = DATA;
176900151229
177000151229               When length = 193;
177100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
177200151229                         :ValueA193 = DATA;
177300151229
177400151229               When length = 194;
177500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
177600151229                         :ValueA194 = DATA;
177700151229
177800151229               When length = 195;
177900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178000151229                         :ValueA195 = DATA;
178100151229
178200151229               When length = 196;
178300151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178400151229                         :ValueA196 = DATA;
178500151229
178600151229               When length = 197;
178700151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
178800151229                         :ValueA197 = DATA;
178900151229
179000151229               When length = 198;
179100151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
179200151229                         :ValueA198 = DATA;
179300151229
179400151229               When length = 199;
179500151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
179600151229                         :ValueA199 = DATA;
179700151229
179800151229               When length = 200;
179900151229                 exec sql GET DESCRIPTOR 'Values' VALUE :x
180000151229                         :ValueA200 = DATA;
180100190522
180200190526               When length > 200;
180300190522                 exec sql GET DESCRIPTOR 'Values' VALUE :x
180400190526                         :ValueA32000 = DATA;
180402190526
180500151101               Other;
180600190526                 ValueA32000 = *blanks;
180700151031               Endsl;
180800151031
180900151031       Endsr;
181000151031
181100151031       //************************************************************************
181200151031       // Subroutine = $Numeric - Get numeric descriptor
181300151031       //************************************************************************
181400151031       Begsr $Numeric;
181500151031
181600170320               clear ValueN;
181700151031               Select;
181800151101           // 1
181900151101               When length = 1 and scale = 0;
182000151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
182100151101                         :ValueN1_0 = DATA;
182200151101               NumericValue = %editc(ValueN1_0:'K');
182300151101
182400151101               When length = 1 and scale = 1;
182500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
182600151101                         :ValueN1_1 = DATA;
182700151101               NumericValue = %editc(ValueN1_1:'K');
182800151101           // 2
182900151101               When length = 2 and scale = 0;
183000151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
183100151101                         :ValueN2_0 = DATA;
183200151101               NumericValue = %editc(ValueN2_0:'K');
183300151101
183400151101               When length = 2 and scale = 1;
183500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
183600151101                         :ValueN2_1 = DATA;
183700151101               NumericValue = %editc(ValueN2_1:'K');
183800151101
183900151101               When length = 2 and scale = 2;
184000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
184100151101                         :ValueN2_2 = DATA;
184200151101               NumericValue = %editc(ValueN2_2:'K');
184300151101
184400151101            // 3
184500151101               When length = 3 and scale = 0;
184600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
184700151101                         :ValueN3_0 = DATA;
184800151101               NumericValue = %editc(ValueN3_0:'K');
184900151101
185000151101               When length = 3 and scale = 1;
185100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
185200151101                         :ValueN3_1 = DATA;
185300151101               NumericValue = %editc(ValueN3_1:'K');
185400151101
185500151101               When length = 3 and scale = 2;
185600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
185700151101                         :ValueN3_2 = DATA;
185800151101               NumericValue = %editc(ValueN3_2:'K');
185900151101
186000151101               When length = 3 and scale = 3;
186100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
186200151101                         :ValueN3_3 = DATA;
186300151101               NumericValue = %editc(ValueN3_3:'K');
186400151101
186500151101            // 4
186600151101               When length = 4 and scale = 0;
186700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
186800151101                         :ValueN4_0 = DATA;
186900151101               NumericValue = %editc(ValueN4_0:'K');
187000151101
187100151101               When length = 4 and scale = 1;
187200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
187300151101                         :ValueN4_1 = DATA;
187400151101               NumericValue = %editc(ValueN4_1:'K');
187500151101
187600151101               When length = 4 and scale = 2;
187700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
187800151101                         :ValueN4_2 = DATA;
187900151101               NumericValue = %editc(ValueN4_2:'K');
188000151101
188100151101               When length = 4 and scale = 3;
188200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
188300151101                         :ValueN4_3 = DATA;
188400151101               NumericValue = %editc(ValueN4_3:'K');
188500151101
188600151101               When length = 4 and scale = 4;
188700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
188800151101                         :ValueN4_4 = DATA;
188900151101               NumericValue = %editc(ValueN4_4:'K');
189000151101
189100151101            // 5
189200151101               When length = 5 and scale = 0;
189300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
189400151101                         :ValueN5_0 = DATA;
189500151101               NumericValue = %editc(ValueN5_0:'K');
189600151101
189700151101               When length = 5 and scale = 1;
189800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
189900151101                         :ValueN5_1 = DATA;
190000151101               NumericValue = %editc(ValueN5_1:'K');
190100151101
190200151101               When length = 5 and scale = 2;
190300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
190400151101                         :ValueN5_2 = DATA;
190500151101               NumericValue = %editc(ValueN5_2:'K');
190600151101
190700151101               When length = 5 and scale = 3;
190800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
190900151101                         :ValueN5_3 = DATA;
191000151101               NumericValue = %editc(ValueN5_3:'K');
191100151101
191200151101               When length = 5 and scale = 4;
191300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
191400151101                         :ValueN5_4 = DATA;
191500151101               NumericValue = %editc(ValueN5_4:'K');
191600151101
191700151101            // 6
191800151101               When length = 6 and scale = 0;
191900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
192000151101                         :ValueN6_0 = DATA;
192100151101               NumericValue = %editc(ValueN6_0:'K');
192200151101
192300151101               When length = 6 and scale = 1;
192400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
192500151101                         :ValueN6_1 = DATA;
192600151101               NumericValue = %editc(ValueN6_1:'K');
192700151101
192800151101               When length = 6 and scale = 2;
192900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
193000151101                         :ValueN6_2 = DATA;
193100151101               NumericValue = %editc(ValueN6_2:'K');
193200151101
193300151101               When length = 6 and scale = 3;
193400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
193500151101                         :ValueN6_3 = DATA;
193600151101               NumericValue = %editc(ValueN6_3:'K');
193700151101
193800151101               When length = 6 and scale = 4;
193900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
194000151101                         :ValueN6_4 = DATA;
194100151101               NumericValue = %editc(ValueN6_4:'K');
194200151101
194300151101            // 7
194400151101               When length = 7 and scale = 0;
194500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
194600151101                         :ValueN7_0 = DATA;
194700151101               NumericValue = %editc(ValueN7_0:'K');
194800151101
194900151101               When length = 7 and scale = 1;
195000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
195100151101                         :ValueN7_1 = DATA;
195200151101               NumericValue = %editc(ValueN7_1:'K');
195300151101
195400151101               When length = 7 and scale = 2;
195500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
195600151101                         :ValueN7_2 = DATA;
195700151101               NumericValue = %editc(ValueN7_2:'K');
195800151101
195900151101               When length = 7 and scale = 3;
196000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
196100151101                         :ValueN7_3 = DATA;
196200151101               NumericValue = %editc(ValueN7_3:'K');
196300151101
196400151101               When length = 7 and scale = 4;
196500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
196600151101                         :ValueN7_4 = DATA;
196700151101               NumericValue = %editc(ValueN7_4:'K');
196800151101
196900151101            // 8
197000151101               When length = 8 and scale = 0;
197100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
197200151101                         :ValueN8_0 = DATA;
197300151101               NumericValue = %editc(ValueN8_0:'K');
197400151101
197500151101               When length = 8 and scale = 1;
197600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
197700151101                         :ValueN8_1 = DATA;
197800151101               NumericValue = %editc(ValueN8_1:'K');
197900151101
198000151101               When length = 8 and scale = 2;
198100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
198200151101                         :ValueN8_2 = DATA;
198300151101               NumericValue = %editc(ValueN8_2:'K');
198400151101
198500151101               When length = 8 and scale = 3;
198600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
198700151101                         :ValueN8_3 = DATA;
198800151101               NumericValue = %editc(ValueN8_3:'K');
198900151101
199000151101               When length = 8 and scale = 4;
199100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
199200151101                         :ValueN8_4 = DATA;
199300151101               NumericValue = %editc(ValueN8_4:'K');
199400151101
199500151101            // 9
199600151101               When length = 9 and scale = 0;
199700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
199800151101                         :ValueN9_0 = DATA;
199900151101               NumericValue = %editc(ValueN9_0:'K');
200000151101
200100151101               When length = 9 and scale = 1;
200200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
200300151101                         :ValueN9_1 = DATA;
200400151101               NumericValue = %editc(ValueN9_1:'K');
200500151101
200600151101               When length = 9 and scale = 2;
200700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
200800151101                         :ValueN9_2 = DATA;
200900151101               NumericValue = %editc(ValueN9_2:'K');
201000151101
201100151101               When length = 9 and scale = 3;
201200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
201300151101                         :ValueN9_3 = DATA;
201400151101               NumericValue = %editc(ValueN9_3:'K');
201500151101
201600151101               When length = 9 and scale = 4;
201700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
201800151101                         :ValueN9_4 = DATA;
201900151101               NumericValue = %editc(ValueN9_4:'K');
202000151101
202100151101            // 10
202200151101               When length = 10 and scale = 0;
202300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
202400151101                         :ValueN10_0 = DATA;
202500151101               NumericValue = %editc(ValueN10_0:'K');
202600151101
202700151101               When length = 10 and scale = 1;
202800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
202900151101                         :ValueN10_1 = DATA;
203000151101               NumericValue = %editc(ValueN10_1:'K');
203100151101
203200151101               When length = 10 and scale = 2;
203300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
203400151101                         :ValueN10_2 = DATA;
203500151101               NumericValue = %editc(ValueN10_2:'K');
203600151101
203700151101               When length = 10 and scale = 3;
203800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
203900151101                         :ValueN10_3 = DATA;
204000151101               NumericValue = %editc(ValueN10_3:'K');
204100151101
204200151101               When length = 10 and scale = 4;
204300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
204400151101                         :ValueN10_4 = DATA;
204500151101               NumericValue = %editc(ValueN10_4:'K');
204600151101
204700151101            // 11
204800151101               When length = 11 and scale = 0;
204900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
205000151101                         :ValueN11_0 = DATA;
205100151101               NumericValue = %editc(ValueN11_0:'K');
205200151031
205300151101               When length = 11 and scale = 1;
205400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
205500151101                         :ValueN11_1 = DATA;
205600151101               NumericValue = %editc(ValueN11_1:'K');
205700151101
205800151101               When length = 11 and scale = 2;
205900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
206000151101                         :ValueN11_2 = DATA;
206100151101               NumericValue = %editc(ValueN11_2:'K');
206200151101
206300151101               When length = 11 and scale = 3;
206400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
206500151101                         :ValueN11_3 = DATA;
206600151101               NumericValue = %editc(ValueN11_3:'K');
206700151101
206800151101               When length = 11 and scale = 4;
206900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
207000151101                         :ValueN11_4 = DATA;
207100151101               NumericValue = %editc(ValueN11_4:'K');
207200151101
207300151101            // 12
207400151101               When length = 12 and scale = 0;
207500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
207600151101                         :ValueN12_0 = DATA;
207700151101               NumericValue = %editc(ValueN12_0:'K');
207800151101
207900151101               When length = 12 and scale = 1;
208000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
208100151101                         :ValueN12_1 = DATA;
208200151101               NumericValue = %editc(ValueN12_1:'K');
208300151101
208400151101               When length = 12 and scale = 2;
208500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
208600151101                         :ValueN12_2 = DATA;
208700151101               NumericValue = %editc(ValueN12_2:'K');
208800151101
208900151101               When length = 12 and scale = 3;
209000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
209100151101                         :ValueN12_3 = DATA;
209200151101               NumericValue = %editc(ValueN12_3:'K');
209300151101
209400151101               When length = 12 and scale = 4;
209500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
209600151101                         :ValueN12_4 = DATA;
209700151101               NumericValue = %editc(ValueN12_4:'K');
209800151101
209900151101            // 13
210000151101               When length = 13 and scale = 0;
210100151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
210200151101                         :ValueN13_0 = DATA;
210300151101               NumericValue = %editc(ValueN13_0:'K');
210400151101
210500151101               When length = 13 and scale = 1;
210600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
210700151101                         :ValueN13_1 = DATA;
210800151101               NumericValue = %editc(ValueN13_1:'K');
210900151101
211000151101               When length = 13 and scale = 2;
211100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
211200151101                         :ValueN13_2 = DATA;
211300151101               NumericValue = %editc(ValueN13_2:'K');
211400151101
211500151101               When length = 13 and scale = 3;
211600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
211700151101                         :ValueN13_3 = DATA;
211800151101               NumericValue = %editc(ValueN13_3:'K');
211900151101
212000151101               When length = 13 and scale = 4;
212100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
212200151101                         :ValueN13_4 = DATA;
212300151101               NumericValue = %editc(ValueN13_4:'K');
212400151101
212500151101            // 14
212600151101               When length = 14 and scale = 0;
212700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
212800151101                         :ValueN14_0 = DATA;
212900151101               NumericValue = %editc(ValueN14_0:'K');
213000151101
213100151101               When length = 14 and scale = 1;
213200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
213300151101                         :ValueN14_1 = DATA;
213400151101               NumericValue = %editc(ValueN14_1:'K');
213500151101
213600151101               When length = 14 and scale = 2;
213700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
213800151101                         :ValueN14_2 = DATA;
213900151101               NumericValue = %editc(ValueN14_2:'K');
214000151101
214100151101               When length = 14 and scale = 3;
214200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
214300151101                         :ValueN14_3 = DATA;
214400151101               NumericValue = %editc(ValueN14_3:'K');
214500151101
214600151101               When length = 14 and scale = 4;
214700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
214800151101                         :ValueN14_4 = DATA;
214900151101               NumericValue = %editc(ValueN14_4:'K');
215000151101
215100190526            // 15
215200151101               When length = 15 and scale = 0;
215300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
215400151101                         :ValueN15_0 = DATA;
215500151101               NumericValue = %editc(ValueN15_0:'K');
215600151101
215700151101               When length = 15 and scale = 1;
215800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
215900151101                         :ValueN15_1 = DATA;
216000151101               NumericValue = %editc(ValueN15_1:'K');
216100151101
216200151101               When length = 15 and scale = 2;
216300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
216400151101                         :ValueN15_2 = DATA;
216500151101               NumericValue = %editc(ValueN15_2:'K');
216600151101
216700151101               When length = 15 and scale = 3;
216800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
216900151101                         :ValueN15_3 = DATA;
217000151101               NumericValue = %editc(ValueN15_3:'K');
217100151101
217200151101               When length = 15 and scale = 4;
217300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217400151101                         :ValueN15_4 = DATA;
217500151101               NumericValue = %editc(ValueN15_4:'K');
217600151101
217601190526               // > 15
217603190526               When length > 15 and scale = 0;
217604190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217605190526                         :ValueN31_0 = DATA;
217606190526               NumericValue = %editc(ValueN31_0:'K');
217607190526
217608190526               When length > 15 and scale = 1;
217610190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217611190526                         :ValueN31_1 = DATA;
217612190526               NumericValue = %editc(ValueN31_1:'K');
217613190526
217614190526               When length > 15 and scale = 2;
217615190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217616190526                         :ValueN31_2 = DATA;
217617190526               NumericValue = %editc(ValueN31_2:'K');
217618190526
217619190526               When length > 15 and scale = 3;
217620190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217621190526                         :ValueN31_3 = DATA;
217622190526               NumericValue = %editc(ValueN31_3:'K');
217623190526
217624190526               When length > 15 and scale = 4;
217625190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217626190526                         :ValueN31_4 = DATA;
217627190526               NumericValue = %editc(ValueN31_4:'K');
217628190526
217629190526               When length > 15 and scale = 5;
217630190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217631190526                         :ValueN31_5 = DATA;
217632190526               NumericValue = %editc(ValueN31_5:'K');
217633190526
217634190526               When length > 15 and scale = 6;
217635190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217636190526                         :ValueN31_6 = DATA;
217637190526               NumericValue = %editc(ValueN31_6:'K');
217638190526
217639190526               When length > 15 and scale = 7;
217640190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217641190526                         :ValueN31_7 = DATA;
217642190526               NumericValue = %editc(ValueN31_7:'K');
217643190526
217644190526               When length > 15 and scale = 8;
217645190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217646190526                         :ValueN31_8 = DATA;
217647190526               NumericValue = %editc(ValueN31_8:'K');
217648190526
217649190526               When length > 15 and scale = 9;
217650190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217651190526                         :ValueN31_9 = DATA;
217652190526               NumericValue = %editc(ValueN31_9:'K');
217653190526
217654190526               When length > 15 and scale = 10;
217655190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217656190526                         :ValueN31_10 = DATA;
217657190526               NumericValue = %editc(ValueN31_10:'K');
217658190526
217659190526               When length > 15 and scale = 11;
217660190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217661190526                         :ValueN31_11 = DATA;
217662190526               NumericValue = %editc(ValueN31_11:'K');
217663190526
217664190526               When length > 15 and scale = 12;
217665190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217666190526                         :ValueN31_12 = DATA;
217667190526               NumericValue = %editc(ValueN31_12:'K');
217668190526
217669190526               When length > 15 and scale = 13;
217670190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217671190526                         :ValueN31_13 = DATA;
217672190526               NumericValue = %editc(ValueN31_13:'K');
217673190526
217674190526               When length > 15 and scale = 14;
217675190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217676190526                         :ValueN31_14 = DATA;
217677190526               NumericValue = %editc(ValueN31_14:'K');
217678190526
217679190526               When length > 15 and scale = 15;
217680190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217681190526                         :ValueN31_15 = DATA;
217682190526               NumericValue = %editc(ValueN31_15:'K');
217683190526
217684190526               When length > 15 and scale = 16;
217685190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217686190526                         :ValueN31_16 = DATA;
217687190526               NumericValue = %editc(ValueN31_16:'K');
217688190526
217689190526               When length > 15 and scale = 17;
217690190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217691190526                         :ValueN31_17 = DATA;
217692190526               NumericValue = %editc(ValueN31_17:'K');
217693190526
217694190526               When length > 15 and scale = 18;
217695190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217696190526                         :ValueN31_18 = DATA;
217697190526               NumericValue = %editc(ValueN31_18:'K');
217698190526
217699190526               When length > 15 and scale = 19;
217700190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217701190526                         :ValueN31_19 = DATA;
217702190526               NumericValue = %editc(ValueN31_19:'K');
217703190526
217704190526               When length > 15 and scale = 20;
217705190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217706190526                         :ValueN31_20 = DATA;
217707190526               NumericValue = %editc(ValueN31_20:'K');
217708190526
217709190526               When length > 15 and scale = 21;
217710190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217711190526                         :ValueN31_21 = DATA;
217712190526               NumericValue = %editc(ValueN31_21:'K');
217713190526
217714190526               When length > 15 and scale = 22;
217715190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217716190526                         :ValueN31_22 = DATA;
217717190526               NumericValue = %editc(ValueN31_22:'K');
217718190526
217719190526               When length > 15 and scale = 23;
217720190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217721190526                         :ValueN31_23 = DATA;
217722190526               NumericValue = %editc(ValueN31_23:'K');
217723190526
217724190526               When length > 15 and scale = 24;
217725190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217726190526                         :ValueN31_24 = DATA;
217727190526               NumericValue = %editc(ValueN31_24:'K');
217728190526
217729190526               When length > 15 and scale = 25;
217730190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217731190526                         :ValueN31_25 = DATA;
217732190526               NumericValue = %editc(ValueN31_25:'K');
217733190526
217734190526               When length > 15 and scale = 26;
217735190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217736190526                         :ValueN31_26 = DATA;
217737190526               NumericValue = %editc(ValueN31_26:'K');
217738190526
217739190526               When length > 15 and scale = 27;
217740190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217741190526                         :ValueN31_27 = DATA;
217742190526               NumericValue = %editc(ValueN31_27:'K');
217743190526
217744190526               When length > 15 and scale = 28;
217745190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217746190526                         :ValueN31_28 = DATA;
217747190526               NumericValue = %editc(ValueN31_28:'K');
217748190526
217749190526               When length > 15 and scale = 29;
217750190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217751190526                         :ValueN31_29 = DATA;
217752190526               NumericValue = %editc(ValueN31_29:'K');
217753190526
217754190526               When length > 15 and scale = 30;
217755190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217756190526                         :ValueN31_30 = DATA;
217757190526               NumericValue = %editc(ValueN31_30:'K');
217758190526
217759190526               When length > 15 and scale = 31;
217760190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
217761190526                         :ValueN31_31 = DATA;
217762190526               NumericValue = %editc(ValueN31_31:'K');
217763190526
217764151101               Other;
217800151101                 NumericValue = *blanks;
217900151031               Endsl;
218000151031
218100151031       ENDSR;
218200151031
218300151031       //************************************************************************
218400151031       // Subroutine = $Decimal - Get numeric descriptor
218500151031       //************************************************************************
218600151031       Begsr $Decimal;
218700151031
218800190527             Length = (Precision/2)+1;
218900190527             Clear PackedDS;
218901190527             Select;
219100151101           // 1
219101190527             When Precision =1;
219102190527             Select;
219200190527               When scale = 0;
219300151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
219400151101                         :ValueD1_0 = DATA;
219500151101                 NumericValue = %editc(ValueD1_0:'K');
219600151101
219700190527               When scale = 1;
219800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
219900151101                         :ValueD1_1 = DATA;
220000151101                 NumericValue = %editc(ValueD1_1:'K');
220100190527             Endsl;
220200190527           // 3
220201190527             When Precision =3;
220202190527             Select;
220300190527               When scale = 0;
220400151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
220500151101                         :ValueD3_0 = DATA;
220600151101                 NumericValue = %editc(ValueD3_0:'K');
220700151031
220800190527               When scale = 1;
220900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
221000151101                         :ValueD3_1 = DATA;
221100151101                 NumericValue = %editc(ValueD3_1:'K');
221200151101
221300190527               When scale = 2;
221400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
221500151101                         :ValueD3_2 = DATA;
221600151101                 NumericValue = %editc(ValueD3_2:'K');
221700151101
221800190527               When scale = 3;
221900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
222000151101                         :ValueD3_3 = DATA;
222100151101                 NumericValue = %editc(ValueD3_3:'K');
222200190527               Endsl;
222300190527           // 5
222301190527             When Precision =5;
222302190527             Select;
222400190527               When scale = 0;
222500151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
222600151101                         :ValueD5_0 = DATA;
222700151101                 NumericValue = %editc(ValueD5_0:'K');
222800151031
222900190527               When scale = 1;
223000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
223100151101                         :ValueD5_1 = DATA;
223200151101                 NumericValue = %editc(ValueD5_1:'K');
223300151101
223400190527               When scale = 2;
223500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
223600151101                         :ValueD5_2 = DATA;
223700151101                 NumericValue = %editc(ValueD5_2:'K');
223800151101
223900190527               When scale = 3;
224000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
224100151101                         :ValueD5_3 = DATA;
224200151101                 NumericValue = %editc(ValueD5_3:'K');
224300151101
224400190527               When scale = 4;
224500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
224600151101                         :ValueD5_4 = DATA;
224700151101                 NumericValue = %editc(ValueD5_4:'K');
224800151101
224900190527               When scale = 5;
225000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
225100151101                         :ValueD5_5 = DATA;
225200151101                 NumericValue = %editc(ValueD5_5:'K');
225201190527             Endsl;
225300151101
225400190527           // 7
225401190527             When Precision =7;
225402190527             Select;
225500190527               When scale = 0;
225600151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
225700151101                         :ValueD7_0 = DATA;
225800151101                 NumericValue = %editc(ValueD7_0:'K');
225900151031
226000190527               When scale = 1;
226100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
226200151101                         :ValueD7_1 = DATA;
226300151101                 NumericValue = %editc(ValueD7_1:'K');
226400151101
226500190527               When scale = 2;
226600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
226700151101                         :ValueD7_2 = DATA;
226800151101                 NumericValue = %editc(ValueD7_2:'K');
226900151101
227000190527               When scale = 3;
227100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
227200151101                         :ValueD7_3 = DATA;
227300151101                 NumericValue = %editc(ValueD7_3:'K');
227400151101
227500190527               When scale = 4;
227600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
227700151101                         :ValueD7_4 = DATA;
227800151101                 NumericValue = %editc(ValueD7_4:'K');
227900151101
228000190527               When scale = 5;
228100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
228200151101                         :ValueD7_5 = DATA;
228300151101                 NumericValue = %editc(ValueD7_5:'K');
228400151101
228500190527               When scale = 6;
228600151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
228700151101                         :ValueD7_6 = DATA;
228800151101                 NumericValue = %editc(ValueD7_6:'K');
228900151101
229000190527               When scale = 7;
229100151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
229200151101                         :ValueD7_7 = DATA;
229300151101                 NumericValue = %editc(ValueD7_7:'K');
229301190527             Endsl;
229400151101
229500190527           // 9
229501190527             When Precision =9;
229502190527             Select;
229600190527               When scale = 0;
229700151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
229800151101                         :ValueD9_0 = DATA;
229900151101                 NumericValue = %editc(ValueD9_0:'K');
230000151031
230100190527               When scale = 1;
230200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
230300151101                         :ValueD9_1 = DATA;
230400151101                 NumericValue = %editc(ValueD9_1:'K');
230500151101
230600190527               When scale = 2;
230700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
230800151101                         :ValueD9_2 = DATA;
230900151101                 NumericValue = %editc(ValueD9_2:'K');
231000151101
231100190527               When scale = 3;
231200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
231300151101                         :ValueD9_3 = DATA;
231400151101                 NumericValue = %editc(ValueD9_3:'K');
231500151101
231600190527               When scale = 4;
231700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
231800151101                         :ValueD9_4 = DATA;
231900151101                 NumericValue = %editc(ValueD9_4:'K');
232000151101
232100190527               When scale = 5;
232200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
232300151101                         :ValueD9_5 = DATA;
232400151101                 NumericValue = %editc(ValueD9_5:'K');
232500151101
232600190527               When scale = 6;
232700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
232800151101                         :ValueD9_6 = DATA;
232900151101                 NumericValue = %editc(ValueD9_6:'K');
233000151101
233100190527               When scale = 7;
233200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
233300151101                         :ValueD9_7 = DATA;
233400151101                 NumericValue = %editc(ValueD9_7:'K');
233500151101
233600190527               When scale = 8;
233700151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
233800151101                         :ValueD9_8 = DATA;
233900151101                 NumericValue = %editc(ValueD9_8:'K');
234000151101
234100190527               When scale = 9;
234200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
234300151101                         :ValueD9_9 = DATA;
234400151101                 NumericValue = %editc(ValueD9_9:'K');
234401190527             Endsl;
234500151101
234600190527           // 11
234601190527             When Precision =11;
234602190527             Select;
234700190527               When scale = 0;
234800151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
234900151101                         :ValueD11_0 = DATA;
235000151101                 NumericValue = %editc(ValueD11_0:'K');
235100151031
235200190527               When scale = 1;
235300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
235400151101                         :ValueD11_1 = DATA;
235500151101                 NumericValue = %editc(ValueD11_1:'K');
235600151101
235700190527               When scale = 2;
235800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
235900151101                         :ValueD11_2 = DATA;
236000151101                 NumericValue = %editc(ValueD11_2:'K');
236100151101
236200190527               When scale = 3;
236300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
236400151101                         :ValueD11_3 = DATA;
236500151101                 NumericValue = %editc(ValueD11_3:'K');
236600151101
236700190527               When scale = 4;
236800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
236900151101                         :ValueD11_4 = DATA;
237000151101                 NumericValue = %editc(ValueD11_4:'K');
237100151101
237200190527               When scale = 5;
237300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
237400151101                         :ValueD11_5 = DATA;
237500151101                 NumericValue = %editc(ValueD11_5:'K');
237600151101
237700190527               When scale = 6;
237800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
237900151101                         :ValueD11_6 = DATA;
238000151101                 NumericValue = %editc(ValueD11_6:'K');
238100151101
238200190527               When scale = 7;
238300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
238400151101                         :ValueD11_7 = DATA;
238500151101                 NumericValue = %editc(ValueD11_7:'K');
238600151101
238700190527               When scale = 8;
238800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
238900151101                         :ValueD11_8 = DATA;
239000151101                 NumericValue = %editc(ValueD11_8:'K');
239100151101
239200190527               When scale = 9;
239300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
239400151101                         :ValueD11_9 = DATA;
239500151101                 NumericValue = %editc(ValueD11_9:'K');
239600151101
239700190527               When scale = 10;
239800151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
239900151101                         :ValueD11_10 = DATA;
240000151101                 NumericValue = %editc(ValueD11_10:'K');
240100151101
240200190527               When scale = 11;
240300151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
240400151101                         :ValueD11_11 = DATA;
240500151101                 NumericValue = %editc(ValueD11_11:'K');
240501190527             Endsl;
240600151101
240700190527           // 13
240701190527             When Precision =13;
240702190527             Select;
240800190527               When scale = 0;
240900151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
241000151101                         :ValueD13_0 = DATA;
241100151101                 NumericValue = %editc(ValueD13_0:'K');
241200151031
241300190527               When scale = 1;
241400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
241500151101                         :ValueD13_1 = DATA;
241600151101                 NumericValue = %editc(ValueD13_1:'K');
241700151101
241800190527               When scale = 2;
241900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
242000151101                         :ValueD13_2 = DATA;
242100151101                 NumericValue = %editc(ValueD13_2:'K');
242200151101
242300190527               When scale = 3;
242400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
242500151101                         :ValueD13_3 = DATA;
242600151101                 NumericValue = %editc(ValueD13_3:'K');
242700151101
242800190527               When scale = 4;
242900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
243000151101                         :ValueD13_4 = DATA;
243100151101                 NumericValue = %editc(ValueD13_4:'K');
243200151101
243300190527               When scale = 5;
243400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
243500151101                         :ValueD13_5 = DATA;
243600151101                 NumericValue = %editc(ValueD13_5:'K');
243700151101
243800190527               When scale = 6;
243900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
244000151101                         :ValueD13_6 = DATA;
244100151101                 NumericValue = %editc(ValueD13_6:'K');
244200151101
244300190527               When scale = 7;
244400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
244500151101                         :ValueD13_7 = DATA;
244600151101                 NumericValue = %editc(ValueD13_7:'K');
244700151101
244800190527               When scale = 8;
244900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
245000151101                         :ValueD13_8 = DATA;
245100151101                 NumericValue = %editc(ValueD13_8:'K');
245200151101
245300190527               When scale = 9;
245400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
245500151101                         :ValueD13_9 = DATA;
245600151101                 NumericValue = %editc(ValueD13_9:'K');
245700151101
245800190527               When scale = 10;
245900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
246000151101                         :ValueD13_10 = DATA;
246100151101                 NumericValue = %editc(ValueD13_10:'K');
246200151101
246300190527               When scale = 11;
246400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
246500151101                         :ValueD13_11 = DATA;
246600151101                 NumericValue = %editc(ValueD13_11:'K');
246700151101
246800190527               When scale = 12;
246900151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
247000151101                         :ValueD13_12 = DATA;
247100151101                 NumericValue = %editc(ValueD13_12:'K');
247200151101
247300190527               When scale = 13;
247400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
247500151101                         :ValueD13_13 = DATA;
247600151101                 NumericValue = %editc(ValueD13_13:'K');
247601190527             Endsl;
247700151101
247800190527           // 15
247801190527             When Precision =15;
247802190527             Select;
247900190527               When scale = 0;
248000151031                 exec sql GET DESCRIPTOR 'Values' VALUE :x
248100151101                         :ValueD15_0 = DATA;
248200151101                 NumericValue = %editc(ValueD15_0:'K');
248300151101
248400190527               When scale = 1;
248500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
248600151101                         :ValueD15_1 = DATA;
248700151101                 NumericValue = %editc(ValueD15_1:'K');
248800151101
248900190527               When scale = 2;
249000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
249100151101                         :ValueD15_2 = DATA;
249200151101                 NumericValue = %editc(ValueD15_2:'K');
249300151101
249400190527               When scale = 3;
249500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
249600151101                         :ValueD15_3 = DATA;
249700151101                 NumericValue = %editc(ValueD15_3:'K');
249800151101
249900190527               When scale = 4;
250000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
250100151101                         :ValueD15_4 = DATA;
250200151101                 NumericValue = %editc(ValueD15_4:'K');
250300151101
250400190527               When scale = 5;
250500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
250600151101                         :ValueD15_5 = DATA;
250700151101                 NumericValue = %editc(ValueD15_5:'K');
250800151101
250900190527               When scale = 6;
251000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
251100151101                         :ValueD15_6 = DATA;
251200151101                 NumericValue = %editc(ValueD15_6:'K');
251300151101
251400190527               When scale = 7;
251500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
251600151101                         :ValueD15_7 = DATA;
251700151101                 NumericValue = %editc(ValueD15_7:'K');
251800151101
251900190527               When scale = 8;
252000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
252100151101                         :ValueD15_8 = DATA;
252200151101                 NumericValue = %editc(ValueD15_8:'K');
252300151101
252400190527               When scale = 9;
252500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
252600151101                         :ValueD15_9 = DATA;
252700151101                 NumericValue = %editc(ValueD15_9:'K');
252800151101
252900190527               When scale = 10;
253000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
253100151101                         :ValueD15_10 = DATA;
253200151101                 NumericValue = %editc(ValueD15_10:'K');
253300151101
253400190527               When scale = 11;
253500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
253600151101                         :ValueD15_11 = DATA;
253700151101                 NumericValue = %editc(ValueD15_11:'K');
253800151101
253900190527               When scale = 12;
254000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
254100151101                         :ValueD15_12 = DATA;
254200151101                 NumericValue = %editc(ValueD15_12:'K');
254300151101
254400190527               When scale = 13;
254500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
254600151101                         :ValueD15_13 = DATA;
254700151101                 NumericValue = %editc(ValueD15_13:'K');
254800151101
254900190527               When scale = 14;
255000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255100151101                         :ValueD15_14 = DATA;
255200151101                 NumericValue = %editc(ValueD15_14:'K');
255300151101
255400190527               When scale = 15;
255500151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255600151101                         :ValueD15_15 = DATA;
255700151101                 NumericValue = %editc(ValueD15_15:'K');
255701190527             Endsl;
255702190527
255703190527           // 17
255704190527             When Precision =17;
255705190527             Select;
255706190527               When scale = 0;
255707190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255708190527                         :ValueD17_0  = DATA;
255709190527                 NumericValue = %editc(ValueD17_0 :'K');
255710190527
255711190527               When scale = 1;
255712190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255713190527                         :ValueD17_1  = DATA;
255714190527                 NumericValue = %editc(ValueD17_1 :'K');
255715190527
255716190527               When scale = 2;
255717190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255718190527                         :ValueD17_2  = DATA;
255719190527                 NumericValue = %editc(ValueD17_2 :'K');
255720190527
255721190527               When scale = 3;
255722190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255723190527                         :ValueD17_3  = DATA;
255724190527                 NumericValue = %editc(ValueD17_3 :'K');
255725190527
255726190527               When scale = 4;
255727190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255728190527                         :ValueD17_4  = DATA;
255729190527                 NumericValue = %editc(ValueD17_4 :'K');
255730190527
255731190527               When scale = 5;
255732190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255733190527                         :ValueD17_5  = DATA;
255734190527                 NumericValue = %editc(ValueD17_5 :'K');
255735190527
255736190527               When scale = 6;
255737190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255738190527                         :ValueD17_6  = DATA;
255739190527                 NumericValue = %editc(ValueD17_6 :'K');
255740190527
255741190527               When scale = 7;
255742190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255743190527                         :ValueD17_7  = DATA;
255744190527                 NumericValue = %editc(ValueD17_7 :'K');
255745190527
255746190527               When scale = 8;
255747190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255748190527                         :ValueD17_8  = DATA;
255749190527                 NumericValue = %editc(ValueD17_8 :'K');
255750190527
255751190527               When scale = 9;
255752190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255753190527                         :ValueD17_9  = DATA;
255754190527                 NumericValue = %editc(ValueD17_9 :'K');
255755190527
255756190527               When scale = 10;
255757190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255758190527                         :ValueD17_10  = DATA;
255759190527                 NumericValue = %editc(ValueD17_10 :'K');
255760190527
255761190527               When scale = 11;
255762190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255763190527                         :ValueD17_11  = DATA;
255764190527                 NumericValue = %editc(ValueD17_11 :'K');
255765190527
255766190527               When scale = 12;
255767190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255768190527                         :ValueD17_12  = DATA;
255769190527                 NumericValue = %editc(ValueD17_12 :'K');
255770190527
255771190527               When scale = 13;
255772190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255773190527                         :ValueD17_13  = DATA;
255774190527                 NumericValue = %editc(ValueD17_13 :'K');
255775190527
255776190527               When scale = 14;
255777190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255778190527                         :ValueD17_14  = DATA;
255779190527                 NumericValue = %editc(ValueD17_14 :'K');
255780190527
255781190527               When scale = 15;
255782190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255783190527                         :ValueD17_15  = DATA;
255784190527                 NumericValue = %editc(ValueD17_15 :'K');
255785190527
255786190527               When scale = 16;
255787190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255788190527                         :ValueD17_16  = DATA;
255789190527                 NumericValue = %editc(ValueD17_16 :'K');
255790190527
255791190527               When scale = 17;
255792190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255793190527                         :ValueD17_17  = DATA;
255794190527                 NumericValue = %editc(ValueD17_17 :'K');
255795190527
255806190527               Endsl;
255807190527
255808190527           // 19
255809190527             When Precision =19;
255810190527             Select;
255811190527               When scale = 0;
255812190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255813190527                         :ValueD19_0  = DATA;
255814190527                 NumericValue = %editc(ValueD19_0 :'K');
255815190527
255816190527               When scale = 1;
255817190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255818190527                         :ValueD19_1  = DATA;
255819190527                 NumericValue = %editc(ValueD19_1 :'K');
255820190527
255821190527               When scale = 2;
255822190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255823190527                         :ValueD19_2  = DATA;
255824190527                 NumericValue = %editc(ValueD19_2 :'K');
255825190527
255826190527               When scale = 3;
255827190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255828190527                         :ValueD19_3  = DATA;
255829190527                 NumericValue = %editc(ValueD19_3 :'K');
255830190527
255831190527               When scale = 4;
255832190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255833190527                         :ValueD19_4  = DATA;
255834190527                 NumericValue = %editc(ValueD19_4 :'K');
255835190527
255836190527               When scale = 5;
255837190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255838190527                         :ValueD19_5  = DATA;
255839190527                 NumericValue = %editc(ValueD19_5 :'K');
255840190527
255841190527               When scale = 6;
255842190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255843190527                         :ValueD19_6  = DATA;
255844190527                 NumericValue = %editc(ValueD19_6 :'K');
255845190527
255846190527               When scale = 7;
255847190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255848190527                         :ValueD19_7  = DATA;
255849190527                 NumericValue = %editc(ValueD19_7 :'K');
255850190527
255851190527               When scale = 8;
255852190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255853190527                         :ValueD19_8  = DATA;
255854190527                 NumericValue = %editc(ValueD19_8 :'K');
255855190527
255856190527               When scale = 9;
255857190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255858190527                         :ValueD19_9  = DATA;
255859190527                 NumericValue = %editc(ValueD19_9 :'K');
255860190527
255861190527               When scale = 10;
255862190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255863190527                         :ValueD19_10  = DATA;
255864190527                 NumericValue = %editc(ValueD19_10 :'K');
255865190527
255866190527               When scale = 11;
255867190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255868190527                         :ValueD19_11  = DATA;
255869190527                 NumericValue = %editc(ValueD19_11 :'K');
255870190527
255871190527               When scale = 12;
255872190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255873190527                         :ValueD19_12  = DATA;
255874190527                 NumericValue = %editc(ValueD19_12 :'K');
255875190527
255876190527               When scale = 13;
255877190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255878190527                         :ValueD19_13  = DATA;
255879190527                 NumericValue = %editc(ValueD19_13 :'K');
255880190527
255881190527               When scale = 14;
255882190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255883190527                         :ValueD19_14  = DATA;
255884190527                 NumericValue = %editc(ValueD19_14 :'K');
255885190527
255886190527               When scale = 15;
255887190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255888190527                         :ValueD19_15  = DATA;
255889190527                 NumericValue = %editc(ValueD19_15 :'K');
255890190527
255891190527               When scale = 16;
255892190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255893190527                         :ValueD19_16  = DATA;
255894190527                 NumericValue = %editc(ValueD19_16 :'K');
255895190527
255896190527               When scale = 17;
255897190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255898190527                         :ValueD19_17  = DATA;
255899190527                 NumericValue = %editc(ValueD19_17 :'K');
255900190527
255901190527               When scale = 18;
255902190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255903190527                         :ValueD19_18  = DATA;
255904190527                 NumericValue = %editc(ValueD19_18 :'K');
255905190527
255906190527               When scale = 19;
255907190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255908190527                         :ValueD19_19  = DATA;
255909190527                 NumericValue = %editc(ValueD19_19 :'K');
255910190527
255911190527               Endsl;
255912190527
255913190527           // 21
255914190527             When Precision =21;
255915190527             Select;
255916190527               When scale = 0;
255917190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255918190527                         :ValueD21_0  = DATA;
255919190527                 NumericValue = %editc(ValueD21_0 :'K');
255920190527
255921190527               When scale = 1;
255922190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255923190527                         :ValueD21_1  = DATA;
255924190527                 NumericValue = %editc(ValueD21_1 :'K');
255925190527
255926190527               When scale = 2;
255927190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255928190527                         :ValueD21_2  = DATA;
255929190527                 NumericValue = %editc(ValueD21_2 :'K');
255930190527
255931190527               When scale = 3;
255932190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255933190527                         :ValueD21_3  = DATA;
255934190527                 NumericValue = %editc(ValueD21_3 :'K');
255935190527
255936190527               When scale = 4;
255937190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255938190527                         :ValueD21_4  = DATA;
255939190527                 NumericValue = %editc(ValueD21_4 :'K');
255940190527
255941190527               When scale = 5;
255942190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255943190527                         :ValueD21_5  = DATA;
255944190527                 NumericValue = %editc(ValueD21_5 :'K');
255945190527
255946190527               When scale = 6;
255947190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255948190527                         :ValueD21_6  = DATA;
255949190527                 NumericValue = %editc(ValueD21_6 :'K');
255950190527
255951190527               When scale = 7;
255952190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255953190527                         :ValueD21_7  = DATA;
255954190527                 NumericValue = %editc(ValueD21_7 :'K');
255955190527
255956190527               When scale = 8;
255957190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255958190527                         :ValueD21_8  = DATA;
255959190527                 NumericValue = %editc(ValueD21_8 :'K');
255960190527
255961190527               When scale = 9;
255962190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255963190527                         :ValueD21_9  = DATA;
255964190527                 NumericValue = %editc(ValueD21_9 :'K');
255965190527
255966190527               When scale = 10;
255967190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255968190527                         :ValueD21_10  = DATA;
255969190527                 NumericValue = %editc(ValueD21_10 :'K');
255970190527
255971190527               When scale = 11;
255972190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255973190527                         :ValueD21_11  = DATA;
255974190527                 NumericValue = %editc(ValueD21_11 :'K');
255975190527
255976190527               When scale = 12;
255977190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255978190527                         :ValueD21_12  = DATA;
255979190527                 NumericValue = %editc(ValueD21_12 :'K');
255980190527
255981190527               When scale = 13;
255982190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255983190527                         :ValueD21_13  = DATA;
255984190527                 NumericValue = %editc(ValueD21_13 :'K');
255985190527
255986190527               When scale = 14;
255987190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255988190527                         :ValueD21_14  = DATA;
255989190527                 NumericValue = %editc(ValueD21_14 :'K');
255990190527
255991190527               When scale = 15;
255992190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255993190527                         :ValueD21_15  = DATA;
255994190527                 NumericValue = %editc(ValueD21_15 :'K');
255995190527
255996190527               When scale = 16;
255997190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
255998190527                         :ValueD21_16  = DATA;
255999190527                 NumericValue = %editc(ValueD21_16 :'K');
256000190527
256001190527               When scale = 17;
256002190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256003190527                         :ValueD21_17  = DATA;
256004190527                 NumericValue = %editc(ValueD21_17 :'K');
256005190527
256006190527               When scale = 18;
256007190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256008190527                         :ValueD21_18  = DATA;
256009190527                 NumericValue = %editc(ValueD21_18 :'K');
256010190527
256011190527               When scale = 19;
256012190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256013190527                         :ValueD21_19  = DATA;
256014190527                 NumericValue = %editc(ValueD21_19 :'K');
256015190527
256016190527               When scale = 20;
256017190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256018190527                         :ValueD21_20  = DATA;
256019190527                 NumericValue = %editc(ValueD21_20 :'K');
256020190527
256021190527               When scale = 21;
256022190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256023190527                         :ValueD21_21  = DATA;
256024190527                 NumericValue = %editc(ValueD21_21 :'K');
256025190527
256026190527               Endsl;
256027190527
256028190527           // 23
256029190527             When Precision =23;
256030190527             Select;
256031190527               When scale = 0;
256032190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256033190527                         :ValueD23_0  = DATA;
256034190527                 NumericValue = %editc(ValueD23_0 :'K');
256035190527
256036190527               When scale = 1;
256037190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256038190527                         :ValueD23_1  = DATA;
256039190527                 NumericValue = %editc(ValueD23_1 :'K');
256040190527
256041190527               When scale = 2;
256042190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256043190527                         :ValueD23_2  = DATA;
256044190527                 NumericValue = %editc(ValueD23_2 :'K');
256045190527
256046190527               When scale = 3;
256047190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256048190527                         :ValueD23_3  = DATA;
256049190527                 NumericValue = %editc(ValueD23_3 :'K');
256050190527
256051190527               When scale = 4;
256052190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256053190527                         :ValueD23_4  = DATA;
256054190527                 NumericValue = %editc(ValueD23_4 :'K');
256055190527
256056190527               When scale = 5;
256057190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256058190527                         :ValueD23_5  = DATA;
256059190527                 NumericValue = %editc(ValueD23_5 :'K');
256060190527
256061190527               When scale = 6;
256062190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256063190527                         :ValueD23_6  = DATA;
256064190527                 NumericValue = %editc(ValueD23_6 :'K');
256065190527
256066190527               When scale = 7;
256067190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256068190527                         :ValueD23_7  = DATA;
256069190527                 NumericValue = %editc(ValueD23_7 :'K');
256070190527
256071190527               When scale = 8;
256072190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256073190527                         :ValueD23_8  = DATA;
256074190527                 NumericValue = %editc(ValueD23_8 :'K');
256075190527
256076190527               When scale = 9;
256077190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256078190527                         :ValueD23_9  = DATA;
256079190527                 NumericValue = %editc(ValueD23_9 :'K');
256080190527
256081190527               When scale = 10;
256082190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256083190527                         :ValueD23_10  = DATA;
256084190527                 NumericValue = %editc(ValueD23_10 :'K');
256085190527
256086190527               When scale = 11;
256087190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256088190527                         :ValueD23_11  = DATA;
256089190527                 NumericValue = %editc(ValueD23_11 :'K');
256090190527
256091190527               When scale = 12;
256092190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256093190527                         :ValueD23_12  = DATA;
256094190527                 NumericValue = %editc(ValueD23_12 :'K');
256095190527
256096190527               When scale = 13;
256097190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256098190527                         :ValueD23_13  = DATA;
256099190527                 NumericValue = %editc(ValueD23_13 :'K');
256100190527
256101190527               When scale = 14;
256102190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256103190527                         :ValueD23_14  = DATA;
256104190527                 NumericValue = %editc(ValueD23_14 :'K');
256105190527
256106190527               When scale = 15;
256107190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256108190527                         :ValueD23_15  = DATA;
256109190527                 NumericValue = %editc(ValueD23_15 :'K');
256110190527
256111190527               When scale = 16;
256112190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256113190527                         :ValueD23_16  = DATA;
256114190527                 NumericValue = %editc(ValueD23_16 :'K');
256115190527
256116190527               When scale = 17;
256117190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256118190527                         :ValueD23_17  = DATA;
256119190527                 NumericValue = %editc(ValueD23_17 :'K');
256120190527
256121190527               When scale = 18;
256122190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256123190527                         :ValueD23_18  = DATA;
256124190527                 NumericValue = %editc(ValueD23_18 :'K');
256125190527
256126190527               When scale = 19;
256127190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256128190527                         :ValueD23_19  = DATA;
256129190527                 NumericValue = %editc(ValueD23_19 :'K');
256130190527
256131190527               When scale = 20;
256132190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256133190527                         :ValueD23_20  = DATA;
256134190527                 NumericValue = %editc(ValueD23_20 :'K');
256135190527
256136190527               When scale = 21;
256137190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256138190527                         :ValueD23_21  = DATA;
256139190527                 NumericValue = %editc(ValueD23_21 :'K');
256140190527
256141190527               When scale = 22;
256142190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256143190527                         :ValueD23_22  = DATA;
256144190527                 NumericValue = %editc(ValueD23_22 :'K');
256145190527
256146190527               When scale = 23;
256147190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256148190527                         :ValueD23_23  = DATA;
256149190527                 NumericValue = %editc(ValueD23_23 :'K');
256150190527
256151190527               Endsl;
256152190527
256153190527           // 25
256154190527             When Precision =25;
256155190527             Select;
256156190527               When scale = 0;
256157190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256158190527                         :ValueD25_0  = DATA;
256159190527                 NumericValue = %editc(ValueD25_0 :'K');
256160190527
256161190527               When scale = 1;
256162190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256163190527                         :ValueD25_1  = DATA;
256164190527                 NumericValue = %editc(ValueD25_1 :'K');
256165190527
256166190527               When scale = 2;
256167190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256168190527                         :ValueD25_2  = DATA;
256169190527                 NumericValue = %editc(ValueD25_2 :'K');
256170190527
256171190527               When scale = 3;
256172190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256173190527                         :ValueD25_3  = DATA;
256174190527                 NumericValue = %editc(ValueD25_3 :'K');
256175190527
256176190527               When scale = 4;
256177190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256178190527                         :ValueD25_4  = DATA;
256179190527                 NumericValue = %editc(ValueD25_4 :'K');
256180190527
256181190527               When scale = 5;
256182190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256183190527                         :ValueD25_5  = DATA;
256184190527                 NumericValue = %editc(ValueD25_5 :'K');
256185190527
256186190527               When scale = 6;
256187190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256188190527                         :ValueD25_6  = DATA;
256189190527                 NumericValue = %editc(ValueD25_6 :'K');
256190190527
256191190527               When scale = 7;
256192190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256193190527                         :ValueD25_7  = DATA;
256194190527                 NumericValue = %editc(ValueD25_7 :'K');
256195190527
256196190527               When scale = 8;
256197190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256198190527                         :ValueD25_8  = DATA;
256199190527                 NumericValue = %editc(ValueD25_8 :'K');
256200190527
256201190527               When scale = 9;
256202190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256203190527                         :ValueD25_9  = DATA;
256204190527                 NumericValue = %editc(ValueD25_9 :'K');
256205190527
256206190527               When scale = 10;
256207190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256208190527                         :ValueD25_10  = DATA;
256209190527                 NumericValue = %editc(ValueD25_10 :'K');
256210190527
256211190527               When scale = 11;
256212190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256213190527                         :ValueD25_11  = DATA;
256214190527                 NumericValue = %editc(ValueD25_11 :'K');
256215190527
256216190527               When scale = 12;
256217190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256218190527                         :ValueD25_12  = DATA;
256219190527                 NumericValue = %editc(ValueD25_12 :'K');
256220190527
256221190527               When scale = 13;
256222190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256223190527                         :ValueD25_13  = DATA;
256224190527                 NumericValue = %editc(ValueD25_13 :'K');
256225190527
256226190527               When scale = 14;
256227190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256228190527                         :ValueD25_14  = DATA;
256229190527                 NumericValue = %editc(ValueD25_14 :'K');
256230190527
256231190527               When scale = 15;
256232190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256233190527                         :ValueD25_15  = DATA;
256234190527                 NumericValue = %editc(ValueD25_15 :'K');
256235190527
256236190527               When scale = 16;
256237190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256238190527                         :ValueD25_16  = DATA;
256239190527                 NumericValue = %editc(ValueD25_16 :'K');
256240190527
256241190527               When scale = 17;
256242190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256243190527                         :ValueD25_17  = DATA;
256244190527                 NumericValue = %editc(ValueD25_17 :'K');
256245190527
256246190527               When scale = 18;
256247190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256248190527                         :ValueD25_18  = DATA;
256249190527                 NumericValue = %editc(ValueD25_18 :'K');
256250190527
256251190527               When scale = 19;
256252190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256253190527                         :ValueD25_19  = DATA;
256254190527                 NumericValue = %editc(ValueD25_19 :'K');
256255190527
256256190527               When scale = 20;
256257190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256258190527                         :ValueD25_20  = DATA;
256259190527                 NumericValue = %editc(ValueD25_20 :'K');
256260190527
256261190527               When scale = 21;
256262190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256263190527                         :ValueD25_21  = DATA;
256264190527                 NumericValue = %editc(ValueD25_21 :'K');
256265190527
256266190527               When scale = 22;
256267190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256268190527                         :ValueD25_22  = DATA;
256269190527                 NumericValue = %editc(ValueD25_22 :'K');
256270190527
256271190527               When scale = 23;
256272190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256273190527                         :ValueD25_23  = DATA;
256274190527                 NumericValue = %editc(ValueD25_23 :'K');
256275190527
256276190527               When scale = 24;
256277190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256278190527                         :ValueD25_24  = DATA;
256279190527                 NumericValue = %editc(ValueD25_24 :'K');
256280190527
256281190527               When scale = 25;
256282190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256283190527                         :ValueD25_25  = DATA;
256284190527                 NumericValue = %editc(ValueD25_25 :'K');
256285190527
256286190527               Endsl;
256287190527
256288190527           // 27
256289190527             When Precision =27;
256290190527             Select;
256291190527               When scale = 0;
256292190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256293190527                         :ValueD27_0  = DATA;
256294190527                 NumericValue = %editc(ValueD27_0 :'K');
256295190527
256296190527               When scale = 1;
256297190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256298190527                         :ValueD27_1  = DATA;
256299190527                 NumericValue = %editc(ValueD27_1 :'K');
256300190527
256301190527               When scale = 2;
256302190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256303190527                         :ValueD27_2  = DATA;
256304190527                 NumericValue = %editc(ValueD27_2 :'K');
256305190527
256306190527               When scale = 3;
256307190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256308190527                         :ValueD27_3  = DATA;
256309190527                 NumericValue = %editc(ValueD27_3 :'K');
256310190527
256311190527               When scale = 4;
256312190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256313190527                         :ValueD27_4  = DATA;
256314190527                 NumericValue = %editc(ValueD27_4 :'K');
256315190527
256316190527               When scale = 5;
256317190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256318190527                         :ValueD27_5  = DATA;
256319190527                 NumericValue = %editc(ValueD27_5 :'K');
256320190527
256321190527               When scale = 6;
256322190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256323190527                         :ValueD27_6  = DATA;
256324190527                 NumericValue = %editc(ValueD27_6 :'K');
256325190527
256326190527               When scale = 7;
256327190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256328190527                         :ValueD27_7  = DATA;
256329190527                 NumericValue = %editc(ValueD27_7 :'K');
256330190527
256331190527               When scale = 8;
256332190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256333190527                         :ValueD27_8  = DATA;
256334190527                 NumericValue = %editc(ValueD27_8 :'K');
256335190527
256336190527               When scale = 9;
256337190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256338190527                         :ValueD27_9  = DATA;
256339190527                 NumericValue = %editc(ValueD27_9 :'K');
256340190527
256341190527               When scale = 10;
256342190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256343190527                         :ValueD27_10  = DATA;
256344190527                 NumericValue = %editc(ValueD27_10 :'K');
256345190527
256346190527               When scale = 11;
256347190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256348190527                         :ValueD27_11  = DATA;
256349190527                 NumericValue = %editc(ValueD27_11 :'K');
256350190527
256351190527               When scale = 12;
256352190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256353190527                         :ValueD27_12  = DATA;
256354190527                 NumericValue = %editc(ValueD27_12 :'K');
256355190527
256356190527               When scale = 13;
256357190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256358190527                         :ValueD27_13  = DATA;
256359190527                 NumericValue = %editc(ValueD27_13 :'K');
256360190527
256361190527               When scale = 14;
256362190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256363190527                         :ValueD27_14  = DATA;
256364190527                 NumericValue = %editc(ValueD27_14 :'K');
256365190527
256366190527               When scale = 15;
256367190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256368190527                         :ValueD27_15  = DATA;
256369190527                 NumericValue = %editc(ValueD27_15 :'K');
256370190527
256371190527               When scale = 16;
256372190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256373190527                         :ValueD27_16  = DATA;
256374190527                 NumericValue = %editc(ValueD27_16 :'K');
256375190527
256376190527               When scale = 17;
256377190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256378190527                         :ValueD27_17  = DATA;
256379190527                 NumericValue = %editc(ValueD27_17 :'K');
256380190527
256381190527               When scale = 18;
256382190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256383190527                         :ValueD27_18  = DATA;
256384190527                 NumericValue = %editc(ValueD27_18 :'K');
256385190527
256386190527               When scale = 19;
256387190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256388190527                         :ValueD27_19  = DATA;
256389190527                 NumericValue = %editc(ValueD27_19 :'K');
256390190527
256391190527               When scale = 20;
256392190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256393190527                         :ValueD27_20  = DATA;
256394190527                 NumericValue = %editc(ValueD27_20 :'K');
256395190527
256396190527               When scale = 21;
256397190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256398190527                         :ValueD27_21  = DATA;
256399190527                 NumericValue = %editc(ValueD27_21 :'K');
256400190527
256401190527               When scale = 22;
256402190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256403190527                         :ValueD27_22  = DATA;
256404190527                 NumericValue = %editc(ValueD27_22 :'K');
256405190527
256406190527               When scale = 23;
256407190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256408190527                         :ValueD27_23  = DATA;
256409190527                 NumericValue = %editc(ValueD27_23 :'K');
256410190527
256411190527               When scale = 24;
256412190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256413190527                         :ValueD27_24  = DATA;
256414190527                 NumericValue = %editc(ValueD27_24 :'K');
256415190527
256416190527               When scale = 25;
256417190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256418190527                         :ValueD27_25  = DATA;
256419190527                 NumericValue = %editc(ValueD27_25 :'K');
256420190527
256421190527               When scale = 26;
256422190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256423190527                         :ValueD27_26  = DATA;
256424190527                 NumericValue = %editc(ValueD27_26 :'K');
256425190527
256426190527               When scale = 27;
256427190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256428190527                         :ValueD27_27  = DATA;
256429190527                 NumericValue = %editc(ValueD27_27 :'K');
256430190527
256431190527               Endsl;
256432190527
256433190527           // 29
256434190527             When Precision =29;
256435190527             Select;
256436190527               When scale = 0;
256437190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256438190527                         :ValueD29_0  = DATA;
256439190527                 NumericValue = %editc(ValueD29_0 :'K');
256440190527
256441190527               When scale = 1;
256442190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256443190527                         :ValueD29_1  = DATA;
256444190527                 NumericValue = %editc(ValueD29_1 :'K');
256445190527
256446190527               When scale = 2;
256447190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256448190527                         :ValueD29_2  = DATA;
256449190527                 NumericValue = %editc(ValueD29_2 :'K');
256450190527
256451190527               When scale = 3;
256452190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256453190527                         :ValueD29_3  = DATA;
256454190527                 NumericValue = %editc(ValueD29_3 :'K');
256455190527
256456190527               When scale = 4;
256457190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256458190527                         :ValueD29_4  = DATA;
256459190527                 NumericValue = %editc(ValueD29_4 :'K');
256460190527
256461190527               When scale = 5;
256462190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256463190527                         :ValueD29_5  = DATA;
256464190527                 NumericValue = %editc(ValueD29_5 :'K');
256465190527
256466190527               When scale = 6;
256467190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256468190527                         :ValueD29_6  = DATA;
256469190527                 NumericValue = %editc(ValueD29_6 :'K');
256470190527
256471190527               When scale = 7;
256472190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256473190527                         :ValueD29_7  = DATA;
256474190527                 NumericValue = %editc(ValueD29_7 :'K');
256475190527
256476190527               When scale = 8;
256477190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256478190527                         :ValueD29_8  = DATA;
256479190527                 NumericValue = %editc(ValueD29_8 :'K');
256480190527
256481190527               When scale = 9;
256482190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256483190527                         :ValueD29_9  = DATA;
256484190527                 NumericValue = %editc(ValueD29_9 :'K');
256485190527
256486190527               When scale = 10;
256487190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256488190527                         :ValueD29_10  = DATA;
256489190527                 NumericValue = %editc(ValueD29_10 :'K');
256490190527
256491190527               When scale = 11;
256492190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256493190527                         :ValueD29_11  = DATA;
256494190527                 NumericValue = %editc(ValueD29_11 :'K');
256495190527
256496190527               When scale = 12;
256497190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256498190527                         :ValueD29_12  = DATA;
256499190527                 NumericValue = %editc(ValueD29_12 :'K');
256500190527
256501190527               When scale = 13;
256502190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256503190527                         :ValueD29_13  = DATA;
256504190527                 NumericValue = %editc(ValueD29_13 :'K');
256505190527
256506190527               When scale = 14;
256507190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256508190527                         :ValueD29_14  = DATA;
256509190527                 NumericValue = %editc(ValueD29_14 :'K');
256510190527
256511190527               When scale = 15;
256512190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256513190527                         :ValueD29_15  = DATA;
256514190527                 NumericValue = %editc(ValueD29_15 :'K');
256515190527
256516190527               When scale = 16;
256517190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256518190527                         :ValueD29_16  = DATA;
256519190527                 NumericValue = %editc(ValueD29_16 :'K');
256520190527
256521190527               When scale = 17;
256522190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256523190527                         :ValueD29_17  = DATA;
256524190527                 NumericValue = %editc(ValueD29_17 :'K');
256525190527
256526190527               When scale = 18;
256527190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256528190527                         :ValueD29_18  = DATA;
256529190527                 NumericValue = %editc(ValueD29_18 :'K');
256530190527
256531190527               When scale = 19;
256532190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256533190527                         :ValueD29_19  = DATA;
256534190527                 NumericValue = %editc(ValueD29_19 :'K');
256535190527
256536190527               When scale = 20;
256537190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256538190527                         :ValueD29_20  = DATA;
256539190527                 NumericValue = %editc(ValueD29_20 :'K');
256540190527
256541190527               When scale = 21;
256542190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256543190527                         :ValueD29_21  = DATA;
256544190527                 NumericValue = %editc(ValueD29_21 :'K');
256545190527
256546190527               When scale = 22;
256547190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256548190527                         :ValueD29_22  = DATA;
256549190527                 NumericValue = %editc(ValueD29_22 :'K');
256550190527
256551190527               When scale = 23;
256552190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256553190527                         :ValueD29_23  = DATA;
256554190527                 NumericValue = %editc(ValueD29_23 :'K');
256555190527
256556190527               When scale = 24;
256557190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256558190527                         :ValueD29_24  = DATA;
256559190527                 NumericValue = %editc(ValueD29_24 :'K');
256560190527
256561190527               When scale = 25;
256562190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256563190527                         :ValueD29_25  = DATA;
256564190527                 NumericValue = %editc(ValueD29_25 :'K');
256565190527
256566190527               When scale = 26;
256567190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256568190527                         :ValueD29_26  = DATA;
256569190527                 NumericValue = %editc(ValueD29_26 :'K');
256570190527
256571190527               When scale = 27;
256572190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256573190527                         :ValueD29_27  = DATA;
256574190527                 NumericValue = %editc(ValueD29_27 :'K');
256575190527
256576190527               When scale = 28;
256577190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256578190527                         :ValueD29_28  = DATA;
256579190527                 NumericValue = %editc(ValueD29_28 :'K');
256580190527
256581190527               When scale = 29;
256582190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256583190527                         :ValueD29_29  = DATA;
256584190527                 NumericValue = %editc(ValueD29_29 :'K');
256585190527
256586190527               Endsl;
256587190527
256588190527           // 31
256589190527             When Precision =31;
256590190527             Select;
256591190527               When scale = 0;
256592190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256593190527                         :ValueD31_0  = DATA;
256594190527                 NumericValue = %editc(ValueD31_0 :'K');
256595190526
256596190527               When scale = 1;
256597190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256598190526                         :ValueD31_1  = DATA;
256599190526                 NumericValue = %editc(ValueD31_1 :'K');
256600190526
256601190527               When scale = 2;
256602190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256603190526                         :ValueD31_2  = DATA;
256604190526                 NumericValue = %editc(ValueD31_2 :'K');
256605190526
256606190527               When scale = 3;
256607190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256608190526                         :ValueD31_3  = DATA;
256609190526                 NumericValue = %editc(ValueD31_3 :'K');
256610190526
256611190527               When scale = 4;
256612190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256613190526                         :ValueD31_4  = DATA;
256614190526                 NumericValue = %editc(ValueD31_4 :'K');
256615190526
256616190527               When scale = 5;
256617190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256618190526                         :ValueD31_5  = DATA;
256619190526                 NumericValue = %editc(ValueD31_5 :'K');
256620190526
256621190527               When scale = 6;
256622190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256623190526                         :ValueD31_6  = DATA;
256624190526                 NumericValue = %editc(ValueD31_6 :'K');
256625190526
256626190527               When scale = 7;
256627190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256628190526                         :ValueD31_7  = DATA;
256629190526                 NumericValue = %editc(ValueD31_7 :'K');
256630190526
256631190527               When scale = 8;
256632190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256633190526                         :ValueD31_8  = DATA;
256634190526                 NumericValue = %editc(ValueD31_8 :'K');
256635190526
256636190527               When scale = 9;
256637190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256638190526                         :ValueD31_9  = DATA;
256639190526                 NumericValue = %editc(ValueD31_9 :'K');
256640190526
256641190527               When scale = 10;
256642190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256643190526                         :ValueD31_10  = DATA;
256644190526                 NumericValue = %editc(ValueD31_10 :'K');
256645190526
256646190527               When scale = 11;
256647190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256648190526                         :ValueD31_11  = DATA;
256649190526                 NumericValue = %editc(ValueD31_11 :'K');
256650190526
256651190527               When scale = 12;
256652190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256653190526                         :ValueD31_12  = DATA;
256654190526                 NumericValue = %editc(ValueD31_12 :'K');
256655190526
256656190527               When scale = 13;
256657190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256658190526                         :ValueD31_13  = DATA;
256659190526                 NumericValue = %editc(ValueD31_13 :'K');
256660190526
256661190527               When scale = 14;
256662190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256663190526                         :ValueD31_14  = DATA;
256664190526                 NumericValue = %editc(ValueD31_14 :'K');
256665190526
256666190527               When scale = 15;
256667190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256668190526                         :ValueD31_15  = DATA;
256669190526                 NumericValue = %editc(ValueD31_15 :'K');
256670190526
256671190527               When scale = 16;
256672190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256673190526                         :ValueD31_16  = DATA;
256674190526                 NumericValue = %editc(ValueD31_16 :'K');
256675190526
256676190527               When scale = 17;
256677190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256678190526                         :ValueD31_17  = DATA;
256679190526                 NumericValue = %editc(ValueD31_17 :'K');
256680190526
256681190527               When scale = 18;
256682190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256683190526                         :ValueD31_18  = DATA;
256684190526                 NumericValue = %editc(ValueD31_18 :'K');
256685190526
256686190527               When scale = 19;
256687190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256688190526                         :ValueD31_19  = DATA;
256689190526                 NumericValue = %editc(ValueD31_19 :'K');
256690190526
256691190527               When scale = 20;
256692190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256693190526                         :ValueD31_20  = DATA;
256694190526                 NumericValue = %editc(ValueD31_20 :'K');
256695190526
256696190527               When scale = 21;
256697190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256698190526                         :ValueD31_21  = DATA;
256699190526                 NumericValue = %editc(ValueD31_21 :'K');
256700190526
256701190527               When scale = 22;
256702190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256703190526                         :ValueD31_22  = DATA;
256704190526                 NumericValue = %editc(ValueD31_22 :'K');
256705190526
256706190527               When scale = 23;
256707190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256708190526                         :ValueD31_23  = DATA;
256709190526                 NumericValue = %editc(ValueD31_23 :'K');
256710190526
256711190527               When scale = 24;
256712190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256713190526                         :ValueD31_24  = DATA;
256714190526                 NumericValue = %editc(ValueD31_24 :'K');
256715190526
256716190527               When scale = 25;
256717190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256718190526                         :ValueD31_25  = DATA;
256719190526                 NumericValue = %editc(ValueD31_25 :'K');
256720190526
256721190527               When scale = 26;
256722190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256723190526                         :ValueD31_26  = DATA;
256724190526                 NumericValue = %editc(ValueD31_26 :'K');
256725190526
256726190527               When scale = 27;
256727190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256728190526                         :ValueD31_27  = DATA;
256729190526                 NumericValue = %editc(ValueD31_27 :'K');
256730190526
256731190527               When scale = 28;
256732190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256733190526                         :ValueD31_28  = DATA;
256734190526                 NumericValue = %editc(ValueD31_28 :'K');
256735190526
256736190527               When scale = 29;
256737190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256738190526                         :ValueD31_29  = DATA;
256739190526                 NumericValue = %editc(ValueD31_29 :'K');
256740190526
256741190527               When scale = 30;
256742190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256743190526                         :ValueD31_30  = DATA;
256744190526                 NumericValue = %editc(ValueD31_30 :'K');
256745190526
256746190527               When scale = 31;
256747190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
256748190526                         :ValueD31_31  = DATA;
256749190526                 NumericValue = %editc(ValueD31_31 :'K');
256750190527               Endsl;
256751190526
256752151101               Other;
256753190526                 NumericValue = 'Length=' + %char(Length) +
256754190527                   ' Precision=' + %char(Precision) +
256755190527                   ' Scale=' + %Char(Scale);
256756151101
256757190527             Endsl;
256758151031       ENDSR;
256759151031
256760151101
256761151101       //************************************************************************
256800151101       // Subroutine = $BigInt - Get big integer
256900151101       //************************************************************************
257000151101       Begsr $BigInt;
257100151101
257200151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
257300151101                         :BigInt = DATA;
257400151101                 BigIntNumeric = BigInt;
257500151101                 NumericValue = %editc(BigIntNumeric:'K');
257600151101
257700151101       ENDSR;
257800151101
257900151101       //************************************************************************
258000151101       // Subroutine = $SmallInt - Get small integer
258100151101       //************************************************************************
258200151101       Begsr $SmallInt;
258300151101
258400151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
258500151101                         :SmallInt = DATA;
258600151101                 BigIntNumeric = SmallInt;
258700151101                 NumericValue = %editc(BigIntNumeric:'K');
258800151101
258900151101       ENDSR;
258901190526
258902190526       //************************************************************************
258903190526       // Subroutine = $Float - Get floating decimal
258904190526       //************************************************************************
258905190526       Begsr $Float;
258906190526
258907190526                 exec sql GET DESCRIPTOR 'Values' VALUE :x
258908190526                         :Float = DATA;
258910190526                 NumericValue = %char(Float);
258911190526
258912190526       ENDSR;
259012190527
259024190527
259025190527       //************************************************************************
259026190527       // Subroutine = $DateTime - Get Date Time
259027190527       //************************************************************************
259028190527       Begsr $DateTime;
259029190527
259030190527               Select;
259031190527
259032190527               When Length = 8;
259033190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
259034190527                         :DateValue = DATA;
259035190527                 NumericValue = %char(DateValue);
259036190527
259037190527               When Length = 26;
259038190527                 exec sql GET DESCRIPTOR 'Values' VALUE :x
259039190527                         :TimeStampValue = DATA;
259040190527                 NumericValue = %char(%subdt(TimeStampValue:*M)) + '/' +
259041190527                                %char(%subdt(TimeStampValue:*D)) + '/' +
259042190527                                %char(%subdt(TimeStampValue:*Y)) + ' ' +
259043190527                                %char(%subdt(TimeStampValue:*H)) + ':' +
259044190527                                %char(%subdt(TimeStampValue:*MN)) + ':' +
259045190527                                %char(%subdt(TimeStampValue:*S));
259046190527
259047190527               Other;
259048190527                 NumericValue = 'Type=Date Length=' + %char(Length) +
259049190527                   ' Precision=' + %char(Precision) +
259050190527                   ' Scale=' + %Char(Scale);
259051190527
259052190527               Endsl;
259053190527
259054190527       ENDSR;
259055190526
259100170604       //************************************************************************
259200170604       // Subroutine = $LogSQL - Log the SQL statement
259300170604       //************************************************************************
259400170604       Begsr $LogSQL;
259500170604
259600170604            Clear SQLLOGR;
259700170604            SQState = SQLStatement;
259800170604            SQUSER = dsuser;
259900170604            If 1 = 2;
260000170604              write sqllogr;
260100170604            Endif;
260200170604
260300170604       ENDSR;
260400151101
260500151101       //************************************************************************
260600151101       // Subroutine = $Int - Get integer
260700151101       //************************************************************************
260800151101       Begsr $Int;
260900151101
261000151101                 exec sql GET DESCRIPTOR 'Values' VALUE :x
261100151101                         :Int = DATA;
261200151101                 BigIntNumeric = Int;
261300151101                 NumericValue = %editc(BigIntNumeric:'K');
261400151101
261500151101       ENDSR;
261600151101
261700171027      //create the ifs file
261800171027       BegSr BuildIfsFile;
261900171027
262000171027              ifsFileName = '/www/zendsvr6/htdocs/Charts/' +
262100171027                            %trim(widbuser) + %trim(widbname) + '.html';
262200171027              widbFile = ifsFileName;
262300171027
262400171027              FileDescr=open64(%trimr(ifsFileName)
262500171027                            : O_CREAT + O_trunc + O_CODEPAGE + o_wronly
262600171027                            : M_RWX
262700171027                            : CP_ISO8859_1
262800171027                            );
262900171027
263000171027              If FileDescr = -1;
263100171027                 Return;
263200171027              EndIf;
263300171027
263400171027              RC = close(FileDescr);
263500171027              If RC = -1;
263600171027                 Return;
263700171027              EndIf;
263800171027
263900171027              FileDescr=open64(%trimr(ifsFileName)
264000171027                            :O_wronly + O_TEXTDATA
264100171027                            );
264200171027
264300171027              If FileDescr = -1;
264400171027                 Return;
264500171027              EndIf;
264600171027
264700171027       EndSr;
