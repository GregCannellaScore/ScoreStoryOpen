000100000000      /copy qcpylesrc,stdhspec
000200000000       //*******************************************************************
000300000000       //
000400000000       //  Program:
000500000000       //
000600000000       //  Description:
000700000000       //
000800000000       //  Programmer:
000900000000       //
001000000000       //  Date:
001100000000       //
001200000000       // Comments........ Files will remain open until this program is
001300000000       //                  called with parm DSINLR equal to 'Y'.
001400000000       //
001500000000       //*******************************************************************
001600000000       //                   Modification Log
001700000000       //
001800000000       //  Initials  Date      Description
001900000000       //-------------------------------------------------------------------
002000000000       //   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002100000000       //
002200000000       //
002300000000       //
002400000000       //*******************************************************************
002500000000       //                   Indicator Usage
002600000000       //
002700000000       //   Ind.   Description
002800000000       //-------------------------------------------------------------------
002900000000       //   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
003000000000       //
003100000000       //
003200000000       //*******************************************************************
003300000000       // Indicator Usage:
003400000000       // Ind      Use
003500000000       // 01-24    Function keys
003600000000       // 25       Rollup key
003700000000       // 36       Protect all input fields
003800000000       // 37       Protect key fields in change mode
003900000000       // 38       Record format level CHANGE keyword indicator
004000000000       // 40-51    Error Indicators
004100000000       // 60       Record lock
004200000000       // 90-99    Hit/Miss
004300000000       //
004400000000       //****************************************************************
004500000000       //****************************************************************
004600000000       // Field Definitions
004700000000       //
004800000000       // Prefix
004900000000       // ww     - Program described work fields
005000000000       // wi     - APPL input parameters
005100000000       // wr     - Display record fields
005200000000       // hd     - Hidden fields
005300000000       // ax     - APPx output parameters for called programs
005400000000       // ds     - Data structure fields
005500000000       //
005600000000       //
005700000000       // Display Record Format Definitions
005800000000       //
005900000000       // Prefix
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
007000000000       //------------------------------------------------
007100000000       //--Define files
007200000000>>>>   dcl-f xxx0101d workstn usropn;
007300000000
007400000000>>>>   dcl-f filxxxx usage(*output :*update :*delete) keyed;
007500000000
007600000000       //------------------------------------------------
007700000000       //--Entry Prototype
007800000000
007900000000       dcl-pr Shl0201R  extpgm('SHL0201R');
008000000000         wiJld like(dsJld);
008100000000         wiApp1 like(App1);
008200000000       end-pr;
008300000000       dcl-pi Shl0201R;
008400000000         wiJld like(dsJld);
008500000000         wiApp1 like(App1);
008600000000       end-pi;
008700000000
008800000000       //------------------------------------------------
008900000000       //--Prototypes For Called Programs
009000000000
009100000000       // Write message to screen
009200000000       dcl-pr WrtErrMsg extpgm('ERMSG1');
009300000000         wiMsgi like(wwMsgi);
009400000000       end-pr;
009500000000
009600000000       // Remove error messages
009700000000       dcl-pr RmvErrMsg extpgm('ERMSG2');
009800000000         wiDsPgnm like(DSPGMN);
009900000000       end-pr;
010000000000
010100000000       // Get User Locking Record
010200000000       dcl-pr GetUsrLockRec extpgm('GEN8001C');
010300000000         wiIUse char(10);
010400000000       end-pr;
010500000000
010600000000       // Prompt program
010700000000       dcl-pr DspPrompt extpgm('GEN0109R');
010800000000         wiCITab like(wwCTab);
010900000000         wiCKey like(wwCKey);
011000000000       end-pr;
011100000000
011200000000       //------------------------------------------------
011300000000       //--Data Structues
011400000000
011500000000       // Incoming Parameter Definitions
011600000000       dcl-ds dsJld
011700000000         extname('DSJLD');
011800000000       end-ds;
011900000000
012000000000       // Incoming parms:
012100000000       dcl-ds App1;
012200000000         wiSec char(5);       // Security
012300000000         wiIUse char(10);     // In Use Flag
012400000000         wiInlr char(1);      // Turn on LR indicator
012500000000         wiActn char(10);     // Define Action
012600000000>>>>     wiXXX1 char(1);
012700000000>>>>     wiXXX2 char(1);
012800000000       end-ds;
012900000000
013000000000       dcl-ds PgmDs psds;
013100000000         dsPgmn *proc;
013200000000         dsUser char(10) pos(254);
013300000000       end-ds;
013400000000
013500000000       //------------------------------------------------
013600000000       // General Constants:
013700000000       dcl-c ccError const('ERRor');
013800000000       dcl-c ccInUse CONST('INUSE');
013900000000       dcl-c ccChange CONST('CHANGE');
014000000000       dcl-c ccCopy CONST('COPY');
014100000000       dcl-c ccAdd CONST('ADD');
014200000000       dcl-c ccDelete CONST('DELETE');
014300000000       dcl-c ccDisplay CONST('DISPLAY');
014400000000       dcl-c ccNext CONST('NEXT');
014500000000       dcl-c ccExit CONST('EXIT');
014600000000       dcl-c ccNo  CONST('N');
014700000000       dcl-c ccYes CONST('Y');
014800000000
014900000000       // Work Fields
015000000000       dcl-s wwRcde like(WRRCDE);
015100000000       dcl-s wwX zoned(1:0);
015200000000       dcl-s wwCTab char(3);
015300000000       dcl-s wwCKey char(27);
015400000000       dcl-s wwFrst char(1);
015500000000       dcl-s wwClr1 char(1);
015600000000       dcl-s wwNext char(1);
015700000000       dcl-s wwUpd1 char(1);
015800000000       dcl-s wwErr1 char(10);
015900000000       dcl-s wwCnt1 zoned(3:0);
016000000000       dcl-s wwGetR char(1);
016100000000       dcl-s wwMsgi char(10);
016200000000
016300000000
016400000000       // Header screen Action desriptions:
016500000000       dcl-s wwMod char(10) dim(5) ctdata perrcd(1);
016600000000       dcl-s wwDsc char(30) dim(5) alt(wwMod);
016700000000
016800000000       //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
016900000000       //M                 M  A  I  N  L  I  N  E                       M
017000000000       //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
017100000000
017200000000       exsr $Inzsr;
017300000000       exsr $Clear;
017400000000
017500000000       // Clear error message sfl
017600000000       RmvErrMsg(dsPgmn);
017700000000
017800000000       // Retrieve record:
017900000000       exsr $GetRecord;
018000000000
018100000000       // if record is in use, retrieve the user who has the lock,
018200000000       // close the display file, and return to the previous program:
018300000000       if wwRcde = ccInUse;
018400000000         GetUsrLockRec(wiIUse);
018500000000>>>>     close XXX0101D;
018600000000         return;
018700000000       endif;
018800000000
018900000000       // Retrieve field descriptions:
019000000000       exsr $GetFldDesc;
019100000000
019200000000       // Main loop:
019300000000       dou wwRcde = ccExit
019400000000       or wwRcde = ccNext;
019500000000
019600000000         // Clear all fields, if requested:
019700000000         if wwClr1 = ccYes;
019800000000           exsr $Clear;
019900000000         endif;
020000000000
020100000000         // Retrieve record, if requested:
020200000000         if wwGetR = ccYes;
020300000000           exsr $GetRecord;
020400000000           exsr $GetFldDesc;
020500000000         endif;
020600000000
020700000000         // Lookup header screen mode description:
020800000000         wwX = %lookup(wiActn:wwMod);
020900000000         if wwX > *zero;
021000000000           WRDSC1 = wwdsc(wwX);
021100000000         endif;
021200000000         WRPGMN = dsPgmn;
021300000000
021400000000         // Display screen:
021500000000         write MSGCTL1;
021600000000         write SCRNK01;
021700000000         exfmt SCRNR01;
021800000000
021900000000         if wwFrst = YES;
022000000000           wwFrst = ccNo;
022100000000         endif;
022200000000
022300000000         wwGetr = ccNo;
022400000000
022500000000         // Set off error indicators here:
022600000000>>>>       *in40 = *off;
022700000000
022800000000         clear wwErr1;
022900000000
023000000000         // Clear messages:
023100000000         RmvErrMsg(dsPgmn);
023200000000
023300000000         // Process screen action taken by user
023400000000         select;
023500000000           // Exit and return to previous program
023600000000           when (*in03 = *on) or (*in12 = *on);
023700000000             wwRcde = ccNext;
023800000000
023900000000           // F4 = Prompt:
024000000000           when *in04 = *on;
024100000000             exsr $Prompt;
024200000000             exsr $GetFldDesc;
024300000000
024400000000           // Display mode then no other action is required
024500000000           when wiActn = ccDisplay;
024600000000             wwRcde = ccNext;
024700000000
024800000000           // Enter pressed
024900000000           other;
025000000000
025100000000             // Error check, if in maintenance mode:
025200000000             if *IN36 = *OFF;
025300000000               exsr $ErrorChk01;
025400000000             endif;
025500000000
025600000000             // if no error, update record:
025700000000             if WWERR1 <> ERRor;
025800000000               exsr $GetFldDesc;
025900000000               exsr $ENTER;
026000000000             endif;
026100000000
026200000000           endsl;
026300000000
026400000000       enddo;
026500000000
026600000000       // Pass return code back to calling program through JLD field:
026700000000       wrRcde = wwRcde;
026800000000
026900000000      // Close the display file:
027000000000>>>>   close XXX0101D;
027100000000
027200000000       // Release record lock:
027300000000       if wiActn = ccChange
027400000000       or wiActn = ccDelete;
027500000000>>>>     unlock FILXXXX;
027600000000       endif;
027700000000
027800000000       return;
027900000000
028000000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028100000000       //$              S  U  B  R  O  U  T  I  N  E  S                 $
028200000000       //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028300000000
028400000000       //------------------------------------------------
028500000000       //*  $CLEAR  ** - Intialize Program/Database Fields
028600000000       //------------------------------------------------
028700000000       begsr $Clear;
028800000000
028900000000         // Program stays open. All program/screen fields and indicators
029000000000         // must be re-initialized here each time this program is called.
029100000000
029200000000
029300000000
029400000000         // Initialize screen and data base fields:
029500000000
029600000000         clear SCRNR01;
029700000000>>>>     clear @FILXXXX;
029800000000         //
029900000000         // Field definitions and initialization:
030000000000         //
030100000000
030200000000         //
030300000000         // Clear all *LIKE definitions:
030400000000         //
030500000000
030600000000         clear wwRcde;
030700000000
030800000000         // Initialize program described fields:
030900000000         wwX = *zero;
031000000000         wwCTab = *blank;
031100000000         wwCKey = *blank;
031200000000         wwFrst = ccYes;
031300000000         wwClr1 = ccNo;
031400000000         wwNexT = *blank;
031500000000         wwUpd1 = *blank;
031600000000         wwErr1 = *blank;
031700000000         wwCnt1 = *zero;
031800000000
031900000000         // Fill default screen values:
032000000000         //
032100000000         //
032200000000         //
032300000000         // Fill default screen values from JLD:
032400000000         //
032500000000         //
032600000000         //
032700000000         // Protect all input capable fields:
032800000000         //
032900000000
033000000000         if wiActn = ccDisplay
033100000000         or wiActn = ccDelete;
033200000000           *in36 = *on;
033300000000
033400000000         else;
033500000000           *in36 = *off;
033600000000
033700000000         endif;
033800000000
033900000000         // Protect key fields in change mode:
034000000000         if wiActn = ccChange;
034100000000           *in37 = *on;
034200000000
034300000000         else;
034400000000           *in37 = *off;
034500000000
034600000000         endif;
034700000000
034800000000         *in60 = *off;
034900000000
035000000000       endsr;
035100000000
035200000000       //------------------------------------------------
035300000000       //*  $GetRecord  ** - Retrieve Data Base Record
035400000000       //------------------------------------------------
035500000000       begsr $GetRecord;
035600000000
035700000000         if wiActn = ccAdd;
035800000000           exsr $LoadScreen;
035900000000
036000000000         else;
036100000000
036200000000           // Do not lock record if copy or display mode:
036300000000           if (wiActn = ccCopy) or wiActn = ccDisplay;
036400000000>>>>         chain(N) (X0001: X0002) filxxxx;
036500000000           else;
036600000000>>>>         chain(E) (X0001: X0002) filxxxx;
036700000000           endif;
036800000000
036900000000           select;
037000000000             when %error;
037100000000               wwRcde = ccInUse;
037200000000             when %found;
037300000000               exsr $LoadScreen;
037400000000           endsl;
037500000000
037600000000         endif;
037700000000
037800000000       endsr;
037900000000
038000000000       //------------------------------------------------
038100000000       //*  $LoadScreen - Move Data Base Fields to Screen Fields
038200000000       //------------------------------------------------
038300000000       begsr $LoadScreen;
038400000000
038500000000         // Add/copy mode default values:
038600000000>>>>     if (wiActn = ccAdd) or (wiActn = ccCopy);
038700000000           if wiActn = ccAdd;
038800000000             // Move key values into key fields:
038900000000
039000000000>>>>         WR0001 = wiXXX1;
039100000000
039200000000           endif;
039300000000         endif;
039400000000
039500000000         select;
039600000000
039700000000           when wiActn = ccCopy
039800000000           or wiActn = ccChange
039900000000           or wiActn = ccDisplay
040000000000           or wiActn = ccDelete;
040100000000
040200000000           // Move DB fields to screen fields here:
040300000000
040400000000>>>>         WR0001 = DB0001;
040500000000
040600000000           // Display last update user/date:
040700000000
040800000000           if wiActn <> ccCopy;
040900000000             //
041000000000
041100000000>>>>         WRLUSR = DBLUSR;
041200000000>>>>         WRLPGM = DBLPGM;
041300000000
041400000000>>>>         if DBLDTE <> 0;
041500000000>>>>           WRLDTE = %int(%char(%date(gdDate:*cymd):*mdy0));
041600000000
041700000000             else;
041800000000               Clear wrldte;
041900000000             endif;
042000000000
042100000000>>>>         WRLITM = DBLTIM;
042200000000
042300000000           endif;
042400000000
042500000000         endsl;
042600000000
042700000000       endsr;
042800000000
042900000000       //------------------------------------------------
043000000000>>>>   //*  $GetFldDesc  ** - Retrieve field descriptions
043100000000       //------------------------------------------------
043200000000       begsr $GetFldDesc;
043300000000         //
043400000000       endsr;
043500000000
043600000000       //------------------------------------------------
043700000000       //*  $PRMPT  ** - Process Promptable Fields
043800000000       //------------------------------------------------
043900000000       begsr $Prompt;
044000000000
044100000000         //****************************************************************
044200000000         //  Field HDCSRF (defined in DDS) contains the field name which
044300000000         //  contains the cursor. if valid, a prompting program may be
044400000000         //  called to select a record from a list of valid values for
044500000000         //  the prompted field. The value selected should then be placed
044600000000         //  in the field which was prompted.
044700000000         //
044800000000         // eg; HDCSRF    WHEQ 'WRXXX1'
044900000000         //      Cursor resides in field WRXXX1
045000000000         //
045100000000         //     CALL 'GEN0109R'
045200000000         //      Codes file prompting program.
045300000000         //
045400000000         //     PARM '653'     WWCTAB
045500000000         //      Outgoing parm.
045600000000         //
045700000000         //     PARM *BLANKS   WWCKEY
045800000000         //      Return parm.
045900000000         //
046000000000         //     MOVELWWCKEY    WRXXX1
046100000000         //      Move return parm into prompted field.
046200000000         //
046300000000         //****************************************************************
046400000000         //
046500000000         select;
046600000000
046700000000>>>>     when HDCSRF = 'WRXXX1';
046800000000           wwCTab = '653';
046900000000           wwCKey = *blank;
047000000000           DspPrompt(wwCTab :wwCKey);
047100000000
047200000000           if wwCKey <> *blank;
047300000000             WRXXX1 = wwCKey;
047400000000
047500000000           endif;
047600000000
047700000000>>>>     when HDCSRF = 'WRXXX2';
047800000000           wwCTab = '654';
047900000000           wwCKey = *blank;
048000000000           DspPrompt(wwCTab :wwCKey);
048100000000
048200000000           if wwCKey <> *BLANKS;
048300000000             WRXXX2 = wwCKey;
048400000000
048500000000           endif;
048600000000
048700000000         // Non propmtable area:
048800000000         other;
048900000000           wwMsgi = 'SHL0004';
049000000000           WrtErrMsg(wwMsgi);
049100000000
049200000000         endsl;
049300000000
049400000000       endsr;
049500000000
049600000000       //------------------------------------------------
049700000000>>>>   //*  $ERR01  ** - Validity Checking
049800000000       //------------------------------------------------
049900000000       begsr $ErrorChk01;
050000000000
050100000000         clear wwErr1;
050200000000
050300000000         //****************************************************************
050400000000         // All error conditions must have the following lines of code:
050500000000         //
050600000000         //   MOVE *ON       *INXX
050700000000         //     Where *INXX = field error indicator in DDS.
050800000000         //
050900000000         //   MOVELERRor     WWERR1
051000000000         //     Program error flag.
051100000000         //
051200000000         //   MOVEL'XXX0001' WWMSGI
051300000000         //     Where XXX0001 = error message id to be displayed.
051400000000         //
051500000000         //   MOVELXXXXXX    WWMSGF
051600000000         //     Where XXXXXX = name of the message file which contains
051700000000         //     the message id contained in field WWMSGI.
051800000000         //
051900000000         //   CALL 'ERMSG1'MSGP01
052000000000         //     Message handling program.
052100000000         //****************************************************************
052200000000
052300000000         // Record already exists on file:
052400000000
052500000000         if (wiActn = ccAdd) or (wiActn = ccCopy);
052600000000>>>>       setll XXXK02 FILXXXX;
052700000000           if %EQUAL;
052800000000             wwErr1 = ccError;
052900000000             wwMsgi = 'SHL0005';
053000000000             WrtErrMsg(wwMsgi);
053100000000           endif;
053200000000         endif;
053300000000
053400000000       endsr;
053500000000
053600000000       //------------------------------------------------
053700000000       //*  $ENTER  ** - Enter Key Pressed
053800000000       //------------------------------------------------
053900000000       begsr $Enter;
054000000000
054100000000         // Update only if screen has been changed:
054200000000         if *IN38 = *ON;
054300000000           wwUpd1 = ccYes;
054400000000         endif;
054500000000
054600000000         // Update database according to current mode:
054700000000         clear wwCnt1;
054800000000         wwRcde = ccNext;
054900000000
055000000000         select;
055100000000
055200000000           when (wiActn = ccChange) and (wwUpd1 = ccYes);
055300000000             exsr $LoadFile;
055400000000>>>>          update @FILXXXX;
055500000000
055600000000           when (wiActn = ccAdd) or (wiActn = ccCopy);
055700000000             exsr $LoadFile;
055800000000>>>>          write @FILXXXX;
055900000000
056000000000           when wiActn = ccDelete;
056100000000>>>>          delete FILXXXX;
056200000000
056300000000         endsl;
056400000000
056500000000         // Pass 'position to' fields back to calling program:
056600000000>>>>     wiXXX1 = WRXXX1;
056700000000>>>>     wiXXX2 = WRXXX2;
056800000000
056900000000         // if add mode, initialize all fields and redisplay the screen:
057000000000         if wiActn = ccAdd;
057100000000           clear wwRcde;
057200000000           wwClr1 = ccYes;
057300000000           wwGetR = ccYes;
057400000000         endif;
057500000000
057600000000         wwUpd1 = ccNo;
057700000000
057800000000       endsr;
057900000000
058000000000       //------------------------------------------------
058100000000       //*  $LoadFile - Load Database Fields from screen fields
058200000000       //------------------------------------------------
058300000000       begsr $LoadFile;
058400000000
058500000000         // Move screen fields to DB fields:
058600000000>>>>     DB0001 = WR0001;
058700000000
058800000000         // Retrieve current date in YYYYMMDD for last update date:
058900000000>>>>     DBLDTE = %int(%char(%date:*cymd0));
059000000000>>>>     DBLTIM = %int(%char(%time:*iso0));
059100000000>>>>     DBLPGM = DSPGMN;
059200000000>>>>     DBLUSR = DSUSER;
059300000000
059400000000       endsr;
059500000000
059600000000       //------------------------------------------------
059700000000       //*  $INZSR  ** - Program Initialization
059800000000       //------------------------------------------------
059900000000       begsr $INZSR;
060000000000
060100000000       //****************************************************************
060200000000       // Key lists. XXXK01 is used for retieving the record to be
060300000000       // maintained based on the record key passed to the program.
060400000000       // XXXK02 is used to determine if a record with a duplicate
060500000000       // key already exists on file (ADD and COPY modes only) based
060600000000       // on the current screen field values entered by the user.
060700000000       //
060800000000       //   eg; File maintained - ITEMMSTR (Item/Type Code).
060900000000       //
061000000000       //
061100000000       //     XXXK01    KLIST
061200000000       //               KFLD           WIITM   <-- incoming parm
061300000000       //               KFLD           WIICDE  <-- incoming parm
061400000000       //
061500000000       //     XXXK02    KLIST
061600000000       //               KFLD           WRITM   <-- screen field
061700000000       //               KFLD           WRICDE  <-- screen field
061800000000       //
061900000000       //****************************************************************
062000000000
062100000000       App1 = wiApp1;
062200000000
062300000000       // Close files if requested by calling program:
062400000000         if wiINLR = ccYes;
062500000000           *inlr = *on;
062600000000           return;
062700000000         endif;
062800000000
062900000000         // Open display file:
063000000000>>>>     open XXX0101D;
063100000000
063200000000         wwGetr = ccNo;
063300000000
063400000000       endsr;
063500000000
063600000000**
063700000000ADD         Create a
063800000000COPY         Copy a
063900000000CHANGE      Change a
064000000000DELETE      Delete a
064100000000DISPLAY     Display a
