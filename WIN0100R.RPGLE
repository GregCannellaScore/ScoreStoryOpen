000100000000      /copy qcpylesrc,stdhspec
000200000000       //*******************************************************************
000300000000       //
000400000000       //  Program....: WIN0300R
000500000000       //
000600000000       //  Description:
000700000000       //
000800000000       //  Programmer.:
000900000000       //
001000000000       //  Date.......:
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
002900000000       //****************************************************************
003000000000       // Indicator Usage:
003100000000       // Ind      Use
003200000000       // 01-24    Function keys
003300000000       // 25       Rollup
003400000000       // 30-34    Subfile keywords
003500000000       // 36       Position to
003600000000       // 37       Error indicator
003700000000       // 40       Search field change
003800000000       // 41-42    Search field display
003900000000       // 61       Subfile option error
004000000000       // 80-89    Reserved for Security
004100000000       // 90-99    Hit/Miss
004200000000       //****************************************************************
004300000000       // Field Definitions
004400000000       //
004500000000       // Prefix
004600000000       // ww     - Program described work fields
004700000000       // wi     - APPL *ENTRY input parameters
004800000000       // ws     - Subfile fields
004900000000       // wc     - Subfile control fields
005000000000       // hd     - Hidden fields
005100000000       // ax     - APPx output parameters for called programs
005200000000       // ds     - Data structure fields
005300000000       // cc     - Constants
005400000000       //
005500000000       // Display Record Format Definitions
005600000000       //
005700000000       // Prefix
005800000000       // SCRNS  - Subfile
005900000000       // SCRNC  - Subfile control
006000000000       // SCRNK  - Command key
006100000000       // SCRNR  - Standard display
006200000000       // WNDWB  - Window border
006300000000       // WNDWR  - Standard window display
006400000000       // MSGCTL - Message subfile control
006500000000       //
006600000000       //****************************************************************
006700000000       //PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
006800000000       //P          P  R  O  G  R  A  M    S  P  E  C  S                P
006900000000       //PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007000000000
007100000000       //------------------------------------------------
007200000000       //--Define the files
007300000000>>>>>  dcl-f WIN0100D workstn infds(infds) sfile(scrns01:wwRRN1);
007400000000>>>>>  dcl-f CodeCat usage(*input) keyed;
007500000000>>>>>  dcl-f CodeHdr usage(*input) keyed;
007600000000>>>>>  dcl-f Usefile usage(*input) keyed;
007700000000>>>>>  dcl-f Codusrm usage(*input) keyed;
007800000000
007900000000       //------------------------------------------------
008000000000       //--Parameter definitions
008100000000       dcl-ds dsJld
008200000000         extname('DSJLD');
008300000000       end-ds;
008400000000
008500000000       dcl-ds dsApp2 len(512);
008600000000         a2Sec char(5);       // Security
008700000000         a2Iuse char(10);     // In Use Flag
008800000000         a2Inlr char(1);      // Turn on LR indicator
008900000000         a2Actn char(10);     // Define Action
009000000000         a2Code char(10);
009100000000         a2Catk char(10);
009200000000       end-ds;
009300000000
009400000000       //------------------------------------------------
009500000000       //--Entry Prototype
009600000000>>>>>  //dcl-pr Win0100r extpgm('WIN0100R');
009700000000>>>>>  //  wiJld like(dsJld);
009800000000>>>>>  //  wiApp1 like(dsApp1);
009900000000>>>>>  //end-pr;
010000000000
010100000000>>>>>  //dcl-pi Win0100r;
010200000000>>>>>  //  wiJld like(dsJld);
010300000000>>>>>  //  wiApp1 like(dsApp1);
010400000000>>>>>  //end-pi;
010500000000
010600000000>>>>>  dcl-pr Win0100r extpgm('WIN0100R');
010700000000>>>>>    wi#CatC like(p#CatC);
010800000000>>>>>    wi#CatK like(p#CatK);
010900000000>>>>>  end-pr;
011000000000
011100000000       //------------------------------------------------
011200000000       //--Prototypes For Called Programs
011300000000
011400000000       // Write message to screen
011500000000       dcl-pr WrtErrMsg extpgm('ERMSG1');
011600000000         wiMsgi like(wwMsgi);
011700000000       end-pr;
011800000000
011900000000       // Remove error messages
012000000000       dcl-pr RmvErrMsg extpgm('ERMSG2');
012100000000         wiDsPgnm like(DSPGMN);
012200000000       end-pr;
012300000000
012400000000       //------------------------------------------------
012500000000       // Incoming entry parms:
012600000000>>>>>  //dcl-ds dsApp1 len(512);
012700000000>>>>>  //  a1Sec char(5);       // Security
012800000000>>>>>  //  a1Sel char(1);       // Select a record
012900000000>>>>>  //  a1View zoned(2:0);   // Screen to display
013000000000>>>>>  //end-ds;
013100000000
013200000000       // Parm to hold message data:
013300000000       //dcl-ds dsMDTA len(500)
013400000000       //end-ds;
013500000000
013600000000       // Split option indicator and action code:
013700000000       dcl-ds DSSPLT len(12);
013800000000         ZZ packed(2:0);
013900000000         DSACTN char(10);
014000000000       end-ds;
014100000000
014200000000       // File Information Data Structure
014300000000       dcl-ds INFDS;
014400000000         SFLLOC bindec(4) pos(378);
014500000000       end-ds;
014600000000
014700000000       // Program Status Data Structure
014800000000       dcl-ds dsPgmDs PSDS;
014900000000         dsPgmn *PROC;
015000000000         dsUser char(10) pos(254);
015100000000       end-ds;
015200000000
015300000000       //------------------------------------------------
015400000000       // Constants
015500000000
015600000000       // Number of records to fill S/F page:
015700000000       dcl-c wwPgsz const(12);
015800000000
015900000000       // General constants:
016000000000       dcl-c ccError const('ERROR');
016100000000       dcl-c ccNo const('N');
016200000000       dcl-c ccYes const('Y');
016300000000
016400000000       //------------------------------------------------
016500000000       // Work Fields
016600000000       dcl-s wwCNT1 packed(2:0) INZ;
016700000000       dcl-s wwCPOS zoned(2:0) INZ(1);
016800000000       dcl-s wwCTAB char(3)    INZ;
016900000000       dcl-s wwCKEY char(27) inz;
017000000000       dcl-s wwNFND char(1)  INZ;
017100000000       dcl-s wwFRST char(1) inz('Y');
017200000000       dcl-s wwLOAD char(1) INZ('Y');
017300000000       dcl-s wwERR1 char(10) INZ;
017400000000       dcl-s wwERR2 char(10) INZ;
017500000000       dcl-s wwERR3 char(1) INZ;
017600000000       dcl-s wwRCDE char(10) INZ;
017700000000       dcl-s wwMSGI char(7) inz;
017800000000       dcl-s wwRRN1 Like(hdSFLP) inz;
017900000000       dcl-s wwRRN# Like(hdSFLP) inz;
018000000000       dcl-s wwCRRN Like(hdSFLP) inz;
018100000000       dcl-s W#User char(10);
018200000000
018300000000>>>>>  dcl-s P#catk Like(CCcatk);
018400000000>>>>>  dcl-s P#catc Like(CCcatc);
018500000000
018600000000      //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
018700000000      //M                 M  A  I  N  L  I  N  E                       M
018800000000      //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
018900000000      // Main loop:
019000000000
019100000000       dow *IN03 <> *ON;
019200000000
019300000000         // Reload subfile, if requested:
019400000000         if wwLOAD = ccYes;
019500000000           exsr $INSFL;
019600000000           wwLOAD = ccNo;
019700000000         endif;
019800000000
019900000000         write SCRNK01;
020000000000         exfmt SCRNC01;
020100000000
020200000000         *in69 = THEFLD;
020300000000
020400000000         if wwFRST = ccYes;
020500000000           wwFrst = ccNo;
020600000000         endif;
020700000000
020800000000         hdSFLP = SFLLOC;
020900000000
021000000000         // Clear messages:
021100000000         RmvErrMsg(dsPgmN);
021200000000
021300000000         // Process command keys:
021400000000         select;
021500000000
021600000000           // Stop processing of F3 or F12 was pressed
021700000000           when (*in03 = *on) or (*in12 = *on);
021800160320             *in03 = *on;
021900000000
022000000000           // Rollup (if records exist in S/F - *IN32):
022100000000           when *In25 and *In32;
022200000000             exsr $LoadSFL;
022300000000
022400000000           // F06 = Add
022500000000           when *In06;
022600000000             //clear dsApp2;
022700000000             //Eval A2actn = 'ADD';
022800000000             //Eval A2Code = P#catc;
022900000000             //Eval A2CatK = P#catk;
023000000000             //AddProgram(dsJld : dsApp2);
023100000000
023200000000             wwLOAD = ccYes;
023300000000
023400000000           // F12= Cancel
023500000000           when *In12;
023600000000             *in03 = *on;
023700000000
023800000000           other;
023900000000
024000000000             // Enter:
024100000000             exsr $READC;
024200000000         endsl;
024300000000
024400000000       enddo;
024500000000
024600000000       *inlr = *ON;
024700000000
024800000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
024900000000       //$              S  U  B  R  O  U  T  I  N  E  S                 $
025000000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025100000000
025200000000       //------------------------------------------------
025300000000       // Initialize Subfile
025400000000       //------------------------------------------------
025500000000       begsr $INSFL;
025600000000
025700000000         clear wwRRN1;
025800000000         hdSFLP = 1;
025900000000         wwNfnd = ccNo;
026000000000
026100000000         // Clear subfile:
026200000000         if *In32 = *ON;
026300000000           *IN32 = *OFF;
026400000000           *IN30 = *ON;
026500000000           write SCRNC01;
026600000000
026700000000           *in30 = *off;
026800000000
026900000000         endif;
027000000000
027100000000         // Check for subfile control errors:
027200000000         if wwFrst = ccNo;
027300000000           exsr $Error01;
027400000000         endif;
027500000000
027600000000         // Position file:
027700000000         select;
027800000000
027900000000           when wwCPOS = 1;
028000000000>>>>>        SETLL (p#CatC) Codecat;
028100000000>>>>>        *IN99 = %EQUAL;
028200000000>>>>>        if *IN99 = *OFF;
028300000000>>>>>          wwNFND = ccYes;
028400000000>>>>>        endif;
028500000000
028600000000         endsl;
028700000000
028800000000         // Load subfile:
028900000000         exsr $LoadSFL;
029000000000
029100000000         // Send message if search criteria is not found:
029200000000         if wwRRN1 = *zero;
029300000000           wwMsgi = 'SHL0011';
029400000000           WrtErrMsg(wwMsgi);
029500000000         endif;
029600000000
029700000000       endsr;
029800000000
029900000000       //------------------------------------------------
030000000000       // Control Screen Validity Checking
030100000000       //------------------------------------------------
030200000000       begsr $Error01;
030300000000
030400000000         clear wwERR1;
030500000000
030600000000>>>>>    //if AA <> BB;
030700000000>>>>>       //wwMsgi = 'SHL0011';
030800000000>>>>>       //WrtErrMsg(wwMsgi);
030900000000>>>>>     //endif;
031000000000
031100000000       endsr;
031200000000
031300000000       //------------------------------------------------
031400000000       // Load Subfile
031500000000       //------------------------------------------------
031600000000       begsr $LoadSFL;
031700000000
031800000000         clear wwCNT1;
031900000000
032000000000         *In34 = *OFF;
032100000000
032200000000         // Load one page at a time:
032300000000         dow (wwCNT1 < wwPGSZ) and (*In34 = *Off);
032400000000
032500000000           select;
032600000000
032700000000             // Read from file, based on current 'position to' view:
032800000000             when wwCPOS = 1;
032900000000               Reade (p#CatC) Codecat;
033000000000               *IN34 = %EOF;
033100000000
033200000000           endsl;
033300000000
033400000000           if *In34 = *Off;
033500000000           clear WSOPT#;
033600000000
033700000000           // Load subfile fields here:
033800000000>>>>>      Wscatk = CCcatk;
033900000000>>>>>      Wscatd = CCcatd;
034000000000
034100000000           wwRRN1 += 1;
034200000000           wwCnt1 += 1;
034300000000
034400000000           if wwCNT1 = 1;
034500000000             hdSFLP = wwRRN1;
034600000000           endif;
034700000000
034800000000           write SCRNS01;
034900000000
035000000000           endif;
035100000000
035200000000         enddo;
035300000000
035400000000         if wwRRN1 > *ZERO;
035500000000           *In32 = *ON;
035600000000         endif;
035700000000
035800000000         *In25 = *Off;
035900000000
036000000000       endsr;
036100000000
036200000000       //------------------------------------------------
036300000000       // Process Subfile Requests
036400000000       //------------------------------------------------
036500000000       begsr $READC;
036600000000
036700000000         clear wwERR2;
036800000000         clear wwRCDE;
036900000000         clear wwRRN#;
037000000000
037100000000         // Save current RRN:
037200000000         wwCrrn = wwRRN1;
037300000000
037400000000         // Read all records in the S/F:
037500000000         dow (wwRRN# < wwCRRN) and
037600000000               (wwERR2 <> ccError) and (*IN03 = *off);
037700000000           wwRRN# += 1;
037800000000
037900000000           CHAIN wwRRN# SCRNS01;
038000000000           *IN99 = NOT %FOUND;
038100000000           if *IN99 = *OFF;
038200000000
038300000000             // Option number was entered:
038400000000             if WSOPT# <> *BLANKS;
038500000000               hdSFLP = wwRRN1;
038600000000>>>>>          P#catk = WScatk;
038700000000               *in03 = *on;
038800000000             endif;
038900000000           endif;
039000000000
039100000000         enddo;
039200000000
039300000000         // Reset current RRN:
039400000000         wwRRN1 = wwCrrn;
039500000000
039600000000         clear wwRCDE;
039700000000
039800000000       endsr;
039900000000       //------------------------------------------------
040000000000       // Get Key Value Heading
040100000000       //------------------------------------------------
040200000000>>>>>  begsr $codehdr;
040300000000
040400000000>>>>>    chain p#catc codehdr;
040500000000>>>>>    if %found and chkeylab <> *blanks;
040600000000>>>>>      wrkeylbl     = chkeylab;
040700000000>>>>>    else;
040800000000>>>>>      wrkeylbl     = '  Key Value';
040900000000>>>>>    endif;
041000000000
041100000000>>>>>  endsr;
041200000000
041300000000       //---------------------------------------------------------------
041400000000       //  *INZSR  ** - Initialize Program
041500000000       //---------------------------------------------------------------
041600000000       begsr *INZSR;
041700000000
041800000000         wrPgmN = dsPgmN;
041900000000
042000000000         // clear message subfile:
042100000000         RmvErrMsg(dsPgmn);
042200000000
042300000000         // Default to the first 'position to' view if value not passed
042400000000         // to this program:
042500000000         wwCpos = 1;
042600000000
042700000000         // Get the key value heading
042800000000
042900000000>>>>>    exsr $codehdr;
043000000000         //
043100000000         // check if user has authority to use F6 key...
043200000000         *in60 = *off;
043300000000         W#user = dsuser;
043400000000         Setll (w#User : p#CatC) Codusrm;
043500000000         if not %equal(Codusrm);
043600000000           // if no individual access is found, check for group access...
043700000000           Chain dsUser Usefile;
043800000000           if %found(Usefile);
043900000000             W#User = upgrpf;
044000000000             Setll (w#User : p#CatC) Codusrm;
044100000000           endif;
044200000000         endif;
044300000000
044400000000         if %equal(Codusrm);
044500000000           *in60 = *on;
044600000000         endif;
044700000000
044800000000         wrcatc = P#catc;
044900000000
045000000000       endsr;
045100000000
