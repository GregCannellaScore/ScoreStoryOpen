000100000000      /copy qcpylesrc,stdhspec
000200000000      *****************************************************************
000300000000      *
000400000000      *  Program....: SEC0004R
000500000000      *
000600000000      *  Description: Program Level Security. Work with Security Maintenance
000700000000      *
000800000000      *  Programmer.: Greg Cannella
000900000000      *
001000000000      *  Date.......: 11/30/14
001100000000      *
001200000000      *  Comments...: Files will remain open until this program is
001300000000      *               called with parm DSINLR equal to 'Y'.
001400000000      *
001500000000      *****************************************************************
001600000000      * CL Special Processing:                                        *
001700000000      *                                                               *
001800000000      *****************************************************************
001900000000      * Compile Options:                                              *
002000000000      *                                                               *
002100000000      *****************************************************************
002200000000      * Modifications:                                                *
002300000000      * Req#  By   Date      Modification                             *
002400000000      * 1234  xxx  xx/xx/xx                                           *
002500000000      *                                                               *
002600000000      *****************************************************************
002700000000      * Indicator Usage:                                              *
002800000000      * Ind      Use                                                  *
002900000000      * 01-24    Function keys                                        *
003000000000      * 25       Rollup                                               *
003100000000      * 30-34    Subfile keywords                                     *
003200000000      * 36       Position to                                          *
003300000000      * 37       Error indicator                                      *
003400000000      * 40       Search field change                                  *
003500000000      * 41-42    Search field display                                 *
003600000000      * 61       Subfile option error                                 *
003700000000      * 80-89    Reserved for Security                                *
003800000000      * 90-99    Hit/Miss                                             *
003900000000      *****************************************************************
004000000000      * Field Definitions                                             *
004100000000      *                                                               *
004200000000      * Prefix                                                        *
004300000000      * WW     - Program described work fields                        *
004400000000      * WI     - APPL input parameters                                *
004500000000      * WR     - Display record fields                                *
004600000000      * HD     - Hidden fields                                        *
004700000000      * Ax     - APPx output parameters for called programs           *
004800000000      * DS     - Data structure fields                                *
004900000000      *                                                               *
005000000000      *                                                               *
005100000000      * Display Record Format Definitions                             *
005200000000      *                                                               *
005300000000      * Prefix                                                        *
005400000000      * SCRNK  - Command key                                          *
005500000000      * SCRNR  - Standard display                                     *
005600000000      * WNDWB  - Window border                                        *
005700000000      * WNDWR  - Standard window display                              *
005800000000      * MSGCTL - Message subfile control                              *
005900000000      *                                                               *
006000000000      *                                                               *
006100000000      * Called programs                                               *
006200000000      *                                                               *
006300000000      * ERMSG2 - Clear program message queue                        *
006400000000      * ERMSG1 - Send program message with message data             *
006500000000      *                                                               *
006600000000      *                                                               *
006700000000     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
006800000000     F*P          P  R  O  G  R  A  M    S  P  E  C  S                P
006900000000     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007000000000     FSEC0004D  CF   E             WORKSTN USROPN
007100000000     FSECDTLM   UF A E           K DISK
007200000000     FUSEFILE   IF   E           K DISK
007300000000      *----------------------------------------------------------------
007400000000      * Header screen mode desriptions:
007500000000     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
007600000000     D DSC             S             30    DIM(5) ALT(MOD)
007700000000      *
007800000000      * General constants:
007900000000     D ERROR           C                   CONST('ERROR')
008000000000     D INUSE           C                   CONST('INUSE')
008100000000     D CHANGE          C                   CONST('CHANGE')
008200000000     D COPY            C                   CONST('COPY')
008300000000     D ADD             C                   CONST('ADD')
008400000000     D DELETE          C                   CONST('DELETE')
008500000000     D DISPLY          C                   CONST('DISPLY')
008600000000     D NEXT            C                   CONST('NEXT')
008700000000     D EXIT            C                   CONST('EXIT')
008800000000     D NO              C                   CONST('N')
008900000000     D YES             C                   CONST('Y')
009000000000      *
009100000000      * General Variables:
009200000000     D WWENTR          S              2  0 INZ
009300000000     D WWCTAB          S              3    INZ
009400000000     D WWCKEY          S             27    INZ
009500000000     D WWNFND          S              1    INZ
009600000000     D WWFRST          S              1    INZ('Y')
009700000000     D WWCLR1          S              1    INZ('N')
009800000000     D WWNEXT          S              1    INZ
009900000000     D WWUPD1          S              1    INZ
010000000000     D WWERR1          S             10    INZ
010100000000     D WWCNT1          S              3  0 INZ
010200000000     D X               S              1  0 INZ
010300000000     D WWRCDE          S                   INZ Like(WRRCDE)
010400000000      *
010500000000     D jld           E DS                  EXTNAME(dsjld)
010600000000      *
010700000000      * Incoming parms:
010800000000     D APPL            DS           512
010900000000     D  WISEC                  1      5
011000000000     D  WIIUSE                 6     15
011100000000     D  WIINLR                16     16
011200000000     D  WIACTN                17     26
011300000000     D  WIpgm                 27     36
011400000000     D  WIseq                 37     39
011500000000     D  WIdesc                40     89
011600000000     D  WIuser                90     99
011700000000      *
011800000000     D                SDS
011900000000     D  DSPGMN           *PROC
012000000000     D  DSUSER               254    263
012100000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012200000000     M*M                 M  A  I  N  L  I  N  E                       M
012300000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012400000000     C                   EXSR      $INZSR
012500000000     C                   EXSR      $CLEAR
012600000000      *
012700000000     C                   CALL      'ERMSG2'
012800000000     C                   Parm                    DSPGMN
012900000000      *
013000000000      * Retrieve record:
013100000000      *
013200000000     C                   EXSR      $GETRC
013300000000      *
013400000000      * If record is in use, retrieve the user who has the lock,
013500000000      * close the display file, and return to the previous program:
013600000000      *
013700000000     C                   If        WWRCDE = INUSE
013800000000     C                   CALL      'GEN8001C'
013900000000     C                   PARM                    WIIUSE
014000000000     C                   MOVEL     WWRCDE        WRRCDE
014100000000     C                   CLOSE     SEC0004D
014200000000     C                   RETURN
014300000000     C                   EndIf
014400000000      *
014500000000      * Retrieve field descriptions:
014600000000      *
014700000000     C                   EXSR      $DESCR
014800000000      *
014900000000      * Main loop:
015000000000      *
015100000000     C                   Dou       WWRCDE = Exit or WWRCDE = Next
015200000000      *
015300000000      * Clear all fields, if requested:
015400000000      *
015500000000     C                   If        WWCLR1 = YES
015600000000     C                   EXSR      $CLEAR
015700000000     C                   EndIf
015800000000      *
015900000000      * Retrieve record, if requested:
016000000000      *
016100000000     C                   If        WWGETR = YES
016200000000     C                   EXSR      $GETRC
016300000000     C                   EXSR      $DESCR
016400000000     C                   EndIf
016500000000      *
016600000000      * Lookup header screen mode description:
016700000000      *
016800000000     C                   Z-ADD     1             X
016900000000     C     WIACTN        LOOKUP    MOD(X)                                 99
017000000000     C     *IN99         IFEQ      *ON
017100000000     C                   MOVEL     DSC(X)        WRDSC1
017200000000     C                   END
017300000000      *
017400000000      * Display screen:
017500000000      *
017600000000     C                   WRITE     MSGCTL1
017700000000     C                   WRITE     SCRNK01
017800000000     C                   EXFMT     SCRNR01
017900000000      *
018000000000      * F12 = return to previous program:
018100000000      *
018200000000     C                   If        *In12 = *ON
018300000000     C                   MOVEL     NEXT          WWRCDE
018400000000     C                   Else
018500000000      *
018600000000     C                   If        WWFRST = YES
018700000000     C                   MOVE      NO            WWFRST
018800000000     C                   EndIf
018900000000      *
019000000000     C                   MOVE      NO            WWGETR
019100000000      *
019200000000      * Set off error indicators here:
019300000000      *
019400000000     C                   MOVEA     '0'           *IN(40)
019500000000      *
019600000000     C                   CLEAR                   WWERR1
019700000000      *
019800000000      * Clear messages:
019900000000      *
020000000000     C                   CALL      'ERMSG2'
020100000000     C                   Parm                    DSPGMN
020200000000      *
020300000000      * Process command keys:
020400000000      *
020500000000     C                   SELECT
020600000000      *
020700000000      * F4 = Prompt:
020800000000      *
020900000000     C                   When      *In04 = *ON
021000000000     C                   EXSR      $PRMPT
021100000000     C                   EXSR      $DESCR
021200000000      *
021300000000     C                   Other
021400000000      *
021500000000      * Enter:
021600000000      *
021700000000     C                   If        WIACTN = DISPLY
021800000000     C                   MOVEL     NEXT          WWRCDE
021900000000     C                   Else
022000000000      *
022100000000      * Error check, if in maintenance mode:
022200000000      *
022300000000     C                   IF        *In36 = *OFF
022400000000     C                   EXSR      $ERR01
022500000000     C                   EndIf
022600000000      *
022700000000      * If no error, update record:
022800000000      *
022900000000     C                   If        WWERR1 <> ERROR
023000000000     C                   EXSR      $DESCR
023100000000     C                   EXSR      $ENTER
023200000000     C                   EndIf
023300000000      *
023400000000     C                   EndIf
023500000000      *
023600000000     C                   EndSl
023700000000      *
023800000000     C                   EndIf
023900000000      *
024000000000     C                   EndDo
024100000000      *
024200000000      * Pass return code back to calling program through JLD field:
024300000000      *
024400000000     C                   MOVEL     WWRCDE        WRRCDE
024500000000      *
024600000000      * Close the display file:
024700000000      *
024800000000     C                   CLOSE     SEC0004D
024900000000      *
025000000000      * Release record lock:
025100000000      *
025200000000     C                   IF        WIACTN = CHANGE or WIACTN = DELETE
025300000000     C                   UNLOCK    SECDTLM
025400000000     C                   EndIf
025500000000      *
025600000000     C                   RETURN
025700000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025800000000     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
025900000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026000000000     C*
026100000000      //---------------------------------------------------------------
026200000000      //  $CLEAR  ** - Intialize Program/Database Fields
026300000000      //---------------------------------------------------------------
026400000000     C     $CLEAR        BEGSR
026500000000      *
026600000000      * Program stays open. All program/screen fields and indicators
026700000000      * must be re-initialized here each time this program is called.
026800000000      *
026900000000      * Initialize screen and data base fields:
027000000000      *
027100000000     C                   CLEAR                   SCRNR01
027200000000     C                   CLEAR                   SECDTLR
027300000000      *
027400000000      * Clear all *LIKE definitions:
027500000000      *
027600000000     C                   CLEAR                   WWRCDE
027700000000      *
027800000000      * Initialize program described fields:
027900000000      *
028000000000     C                   MOVE      *ZEROS        WWENTR
028100000000     C                   MOVE      *ZEROS        X
028200000000     C                   MOVE      *BLANKS       WWCTAB
028300000000     C                   MOVE      *BLANKS       WWCKEY
028400000000     C                   MOVE      YES           WWFRST
028500000000     C                   MOVE      NO            WWCLR1
028600000000     C                   MOVE      *BLANKS       WWNEXT
028700000000     C                   MOVE      *BLANKS       WWUPD1
028800000000     C                   MOVE      *BLANKS       WWERR1
028900000000     C                   Z-ADD     *ZERO         WWCNT1
029000000000      *
029100000000      * Protect all input capable fields:
029200000000      *
029300000000     C                   If        WIACTN = DISPLY or WIACTN = DELETE
029400000000     C                   Eval      *IN36 = *ON
029500000000     C                   ELSE
029600000000     C                   Eval      *IN36 = *Off
029700000000     C                   END
029800000000      *
029900000000     C                   MOVE      *OFF          *IN60
030000000000      *
030100000000     C     #CLEAR        ENDSR
030200000000      //---------------------------------------------------------------
030300000000      //  $GETRC  ** - Retrieve Data Base Record
030400000000      //---------------------------------------------------------------
030500000000     C     $GETRC        BEGSR
030600000000      *
030700000000     C                   IF        WIACTN <> ADD
030800000000      *
030900000000      * Do not lock record if copy or display mode:
031000000000      *
031100000000     C                   If        WIACTN = COPY or WIACTN = DISPLY
031200000000     C     WIkey         CHAIN(N)  SECDTLM                            99
031300000000     C                   Else
031400000000     C     WIkey         CHAIN     SECDTLM                            9960
031500000000     C                   EndIf
031600000000      *
031700000000     C                   If        *In60 = *ON
031800000000     C                   MOVEL     INUSE         WWRCDE
031900000000     C                   Else
032000000000     C                   If        *In99 = *OFF
032100000000     C                   Exsr      $MOVIN
032200000000     C                   EndIf
032300000000     C                   EndIf
032400000000      *
032500000000     C                   ELSE
032600000000      *
032700000000     C                   EXSR      $MOVIN
032800000000      *
032900000000     C                   END
033000000000      *
033100000000     C     #GETRC        ENDSR
033200000000      //---------------------------------------------------------------
033300000000      //  $MOVIN  ** - Move Data Base Fields to Screen Fields
033400000000      //---------------------------------------------------------------
033500000000     C     $MOVIN        BEGSR
033600000000      *
033700000000      * Add/copy mode default values:
033800000000      *
033900000000     C                   IF        Wiactn = ADD
034000000000     C                   Eval      WRpgm  = WIpgm
034100000000     C                   Eval      WRseq  = WIseq
034200000000     C                   Eval      WRdesc = WIdesc
034300000000     C                   Eval      WRuser = WIuser
034400000000     C                   EndIf
034500000000      *
034600000000     C                   Select
034700000000      *
034800000000     C                   WHEN      WIACTN = COPY or WIACTN = CHANGE or
034900000000     C                             WIACTN = DISPLY or WIACTN = DELETE
035000000000     C*
035100000000     C* Move DB fields to screen fields here:
035200000000     C*
035300000000     C                   Eval      WRpgm  = SDpgm
035400000000     C                   Eval      WRseq  = SDseq
035500000000     C                   Eval      WRdesc = WIdesc
035600000000     C                   Eval      WRuser = SDuser
035700000000      *
035800000000      * Display last update user/date:
035900000000      *
036000000000     C                   If        WIACTN <> COPY
036100000000      *
036200000000     C                   Eval      WRLUSR = SDLUSR
036300000000     C                   Eval      WRLpgm = SDLpgm
036400000000     C*
036500000000     c                   If        SDLDTE <> 0
036600000000     C                   Eval      Wrldte = %dec(%date(SDLDTE:*ISO):*MDY)
036700000000     c                   Else
036800000000     c                   Clear                   wrldte
036900000000     c                   Endif
037000000000     C                   Move      SDltim        wrltim
037100000000      *
037200000000     C                   EndIf
037300000000      *
037400000000     C                   ENDSL
037500000000     C*
037600000000     C     #MOVIN        ENDSR
037700000000      //---------------------------------------------------------------
037800000000      //  $DESCR  ** - Retrieve field descriptions
037900000000      //---------------------------------------------------------------
038000000000     C     $DESCR        BEGSR
038100000000      *
038200000000     C     WRuser        chain     Usefile
038300000000     C                   If        %found(Usefile)
038400000000     C                   Eval      wrname = UPTEXT
038500000000     C                   Else
038600000000     C                   Eval      wrname = *blank
038700000000     C                   EndIf
038800000000      *
038900000000     C     #DESCR        ENDSR
039000000000      //---------------------------------------------------------------
039100000000      //  $PRMPT  ** - Process Promptable Fields
039200000000      //---------------------------------------------------------------
039300000000     C     $PRMPT        BEGSR
039400000000      *
039500000000     C                   SELECT
039600000000      *
039700000000     C
039800000000     C     HDCSRF        WHENEQ    'WRUSER'
039900000000     C                   CALL      'USERSL'
040000000000     C                   PARM                    WRUSER
040100000000      *
040200000000      * Non propmtable area:
040300000000      *
040400000000     C                   OTHER
040500000000      *
040600000000     C                   MOVEL     'SHL0004'     WWMSGI
040700000000     C                   CALL      'ERMSG1'      MSGP01
040800000000     C*
040900000000     C                   ENDSL
041000000000     C*
041100000000     C     #PRMPT        ENDSR
041200000000      //---------------------------------------------------------------
041300000000      //  $ERR01  ** - Vaildity Checking
041400000000      //---------------------------------------------------------------
041500000000     C     $ERR01        BEGSR
041600000000      *
041700000000     C                   CLEAR                   WWERR1
041800000000      *
041900000000      * Record already exists on file:
042000000000      *
042100000000     C                   IF        WIACTN = ADD or WIACTN = COPY
042200000000     C     DetKey        SETLL     SECDTLM
042300000000     C                   IF        %equal(SECDTLM)
042400000000     C                   MOVEL     ERROR         WWERR1
042500000000     C                   MOVEL     'SHL0005'     WWMSGI
042600000000     C                   CALL      'ERMSG1'      MSGP01
042700000000     C                   EndIf
042800000000     C                   EndIf
042900000000      *
043000000000      * Validate User:
043100000000      *
043200000000     C     WRuser        SETLL     USEFILE
043300000000     C                   If        not %equal(USEFILE)
043400000000     C                   MOVEL     ERROR         WWERR1
043500000000     C                   MOVEL     'EDI0003'     WWMSGI
043600000000     C                   CALL      'ERMSG1'      MSGP01
043700000000     C                   EndIf
043800000000      *
043900000000      * All field have to be filled in...
044000000000      *
044100000000     C                   If        Wrseq = *blank or Wruser = *Blank
044200000000     C                   MOVEL     ERROR         WWERR1
044300000000     C                   MOVEL     'GEN0001'     WWMSGI
044400000000     C                   CALL      'ERMSG1'      MSGP01
044500000000     C                   EndIf
044600000000      *
044700000000     C                   If        WWERR1 = ERROR
044800000000     C                   CLEAR                   WWENTR
044900000000     C                   EndIf
045000000000      *
045100000000     C     #ERR01        ENDSR
045200000000      //---------------------------------------------------------------
045300000000      //  $ENTER  ** - Enter Key Pressed
045400000000      //---------------------------------------------------------------
045500000000     C     $ENTER        BEGSR
045600000000      *
045700000000     C*****              ADD       1             WWENTR
045800000000      *
045900000000      * Update only if screen has been changed:
046000000000      *
046100000000     C                   If        *In38 = *ON
046200000000     C                   MOVE      YES           WWUPD1
046300000000     C                   EndIf
046400000000      *
046500000000      * Send verification messages:
046600000000      *
046700000000     C                   IF        WWENTR = 1
046800000000      *
046900000000     C                   SELECT
047000000000      *
047100000000     C                   When      WIACTN = ADD or WIACTN = COPY
047200000000     C                   MOVEL     'SHL0001'     WWMSGI
047300000000     C                   CALL      'ERMSG1'      MSGP01
047400000000      *
047500000000     C                   When      WIACTN = CHANGE
047600000000     C                   MOVEL     'SHL0002'     WWMSGI
047700000000     C                   CALL      'ERMSG1'      MSGP01
047800000000      *
047900000000     C                   When      WIACTN = DELETE
048000000000     C                   MOVEL     'SHL0003'     WWMSGI
048100000000     C                   CALL      'ERMSG1'      MSGP01
048200000000      *
048300000000     C                   EndSl
048400000000      *
048500000000     C                   Else
048600000000      *
048700000000      * Update database according to current mode:
048800000000      *
048900000000     C                   CLEAR                   WWENTR
049000000000     C                   CLEAR                   WWCNT1
049100000000      *
049200000000     C                   MOVEL     NEXT          WWRCDE
049300000000      *
049400000000     C                   SELECT
049500000000      *
049600000000     C                   When      WIACTN = CHANGE and WWUPD1 = YES
049700000000     C                   EXSR      $MOVOU
049800000000     C                   UPDATE    SECDTLR
049900000000      *
050000000000     C                   When      WIACTN = ADD or WIACTN = COPY
050100000000     C                   EXSR      $MOVOU
050200000000     C                   WRITE     SECDTLR
050300000000     C                   Clear                   Wruser
050400000000      *
050500000000     C                   When      WIACTN = DELETE
050600000000     C                   DELETE    SECDTLR
050700000000      *
050800000000     C                   EndSl
050900000000      *
051000000000      * Pass 'position to' fields back to calling program:
051100000000      *
051200000000     C                   Eval      WIpgm  = Wrpgm
051300000000     C                   Eval      WIseq  = Wrseq
051400000000     C                   Eval      WIdesc = Wrdesc
051500000000     C                   Eval      WIuser = Wruser
051600000000      *
051700000000      * If add mode, initialize all fields and redisplay the screen:
051800000000      *
051900000000     C                   If        WIACTN = ADD
052000000000     C                   CLEAR                   WWRCDE
052100000000     C                   MOVE      YES           WWCLR1
052200000000     C                   MOVE      YES           WWGETR
052300000000     C                   EndIf
052400000000      *
052500000000     C                   MOVE      NO            WWUPD1
052600000000      *
052700000000     C                   END
052800000000      *
052900000000     C     #ENTER        ENDSR
053000000000      //---------------------------------------------------------------
053100000000      //  $MOVOU  ** - Move Screen Fields to Data Base Fields
053200000000      //---------------------------------------------------------------
053300000000     C     $MOVOU        BEGSR
053400000000      *
053500000000      * Move screen fields to DB fields:
053600000000      *
053700000000     C                   Eval      SDpgm = WRpgm
053800000000     C                   Eval      SDseq = WRseq
053900000000     C                   Eval      SDuser = WRuser
054000000000      *
054100000000      * Retrieve current date in YYYYMMDD for last update date:
054200000000      *
054300000000     C                   Eval      SDldte = %int(%char(%date:*iso0))
054400000000     C                   TIME                    SDltim
054500000000     C                   Eval      sdlusr = dsuser
054600000000     C                   Eval      sdlpgm = dspgmn
054700000000      *
054800000000     C     #MOVOU        ENDSR
054900000000      //---------------------------------------------------------------
055000000000      //  $INZSR  ** - Program Initialization
055100000000      //---------------------------------------------------------------
055200000000     C     $INZSR        BEGSR
055300000000      *
055400000000      * Parm lists:
055500000000      *
055600000000     C     *ENTRY        PLIST
055700000000     C                   PARM                    JLD
055800000000     C                   PARM                    APPL
055900000000     C*
056000000000     C* Message file:
056100000000     C*
056200000000     C     MSGP01        PLIST
056300000000     C                   PARM                    WWMSGI            7
056400000000      *
056500000000      * Key lists:
056600000000      *
056700000000     C     WIkey         KLIST
056800000000     C                   KFLD                    WIpgm
056900000000     C                   KFLD                    WIseq
057000000000     C                   KFLD                    WIuser
057100000000      *
057200000000     C     DetKey        KLIST
057300000000     C                   KFLD                    WRpgm
057400000000     C                   KFLD                    WRseq
057500000000     C                   KFLD                    WRuser
057600000000      *
057700000000      * Close files if requested by calling program:
057800000000      *
057900000000     C                   If        WIINLR = YES
058000000000     C                   Eval      *INLR = *ON
058100000000     C                   RETURN
058200000000     C                   EndIf
058300000000      *
058400000000      * Open display file:
058500000000      *
058600000000     C                   OPEN      SEC0004D
058700000000      *
058800000000     C                   MOVE      NO            WWGETR            1
058900000000      *
059000000000     C     #INZSR        ENDSR
059100000000      //---------------------------------------------------------------
059200000000**
059300000000ADD         Create a Record
059400000000COPY         Copy a Record
059500000000CHANGE      Change a Record
059600000000DELETE      Delete a Record
059700000000DISPLY      Display a Record
