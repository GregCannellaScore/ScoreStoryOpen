000100151105      /copy qcpylesrc,stdhspec
000101151105      //****************************************************************
000102151105      //                                                               *
000103151105      // Program ID...... DSH0120R                                     *
000104151105      // Program Desc.... Create a dashboard Chart                     *
000105151105      // Request Number..                                              *
000106151105      //                                                               *
000107151105      // Written By...... Greg Cannella                                *
000108151105      // Date Written.... 11/5/15                                      *
000109151105      //                                                               *
000110151105      // Comments........                                              *
000111151105      //                                                               *
000112151105      //                                                               *
000113151105      //****************************************************************
000114151105      // Compile Options:                                              *
000115151105      //                                                               *
000116151105      //****************************************************************
000117151105      // Modifications:                                                *
000118151105      // Req#  By   Date      Modification                             *
000119151105      // 1234  xxx  xx/xx/xx                                           *
000120151105      //                                                               *
000121151105      //****************************************************************
000157151105       dcl-f htmlbdm usage(*input) keyed;
000159151106       dcl-f dshchtm usage(*input) keyed;
000160151108       dcl-f dsh0120w usage(*output);
000163151105
000164151105       //--Entry Prototype
000165151105       dcl-pr DSH0120R  extpgm('DSH0120R');
000166151105         wichart char(20);
000167170524         widbuser char(10);
000168170524         widbparm char(200);
000169151106       //widbbody char(32000);
000170151105       end-pr;
000171151105       dcl-pi DSH0120R;
000172151105         wichart char(20);
000173170524         widbuser char(10);
000174170524         widbparm char(200);
000175151106       //widbbody char(32000);
000176151105       end-pi;
000177151106
000178151106       // Declare fields
000179170523       dcl-s widbbody char(32000);
000180151106       dcl-s SubValue char(32000);
000181151106       dcl-s SubData char(32000);
000182151106       dcl-s SubHeadings char(32000);
000183151106       dcl-s SQLStatement char(2000);
000184151106       dcl-s x int(5);
000185151106       dcl-s TotalColumns int(5);
000186151106       dcl-s ColumnType char(1) dim(200);
000187151106       dcl-s Type int(5) ;
000188151106       dcl-s Length int(5) ;
000189151106       dcl-s Result_Ind int(5) ;
000190151106       dcl-s Precision int(5) ;
000191151106       dcl-s Scale int(5) ;
000192151106       dcl-s NumericValue char(20);
000193151106       dcl-s BigInt int(20);
000194151106       dcl-s Int int(10);
000195151106       dcl-s SmallInt int(5);
000196151106       dcl-s BigIntNumeric packed(15:0);
000197151107       dcl-s First char(1);
000198151107       dcl-s Second char(1);
000199170404       dcl-s NewDate date;
000200151106
000201170524            // Incomming Parms
000202170524     D IncommingParms  ds           200
000203170524     D   PMCust                1      7  0
000204170524     D   PMVendor              8     12  0
000205170524     D   PMStyle              13     26
000206170524     D   PMStyle10            27     36
000207170524     D   PMCorp               37     41  0
000208170524     D   PMCategory           42     51
000209170524     D   PMSls                52     54  0
000210170524     D   PMBuyer              55     57  0
000211170524     D   PMRegion             58     58
000212170524     D   PMFromDate           59     65  0
000213170524     D   PMToDate             66     72  0
000214170524
000215151106       // Declare all variations of fields
000216151106     D  ValueA         ds           100
000217151106     D   ValueA1               1      1
000218151106     D   ValueA2               1      2
000219151106     D   ValueA3               1      3
000220151106     D   ValueA4               1      4
000221151106     D   ValueA5               1      5
000222151106     D   ValueA6               1      6
000223151106     D   ValueA7               1      7
000224151106     D   ValueA8               1      8
000225151106     D   ValueA9               1      9
000226151106     D   ValueA10              1     10
000227151106     D   ValueA11              1     11
000228151106     D   ValueA12              1     12
000229151106     D   ValueA13              1     13
000230151106     D   ValueA14              1     14
000231151106     D   ValueA15              1     15
000232151106     D   ValueA16              1     16
000233151106     D   ValueA17              1     17
000234151106     D   ValueA18              1     18
000235151106     D   ValueA19              1     19
000236151106     D   ValueA20              1     20
000237151106     D   ValueA21              1     21
000238151106     D   ValueA22              1     22
000239151106     D   ValueA23              1     23
000240151106     D   ValueA24              1     24
000241151106     D   ValueA25              1     25
000242151106     D   ValueA26              1     26
000243151106     D   ValueA27              1     27
000244151106     D   ValueA28              1     28
000245151106     D   ValueA29              1     29
000246151106     D   ValueA30              1     30
000247151106     D   ValueA31              1     31
000248151106     D   ValueA32              1     32
000249151106     D   ValueA33              1     33
000250151106     D   ValueA34              1     34
000251151106     D   ValueA35              1     35
000252151106     D   ValueA36              1     36
000253151106     D   ValueA37              1     37
000254151106     D   ValueA38              1     38
000255151106     D   ValueA39              1     39
000256151106     D   ValueA40              1     40
000257151106     D   ValueA41              1     41
000258151106     D   ValueA42              1     42
000259151106     D   ValueA43              1     43
000260151106     D   ValueA44              1     44
000261151106     D   ValueA45              1     45
000262151106     D   ValueA46              1     46
000263151106     D   ValueA47              1     47
000264151106     D   ValueA48              1     48
000265151106     D   ValueA49              1     49
000266151106     D   ValueA50              1     50
000267151106     D   ValueA51              1     51
000268151106     D   ValueA52              1     52
000269151106     D   ValueA53              1     53
000270151106     D   ValueA54              1     54
000271151106     D   ValueA55              1     55
000272151106     D   ValueA56              1     56
000273151106     D   ValueA57              1     57
000274151106     D   ValueA58              1     58
000275151106     D   ValueA59              1     59
000276151106     D   ValueA60              1     60
000277151106     D   ValueA61              1     61
000278151106     D   ValueA62              1     62
000279151106     D   ValueA63              1     63
000280151106     D   ValueA64              1     64
000281151106     D   ValueA65              1     65
000282151106     D   ValueA66              1     66
000283151106     D   ValueA67              1     67
000284151106     D   ValueA68              1     68
000285151106     D   ValueA69              1     69
000286151106     D   ValueA70              1     70
000287151106     D   ValueA71              1     71
000288151106     D   ValueA72              1     72
000289151106     D   ValueA73              1     73
000290151106     D   ValueA74              1     74
000291151106     D   ValueA75              1     75
000292151106     D   ValueA76              1     76
000293151106     D   ValueA77              1     77
000294151106     D   ValueA78              1     78
000295151106     D   ValueA79              1     79
000296151106     D   ValueA80              1     80
000297151106     D   ValueA81              1     81
000298151106     D   ValueA82              1     82
000299151106     D   ValueA83              1     83
000300151106     D   ValueA84              1     84
000301151106     D   ValueA85              1     85
000302151106     D   ValueA86              1     86
000303151106     D   ValueA87              1     87
000304151106     D   ValueA88              1     88
000305151106     D   ValueA89              1     89
000306151106     D   ValueA90              1     90
000307151106     D   ValueA91              1     91
000308151106     D   ValueA92              1     92
000309151106     D   ValueA93              1     93
000310151106     D   ValueA94              1     94
000311151106     D   ValueA95              1     95
000312151106     D   ValueA96              1     96
000313151106     D   ValueA97              1     97
000314151106     D   ValueA98              1     98
000315151106     D   ValueA99              1     99
000316151106     D   ValueA100             1    100
000317151106
000318151106     D  ValueN         DS            15
000319151106     D   ValueN1_0             1      1  0 inz(0)
000320151106     D   ValueN1_1             1      1  1 inz(.0)
000321151106     D   ValueN2_0             1      2  0 inz(0)
000322151106     D   ValueN2_1             1      2  1 inz(0)
000323151106     D   ValueN2_2             1      2  2 inz(.0)
000324151106     D   ValueN3_0             1      3  0 inz(0)
000325151106     D   ValueN3_1             1      3  1 inz(0)
000326151106     D   ValueN3_2             1      3  2 inz(0)
000327151106     D   ValueN3_3             1      3  3 inz(.0)
000328151106     D   ValueN4_0             1      4  0 inz(0)
000329151106     D   ValueN4_1             1      4  1 inz(0)
000330151106     D   ValueN4_2             1      4  2 inz(0)
000331151106     D   ValueN4_3             1      4  3 inz(0)
000332151106     D   ValueN4_4             1      4  4 inz(.0)
000333151106     D   ValueN5_0             1      5  0 inz(0)
000334151106     D   ValueN5_1             1      5  1 inz(0)
000335151106     D   ValueN5_2             1      5  2 inz(0)
000336151106     D   ValueN5_3             1      5  3 inz(0)
000337151106     D   ValueN5_4             1      5  4 inz(0)
000338151106     D   ValueN6_0             1      6  0 inz(0)
000339151106     D   ValueN6_1             1      6  1 inz(0)
000340151106     D   ValueN6_2             1      6  2 inz(0)
000341151106     D   ValueN6_3             1      6  3 inz(0)
000342151106     D   ValueN6_4             1      6  4 inz(0)
000343151106     D   ValueN7_0             1      7  0 inz(0)
000344151106     D   ValueN7_1             1      7  1 inz(0)
000345151106     D   ValueN7_2             1      7  2 inz(0)
000346151106     D   ValueN7_3             1      7  3 inz(0)
000347151106     D   ValueN7_4             1      7  4 inz(0)
000348151106     D   ValueN8_0             1      8  0 inz(0)
000349151106     D   ValueN8_1             1      8  1 inz(0)
000350151106     D   ValueN8_2             1      8  2 inz(0)
000351151106     D   ValueN8_3             1      8  3 inz(0)
000352151106     D   ValueN8_4             1      8  4 inz(0)
000353151106     D   ValueN9_0             1      9  0 inz(0)
000354151106     D   ValueN9_1             1      9  1 inz(0)
000355151106     D   ValueN9_2             1      9  2 inz(0)
000356151106     D   ValueN9_3             1      9  3 inz(0)
000357151106     D   ValueN9_4             1      9  4 inz(0)
000358151106     D   ValueN10_0            1     10  0 inz(0)
000359151106     D   ValueN10_1            1     10  1 inz(0)
000360151106     D   ValueN10_2            1     10  2 inz(0)
000361151106     D   ValueN10_3            1     10  3 inz(0)
000362151106     D   ValueN10_4            1     10  4 inz(0)
000363151106     D   ValueN11_0            1     11  0 inz(0)
000364151106     D   ValueN11_1            1     11  1 inz(0)
000365151106     D   ValueN11_2            1     11  2 inz(0)
000366151106     D   ValueN11_3            1     11  3 inz(0)
000367151106     D   ValueN11_4            1     11  4 inz(0)
000368151106     D   ValueN12_0            1     12  0 inz(0)
000369151106     D   ValueN12_1            1     12  1 inz(0)
000370151106     D   ValueN12_2            1     12  2 inz(0)
000371151106     D   ValueN12_3            1     12  3 inz(0)
000372151106     D   ValueN12_4            1     12  4 inz(0)
000373151106     D   ValueN13_0            1     13  0 inz(0)
000374151106     D   ValueN13_1            1     13  1 inz(0)
000375151106     D   ValueN13_2            1     13  2 inz(0)
000376151106     D   ValueN13_3            1     13  3 inz(0)
000377151106     D   ValueN13_4            1     13  4 inz(0)
000378151106     D   ValueN14_0            1     14  0 inz(0)
000379151106     D   ValueN14_1            1     14  1 inz(0)
000380151106     D   ValueN14_2            1     14  2 inz(0)
000381151106     D   ValueN14_3            1     14  3 inz(0)
000382151106     D   ValueN14_4            1     14  4 inz(0)
000383151106     D   ValueN15_0            1     15  0 inz(0)
000384151106     D   ValueN15_1            1     15  1 inz(0)
000385151106     D   ValueN15_2            1     15  2 inz(0)
000386151106     D   ValueN15_3            1     15  3 inz(0)
000387151106     D   ValueN15_4            1     15  4 inz(0)
000388151106
000389151106     D   ValueD1_0     s              1P 0 inz(0)
000390151106     D   ValueD1_1     s              1P 1 inz(.0)
000391151106     D   ValueD3_0     s              3P 0 inz(0)
000392151106     D   ValueD3_1     s              3P 1 inz(0)
000393151106     D   ValueD3_2     s              3P 2 inz(0)
000394151106     D   ValueD3_3     s              3P 3 inz(.0)
000395151106     D   ValueD5_0     s              5P 0 inz(0)
000396151106     D   ValueD5_1     s              5P 1 inz(0)
000397151106     D   ValueD5_2     s              5P 2 inz(0)
000398151106     D   ValueD5_3     s              5P 3 inz(0)
000399151106     D   ValueD5_4     s              5P 4 inz(0)
000400151106     D   ValueD5_5     s              5P 5 inz(.0)
000401151106     D   ValueD7_0     s              7P 0 inz(0)
000402151106     D   ValueD7_1     s              7P 1 inz(0)
000403151106     D   ValueD7_2     s              7P 2 inz(0)
000404151106     D   ValueD7_3     s              7P 3 inz(0)
000405151106     D   ValueD7_4     s              7P 4 inz(0)
000406151106     D   ValueD7_5     s              7P 5 inz(0)
000407151106     D   ValueD7_6     s              7P 6 inz(0)
000408151106     D   ValueD7_7     s              7P 7 inz(.0)
000409151106     D   ValueD9_0     s              9P 0 inz(0)
000410151106     D   ValueD9_1     s              9P 1 inz(0)
000411151106     D   ValueD9_2     s              9P 2 inz(0)
000412151106     D   ValueD9_3     s              9P 3 inz(0)
000413151106     D   ValueD9_4     s              9P 4 inz(0)
000414151106     D   ValueD9_5     s              9P 5 inz(0)
000415151106     D   ValueD9_6     s              9P 6 inz(0)
000416151106     D   ValueD9_7     s              9P 7 inz(0)
000417151106     D   ValueD9_8     s              9P 8 inz(0)
000418151106     D   ValueD9_9     s              9P 9 inz(.0)
000419151106     D   ValueD11_0    s             11P 0 inz(0)
000420151106     D   ValueD11_1    s             11P 1 inz(0)
000421151106     D   ValueD11_2    s             11P 2 inz(0)
000422151106     D   ValueD11_3    s             11P 3 inz(0)
000423151106     D   ValueD11_4    s             11P 4 inz(0)
000424151106     D   ValueD11_5    s             11P 5 inz(0)
000425151106     D   ValueD11_6    s             11P 6 inz(0)
000426151106     D   ValueD11_7    s             11P 7 inz(0)
000427151106     D   ValueD11_8    s             11P 8 inz(0)
000428151106     D   ValueD11_9    s             11P 9 inz(0)
000429151106     D   ValueD11_10   s             11P10 inz(0)
000430151106     D   ValueD11_11   s             11P11 inz(.0)
000431151106     D   ValueD13_0    s             13P 0 inz(0)
000432151106     D   ValueD13_1    s             13P 1 inz(0)
000433151106     D   ValueD13_2    s             13P 2 inz(0)
000434151106     D   ValueD13_3    s             13P 3 inz(0)
000435151106     D   ValueD13_4    s             13P 4 inz(0)
000436151106     D   ValueD13_5    s             13P 5 inz(0)
000437151106     D   ValueD13_6    s             13P 6 inz(0)
000438151106     D   ValueD13_7    s             13P 7 inz(0)
000439151106     D   ValueD13_8    s             13P 8 inz(0)
000440151106     D   ValueD13_9    s             13P 9 inz(0)
000441151106     D   ValueD13_10   s             13P10 inz(0)
000442151106     D   ValueD13_11   s             13P11 inz(0)
000443151106     D   ValueD13_12   s             13P12 inz(0)
000444151106     D   ValueD13_13   s             13P13 inz(.0)
000445151106     D   ValueD15_0    s             15P 0 inz(0)
000446151106     D   ValueD15_1    s             15P 1 inz(0)
000447151106     D   ValueD15_2    s             15P 2 inz(0)
000448151106     D   ValueD15_3    s             15P 3 inz(0)
000449151106     D   ValueD15_4    s             15P 4 inz(0)
000450151106     D   ValueD15_5    s             15P 5 inz(0)
000451151106     D   ValueD15_6    s             15P 6 inz(0)
000452151106     D   ValueD15_7    s             15P 7 inz(0)
000453151106     D   ValueD15_8    s             15P 8 inz(0)
000454151106     D   ValueD15_9    s             15P 9 inz(0)
000455151106     D   ValueD15_10   s             15P10 inz(0)
000456151106     D   ValueD15_11   s             15P11 inz(0)
000457151106     D   ValueD15_12   s             15P12 inz(0)
000458151106     D   ValueD15_13   s             15P13 inz(0)
000459151106     D   ValueD15_14   s             15P14 inz(0)
000460151106     D   ValueD15_15   s             15P15 inz(.0)
000461151106     D
000462151106     D
000463151106
000464151106     D*      SQL DESCRIPTOR AREA
000465151106     D  SQLDA          DS
000466151106     D  SQLDAID                       8A
000467151106     D  SQLDABC                      10I 0
000468151106     D  SQLN                          5I 0
000469151106     D  SQLD                          5I 0
000470151106     D  SQL_VAR                      80A   DIM(SQL_NUM)
000471151106     D                        33     48*
000472151106     D                        49     64*
000473151106     D*
000474151106     D SQLVAR          DS
000475151106     D  SQLTYPE                       5I 0
000476151106     D  SQLLEN                        5I 0
000477151106     D  SQLRES                       12A
000478151106     D  SQLINFO1                     16A
000479151106     D   SQLDATA                       *   OVERLAY(SQLINFO1:1)
000480151106     D   SQL_RESULT_SET_LOCATOR...
000481151106     D                               20I 0 OVERLAY(SQLINFO1:1)
000482151106     D  SQLINFO2                     16A
000483151106     D   SQLIND                        *   OVERLAY(SQLINFO2:1)
000484151106     D   SQL_ROW_CHANGE...
000485151106     D                               10I 0 OVERLAY(SQLINFO2:1)
000486151106     D   SQL_RESULT_SET_ROWS...
000487151106     D                               10I 0 OVERLAY(SQLINFO2:1)
000488151106     D  SQLNAMELEN                    5I 0
000489151106     D  SQLNAME                      30A
000490151106     D*  END OF SQLDA
000491151106     D*  EXTENDED SQLDA
000492151106     D SQLVAR2         DS
000493151106     D  SQLLONGL               1      4I 0
000494151106     D  SQLRSVDL               5     32A
000495151106     D  SQLDATAL              33     48*
000496151106     D  SQLTNAMELN            49     50I 0
000497151106     D  SQLTNAME              51     80A
000498151106     D*  END OF EXTENDED SQLDA
000499151106
000500151106     D SQL_NUM         C                    const(200)
000501151106
000502151106
000503151106       //-- Mainline
000504170524       IncommingParms = widbparm;
000505170524
000506151105       dcchart = wichart;
000507151105       Chain dcchart dshchtm;
000508151105       If %found;
000509151105         hxbodyname = dchtml;
000510151105         Chain hxbodyname htmlbdm;
000511151105         If %found;
000512151105           widbbody = hxbody;
000513151105           // Move in subs
000514151106           widbbody = %scanrpl('%SUB-TITLE':%trim(dctitle):widbbody);
000515151106           widbbody = %scanrpl('%SUB-PACKAGE':%trim(dcpackage):widbbody);
000516151106           widbbody = %scanrpl('%SUB-WIDTH':%trim(%char(dcwidth)):widbbody);
000517151106           widbbody = %scanrpl('%SUB-HEIGHT':%trim(%char(dcheight)):widbbody);
000518151107           widbbody = %scanrpl('%SUB-TYPE':%trim(dctype):widbbody);
000519151108           widbbody = %scanrpl('%SUB-VAXIS':%trim(dcvaxis):widbbody);
000520151108           widbbody = %scanrpl('%SUB-HAXIS':%trim(dchaxis):widbbody);
000521151105
000522151105           // Run SQL and fill in headings and data
000523151106           Exsr $SQLTable;
000524151105
000525151107           widbbody = %scanrpl('%SUB-HEADINGS':%trim(SubHeadings):widbbody);
000526151107           widbbody = %scanrpl('%SUB-DATA':%trim(SubData):widbbody);
000527151108           ChartBody = widbbody;
000528151108           Write dsh0120wr;
000529151108
000530151105         ENDIF;
000531151105       ENDIF;
000532151106
000533151106       *inlr = *on;
000534151105
000535151106       //************************************************************************
000536151106       // Subroutine = $SQLTable
000537151106       //************************************************************************
000538151106       Begsr $SQLTable;
000539151106
000540170524         SQLStatement = dcsql;
000541170524         SQLN = 100;
000543170524
000548170524         // Replace any variables in the sql statements
000549170524         SQLStatement = %scanrpl(':widbuser':
000550170524             %trimr(widbuser):SQLStatement);
000553170524         SQLStatement = %scanrpl(':pmcust':
000554170524             %trimr(%char(pmcust)):SQLStatement);
000555170524         SQLStatement = %scanrpl(':pmvendor':
000556170524             %trimr(%char(pmvendor)):SQLStatement);
000557170524         SQLStatement = %scanrpl(':pmstyle':
000558170524             %trimr(pmstyle):SQLStatement);
000559170524         SQLStatement = %scanrpl(':pmstyle10':
000560170524             %trimr(pmstyle10):SQLStatement);
000561170524         SQLStatement = %scanrpl(':pmcorp':
000562170524             %trimr(%char(pmcorp)):SQLStatement);
000563170524         SQLStatement = %scanrpl(':pmcategory':
000564170524             %trimr(pmcategory):SQLStatement);
000565170524         SQLStatement = %scanrpl(':pmsls':
000566170524             %trimr(%char(pmsls)):SQLStatement);
000567170524         SQLStatement = %scanrpl(':pmbuyer':
000568170524             %trimr(%char(pmbuyer)):SQLStatement);
000569170524         SQLStatement = %scanrpl(':pmregion':
000570170524             %trimr(pmregion):SQLStatement);
000571170524         SQLStatement = %scanrpl(':pmfromdate':
000572170524             %trimr(%char(pmfromdate)):SQLStatement);
000573170524         SQLStatement = %scanrpl(':pmtodate':
000574170524             %trimr(%char(pmtodate)):SQLStatement);
000575170524
000579151106       exec sql prepare handleT from :SQLStatement;
000580151106       exec sql declare OpenHandleT cursor for handleT;
000581151106       exec sql Open OpenHandleT;
000582151106       exec SQL ALLOCATE DESCRIPTOR 'Values' WITH MAX 200;
000583151106       exec SQL describe handleT using descriptor 'Values';
000584151106       exec sql describe handleT into :SQLDA using ANY;
000585151207         If SQLCOD = 0;
000586151106           Clear ColumnType;
000587151106           TotalColumns = sqld;
000588151106           SubHeadings = '[';
000589151106           for x = 1 to TotalColumns;
000590151106             SQLVAR = SQL_VAR(x);
000591151106
000592151106             // Formulate the heading
000593151106             If x > 1;
000594151107               SubHeadings = %trimr(SubHeadings) + ', ';
000595151106             ENDIF;
000596151107             SubHeadings = %trimr(SubHeadings) + '''' +
000597151106                 %trimr(SQLName) + '''';
000598151106
000599151106           ENDFOR;
000600151107           SubHeadings = %trimr(SubHeadings) + ']';
000601151106
000602151106           // Get the values and fill into table.
000603151106           sqldabc = 16+sqln*80;
000604151106       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
000605151106           Dow sqlcode = 0;
000606151107             If First <> 'N';
000607151107               First = 'N';
000608151108               SubData = '[';
000609151107             ENDIF;
000610151106             // Put comma between rows
000611151107             If Second = 'Y';
000612151108             SubData = %trimr(SubData) + ',[';
000613151107             Else;
000614151107               Second = 'Y';
000615151107             Endif;
000616151106
000617151106             for x = 1 to TotalColumns;
000618151106               // Put comma between fields
000619151106               If x > 1;
000620151107                 SubData = %trimr(SubData) + ', ';
000621151106               ENDIF;
000622151106
000623151106       exec sql GET DESCRIPTOR 'Values' VALUE :x
000624151106                                  :type = TYPE,
000625151106                                  :length = LENGTH,
000626151106                                  :result_ind = INDICATOR,
000627151106                                  :scale = SCALE,
000628151106                                  :precision = PRECISION ;
000629151106               Select;
000630151106               When Type = 1;
000631151106                 Exsr $Alpha;
000632151106                 SubData = %trimr(SubData) +
000633151106                         '''' +
000634151106                         %subst(ValueA:1:length) +
000635151106                         '''';
000636151106
000637151106               When Type = 2 or Type = 4;
000638151106                 Exsr $Numeric;
000639151106
000640151108                 If NumericValue = '';
000641151108                   NumericValue = '0';
000642151108                 ENDIF;
000643151106                 SubData = %trimr(SubData) +
000644151106                         %trim(NumericValue);
000645151106
000646151106               When Type = 3 ;
000647151106                 Exsr $Decimal; // AKA Packed
000648151106
000649151108                 If NumericValue = '';
000650151108                   NumericValue = '0';
000651151108                 ENDIF;
000652151106                 SubData = %trimr(SubData) +
000653151106                         %trim(NumericValue) ;
000654151106
000655151106               When Type = 25 ;
000656151106                 Exsr $BigInt; // Big Integer
000657151106
000658151108                 If NumericValue = '';
000659151108                   NumericValue = '0';
000660151108                 ENDIF;
000661151106                 SubData = %trimr(SubData) +
000662151106                         %trim(NumericValue) ;
000663151106
000664151106               When Type = 5 ;
000665151106                 Exsr $SmallInt; // Small Integer
000666151106
000667151108                 If NumericValue = '';
000668151108                   NumericValue = '0';
000669151108                 ENDIF;
000670151106                 SubData = %trimr(SubData) +
000671151106                         %trim(NumericValue) ;
000672151106
000673151106               When Type = 4 ;
000674151106                 Exsr $Int; // Integer
000675151106
000676151108                 If NumericValue = '';
000677151108                   NumericValue = '0';
000678151108                 ENDIF;
000679151106                 SubData = %trimr(SubData) +
000680151106                         %trim(NumericValue) ;
000681151106
000682170404               When Type = 9 ;
000683170404                 Exsr $Date; // Date
000684170404
000685170404                 SubData = %trimr(SubData) +
000686170404                         '''' +
000687170404                         %trim(%char(NewDate)) +
000688170404                         '''';
000689151106               Other;
000690151106               ENDSL;
000691151106
000692151106             Endfor;
000693151106             SubData = %trimr(SubData) + ']';
000694151106       exec sql fetch next from OpenHandleT into SQL DESCRIPTOR 'Values';
000695151106           ENDDO;
000696151207         Endif;
000697151106     c/exec sql
000698151106     c+     Close OpenHandleT
000699151106     c/end-exec
000700151106
000701151106
000702151106       Endsr;
000703151106
000704151106       //************************************************************************
000705151106       // Subroutine = $Alpha - Get alpha descriptor
000706151106       //************************************************************************
000707151106       Begsr $Alpha;
000708151106
000709151106               Select;
000710151106               When length = 1;
000711151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000712151106                         :ValueA1 = DATA;
000713151106
000714151106               When length = 2;
000715151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000716151106                         :ValueA2 = DATA;
000717151106
000718151106               When length = 3;
000719151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000720151106                         :ValueA3 = DATA;
000721151106
000722151106               When length = 4;
000723151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000724151106                         :ValueA4 = DATA;
000725151106
000726151106               When length = 5;
000727151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000728151106                         :ValueA5 = DATA;
000729151106
000730151106               When length = 6;
000731151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000732151106                         :ValueA6 = DATA;
000733151106
000734151106               When length = 7;
000735151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000736151106                         :ValueA7 = DATA;
000737151106
000738151106               When length = 8;
000739151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000740151106                         :ValueA8 = DATA;
000741151106
000742151106               When length = 9;
000743151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000744151106                         :ValueA9 = DATA;
000745151106
000746151106               When length = 10;
000747151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000748151106                         :ValueA10 = DATA;
000749151106
000750151106               When length = 11;
000751151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000752151106                         :ValueA11 = DATA;
000753151106
000754151106               When length = 12;
000755151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000756151106                         :ValueA12 = DATA;
000757151106
000758151106               When length = 13;
000759151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000760151106                         :ValueA13 = DATA;
000761151106
000762151106               When length = 14;
000763151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000764151106                         :ValueA14 = DATA;
000765151106
000766151106               When length = 15;
000767151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000768151106                         :ValueA15 = DATA;
000769151106
000770151106               When length = 16;
000771151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000772151106                         :ValueA16 = DATA;
000773151106
000774151106               When length = 17;
000775151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000776151106                         :ValueA17 = DATA;
000777151106
000778151106               When length = 18;
000779151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000780151106                         :ValueA18 = DATA;
000781151106
000782151106               When length = 19;
000783151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000784151106                         :ValueA19 = DATA;
000785151106
000786151106               When length = 20;
000787151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000788151106                         :ValueA20 = DATA;
000789151106
000790151106               When length = 21;
000791151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000792151106                         :ValueA21 = DATA;
000793151106
000794151106               When length = 22;
000795151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000796151106                         :ValueA22 = DATA;
000797151106
000798151106               When length = 23;
000799151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000800151106                         :ValueA23 = DATA;
000801151106
000802151106               When length = 24;
000803151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000804151106                         :ValueA24 = DATA;
000805151106
000806151106               When length = 25;
000807151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000808151106                         :ValueA25 = DATA;
000809151106
000810151106               When length = 26;
000811151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000812151106                         :ValueA26 = DATA;
000813151106
000814151106               When length = 27;
000815151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000816151106                         :ValueA27 = DATA;
000817151106
000818151106               When length = 28;
000819151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000820151106                         :ValueA28 = DATA;
000821151106
000822151106               When length = 29;
000823151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000824151106                         :ValueA29 = DATA;
000825151106
000826151106               When length = 30;
000827151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000828151106                         :ValueA30 = DATA;
000829151106
000830151106               When length = 31;
000831151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000832151106                         :ValueA31 = DATA;
000833151106
000834151106               When length = 32;
000835151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000836151106                         :ValueA32 = DATA;
000837151106
000838151106               When length = 33;
000839151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000840151106                         :ValueA33 = DATA;
000841151106
000842151106               When length = 34;
000843151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000844151106                         :ValueA34 = DATA;
000845151106
000846151106               When length = 35;
000847151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000848151106                         :ValueA35 = DATA;
000849151106
000850151106               When length = 36;
000851151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000852151106                         :ValueA36 = DATA;
000853151106
000854151106               When length = 37;
000855151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000856151106                         :ValueA37 = DATA;
000857151106
000858151106               When length = 38;
000859151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000860151106                         :ValueA38 = DATA;
000861151106
000862151106               When length = 39;
000863151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000864151106                         :ValueA39 = DATA;
000865151106
000866151106               When length = 40;
000867151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000868151106                         :ValueA40 = DATA;
000869151106
000870151106               When length = 41;
000871151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000872151106                         :ValueA41 = DATA;
000873151106
000874151106               When length = 42;
000875151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000876151106                         :ValueA42 = DATA;
000877151106
000878151106               When length = 43;
000879151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000880151106                         :ValueA43 = DATA;
000881151106
000882151106               When length = 44;
000883151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000884151106                         :ValueA44 = DATA;
000885151106
000886151106               When length = 45;
000887151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000888151106                         :ValueA45 = DATA;
000889151106
000890151106               When length = 46;
000891151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000892151106                         :ValueA46 = DATA;
000893151106
000894151106               When length = 47;
000895151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000896151106                         :ValueA47 = DATA;
000897151106
000898151106               When length = 48;
000899151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000900151106                         :ValueA48 = DATA;
000901151106
000902151106               When length = 49;
000903151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000904151106                         :ValueA49 = DATA;
000905151106
000906151106               When length = 50;
000907151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000908151106                         :ValueA50 = DATA;
000909151106
000910151106               When length = 51;
000911151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000912151106                         :ValueA51 = DATA;
000913151106
000914151106               When length = 52;
000915151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000916151106                         :ValueA52 = DATA;
000917151106
000918151106               When length = 53;
000919151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000920151106                         :ValueA53 = DATA;
000921151106
000922151106               When length = 54;
000923151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000924151106                         :ValueA54 = DATA;
000925151106
000926151106               When length = 55;
000927151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000928151106                         :ValueA55 = DATA;
000929151106
000930151106               When length = 56;
000931151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000932151106                         :ValueA56 = DATA;
000933151106
000934151106               When length = 57;
000935151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000936151106                         :ValueA57 = DATA;
000937151106
000938151106               When length = 58;
000939151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000940151106                         :ValueA58 = DATA;
000941151106
000942151106               When length = 59;
000943151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000944151106                         :ValueA59 = DATA;
000945151106
000946151106               When length = 60;
000947151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000948151106                         :ValueA60 = DATA;
000949151106
000950151106               When length = 61;
000951151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000952151106                         :ValueA61 = DATA;
000953151106
000954151106               When length = 62;
000955151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000956151106                         :ValueA62 = DATA;
000957151106
000958151106               When length = 63;
000959151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000960151106                         :ValueA63 = DATA;
000961151106
000962151106               When length = 64;
000963151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000964151106                         :ValueA64 = DATA;
000965151106
000966151106               When length = 65;
000967151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000968151106                         :ValueA65 = DATA;
000969151106
000970151106               When length = 66;
000971151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000972151106                         :ValueA66 = DATA;
000973151106
000974151106               When length = 67;
000975151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000976151106                         :ValueA67 = DATA;
000977151106
000978151106               When length = 68;
000979151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000980151106                         :ValueA68 = DATA;
000981151106
000982151106               When length = 69;
000983151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000984151106                         :ValueA69 = DATA;
000985151106
000986151106               When length = 70;
000987151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000988151106                         :ValueA70 = DATA;
000989151106
000990151106               When length = 71;
000991151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000992151106                         :ValueA71 = DATA;
000993151106
000994151106               When length = 72;
000995151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
000996151106                         :ValueA72 = DATA;
000997151106
000998151106               When length = 73;
000999151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001000151106                         :ValueA73 = DATA;
001001151106
001002151106               When length = 74;
001003151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001004151106                         :ValueA74 = DATA;
001005151106
001006151106               When length = 75;
001007151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001008151106                         :ValueA75 = DATA;
001009151106
001010151106               When length = 76;
001011151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001012151106                         :ValueA76 = DATA;
001013151106
001014151106               When length = 77;
001015151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001016151106                         :ValueA77 = DATA;
001017151106
001018151106               When length = 78;
001019151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001020151106                         :ValueA78 = DATA;
001021151106
001022151106               When length = 79;
001023151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001024151106                         :ValueA79 = DATA;
001025151106
001026151106               When length = 80;
001027151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001028151106                         :ValueA80 = DATA;
001029151106
001030151106               When length = 81;
001031151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001032151106                         :ValueA81 = DATA;
001033151106
001034151106               When length = 82;
001035151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001036151106                         :ValueA82 = DATA;
001037151106
001038151106               When length = 83;
001039151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001040151106                         :ValueA83 = DATA;
001041151106
001042151106               When length = 84;
001043151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001044151106                         :ValueA84 = DATA;
001045151106
001046151106               When length = 85;
001047151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001048151106                         :ValueA85 = DATA;
001049151106
001050151106               When length = 86;
001051151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001052151106                         :ValueA86 = DATA;
001053151106
001054151106               When length = 87;
001055151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001056151106                         :ValueA87 = DATA;
001057151106
001058151106               When length = 88;
001059151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001060151106                         :ValueA88 = DATA;
001061151106
001062151106               When length = 89;
001063151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001064151106                         :ValueA89 = DATA;
001065151106
001066151106               When length = 90;
001067151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001068151106                         :ValueA90 = DATA;
001069151106
001070151106               When length = 91;
001071151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001072151106                         :ValueA91 = DATA;
001073151106
001074151106               When length = 92;
001075151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001076151106                         :ValueA92 = DATA;
001077151106
001078151106               When length = 93;
001079151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001080151106                         :ValueA93 = DATA;
001081151106
001082151106               When length = 94;
001083151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001084151106                         :ValueA94 = DATA;
001085151106
001086151106               When length = 95;
001087151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001088151106                         :ValueA95 = DATA;
001089151106
001090151106               When length = 96;
001091151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001092151106                         :ValueA96 = DATA;
001093151106
001094151106               When length = 97;
001095151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001096151106                         :ValueA97 = DATA;
001097151106
001098151106               When length = 98;
001099151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001100151106                         :ValueA98 = DATA;
001101151106
001102151106               When length = 99;
001103151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001104151106                         :ValueA99 = DATA;
001105151106
001106151106               When length = 100;
001107151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001108151106                         :ValueA100 = DATA;
001109151106               Other;
001110151106                 ValueA100 = *blanks;
001111151106               Endsl;
001112151106
001113151106       Endsr;
001114151106
001115151106       //************************************************************************
001116151106       // Subroutine = $Numeric - Get numeric descriptor
001117151106       //************************************************************************
001118151106       Begsr $Numeric;
001119151106
001120151106               Select;
001121151106           // 1
001122151106               When length = 1 and scale = 0;
001123151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001124151106                         :ValueN1_0 = DATA;
001125151207               NumericValue = %editc(ValueN1_0:'M');
001126151106
001127151106               When length = 1 and scale = 1;
001128151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001129151106                         :ValueN1_1 = DATA;
001130151207               NumericValue = %editc(ValueN1_1:'M');
001131151106           // 2
001132151106               When length = 2 and scale = 0;
001133151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001134151106                         :ValueN2_0 = DATA;
001135151207               NumericValue = %editc(ValueN2_0:'M');
001136151106
001137151106               When length = 2 and scale = 1;
001138151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001139151106                         :ValueN2_1 = DATA;
001140151207               NumericValue = %editc(ValueN2_1:'M');
001141151106
001142151106               When length = 2 and scale = 2;
001143151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001144151106                         :ValueN2_2 = DATA;
001145151207               NumericValue = %editc(ValueN2_2:'M');
001146151106
001147151106            // 3
001148151106               When length = 3 and scale = 0;
001149151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001150151106                         :ValueN3_0 = DATA;
001151151207               NumericValue = %editc(ValueN3_0:'M');
001152151106
001153151106               When length = 3 and scale = 1;
001154151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001155151106                         :ValueN3_1 = DATA;
001156151207               NumericValue = %editc(ValueN3_1:'M');
001157151106
001158151106               When length = 3 and scale = 2;
001159151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001160151106                         :ValueN3_2 = DATA;
001161151207               NumericValue = %editc(ValueN3_2:'M');
001162151106
001163151106               When length = 3 and scale = 3;
001164151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001165151106                         :ValueN3_3 = DATA;
001166151207               NumericValue = %editc(ValueN3_3:'M');
001167151106
001168151106            // 4
001169151106               When length = 4 and scale = 0;
001170151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001171151106                         :ValueN4_0 = DATA;
001172151207               NumericValue = %editc(ValueN4_0:'M');
001173151106
001174151106               When length = 4 and scale = 1;
001175151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001176151106                         :ValueN4_1 = DATA;
001177151207               NumericValue = %editc(ValueN4_1:'M');
001178151106
001179151106               When length = 4 and scale = 2;
001180151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001181151106                         :ValueN4_2 = DATA;
001182151207               NumericValue = %editc(ValueN4_2:'M');
001183151106
001184151106               When length = 4 and scale = 3;
001185151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001186151106                         :ValueN4_3 = DATA;
001187151207               NumericValue = %editc(ValueN4_3:'M');
001188151106
001189151106               When length = 4 and scale = 4;
001190151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001191151106                         :ValueN4_4 = DATA;
001192151207               NumericValue = %editc(ValueN4_4:'M');
001193151106
001194151106            // 5
001195151106               When length = 5 and scale = 0;
001196151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001197151106                         :ValueN5_0 = DATA;
001198151207               NumericValue = %editc(ValueN5_0:'M');
001199151106
001200151106               When length = 5 and scale = 1;
001201151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001202151106                         :ValueN5_1 = DATA;
001203151207               NumericValue = %editc(ValueN5_1:'M');
001204151106
001205151106               When length = 5 and scale = 2;
001206151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001207151106                         :ValueN5_2 = DATA;
001208151207               NumericValue = %editc(ValueN5_2:'M');
001209151106
001210151106               When length = 5 and scale = 3;
001211151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001212151106                         :ValueN5_3 = DATA;
001213151207               NumericValue = %editc(ValueN5_3:'M');
001214151106
001215151106               When length = 5 and scale = 4;
001216151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001217151106                         :ValueN5_4 = DATA;
001218151207               NumericValue = %editc(ValueN5_4:'M');
001219151106
001220151106            // 6
001221151106               When length = 6 and scale = 0;
001222151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001223151106                         :ValueN6_0 = DATA;
001224151207               NumericValue = %editc(ValueN6_0:'M');
001225151106
001226151106               When length = 6 and scale = 1;
001227151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001228151106                         :ValueN6_1 = DATA;
001229151207               NumericValue = %editc(ValueN6_1:'M');
001230151106
001231151106               When length = 6 and scale = 2;
001232151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001233151106                         :ValueN6_2 = DATA;
001234151207               NumericValue = %editc(ValueN6_2:'M');
001235151106
001236151106               When length = 6 and scale = 3;
001237151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001238151106                         :ValueN6_3 = DATA;
001239151207               NumericValue = %editc(ValueN6_3:'M');
001240151106
001241151106               When length = 6 and scale = 4;
001242151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001243151106                         :ValueN6_4 = DATA;
001244151207               NumericValue = %editc(ValueN6_4:'M');
001245151106
001246151106            // 7
001247151106               When length = 7 and scale = 0;
001248151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001249151106                         :ValueN7_0 = DATA;
001250151207               NumericValue = %editc(ValueN7_0:'M');
001251151106
001252151106               When length = 7 and scale = 1;
001253151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001254151106                         :ValueN7_1 = DATA;
001255151207               NumericValue = %editc(ValueN7_1:'M');
001256151106
001257151106               When length = 7 and scale = 2;
001258151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001259151106                         :ValueN7_2 = DATA;
001260151207               NumericValue = %editc(ValueN7_2:'M');
001261151106
001262151106               When length = 7 and scale = 3;
001263151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001264151106                         :ValueN7_3 = DATA;
001265151207               NumericValue = %editc(ValueN7_3:'M');
001266151106
001267151106               When length = 7 and scale = 4;
001268151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001269151106                         :ValueN7_4 = DATA;
001270151207               NumericValue = %editc(ValueN7_4:'M');
001271151106
001272151106            // 8
001273151106               When length = 8 and scale = 0;
001274151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001275151106                         :ValueN8_0 = DATA;
001276151207               NumericValue = %editc(ValueN8_0:'M');
001277151106
001278151106               When length = 8 and scale = 1;
001279151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001280151106                         :ValueN8_1 = DATA;
001281151207               NumericValue = %editc(ValueN8_1:'M');
001282151106
001283151106               When length = 8 and scale = 2;
001284151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001285151106                         :ValueN8_2 = DATA;
001286151207               NumericValue = %editc(ValueN8_2:'M');
001287151106
001288151106               When length = 8 and scale = 3;
001289151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001290151106                         :ValueN8_3 = DATA;
001291151207               NumericValue = %editc(ValueN8_3:'M');
001292151106
001293151106               When length = 8 and scale = 4;
001294151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001295151106                         :ValueN8_4 = DATA;
001296151207               NumericValue = %editc(ValueN8_4:'M');
001297151106
001298151106            // 9
001299151106               When length = 9 and scale = 0;
001300151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001301151106                         :ValueN9_0 = DATA;
001302151207               NumericValue = %editc(ValueN9_0:'M');
001303151106
001304151106               When length = 9 and scale = 1;
001305151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001306151106                         :ValueN9_1 = DATA;
001307151207               NumericValue = %editc(ValueN9_1:'M');
001308151106
001309151106               When length = 9 and scale = 2;
001310151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001311151106                         :ValueN9_2 = DATA;
001312151207               NumericValue = %editc(ValueN9_2:'M');
001313151106
001314151106               When length = 9 and scale = 3;
001315151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001316151106                         :ValueN9_3 = DATA;
001317151207               NumericValue = %editc(ValueN9_3:'M');
001318151106
001319151106               When length = 9 and scale = 4;
001320151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001321151106                         :ValueN9_4 = DATA;
001322151207               NumericValue = %editc(ValueN9_4:'M');
001323151106
001324151106            // 10
001325151106               When length = 10 and scale = 0;
001326151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001327151106                         :ValueN10_0 = DATA;
001328151207               NumericValue = %editc(ValueN10_0:'M');
001329151106
001330151106               When length = 10 and scale = 1;
001331151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001332151106                         :ValueN10_1 = DATA;
001333151207               NumericValue = %editc(ValueN10_1:'M');
001334151106
001335151106               When length = 10 and scale = 2;
001336151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001337151106                         :ValueN10_2 = DATA;
001338151207               NumericValue = %editc(ValueN10_2:'M');
001339151106
001340151106               When length = 10 and scale = 3;
001341151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001342151106                         :ValueN10_3 = DATA;
001343151207               NumericValue = %editc(ValueN10_3:'M');
001344151106
001345151106               When length = 10 and scale = 4;
001346151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001347151106                         :ValueN10_4 = DATA;
001348151207               NumericValue = %editc(ValueN10_4:'M');
001349151106
001350151106            // 11
001351151106               When length = 11 and scale = 0;
001352151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001353151106                         :ValueN11_0 = DATA;
001354151207               NumericValue = %editc(ValueN11_0:'M');
001355151106
001356151106               When length = 11 and scale = 1;
001357151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001358151106                         :ValueN11_1 = DATA;
001359151207               NumericValue = %editc(ValueN11_1:'M');
001360151106
001361151106               When length = 11 and scale = 2;
001362151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001363151106                         :ValueN11_2 = DATA;
001364151207               NumericValue = %editc(ValueN11_2:'M');
001365151106
001366151106               When length = 11 and scale = 3;
001367151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001368151106                         :ValueN11_3 = DATA;
001369151207               NumericValue = %editc(ValueN11_3:'M');
001370151106
001371151106               When length = 11 and scale = 4;
001372151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001373151106                         :ValueN11_4 = DATA;
001374151207               NumericValue = %editc(ValueN11_4:'M');
001375151106
001376151106            // 12
001377151106               When length = 12 and scale = 0;
001378151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001379151106                         :ValueN12_0 = DATA;
001380151207               NumericValue = %editc(ValueN12_0:'M');
001381151106
001382151106               When length = 12 and scale = 1;
001383151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001384151106                         :ValueN12_1 = DATA;
001385151207               NumericValue = %editc(ValueN12_1:'M');
001386151106
001387151106               When length = 12 and scale = 2;
001388151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001389151106                         :ValueN12_2 = DATA;
001390151207               NumericValue = %editc(ValueN12_2:'M');
001391151106
001392151106               When length = 12 and scale = 3;
001393151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001394151106                         :ValueN12_3 = DATA;
001395151207               NumericValue = %editc(ValueN12_3:'M');
001396151106
001397151106               When length = 12 and scale = 4;
001398151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001399151106                         :ValueN12_4 = DATA;
001400151207               NumericValue = %editc(ValueN12_4:'M');
001401151106
001402151106            // 13
001403151106               When length = 13 and scale = 0;
001404151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001405151106                         :ValueN13_0 = DATA;
001406151207               NumericValue = %editc(ValueN13_0:'M');
001407151106
001408151106               When length = 13 and scale = 1;
001409151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001410151106                         :ValueN13_1 = DATA;
001411151207               NumericValue = %editc(ValueN13_1:'M');
001412151106
001413151106               When length = 13 and scale = 2;
001414151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001415151106                         :ValueN13_2 = DATA;
001416151207               NumericValue = %editc(ValueN13_2:'M');
001417151106
001418151106               When length = 13 and scale = 3;
001419151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001420151106                         :ValueN13_3 = DATA;
001421151207               NumericValue = %editc(ValueN13_3:'M');
001422151106
001423151106               When length = 13 and scale = 4;
001424151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001425151106                         :ValueN13_4 = DATA;
001426151207               NumericValue = %editc(ValueN13_4:'M');
001427151106
001428151106            // 14
001429151106               When length = 14 and scale = 0;
001430151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001431151106                         :ValueN14_0 = DATA;
001432151207               NumericValue = %editc(ValueN14_0:'M');
001433151106
001434151106               When length = 14 and scale = 1;
001435151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001436151106                         :ValueN14_1 = DATA;
001437151207               NumericValue = %editc(ValueN14_1:'M');
001438151106
001439151106               When length = 14 and scale = 2;
001440151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001441151106                         :ValueN14_2 = DATA;
001442151207               NumericValue = %editc(ValueN14_2:'M');
001443151106
001444151106               When length = 14 and scale = 3;
001445151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001446151106                         :ValueN14_3 = DATA;
001447151207               NumericValue = %editc(ValueN14_3:'M');
001448151106
001449151106               When length = 14 and scale = 4;
001450151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001451151106                         :ValueN14_4 = DATA;
001452151207               NumericValue = %editc(ValueN14_4:'M');
001453151106
001454151106            // 15
001455151106               When length = 15 and scale = 0;
001456151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001457151106                         :ValueN15_0 = DATA;
001458151207               NumericValue = %editc(ValueN15_0:'M');
001459151106
001460151106               When length = 15 and scale = 1;
001461151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001462151106                         :ValueN15_1 = DATA;
001463151207               NumericValue = %editc(ValueN15_1:'M');
001464151106
001465151106               When length = 15 and scale = 2;
001466151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001467151106                         :ValueN15_2 = DATA;
001468151207               NumericValue = %editc(ValueN15_2:'M');
001469151106
001470151106               When length = 15 and scale = 3;
001471151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001472151106                         :ValueN15_3 = DATA;
001473151207               NumericValue = %editc(ValueN15_3:'M');
001474151106
001475151106               When length = 15 and scale = 4;
001476151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001477151106                         :ValueN15_4 = DATA;
001478151207               NumericValue = %editc(ValueN15_4:'M');
001479151106
001480151106               Other;
001481151106                 NumericValue = *blanks;
001482151106               Endsl;
001483151106
001484151106       ENDSR;
001485151106
001486151106       //************************************************************************
001487151106       // Subroutine = $Decimal - Get numeric descriptor
001488151106       //************************************************************************
001489151106       Begsr $Decimal;
001490151106
001491151106               Length = (Precision/2)+1;
001492151106               Select;
001493151106           // 1
001494151106               When Length = 1 and scale = 0;
001495151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001496151106                         :ValueD1_0 = DATA;
001497151207                 NumericValue = %editc(ValueD1_0:'M');
001498151106
001499151106               When Length = 1 and scale = 1;
001500151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001501151106                         :ValueD1_1 = DATA;
001502151207                 NumericValue = %editc(ValueD1_1:'M');
001503151106
001504151106           // 2
001505151106               When Length = 2 and scale = 0;
001506151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001507151106                         :ValueD3_0 = DATA;
001508151207                 NumericValue = %editc(ValueD3_0:'M');
001509151106
001510151106               When Length = 2 and scale = 1;
001511151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001512151106                         :ValueD3_1 = DATA;
001513151207                 NumericValue = %editc(ValueD3_1:'M');
001514151106
001515151106               When Length = 2 and scale = 2;
001516151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001517151106                         :ValueD3_2 = DATA;
001518151207                 NumericValue = %editc(ValueD3_2:'M');
001519151106
001520151106               When Length = 2 and scale = 3;
001521151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001522151106                         :ValueD3_3 = DATA;
001523151207                 NumericValue = %editc(ValueD3_3:'M');
001524151106
001525151106           // 3
001526151106               When Length = 3 and scale = 0;
001527151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001528151106                         :ValueD5_0 = DATA;
001529151207                 NumericValue = %editc(ValueD5_0:'M');
001530151106
001531151106               When Length = 3 and scale = 1;
001532151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001533151106                         :ValueD5_1 = DATA;
001534151207                 NumericValue = %editc(ValueD5_1:'M');
001535151106
001536151106               When Length = 3 and scale = 2;
001537151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001538151106                         :ValueD5_2 = DATA;
001539151207                 NumericValue = %editc(ValueD5_2:'M');
001540151106
001541151106               When Length = 3 and scale = 3;
001542151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001543151106                         :ValueD5_3 = DATA;
001544151207                 NumericValue = %editc(ValueD5_3:'M');
001545151106
001546151106               When Length = 3 and scale = 4;
001547151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001548151106                         :ValueD5_4 = DATA;
001549151207                 NumericValue = %editc(ValueD5_4:'M');
001550151106
001551151106               When Length = 3 and scale = 5;
001552151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001553151106                         :ValueD5_5 = DATA;
001554151207                 NumericValue = %editc(ValueD5_5:'M');
001555151106
001556151106           // 4
001557151106               When Length = 4 and scale = 0;
001558151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001559151106                         :ValueD7_0 = DATA;
001560151207                 NumericValue = %editc(ValueD7_0:'M');
001561151106
001562151106               When Length = 4 and scale = 1;
001563151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001564151106                         :ValueD7_1 = DATA;
001565151207                 NumericValue = %editc(ValueD7_1:'M');
001566151106
001567151106               When Length = 4 and scale = 2;
001568151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001569151106                         :ValueD7_2 = DATA;
001570151207                 NumericValue = %editc(ValueD7_2:'M');
001571151106
001572151106               When Length = 4 and scale = 3;
001573151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001574151106                         :ValueD7_3 = DATA;
001575151207                 NumericValue = %editc(ValueD7_3:'M');
001576151106
001577151106               When Length = 4 and scale = 4;
001578151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001579151106                         :ValueD7_4 = DATA;
001580151207                 NumericValue = %editc(ValueD7_4:'M');
001581151106
001582151106               When Length = 4 and scale = 5;
001583151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001584151106                         :ValueD7_5 = DATA;
001585151207                 NumericValue = %editc(ValueD7_5:'M');
001586151106
001587151106               When Length = 4 and scale = 6;
001588151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001589151106                         :ValueD7_6 = DATA;
001590151207                 NumericValue = %editc(ValueD7_6:'M');
001591151106
001592151106               When Length = 4 and scale = 7;
001593151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001594151106                         :ValueD7_7 = DATA;
001595151207                 NumericValue = %editc(ValueD7_7:'M');
001596151106
001597151106           // 5
001598151106               When Length = 5 and scale = 0;
001599151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001600151106                         :ValueD9_0 = DATA;
001601151207                 NumericValue = %editc(ValueD9_0:'M');
001602151106
001603151106               When Length = 5 and scale = 1;
001604151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001605151106                         :ValueD9_1 = DATA;
001606151207                 NumericValue = %editc(ValueD9_1:'M');
001607151106
001608151106               When Length = 5 and scale = 2;
001609151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001610151106                         :ValueD9_2 = DATA;
001611151207                 NumericValue = %editc(ValueD9_2:'M');
001612151106
001613151106               When Length = 5 and scale = 3;
001614151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001615151106                         :ValueD9_3 = DATA;
001616151207                 NumericValue = %editc(ValueD9_3:'M');
001617151106
001618151106               When Length = 5 and scale = 4;
001619151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001620151106                         :ValueD9_4 = DATA;
001621151207                 NumericValue = %editc(ValueD9_4:'M');
001622151106
001623151106               When Length = 5 and scale = 5;
001624151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001625151106                         :ValueD9_5 = DATA;
001626151207                 NumericValue = %editc(ValueD9_5:'M');
001627151106
001628151106               When Length = 5 and scale = 6;
001629151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001630151106                         :ValueD9_6 = DATA;
001631151207                 NumericValue = %editc(ValueD9_6:'M');
001632151106
001633151106               When Length = 5 and scale = 7;
001634151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001635151106                         :ValueD9_7 = DATA;
001636151207                 NumericValue = %editc(ValueD9_7:'M');
001637151106
001638151106               When Length = 5 and scale = 8;
001639151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001640151106                         :ValueD9_8 = DATA;
001641151207                 NumericValue = %editc(ValueD9_8:'M');
001642151106
001643151106               When Length = 5 and scale = 9;
001644151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001645151106                         :ValueD9_9 = DATA;
001646151207                 NumericValue = %editc(ValueD9_9:'M');
001647151106
001648151106           // 6
001649151106               When Length = 6 and scale = 0;
001650151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001651151106                         :ValueD11_0 = DATA;
001652151207                 NumericValue = %editc(ValueD11_0:'M');
001653151106
001654151106               When Length = 6 and scale = 1;
001655151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001656151106                         :ValueD11_1 = DATA;
001657151207                 NumericValue = %editc(ValueD11_1:'M');
001658151106
001659151106               When Length = 6 and scale = 2;
001660151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001661151106                         :ValueD11_2 = DATA;
001662151207                 NumericValue = %editc(ValueD11_2:'M');
001663151106
001664151106               When Length = 6 and scale = 3;
001665151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001666151106                         :ValueD11_3 = DATA;
001667151207                 NumericValue = %editc(ValueD11_3:'M');
001668151106
001669151106               When Length = 6 and scale = 4;
001670151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001671151106                         :ValueD11_4 = DATA;
001672151207                 NumericValue = %editc(ValueD11_4:'M');
001673151106
001674151106               When Length = 6 and scale = 5;
001675151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001676151106                         :ValueD11_5 = DATA;
001677151207                 NumericValue = %editc(ValueD11_5:'M');
001678151106
001679151106               When Length = 6 and scale = 6;
001680151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001681151106                         :ValueD11_6 = DATA;
001682151207                 NumericValue = %editc(ValueD11_6:'M');
001683151106
001684151106               When Length = 6 and scale = 7;
001685151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001686151106                         :ValueD11_7 = DATA;
001687151207                 NumericValue = %editc(ValueD11_7:'M');
001688151106
001689151106               When Length = 6 and scale = 8;
001690151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001691151106                         :ValueD11_8 = DATA;
001692151207                 NumericValue = %editc(ValueD11_8:'M');
001693151106
001694151106               When Length = 6 and scale = 9;
001695151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001696151106                         :ValueD11_9 = DATA;
001697151207                 NumericValue = %editc(ValueD11_9:'M');
001698151106
001699151106               When Length = 6 and scale = 10;
001700151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001701151106                         :ValueD11_10 = DATA;
001702151207                 NumericValue = %editc(ValueD11_10:'M');
001703151106
001704151106               When Length = 6 and scale = 11;
001705151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001706151106                         :ValueD11_11 = DATA;
001707151207                 NumericValue = %editc(ValueD11_11:'M');
001708151106
001709151106           // 7
001710151106               When Length = 7 and scale = 0;
001711151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001712151106                         :ValueD13_0 = DATA;
001713151207                 NumericValue = %editc(ValueD13_0:'M');
001714151106
001715151106               When Length = 7 and scale = 1;
001716151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001717151106                         :ValueD13_1 = DATA;
001718151207                 NumericValue = %editc(ValueD13_1:'M');
001719151106
001720151106               When Length = 7 and scale = 2;
001721151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001722151106                         :ValueD13_2 = DATA;
001723151207                 NumericValue = %editc(ValueD13_2:'M');
001724151106
001725151106               When Length = 7 and scale = 3;
001726151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001727151106                         :ValueD13_3 = DATA;
001728151207                 NumericValue = %editc(ValueD13_3:'M');
001729151106
001730151106               When Length = 7 and scale = 4;
001731151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001732151106                         :ValueD13_4 = DATA;
001733151207                 NumericValue = %editc(ValueD13_4:'M');
001734151106
001735151106               When Length = 7 and scale = 5;
001736151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001737151106                         :ValueD13_5 = DATA;
001738151207                 NumericValue = %editc(ValueD13_5:'M');
001739151106
001740151106               When Length = 7 and scale = 6;
001741151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001742151106                         :ValueD13_6 = DATA;
001743151207                 NumericValue = %editc(ValueD13_6:'M');
001744151106
001745151106               When Length = 7 and scale = 7;
001746151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001747151106                         :ValueD13_7 = DATA;
001748151207                 NumericValue = %editc(ValueD13_7:'M');
001749151106
001750151106               When Length = 7 and scale = 8;
001751151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001752151106                         :ValueD13_8 = DATA;
001753151207                 NumericValue = %editc(ValueD13_8:'M');
001754151106
001755151106               When Length = 7 and scale = 9;
001756151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001757151106                         :ValueD13_9 = DATA;
001758151207                 NumericValue = %editc(ValueD13_9:'M');
001759151106
001760151106               When Length = 7 and scale = 10;
001761151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001762151106                         :ValueD13_10 = DATA;
001763151207                 NumericValue = %editc(ValueD13_10:'M');
001764151106
001765151106               When Length = 7 and scale = 11;
001766151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001767151106                         :ValueD13_11 = DATA;
001768151207                 NumericValue = %editc(ValueD13_11:'M');
001769151106
001770151106               When Length = 7 and scale = 12;
001771151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001772151106                         :ValueD13_12 = DATA;
001773151207                 NumericValue = %editc(ValueD13_12:'M');
001774151106
001775151106               When Length = 7 and scale = 13;
001776151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001777151106                         :ValueD13_13 = DATA;
001778151207                 NumericValue = %editc(ValueD13_13:'M');
001779151106
001780151106           // 8
001781151106               When Length = 8 and scale = 0;
001782151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001783151106                         :ValueD15_0 = DATA;
001784151207                 NumericValue = %editc(ValueD15_0:'M');
001785151106
001786151106               When Length = 8 and scale = 1;
001787151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001788151106                         :ValueD15_1 = DATA;
001789151207                 NumericValue = %editc(ValueD15_1:'M');
001790151106
001791151106               When Length = 8 and scale = 2;
001792151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001793151106                         :ValueD15_2 = DATA;
001794151207                 NumericValue = %editc(ValueD15_2:'M');
001795151106
001796151106               When Length = 8 and scale = 3;
001797151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001798151106                         :ValueD15_3 = DATA;
001799151207                 NumericValue = %editc(ValueD15_3:'M');
001800151106
001801151106               When Length = 8 and scale = 4;
001802151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001803151106                         :ValueD15_4 = DATA;
001804151207                 NumericValue = %editc(ValueD15_4:'M');
001805151106
001806151106               When Length = 8 and scale = 5;
001807151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001808151106                         :ValueD15_5 = DATA;
001809151207                 NumericValue = %editc(ValueD15_5:'M');
001810151106
001811151106               When Length = 8 and scale = 6;
001812151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001813151106                         :ValueD15_6 = DATA;
001814151207                 NumericValue = %editc(ValueD15_6:'M');
001815151106
001816151106               When Length = 8 and scale = 7;
001817151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001818151106                         :ValueD15_7 = DATA;
001819151207                 NumericValue = %editc(ValueD15_7:'M');
001820151106
001821151106               When Length = 8 and scale = 8;
001822151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001823151106                         :ValueD15_8 = DATA;
001824151207                 NumericValue = %editc(ValueD15_8:'M');
001825151106
001826151106               When Length = 8 and scale = 9;
001827151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001828151106                         :ValueD15_9 = DATA;
001829151207                 NumericValue = %editc(ValueD15_9:'M');
001830151106
001831151106               When Length = 8 and scale = 10;
001832151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001833151106                         :ValueD15_10 = DATA;
001834151207                 NumericValue = %editc(ValueD15_10:'M');
001835151106
001836151106               When Length = 8 and scale = 11;
001837151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001838151106                         :ValueD15_11 = DATA;
001839151207                 NumericValue = %editc(ValueD15_11:'M');
001840151106
001841151106               When Length = 8 and scale = 12;
001842151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001843151106                         :ValueD15_12 = DATA;
001844151207                 NumericValue = %editc(ValueD15_12:'M');
001845151106
001846151106               When Length = 8 and scale = 13;
001847151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001848151106                         :ValueD15_13 = DATA;
001849151207                 NumericValue = %editc(ValueD15_13:'M');
001850151106
001851151106               When Length = 8 and scale = 14;
001852151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001853151106                         :ValueD15_14 = DATA;
001854151207                 NumericValue = %editc(ValueD15_14:'M');
001855151106
001856151106               When Length = 8 and scale = 15;
001857151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001858151106                         :ValueD15_15 = DATA;
001859151207                 NumericValue = %editc(ValueD15_15:'M');
001860151106
001861151106               Other;
001862151106                 NumericValue = *blanks;
001863151106
001864151106               Endsl;
001865151106
001866151106       ENDSR;
001867151106
001868151106
001869151106       //************************************************************************
001870151106       // Subroutine = $BigInt - Get big integer
001871151106       //************************************************************************
001872151106       Begsr $BigInt;
001873151106
001874151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001875151106                         :BigInt = DATA;
001876151106                 BigIntNumeric = BigInt;
001877151207                 NumericValue = %editc(BigIntNumeric:'M');
001878151106
001879151106       ENDSR;
001880151106
001881151106       //************************************************************************
001882151106       // Subroutine = $SmallInt - Get small integer
001883151106       //************************************************************************
001884151106       Begsr $SmallInt;
001885151106
001886151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001887151106                         :SmallInt = DATA;
001888151106                 BigIntNumeric = SmallInt;
001889151207                 NumericValue = %editc(BigIntNumeric:'M');
001890151106
001891151106       ENDSR;
001892151106
001893151106       //************************************************************************
001894151106       // Subroutine = $Int - Get integer
001895151106       //************************************************************************
001896151106       Begsr $Int;
001897151106
001898151106                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001899151106                         :Int = DATA;
001900151106                 BigIntNumeric = Int;
001901151207                 NumericValue = %editc(BigIntNumeric:'M');
001902151106
001903151106       ENDSR;
001904170404       //************************************************************************
001905170404       // Subroutine = $Date - get date
001906170404       //************************************************************************
001907170404       Begsr $Date;
001908170404
001909170404                 exec sql GET DESCRIPTOR 'Values' VALUE :x
001910170404                         :NewDate = DATA;
001911170404
001912170404       ENDSR;
001913151106
