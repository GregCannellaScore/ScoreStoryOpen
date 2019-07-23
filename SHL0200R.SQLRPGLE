000100000000      /copy qcpylesrc,stdhspec
000200000000       //*******************************************************************
000300000000       //
000400000000       //  Program:      XXX0200R
000500000000       //
000600000000       //  Description:  xxxxxxxxxxxx Inquiry/Maintenance
000700000000       //
000800000000       //  Programmer:   xxxxxxxxxxxxxxxxxx
000900000000       //
001000000000       //  Date:         xx/xx/xx
001100000000       //
001200000000       //*******************************************************************
001300000000       //                   Modification Log
001400000000       //
001500000000       //  Initials  Date      Description
001600000000       //-------------------------------------------------------------------
001700000000       //   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800000000       //
001900000000       //
002000000000       //
002100000000       //*******************************************************************
002200000000       //                   Indicator Usage
002300000000       //
002400000000       //   Ind.   Description
002500000000       //-------------------------------------------------------------------
002600000000       //   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700000000       //
002800000000       //
002900000000       //*******************************************************************
003000000000       //****************************************************************
003100000000       // Indicator Usage:                                              *
003200000000       // Ind      Use                                                  *
003300000000       // 01-24    Function keys                                        *
003400000000       // 25       Rollup                                               *
003500000000       // 30-34    Subfile keywords                                     *
003600000000       // 36       Position to                                          *
003700000000       // 37       Error indicator                                      *
003800000000       // 40       Search field change                                  *
003900000000       // 41-42    Search field display                                 *
004000000000       // 61       Subfile option error                                 *
004100000000       // 80-89    Reserved for Security                                *
004200000000       // 90-99    Hit/Miss                                             *
004300000000       //****************************************************************
004400000000       //****************************************************************
004500000000       // Field Definitions                                             *
004600000000       //                                                               *
004700000000       // Prefix                                                        *
004800000000       // ww     - Program described work fields                        *
004900000000       // cc     - Program described constants                          *
005000000000       // wi     - APPL *ENTRY input parameters                         *
005100000000       // ws     - Subfile fields                                       *
005200000000       // wc     - Subfile control fields                               *
005300000000       // hd     - Hidden fields                                        *
005400000000       // ax     - APPx output parameters for called programs           *
005500000000       // ds     - Data structure fields                                *
005600000000       // cc     - Constants
005700000000       //                                                               *
005800000000       //                                                               *
005900000000       // Display Record Format Definitions                             *
006000000000       //                                                               *
006100000000       // Prefix                                                        *
006200000000       // SCRNS  - Subfile                                              *
006300000000       // SCRNC  - Subfile control                                      *
006400000000       // SCRNK  - Command key                                          *
006500000000       // SCRNR  - Standard display                                     *
006600000000       // WNDWB  - window border                                        *
006700000000       // WNDWR  - Standard window display                              *
006800000000       // MSGCTL - Message subfile control                              *
006900000000       //                                                               *
007000000000       //****************************************************************
007100000000       //PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007200000000       //P          P  R  O  G  R  A  M    S  P  E  C  S                P
007300000000       //PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007400000000
007500000000       //------------------------------------------------
007600000000       //--Define the files
007700150518>>>>   dcl-f Shl0200D workstn SFILE(SCRNS01:wwRRN1) INFDS(INFDS);
007800000000
007900150518>>>>   dcl-f FileXXX1 usage(*input) keyed;
008000000000
008100150518>>>>   dcl-ds dsFileXXX2
008200150518>>>>     extname('FILEXXX2');
008300000000       end-ds;
008400000000
008500150518>>>>   dcl-ds dsFileXXX3
008600150518>>>>     extname('FILEXXX3');
008700000000       end-ds;
008800000000
008900000000       //----------------
009000000000       //--Parameter definitions
009100000000       dcl-ds dsJld
009200000000         extname('DSJLD');
009300000000       end-ds;
009400000000
009500000000       //------------------------------------------------
009600000000       //--Entry Prototype
009700150518>>>>   dcl-pr Shl0200r extpgm('SHL0200R');
009800000000         wiJld like(dsJld);
009900000000         wiApp1 like(dsApp1);
010000000000       end-pr;
010100000000
010200150518>>>>   dcl-pi Shl0200r;
010300000000         wiJld like(dsJld);
010400000000         wiApp1 like(dsApp1);
010500000000       end-pi;
010600000000
010700000000       //------------------------------------------------
010800000000       //--Prototypes For Called Programs
010900000000
011000000000       // Write message to screen
011100000000       dcl-pr WrtErrMsg extpgm('ERMSG1');
011200000000         wiMsgi like(wwMsgi);
011300000000       end-pr;
011400000000
011500000000       // Remove error messages
011600000000       dcl-pr RmvErrMsg extpgm('ERMSG2');
011700000000         wiDsPgnm like(DSPGMN);
011800000000       end-pr;
011900000000
012000000000       // Set program security
012100000000       dcl-pr SetSecurity extpgm('SEC0100R');
012200000000         wiPGM char(10);
012300000000         wiSecInd like(a1Sec);
012400000000       end-pr;
012500000000
012600000000       // xxxxxx xxxxx xxxxxx Maintenance/Display
012700150518>>>>   dcl-pr Xxx0071r extpgm('XXX0071R');
012800000000         wiCrdGrp# char(5);
012900000000         wiOpt char(1);
013000000000       end-pr;
013100000000
013200000000       // xxxxxx xxx xxxxxxx
013300150518>>>>   dcl-pr Xxx0121r extpgm('XXX0121R');
013400000000         wiJld like(dsJld);
013500000000         wiAPP2 like(dsApp2);
013600000000       end-pr;
013700000000
013800000000       // New Credit Group prompt
013900150518>>>>   dcl-pr Xxx0122r extpgm('XXX0122R');
014000000000         wiJld like(dsJld);
014100000000         wiAPP3 like(dsApp3);
014200000000       end-pr;
014300000000
014400000000       // Incoming entry parms:
014500000000       dcl-ds dsApp1 len(512);
014600000000         a1Sec char(5);       // Security
014700000000         a1Sel char(1);       // Select a record
014800000000         a1View zoned(2:0);   // Screen to display
014900150518>>>>     a1xxx1 zoned(6:0);
015000150518>>>>     a1xxx2 char(10);
015100150518>>>>     a1xxx3 char(10);
015200000000       end-ds;
015300000000
015400000000       // Xxxx121R Parms
015500000000       dcl-ds dsApp2 len(512);
015600000000         a2Sec char(5);       // Security
015700000000         a2Iuse char(10);     // In Use Flag
015800000000         a2Inlr char(1);      // Turn on LR indicator
015900150518>>>>     a2Actn char(10);     // Define Action
016000150518>>>>     a2xxx1 zoned(5:0);
016100000000       end-ds;
016200000000
016300000000        // Xxx0122r Parms
016400000000       dcl-ds dsApp3 len(512);
016500000000         a3Sec char(5);
016600000000         a3Sel char(1);
016700000000         a3View zoned(2:0);
016800150518>>>>     a3xxx1 zoned(5:0);
016900150518>>>>     a3xxx2 zoned(5:0);
017000000000       end-ds;
017100000000
017200000000       // Split option indicator and action code:
017300000000       dcl-ds dsSplt len(12);
017400000000         wwZZ zoned(2:0) pos(1);
017500000000         dsActn char(10) pos(3);
017600000000       end-ds;
017700000000
017800000000       dcl-ds INFDS;
017900150520         SFLLOC bindec(4) pos(378);
018000000000       end-ds;
018100000000
018200000000       dcl-ds dsPgmDs PSDS;
018300000000         dsPgmn *PROC;
018400000000         dsUser char(10) pos(254);
018500000000       end-ds;
018600000000
018700000000       // General constants:
018800000000       dcl-c ccLOAD const('LOAD');
018900000000       dcl-c ccERROR const('ERROR');
019000000000       dcl-c ccINUSE const('INUSE');
019100000000       dcl-c ccSELECT const('SELECT');
019200000000       dcl-c ccADD const('ADD');
019300000000       dcl-c ccCHANGE const('CHANGE');
019400000000       dcl-c ccCOPY const('COPY');
019500000000       dcl-c ccDELETE const('DELETE');
019600000000       dcl-c ccDISPLAY const('DISPLAY');
019700000000       dcl-c ccCPYCUST const('CPYCUST');
019800000000       dcl-c ccWRKWTH const('WRKWTH');
019900000000       dcl-c ccNO const('N');
020000000000       dcl-c ccYES const('Y');
020100000000
020200000000       // Max number of 'position to':
020300000000       dcl-c cc#POS const(03);
020400000000
020500000000       // Number of records to fill S/F page:
020600000000       dcl-c ccPGSZ const(10);
020700000000
020800000000       // Case conversion
020900000000       dcl-c ccLowerCase const('abcdefghijklmnopqrstuvwxyz');
021000000000       dcl-c ccUpperCase const('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
021100000000
021200000000       // Quote for building SQL statement
021300000000       dcl-c ccQuote const('''');
021400000000
021500000000       // Definitions from Screen
021600000000       dcl-s wwRRN1 like(hdSFLP);
021700000000       dcl-s wwRRN# like(hdSFLP);
021800000000       dcl-s wwcRRN like(hdSFLP);
021900000000
022000000000       dcl-s wwCnt1 zoned(2:0);
022100000000       dcl-s wwCPOS zoned(2:0) inz(1);
022200000000       dcl-s wwCTAB char(3);
022300000000       dcl-s wwCKEY char(27);
022400000000       dcl-s wwNFND char(1);
022500000000       dcl-s wwFRST char(1) inz(ccYES);
022600000000       dcl-s wwLOAD char(1) inz(ccYES);
022700000000       dcl-s wwERR1 char(10);
022800000000       dcl-s wwERR2 char(10);
022900000000       dcl-s wwERR3 char(1);
023000000000       dcl-s wwRCDE char(10);
023100000000       dcl-s wwX zoned(2:0);
023200000000       dcl-s wwZ like(wwX);
023300000000       dcl-s wwMsgi char(10);
023400000000       dcl-s wwCrdGrp# char(5);
023500000000       dcl-s wwCorpGrp# char(5);
023600000000
023700000000       // -Sql Statement
023800000000       dcl-s wwSelect varchar(1024);
023900000000       dcl-s wwFrom varchar(1024);
024000000000       dcl-s wwJoin varchar(1024);
024100000000       dcl-s wwWhere varchar(1024);
024200000000       dcl-s wwGroup varchar(1024);
024300000000       dcl-s wwOrder varchar(1024);
024400000000       dcl-s wwFor varchar(1024);
024500000000       dcl-s wwSqlTxt varchar(6144);
024600000000
024700000000       // Monitor nulls for dsRd3
024800000000       dcl-s dsRdNullArr int(5:0) dim(6);
024900000000       dcl-s wwUsrNull int(5:0);
025000000000
025100000000       // Header screen Action desriptions:
025200000000       dcl-s wwOpt char(1) dim(12) ctdata perrcd(1);
025300000000       dcl-s wwInmd char(12) dim(12) alt(wwOpt);
025400000000
025500000000       //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
025600000000       //M                 M  A  I  N  L  I  N  E                       M
025700000000       //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
025800000000
025900000000       // Main loop:
026000000000       DOU *in03 = *ON;
026100000000
026200000000         // Reload subfile, if requested:
026300000000         if wwLOAD = ccYES;
026400000000           exsr $INSFL;
026500000000           wwLOAD = ccNO;
026600000000         endif;
026700000000
026800000000         // Display screen:
026900000000         write MSGCTL1;
027000000000         write SCRNK01;
027100000000
027200000000         if *in32 = *OFF;
027300000000           write SCRNR01;
027400000000         endif;
027500000000
027600000000         exfmt SCRNC01;
027700000000
027800000000         *in69 = THEFLD;
027900000000         if wwFRST = ccYES;
028000000000           wwFrst = ccNO;
028100000000         endif;
028200000000
028300000000         hdsFlp = SflLoc;
028400000000
028500000000         // clear messages:
028600000000         RmvErrMsg(DSPGMN);
028700000000
028800000000         // Set off all error indicators here:
028900000000         *in36 = *off;
029000000000         *in38 = *off;
029100000000         *in71 = *off;
029200000000
029300000000         // If not exiting program the process user action taken
029400000000         if *in03 = *OFF;
029500000000           exsr $UserAction;
029600000000         endif;
029700000000
029800000000       enddo;
029900000000
030000000000       // Close cursor
030100000000       exec sql
030200000000         close Csr_Read;
030300000000
030400000000       // Close called programs:
030500000000       a2Inlr = ccYES;
030600000000
030700000000       // End the maintenance program:
030800150518>>>>   //--Xxx0121(dsJld : dsApp2);
030900000000
031000000000       *inlr = *on;
031100000000
031200000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
031300000000       //$              S  U  B  R  O  U  T  I  N  E  S                 $
031400000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
031500000000       //
031600000000       //------------------------------------------------
031700000000       //*  $INSFL  ** - Initialize Subfile
031800000000       //------------------------------------------------
031900000000       begsr $INSFL;
032000000000
032100000000         clear wwRRN1;
032200000000         hdsFlp = 1;
032300000000         wwNFnd = ccNO;
032400000000
032500000000         // clear subfile:
032600000000         if *in32 = *ON;
032700000000           *in32 = *off;
032800000000           *in30 = *on;
032900000000           write SCRNC01;
033000000000           *in30 = *off;
033100000000         endif;
033200000000
033300000000         // Check for subfile control errors:
033400000000         select;
033500000000           when wwFrst = ccNO;
033600000000             exsr $Error01;
033700000000         endsl;
033800000000
033900000000         // Build needed SQL statement based upon Position To
034000000000         exsr $Sql;
034100000000
034200000000         // Load subfile:
034300000000         exsr $LoadSFL;
034400000000
034500000000         // Send message if records do not exist for loading SFL
034600000000         if wwRRN1 = *zero;
034700000000           wwMsgi = 'SHL0011';
034800000000           WrtErrMsg(wwMsgi);
034900000000         endif;
035000000000
035100000000       endsr;
035200000000
035300000000       //------------------------------------------------
035400000000       //*  $LoadSFL  ** - Load Subfile
035500000000       //------------------------------------------------
035600000000       begsr $LoadSFL;
035700000000
035800000000         clear wwCnt1;
035900000000         *in34 = *off;
036000000000
036100000000         // Load one page at a time:
036200000000         dow wwCnt1 < ccPGSZ
036300000000           and SQLCODE = 0;
036400000000           //****************************************************************
036500000000
036600000000           // wwUsrNull needed to accept a null value for this field since
036700000000           //  the join result can return null if user data not found.
036800000000
036900000000           exec sql
037000000000             fetch from Csr_Read
037100150518>>>>           into :wsgrp#, :wsnme, :wsusr :wwUsrNull, :wstype, :wstcde,
037200150518>>>>                :wsclmt;
037300000000
037400000000           if SQLCODE = 0;
037500000000             clear wsOPT#;
037600000000             *in61 = *off;
037700000000
037800000000             wwRRN1 += 1;
037900000000             wwCnt1 += 1;
038000000000
038100000000             if wwCnt1 = 1;
038200000000               hdSFLP = wwRRN1;
038300000000             endif;
038400000000
038500000000             write SCRNS01;
038600000000
038700000000           endif;
038800000000
038900000000         enddo;
039000000000
039100000000         if wwRRN1 > *ZERO;
039200000000           *in32 = *on;
039300000000         endif;
039400000000
039500000000         // No more records found then display bottom
039600000000         if SQLCODE <> 0;
039700000000           *in34 = *on;
039800000000         endif;
039900000000
040000000000         *in25 = *off;
040100000000
040200000000       endsr;
040300000000
040400000000       //------------------------------------------------
040500000000       //*  $SQL    ** - Build selection for dynamic SQL statement
040600000000       //------------------------------------------------
040700000000       begsr $SQL;
040800000000
040900000000         exec sql
041000000000           close Csr_Read;
041100000000
041200000000         wwSelect = *blank;
041300000000         wwFrom   = *blank;
041400000000         wwJoin   = *blank;
041500000000         wwWhere  = *blank;
041600000000         wwGroup  = *blank;
041700000000         wwOrder  = *blank;
041800000000         wwFor    = *blank;
041900000000         wwSqlTxt = *blank;
042000000000
042100150518>>>>     wwSelect = 'Select GHGRP#, GHNME, CRDUSR, GHTYPE, +
042200150518>>>>        GHTCDE, GHCLMT';
042300000000
042400150518>>>>     wwFrom   = 'From FileXXX2';
042500000000
042600150518>>>>     wwJoin   = 'Left Join FileXXX3 on ghgrp# = crdcrp';
042700000000
042800000000         // Build where clause based upon Position To screen
042900000000         exsr $SqlWhere;
043000000000
043100000000         select;
043200000000           when wwCPOS = 1;
043300150518>>>>         wwOrder = 'Order By GHGRP#';
043400000000
043500000000           when wwCPOS = 2;
043600150518>>>>         wwOrder = 'Order By GHNME';
043700000000
043800000000           when wwCPOS = 3;
043900150518>>>>         wwOrder = 'Order By CRDUSR';
044000000000         endsl;
044100000000
044200150518>>>>     wwFor = 'Optimize for 10 Rows';
044300000000
044400000000         wwSqlTxt = %trim(wwSelect)
044500000000            + ' ' + %trim(wwFrom)
044600000000            + ' ' + %trim(wwJoin)
044700000000            + ' ' + %trim(wwWhere)
044800000000            + ' ' + %trim(wwOrder)
044900000000            + ' ' + %trim(wwFor);
045000000000
045100000000         exec sql
045200000000           Prepare DynCsr_Read From :wwSqlTxt;
045300000000
045400000000         exec sql
045500000000           Declare Csr_Read Cursor For DynCsr_Read;
045600000000
045700000000         exec sql
045800000000           Open Csr_Read;
045900000000
046000000000       endsr;
046100000000
046200000000       //------------------------------------------------
046300000000       //*  $SqlWhere - Build the where clause
046400000000       //------------------------------------------------
046500000000       begsr $SqlWhere;
046600000000
046700000000         select;
046800000000           when wwCPOS = 1
046900150518>>>>         and WCGRP#1 > *zero;
047000150518>>>>         wwWhere = 'Where GHGRP# >= ' + %char(WCGRP#1);
047100000000
047200000000           when wwCPOS = 2
047300150518>>>>         and WCNME2 > *blank;
047400150518>>>>         wwWhere = 'Where upper(GHNME) like ' + ccQuote + '%' +
047500150518>>>>           %trim(WCNME2) + '%' + ccQuote;
047600000000
047700000000           when wwCPOS = 3
047800150518>>>>         and WCUSR3 > *blank;
047900150518>>>>         wwWhere = 'Where upper(CRDUSR) like ' + ccQuote + '%' +
048000150518>>>>           %trim(WCUSR3) + '%' + ccQuote;
048100000000
048200000000         endsl;
048300000000
048400000000       endsr;
048500000000
048600000000       //------------------------------------------------
048700000000       //*  $UserAction  ** - Process Function Keys or SFL options
048800000000       //------------------------------------------------
048900000000       begsr $UserAction;
049000000000
049100000000           // Process command keys:
049200000000           select;
049300000000
049400000000             // F10 = Position to:
049500000000             when *in10 = *ON;
049600000000               exsr $PositionTo;
049700000000
049800000000             // F5 or 'position to' field value change (*in40) - reload S/F:
049900000000             when *in05 = *ON
050000000000             OR *in40 = *ON;
050100000000               exsr $INSFL;
050200000000
050300000000             // Rollup (if records exist in S/F - *in32):
050400000000             when *in25 = *ON
050500000000             and *in32 = *ON;
050600000000               exsr $LoadSFL;
050700000000
050800000000             // F6 = Add a record:
050900000000             when *in06 = *on;
051000000000               exsr $AddRecord;
051100000000
051200000000             // F12= Cancel
051300000000             when *in12 = *ON;
051400000000               *in03=*on;
051500150518>>>>
051600000000             other;
051700000000
051800000000             // Enter:
051900000000             exsr $READC;
052000000000
052100000000           endsl;
052200000000
052300000000       endsr;
052400000000       //------------------------------------------------
052500000000       //*  $Error01  ** - Control Screen Validity Checking
052600000000       //------------------------------------------------
052700000000       begsr $Error01;
052800000000
052900000000         clear wwERR1;
053000000000
053100000000       endsr;
053200000000
053300000000       //------------------------------------------------
053400000000       //*  $PositionTo  ** - Position To
053500000000       //------------------------------------------------
053600000000       begsr $PositionTo;
053700000000
053800000000         // clear all 'position to' fields here:
053900150518>>>>     clear wcXXX1;
054000150518>>>>     clear wcXXX2;
054100150518>>>>     clear wcXXX3;
054200000000
054300000000         clear wwRRN1;
054400000000         clear hdSFLP;
054500000000
054600000000         // clear subfile:
054700000000         if *in32 = *ON;
054800000000           *in32 = *off;
054900000000           *in30 = *on;
055000000000           write SCRNC01;
055100000000           *in30 = *off;
055200000000         endif;
055300000000
055400000000         // Position cursor:
055500000000         *in36 = *on;
055600000000
055700000000         // Toggle to next 'position to' field:
055800000000         wwCPOS += 1;
055900000000
056000000000         if wwCPOS > cc#Pos;
056100000000           wwCPOS = 1;
056200000000         endif;
056300000000
056400000000         // Set 'position to' field display indicator:
056500000000         *in41 = *off;
056600000000         *in42 = *off;
056700000000         *in43 = *off;
056800000000
056900000000         select;
057000000000
057100000000           when wwCPOS = 1;
057200000000             *in41 = *on;
057300000000
057400000000           when wwCPOS = 2;
057500000000             *in42 = *on;
057600000000
057700000000           when wwCPOS = 3;
057800000000             *in43 = *on;
057900150518>>>>
058000000000         endsl;
058100000000
058200000000         // Force SFL to reload for new Position To
058300000000         wwLOAD = ccYES;
058400000000
058500000000       endsr;
058600000000
058700000000       //------------------------------------------------
058800000000       //*  $AddRecord  ** - Add a record
058900000000       //------------------------------------------------
059000000000       begsr $AddRecord;
059100000000
059200000000         // Maint pgm does not follow new standards so a popup window is used.
059300000000         wwLOAD = ccYES;
059400000000         clear dsApp2;
059500000000
059600000000         a2Sec = a1Sec;
059700000000         a2Actn = ccADD;
059800000000         a2xxx1 = *zero;
059900000000
060000000000         // Call add record prompt program
060100150518>>>>     // Xxx0121r(dsJld : dsApp2);
060200000000
060300000000         // If group number returned then position to new group number
060400000000         if a2xxx1 > *zero;
060500000000           wcxxx1 = a2xxx1;
060600000000           exsr $INSFL;
060700000000         endif;
060800000000
060900000000       endsr;
061000000000
061100000000       //------------------------------------------------
061200000000       //*  $READC  ** - Process Subfile Requests
061300000000       //------------------------------------------------
061400000000       begsr $READC;
061500000000
061600000000         clear wwERR2;
061700000000         clear wwRCDE;
061800000000         clear wwRRN#;
061900000000
062000000000         // Save current RRN:
062100000000         wwcRRN = wwRRN1;
062200000000
062300000000         // Read all records in the S/F:
062400000000         dow (wwRRN# < wwcRRN) and (wwERR2 <> ccERROR)
062500000000           and (wwRCDE <> ccINUSE) and (*in03 = *OFF);
062600000000
062700000000           wwRRN# += 1;
062800000000
062900000000           chain wwRRN# SCRNS01;
063000000000
063100000000           if %found;
063200000000             *in61 = *off;
063300000000
063400000000             // Option number was entered:
063500000000             if wsOPT# <> *BLANKS;
063600000000
063700000000               // Check for subfile option errors:
063800000000               exsr $Error02;
063900000000               hdSFLP = wwRRN1;
064000000000
064100000000               // Error occurred, return to mainline:
064200000000               select;
064300000000                 when wwERR2 = ccERROR;
064400000000                   *in61 = *on;
064500000000
064600000000                 // Options 2,5 for this and called program are the same.
064700000000                 when (dsActn = ccCHANGE) or (dsActn = ccDISPLAY);
064800150518>>>>               //wwCrdGrp# = %editc(wsGrp#:'X');
064900150518>>>>               //Xxx0071r(wwCrdGrp# :wsOpt#);
065000000000
065100000000                 // Delete option
065200000000                 when dsActn = ccDELETE;
065300150518>>>>               //wwCrdGrp# = %editc(wsGrp#:'X');
065400150518>>>>               //Xxx0071r(wwCrdGrp# :wsOpt#);
065500000000                   // Force reload of SFL
065600000000                   wwLOAD = ccYES;
065700000000
065800000000                 // Work with option
065900000000                 when dsActn = ccWRKWTH;
066000000000                   clear dsApp3;
066100000000                   a3Sec = a1Sec;
066200000000                   a3View = 1;
066300150518>>>>               //a3xxx1 = wsxxx1;
066400150518>>>>               //Xxx0122r(dsJld :dsApp3);
066500000000
066600000000               endsl;
066700000000
066800000000               clear wsOPT#;
066900000000               update SCRNS01;
067000000000
067100000000             endif;
067200000000           endif;
067300000000
067400000000         enddo;
067500000000
067600000000         // Reset current RRN:
067700000000         wwRRN1 = wwcRRN;
067800000000
067900000000         clear wwRCDE;
068000000000
068100000000       endsr;
068200000000       //
068300000000       //------------------------------------------------
068400000000       //*  $Error02  ** - Subfile Validity Checking
068500000000       //------------------------------------------------
068600000000       begsr $Error02;
068700000000
068800000000         // Check for valid option:
068900000000         wwX = %lookup(wsOpt# : wwOpt);
069000000000         if wwX > *zero;
069100000000           dsSplt = wwINMD(wwX);
069200000000         else;
069300000000           clear DSSPLT;
069400000000         endif;
069500000000
069600000000         select;
069700000000
069800000000           // if indicator 90 is off, option number is not valid.
069900000000           // if indicator wwZZ is off, user is not authorized to option.
070000000000
070100000000           when (wwX = *zero) or (*in(wwZZ)) = *OFF;
070200000000             wwMsgi = 'SHL0008';
070300000000             WrtErrMsg(wwMsgi);
070400000000             wwERR2 = ccERROR;
070500000000
070600000000         endsl;
070700000000
070800000000       endsr;
070900000000
071000000000       //------------------------------------------------
071100000000       //*  *inZSR  ** - Initialize Program
071200000000       //------------------------------------------------
071300000000       begsr *inZSR;
071400000000
071500000000         dsApp1 = wiApp1;
071600000000
071700000000         // clear message subfile:
071800000000         RmvErrMsg(DSPGMN);
071900000000
072000000000         // Default to the first 'position to' view if value not passed
072100000000         // to this program:
072200000000         // Set initial 'position to' display indicator. Also load
072300000000         // 'position to' values passed to this program (wiXXX1,2), if
072400000000         // applicable:
072500000000
072600000000         wwCPOS = a1VIEW;
072700000000
072800000000         select;
072900000000           when wwCPOS = *zero;
073000000000             wwCPOS = 1;
073100000000             *in40 = *on;
073200000000             *in41 = *on;
073300150518>>>>         wcXXXX1 = *zero;
073400000000
073500000000           when wwCPOS = 1;
073600000000             *in40 = *on;
073700000000             *in41 = *on;
073800150518>>>>         wcXXX1 = a1xxx1;
073900000000
074000000000           when wwCPOS = 2;
074100000000             *in40 = *on;
074200000000             *in42 = *on;
074300150518>>>>         wcXXX2 = a1xxx2;
074400000000
074500000000           when wwCPOS = 3;
074600000000             *in40 = *on;
074700000000             *in43 = *on;
074800150518>>>>         wcXXX3 = a1xxx3;
074900000000
075000000000         endsl;
075100000000         //****************************************************************
075200000000         // Field wiSEC is a 5 byte logical indicator field used to control
075300000000         // user access to all maintenance functions (eg; change, delete).
075400000000         // Each byte will have a value of either '0'(not authorized) or
075500000000         // '1'(authorized). This field will be moved into indicator
075600000000         // array *in,81.
075700000000         //
075800000000         //
075900000000         //  wiSEC = '00000'                  *in81 = Add/Copy
076000000000         //           |||||___ Work with      *in82 = Change
076100000000         //         Add|||     (Extra)        *in83 = Delete
076200000000         //            |||                    *in84 = Display
076300000000         //       Change||                    *in85 = Work with
076400000000         //             ||
076500000000         //        Delete|
076600000000         //              |
076700000000         //        Display
076800000000         //
076900000000         //****************************************************************
077000000000
077100000000         // Set up security options:
077200000000         if a1Sec = *BLANKS;
077300000000           SetSecurity(dsPgmn : a1Sec);
077400000000         endif;
077500000000
077600000000         // User not setup in security file:
077700000000         if a1SEC = '99999';
077800000000           a1Sec = '00000';
077900000000           wwLoad = ccNO;
078000000000           wwMsgi = 'SHL0009';
078100000000           WrtErrMsg(wwMsgi);
078200000000
078300000000         else;
078400000000           // clear messages:
078500000000           RmvErrMsg(DSPGMN);
078600000000
078700000000           // Set indicators 81-85
078800000000           for wwX = 1 to 5;
078900000000             wwZ = 80 + wwX;
079000000000             *in(wwZ) = %subst(a1Sec:wwX:1);
079100000000           EndFor;
079200000000
079300000000           // if program is called to select a record, turn off all
079400000000           // maintenance functions:
079500000000           if a1Sel = ccYES;
079600000000             *in86 = *on;
079700000000             *in81 = *off;
079800000000             *in82 = *off;
079900000000             *in83 = *off;
080000000000             *in84 = *on;
080100000000             *in85 = *off;
080200000000           endif;
080300000000
080400000000         endif;
080500000000
080600000000         //****************************************************************
080700000000         // All users are authorized to any *in89 option from table wwOpt:
080800000000         //
080900000000         //        Option Named
081000000000         //            Constant
081100000000         //              |    |
081200000000         // Authorization|    |
081300000000         //     Indicator|    |
081400000000         //            |||    |
081500000000         //      Option|||    |
081600000000         //          |||||    |
081700000000         //   eg ;    282CHANGE
081800000000         //          2 82CHANGE
081900000000         //           789ITMINQ
082000000000         //          7 89ITMINQ
082100000000         //           989POINQ
082200000000         //          9 89POINQ
082300000000         //
082400000000         //  In this example, option 2 to change a record is available
082500000000         //  only to users which have authorization (*in82). option 7 to
082600000000         //  view the item inquiry and option 9 to view the PO inquiry are
082700000000         //  setup in the table with indicator *in89, therefore will be
082800000000         //  available to all users, without restriction.
082900000000         //
083000000000         //****************************************************************
083100000000
083200000000         *in89 = *on;
083300000000         *in36 = *on;
083400000000
083500000000       endsr;
083600000000
083700000000**
083800000000186SELECT
083900000000282CHANGE
084000000000381COPY
084100000000483DELETE
084200000000584DISPLAY
084300000000885CPYCUST
084400000000984WRKWTH
