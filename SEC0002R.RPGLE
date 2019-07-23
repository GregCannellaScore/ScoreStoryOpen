000100000000      /copy qcpylesrc,stdhspec
000200000000      *****************************************************************
000300000000      *
000400000000      *  Program....: SEC0002R
000500000000      *
000600000000      *  Description: Program Level Security
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
007000000000     FSEC0002D  CF   E             WORKSTN USROPN
007100000000     FSECHDRM   UF A E           K DISK
007200000000      *----------------------------------------------------------------
007300000000      * Header screen mode desriptions:
007400000000     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
007500000000     D DSC             S             30    DIM(5) ALT(MOD)
007600000000      *
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
009100000000     D ConvertDate     s               d
009200000000      *
009300000000     D jld           E DS                  EXTNAME(dsjld)
009400000000      *
009500000000      * Incoming parms:
009600000000     D APPL            DS           512
009700000000     D  WISEC                  1      5
009800000000     D  WIIUSE                 6     15
009900000000     D  WIINLR                16     16
010000000000     D  WIACTN                17     26
010100000000     D  WIpgm                 27     36
010200000000     D  WIseq                 37     39
010300000000     D  WIdesc                40     89
010400000000      *
010500000000     D                SDS
010600000000     D  DSPGMN           *PROC
010700000000     D  DSUSER               254    263
010800000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
010900000000     M*M                 M  A  I  N  L  I  N  E                       M
011000000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011100000000     C                   EXSR      $INZSR
011200000000     C                   EXSR      $CLEAR
011300000000      *
011400000000     C                   CALL      'ERMSG2'
011500000000     C                   Parm                    DSPGMN
011600000000      *
011700000000      * Retrieve record:
011800000000      *
011900000000     C                   EXSR      $GETRC
012000000000      *
012100000000      * If record is in use, retrieve the user who has the lock,
012200000000      * close the display file, and return to the previous program:
012300000000      *
012400000000     C                   If        WWRCDE = INUSE
012500000000     C                   CALL      'GEN8001C'
012600000000     C                   PARM                    WIIUSE
012700000000     C                   MOVEL     WWRCDE        WRRCDE
012800000000     C                   CLOSE     SEC0002D
012900000000     C                   RETURN
013000000000     C                   EndIf
013100000000      *
013200000000      * Retrieve field descriptions:
013300000000      *
013400000000     C                   EXSR      $DESCR
013500000000      *
013600000000      * Main loop:
013700000000      *
013800000000     C                   Dou       WWRCDE = Exit or WWRCDE = Next
013900000000      *
014000000000      * Clear all fields, if requested:
014100000000      *
014200000000     C                   If        WWCLR1 = YES
014300000000     C                   EXSR      $CLEAR
014400000000     C                   EndIf
014500000000      *
014600000000      * Retrieve record, if requested:
014700000000      *
014800000000     C                   If        WWGETR = YES
014900000000     C                   EXSR      $GETRC
015000000000     C                   EXSR      $DESCR
015100000000     C                   EndIf
015200000000      *
015300000000      * Lookup header screen mode description:
015400000000      *
015500000000     C                   Z-ADD     1             X
015600000000     C     WIACTN        LOOKUP    MOD(X)                                 99
015700000000     C     *IN99         IFEQ      *ON
015800000000     C                   MOVEL     DSC(X)        WRDSC1
015900000000     C                   END
016000000000      *
016100000000      * Display screen:
016200000000      *
016300000000     C                   WRITE     MSGCTL1
016400000000     C                   WRITE     SCRNK01
016500000000     C                   EXFMT     SCRNR01
016600000000      *
016700000000      * F12 = return to previous program:
016800000000      *
016900000000     C                   If        *In12 = *ON
017000000000     C                   MOVEL     NEXT          WWRCDE
017100000000     C                   Else
017200000000      *
017300000000     C                   If        WWFRST = YES
017400000000     C                   MOVE      NO            WWFRST
017500000000     C                   EndIf
017600000000      *
017700000000     C                   MOVE      NO            WWGETR
017800000000      *
017900000000      * Set off error indicators here:
018000000000      *
018100000000      *
018200000000     C                   CLEAR                   WWERR1
018300000000      *
018400000000      * Clear messages:
018500000000      *
018600000000     C                   CALL      'ERMSG2'
018700000000     C                   Parm                    DSPGMN
018800000000      *
018900000000      * Process command keys:
019000000000      *
019100000000     C                   SELECT
019200000000      *
019300000000      * F4 = Prompt:
019400000000      *
019500000000     C                   When      *In04 = *ON
019600000000     C                   EXSR      $PRMPT
019700000000     C                   EXSR      $DESCR
019800000000      *
019900000000     C                   Other
020000000000      *
020100000000      * Enter:
020200000000      *
020300000000     C                   If        WIACTN = DISPLY
020400000000     C                   MOVEL     NEXT          WWRCDE
020500000000     C                   Else
020600000000      *
020700000000      * Error check, if in maintenance mode:
020800000000      *
020900000000     C                   IF        *In36 = *OFF
021000000000     C                   EXSR      $ERR01
021100000000     C                   EndIf
021200000000      *
021300000000      * If no error, update record:
021400000000      *
021500000000     C                   If        WWERR1 <> ERROR
021600000000     C                   EXSR      $DESCR
021700000000     C                   EXSR      $ENTER
021800000000     C                   EndIf
021900000000      *
022000000000     C                   EndIf
022100000000      *
022200000000     C                   EndSl
022300000000      *
022400000000     C                   EndIf
022500000000      *
022600000000     C                   EndDo
022700000000      *
022800000000      * Pass return code back to calling program through JLD field:
022900000000      *
023000000000     C                   MOVEL     WWRCDE        WRRCDE
023100000000      *
023200000000      * Close the display file:
023300000000      *
023400000000     C                   CLOSE     SEC0002D
023500000000      *
023600000000      * Release record lock:
023700000000      *
023800000000     C                   IF        WIACTN = CHANGE or WIACTN = DELETE
023900000000     C                   UNLOCK    SECHDRM
024000000000     C                   EndIf
024100000000      *
024200000000     C                   RETURN
024300000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
024400000000     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
024500000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
024600000000     C*
024700000000      //---------------------------------------------------------------
024800000000      //  $CLEAR  ** - Intialize Program/Database Fields
024900000000      //---------------------------------------------------------------
025000000000     C     $CLEAR        BEGSR
025100000000      *
025200000000      * Program stays open. All program/screen fields and indicators
025300000000      * must be re-initialized here each time this program is called.
025400000000      *
025500000000      * Initialize screen and data base fields:
025600000000      *
025700000000     C                   CLEAR                   SCRNR01
025800000000     C                   CLEAR                   SECHDRR
025900000000      *
026000000000      * Field definitions and initialization:
026100000000      *
026200000000     C     *LIKE         DEFINE    WRRCDE        WWRCDE
026300000000      *
026400000000      * Clear all *LIKE definitions:
026500000000      *
026600000000     C                   CLEAR                   WWRCDE
026700000000      *
026800000000      * Initialize program described fields:
026900000000      *
027000000000     C                   MOVE      *ZEROS        WWENTR            2 0
027100000000     C                   MOVE      *ZEROS        X                 1 0
027200000000     C                   MOVE      *BLANKS       WWCTAB            3
027300000000     C                   MOVE      *BLANKS       WWCKEY           27
027400000000     C                   MOVE      YES           WWFRST            1
027500000000     C                   MOVE      NO            WWCLR1            1
027600000000     C                   MOVE      *BLANKS       WWNEXT            1
027700000000     C                   MOVE      *BLANKS       WWUPD1            1
027800000000     C                   MOVE      *BLANKS       WWERR1           10
027900000000     C                   Z-ADD     *ZERO         WWCNT1            3 0
028000000000      *
028100000000      * Protect all input capable fields:
028200000000      *
028300000000     C                   If        WIACTN = DISPLY or WIACTN = DELETE
028400000000     C                   Eval      *IN36 = *on
028500000000     C                   ELSE
028600000000     C                   Eval      *IN36 = *off
028700000000     C                   EndIf
028800000000      * Protect key fields in change mode:
028900000000     C                   If        WIACTN = CHANGE
029000000000     C                   Eval      *IN37 = *on
029100000000     C                   ELSE
029200000000     C                   Eval      *IN37 = *off
029300000000     C                   EndIf
029400000000      *
029500000000     C                   MOVE      *OFF          *IN60
029600000000      *
029700000000     C     #CLEAR        ENDSR
029800000000      //---------------------------------------------------------------
029900000000      //  $GETRC  ** - Retrieve Data Base Record
030000000000      //---------------------------------------------------------------
030100000000     C     $GETRC        BEGSR
030200000000      *
030300000000     C                   IF        WIACTN <> ADD
030400000000      *
030500000000      * Do not lock record if copy or display mode:
030600000000      *
030700000000     C                   If        WIACTN = COPY or WIACTN = DISPLY
030800000000     C     WIkey         CHAIN(N)  SECHDRM                            99
030900000000     C                   Else
031000000000     C     WIkey         CHAIN     SECHDRM                            9960
031100000000     C                   EndIf
031200000000      *
031300000000     C                   If        *In60 = *ON
031400000000     C                   MOVEL     INUSE         WWRCDE
031500000000     C                   Else
031600000000     C                   If        *In99 = *OFF
031700000000     C                   Exsr      $MOVIN
031800000000     C                   EndIf
031900000000     C                   END
032000000000      *
032100000000     C                   ELSE
032200000000      *
032300000000     C                   EXSR      $MOVIN
032400000000      *
032500000000     C                   END
032600000000      *
032700000000     C     #GETRC        ENDSR
032800000000      //---------------------------------------------------------------
032900000000      //  $MOVIN  ** - Move Data Base Fields to Screen Fields
033000000000      //---------------------------------------------------------------
033100000000     C     $MOVIN        BEGSR
033200000000      *
033300000000      * Add/copy mode default values:
033400000000      *
033500000000     C                   If        WIACTN = ADD
033600000000     C                   Eval      WRpgm  = WIpgm
033700000000     C                   Eval      WRseq  = WIseq
033800000000     C                   Eval      WRdesc = WIdesc
033900000000     C                   EndIf
034000000000      *
034100000000     C                   Select
034200000000      *
034300000000     C                   WHEN      WIACTN = COPY or WIACTN = CHANGE or
034400000000     C                             WIACTN = DISPLY or WIACTN = DELETE
034500000000     C*
034600000000     C* Move DB fields to screen fields here:
034700000000     C*
034800000000     C                   Eval      WRpgm = SHpgm
034900000000     C                   Eval      WRseq = SHseq
035000000000     C                   Eval      WRdesc = SHdesc
035100000000      *
035200000000      * Display last update user/date:
035300000000      *
035400000000     C                   If        WIACTN <> COPY
035500000000      *
035600000000     C                   Eval      WRLUSR = SHLUSR
035700000000     C                   Eval      WRLpgm = SHLpgm
035800000000     C*
035900000000     c                   If        SHLDTE <> 0
036000000000     C                   Eval      Wrldte = %dec(%date(SHLDTE:*ISO):*MDY)
036100000000     c                   Else
036200000000     c                   Clear                   wrldte
036300000000     c                   Endif
036400000000     C                   Move      shltim        wrltim
036500000000      *
036600000000     C                   EndIf
036700000000      *
036800000000     C                   ENDSL
036900000000     C*
037000000000     C     #MOVIN        ENDSR
037100000000      //---------------------------------------------------------------
037200000000      //  $DESCR  ** - Retrieve field descriptions
037300000000      //---------------------------------------------------------------
037400000000     C     $DESCR        BEGSR
037500000000      *
037600000000      *
037700000000     C     #DESCR        ENDSR
037800000000      //---------------------------------------------------------------
037900000000      //  $PRMPT  ** - Process Promptable Fields
038000000000      //---------------------------------------------------------------
038100000000     C     $PRMPT        BEGSR
038200000000      *
038300000000     C                   SELECT
038400000000      *
038500000000      * Non propmtable area:
038600000000      *
038700000000     C                   OTHER
038800000000      *
038900000000     C                   MOVEL     'SHL0004'     WWMSGI
039000000000     C                   CALL      'ERMSG1'      MSGP01
039100000000      *
039200000000     C                   ENDSL
039300000000      *
039400000000     C     #PRMPT        ENDSR
039500000000      //---------------------------------------------------------------
039600000000      //  $ERR01  ** - Vaildity Checking
039700000000      //---------------------------------------------------------------
039800000000     C     $ERR01        BEGSR
039900000000      *
040000000000     C                   CLEAR                   WWERR1
040100000000      *
040200000000      * Record already exists on file:
040300000000      *
040400000000     C                   IF        WIACTN = ADD or WIACTN = COPY
040500000000     C     SHkey         SETLL     SECHDRM
040600000000     C                   IF        %equal(SECHDRM)
040700000000     C                   MOVEL     ERROR         WWERR1
040800000000     C                   MOVEL     'SHL0005'     WWMSGI
040900000000     C                   CALL      'ERMSG1'      MSGP01
041000000000     C                   EndIf
041100000000     C                   EndIf
041200000000      *
041300000000      * All field have to be filled in...
041400000000      *
041500000000     C                   If        Wrpgm = *Blank or Wrseq = *blank or
041600000000     C                             Wrdesc = *Blank
041700000000     C                   MOVEL     ERROR         WWERR1
041800000000     C                   MOVEL     'GEN0001'     WWMSGI
041900000000     C                   CALL      'ERMSG1'      MSGP01
042000000000     C                   EndIf
042100000000      *
042200000000     C                   If        WWERR1 = ERROR
042300000000     C                   CLEAR                   WWENTR
042400000000     C                   EndIf
042500000000      *
042600000000     C     #ERR01        ENDSR
042700000000      //---------------------------------------------------------------
042800000000      //  $ENTER  ** - Enter Key Pressed
042900000000      //---------------------------------------------------------------
043000000000     C     $ENTER        BEGSR
043100000000      *
043200000000     C*****              ADD       1             WWENTR
043300000000      *
043400000000      * Update only if screen has been changed:
043500000000      *
043600000000     C                   If        *In38 = *ON
043700000000     C                   MOVE      YES           WWUPD1
043800000000     C                   Else
043900000000     C                   If        WIpgm <> WRpgm or WIseq <> WRseq or
044000000000     C                             WIdesc <> WRdesc
044100000000     C                   MOVE      YES           WWUPD1
044200000000     C                   EndIf
044300000000     C                   EndIf
044400000000      *
044500000000      * Send verification messages:
044600000000      *
044700000000     C                   IF        WWENTR = 1
044800000000      *
044900000000     C                   SELECT
045000000000      *
045100000000     C                   When      WIACTN = ADD or WIACTN = COPY
045200000000     C                   MOVEL     'SHL0001'     WWMSGI
045300000000     C                   CALL      'ERMSG1'      MSGP01
045400000000      *
045500000000     C                   When      WIACTN = CHANGE
045600000000     C                   MOVEL     'SHL0002'     WWMSGI
045700000000     C                   CALL      'ERMSG1'      MSGP01
045800000000      *
045900000000     C                   When      WIACTN = DELETE
046000000000     C                   MOVEL     'SHL0003'     WWMSGI
046100000000     C                   CALL      'ERMSG1'      MSGP01
046200000000      *
046300000000     C                   EndSl
046400000000      *
046500000000     C                   Else
046600000000      *
046700000000      * Update database according to current mode:
046800000000      *
046900000000     C                   CLEAR                   WWENTR
047000000000     C                   CLEAR                   WWCNT1
047100000000      *
047200000000     C                   MOVEL     NEXT          WWRCDE
047300000000      *
047400000000     C                   SELECT
047500000000      *
047600000000     C                   When      WIACTN = CHANGE and WWUPD1 = YES
047700000000     C                   EXSR      $MOVOU
047800000000     C                   UPDATE    SECHDRR
047900000000      *
048000000000     C                   When      WIACTN = ADD or WIACTN = COPY
048100000000     C                   EXSR      $MOVOU
048200000000     C                   WRITE     SECHDRR
048300000000     C                   Clear                   Wrpgm
048400000000     C                   Clear                   Wrseq
048500000000     C                   Clear                   Wrdesc
048600000000      *
048700000000     C                   When      WIACTN = DELETE
048800000000     C                   DELETE    SECHDRR
048900000000      *
049000000000     C                   EndSl
049100000000      *
049200000000      * Pass 'position to' fields back to calling program:
049300000000      *
049400000000     C                   Eval      WIpgm  = Wrpgm
049500000000     C                   Eval      WIseq  = Wrseq
049600000000     C                   Eval      WIdesc = Wrdesc
049700000000      *
049800000000      * If add mode, initialize all fields and redisplay the screen:
049900000000      *
050000000000     C                   If        WIACTN = ADD
050100000000     C                   CLEAR                   WWRCDE
050200000000     C                   MOVE      YES           WWCLR1
050300000000     C                   MOVE      YES           WWGETR
050400000000     C                   END
050500000000      *
050600000000     C                   MOVE      NO            WWUPD1
050700000000      *
050800000000     C                   END
050900000000      *
051000000000     C     #ENTER        ENDSR
051100000000      //---------------------------------------------------------------
051200000000      //  $MOVOU  ** - Move Screen Fields to Data Base Fields
051300000000      //---------------------------------------------------------------
051400000000     C     $MOVOU        BEGSR
051500000000      *
051600000000      * Move screen fields to DB fields:
051700000000      *
051800000000     C                   Eval      SHpgm = WRpgm
051900000000     C                   Eval      SHseq = WRseq
052000000000     C                   Eval      SHdesc = WRdesc
052100000000      *
052200000000      * Retrieve current date in YYYYMMDD for last update date:
052300000000      *
052400000000     C                   Eval      shldte = %int(%char(%date:*iso0))
052500000000     C                   TIME                    shltim
052600000000     C                   Eval      shlusr = dsuser
052700000000     C                   Eval      shlpgm = dspgmn
052800000000      *
052900000000     C     #MOVOU        ENDSR
053000000000      //---------------------------------------------------------------
053100000000      //  $INZSR  ** - Program Initialization
053200000000      //---------------------------------------------------------------
053300000000     C     $INZSR        BEGSR
053400000000      *
053500000000      * Parm lists:
053600000000      *
053700000000     C     *ENTRY        PLIST
053800000000     C                   PARM                    JLD
053900000000     C                   PARM                    APPL
054000000000     C*
054100000000     C* Message file:
054200000000     C*
054300000000     C     MSGP01        PLIST
054400000000     C                   PARM                    WWMSGI            7
054500000000      *
054600000000      * Key lists:
054700000000      *
054800000000     C     CODK01        KLIST
054900000000     C                   KFLD                    WWCTAB
055000000000     C                   KFLD                    WWCKEY
055100000000      *
055200000000     C     WIkey         KLIST
055300000000     C                   KFLD                    WIpgm
055400000000     C                   KFLD                    WIseq
055500000000      *
055600000000     C     SHkey         KLIST
055700000000     C                   KFLD                    WRpgm
055800000000     C                   KFLD                    WRseq
055900000000      *
056000000000      * Close files if requested by calling program:
056100000000      *
056200000000     C                   If        WIINLR = YES
056300000000     C                   Eval      *INLR = *ON
056400000000     C                   RETURN
056500000000     C                   EndIf
056600000000      *
056700000000      * Open display file:
056800000000      *
056900000000     C                   OPEN      SEC0002D
057000000000      *
057100000000     C                   MOVE      NO            WWGETR            1
057200000000      *
057300000000     C     #INZSR        ENDSR
057400000000      //---------------------------------------------------------------
057500000000**
057600000000ADD         Create a Record
057700000000COPY         Copy a Record
057800000000CHANGE      Change a Record
057900000000DELETE      Delete a Record
058000000000DISPLY      Display a Record
