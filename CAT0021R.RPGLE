000100000000      /copy qcpylesrc,stdhspec
000200000000      *****************************************************************
000300000000      *
000400000000      *  Program....: CAT0020R
000500000000      *
000600000000      *  Description: Maintain the List of users who allow to change category
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
007000000000     FCAT0021D  CF   E             WORKSTN USROPN
007100000000     FCODUSRM   UF A E           K DISK
007200000000     FUSEFILE   IF   E           K DISK
007300000000     FCODEHDR   IF   E           K DISK
007400000000      *----------------------------------------------------------------
007500000000      * Header screen mode desriptions:
007600000000     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
007700000000     D DSC             S             30    DIM(5) ALT(MOD)
007800000000      *
007900000000      *
008000000000      * General constants:
008100000000     D ERROR           C                   CONST('ERROR')
008200000000     D INUSE           C                   CONST('INUSE')
008300000000     D CHANGE          C                   CONST('CHANGE')
008400000000     D COPY            C                   CONST('COPY')
008500000000     D ADD             C                   CONST('ADD')
008600000000     D DELETE          C                   CONST('DELETE')
008700000000     D DISPLY          C                   CONST('DISPLY')
008800000000     D NEXT            C                   CONST('NEXT')
008900000000     D EXIT            C                   CONST('EXIT')
009000000000     D NO              C                   CONST('N')
009100000000     D YES             C                   CONST('Y')
009200000000      *
009300000000     D ConvertDate     s               d
009400000000      *
009500000000     D jld           E DS                  EXTNAME(dsjld)
009600000000      *
009700000000      * Incoming parms:
009800000000     D APPL            DS           512
009900000000     D  WISEC                  1      5
010000000000     D  WIIUSE                 6     15
010100000000     D  WIINLR                16     16
010200000000     D  WIACTN                17     26
010300000000     D  WIuser                27     36
010400000000     D  WIcatc                37     46
010500000000      *
010600000000      * Prompt parms for CAT0100R:
010700000000     D APP2            DS           512
010800000000     D  A2SEC                  1      5
010900000000     D  A2SEL                  6      6
011000000000     D  A2VIEW                 7      8  0
011100000000     D  A2Code                 9     18
011200000000      *
011300000000     D                SDS
011400000000     D  DSPGMN           *PROC
011500000000     D  DSUSER               254    263
011600000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011700000000     M*M                 M  A  I  N  L  I  N  E                       M
011800000000     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011900000000     C                   EXSR      $INZSR
012000000000     C                   EXSR      $CLEAR
012100000000      *
012200000000     C                   CALL      'ERMSG2'
012300000000     C                   Parm                    DSPGMN
012400000000      *
012500000000      * Retrieve record:
012600000000      *
012700000000     C                   EXSR      $GETRC
012800000000      *
012900000000      * If record is in use, retrieve the user who has the lock,
013000000000      * close the display file, and return to the previous program:
013100000000      *
013200000000     C                   If        WWRCDE = INUSE
013300000000     C                   CALL      'GEN8001C'
013400000000     C                   PARM                    WIIUSE
013500000000     C                   MOVEL     WWRCDE        WRRCDE
013600000000     C                   CLOSE     CAT0021D
013700000000     C                   RETURN
013800000000     C                   EndIf
013900000000      *
014000000000      * Retrieve field descriptions:
014100000000      *
014200000000     C                   EXSR      $DESCR
014300000000      *
014400000000      * Main loop:
014500000000      *
014600000000     C                   Dou       WWRCDE = Exit or WWRCDE = Next
014700000000      *
014800000000      * Clear all fields, if requested:
014900000000      *
015000000000     C                   If        WWCLR1 = YES
015100000000     C                   EXSR      $CLEAR
015200000000     C                   EndIf
015300000000      *
015400000000      * Retrieve record, if requested:
015500000000      *
015600000000     C                   If        WWGETR = YES
015700000000     C                   EXSR      $GETRC
015800000000     C                   EXSR      $DESCR
015900000000     C                   EndIf
016000000000      *
016100000000      * Lookup header screen mode description:
016200000000      *
016300000000     C                   Z-ADD     1             X
016400000000     C     WIACTN        LOOKUP    MOD(X)                                 99
016500000000     C     *IN99         IFEQ      *ON
016600000000     C                   MOVEL     DSC(X)        WRDSC1
016700000000     C                   END
016800000000      *
016900000000      * Display screen:
017000000000      *
017100000000     C                   WRITE     MSGCTL1
017200000000     C                   WRITE     SCRNK01
017300000000     C                   EXFMT     SCRNR01
017400000000      *
017500000000      * F12 = return to previous program:
017600000000      *
017700000000     C                   If        *In12 = *ON
017800000000     C                   MOVEL     NEXT          WWRCDE
017900000000     C                   Else
018000000000      *
018100000000     C                   If        WWFRST = YES
018200000000     C                   MOVE      NO            WWFRST
018300000000     C                   EndIf
018400000000      *
018500000000     C                   MOVE      NO            WWGETR
018600000000      *
018700000000      * Set off error indicators here:
018800000000      *
018900000000     C                   MOVEA     '00'          *IN(40)
019000000000      *
019100000000     C                   CLEAR                   WWERR1
019200000000      *
019300000000      * Clear messages:
019400000000      *
019500000000     C                   CALL      'ERMSG2'
019600000000     C                   Parm                    DSPGMN
019700000000      *
019800000000      * Process command keys:
019900000000      *
020000000000     C                   SELECT
020100000000      *
020200000000      * F4 = Prompt:
020300000000      *
020400000000     C                   When      *In04 = *ON
020500000000     C                   EXSR      $PRMPT
020600000000     C                   EXSR      $DESCR
020700000000      *
020800000000     C                   Other
020900000000      *
021000000000      * Enter:
021100000000      *
021200000000     C                   If        WIACTN = DISPLY
021300000000     C                   MOVEL     NEXT          WWRCDE
021400000000     C                   Else
021500000000      *
021600000000      * Error check, if in maintenance mode:
021700000000      *
021800000000     C                   IF        *In36 = *OFF
021900000000     C                   EXSR      $ERR01
022000000000     C                   EndIf
022100000000      *
022200000000      * If no error, update record:
022300000000      *
022400000000     C                   If        WWERR1 <> ERROR
022500000000     C                   EXSR      $DESCR
022600000000     C                   EXSR      $ENTER
022700000000     C                   EndIf
022800000000      *
022900000000     C                   EndIf
023000000000      *
023100000000     C                   EndSl
023200000000      *
023300000000     C                   EndIf
023400000000      *
023500000000     C                   EndDo
023600000000      *
023700000000      * Pass return code back to calling program through JLD field:
023800000000      *
023900000000     C                   MOVEL     WWRCDE        WRRCDE
024000000000      *
024100000000      * Close the display file:
024200000000      *
024300000000     C                   CLOSE     CAT0021D
024400000000      *
024500000000      * Release record lock:
024600000000      *
024700000000     C                   IF        WIACTN = CHANGE or WIACTN = DELETE
024800000000     C                   UNLOCK    CODUSRM
024900000000     C                   EndIf
025000000000      *
025100000000     C                   RETURN
025200000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025300000000     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
025400000000     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025500000000     C*
025600000000     C**************
025700000000     C**  $CLEAR  ** - Intialize Program/Database Fields
025800000000     C**************
025900000000     C     $CLEAR        BEGSR
026000000000      *
026100000000      * Program stays open. All program/screen fields and indicators
026200000000      * must be re-initialized here each time this program is called.
026300000000      *
026400000000      * Initialize screen and data base fields:
026500000000      *
026600000000     C                   CLEAR                   SCRNR01
026700000000     C                   CLEAR                   CODUSRR
026800000000      *
026900000000      * Field definitions and initialization:
027000000000      *
027100000000     C     *LIKE         DEFINE    WRRCDE        WWRCDE
027200000000      *
027300000000      * Clear all *LIKE definitions:
027400000000      *
027500000000     C                   CLEAR                   WWRCDE
027600000000      *
027700000000      * Initialize program described fields:
027800000000      *
027900000000     C                   MOVE      *ZEROS        WWENTR            2 0
028000000000     C                   MOVE      *ZEROS        X                 1 0
028100000000     C                   MOVE      *BLANKS       WWCTAB            3
028200000000     C                   MOVE      *BLANKS       WWCKEY           27
028300000000     C                   MOVE      YES           WWFRST            1
028400000000     C                   MOVE      NO            WWCLR1            1
028500000000     C                   MOVE      *BLANKS       WWNEXT            1
028600000000     C                   MOVE      *BLANKS       WWUPD1            1
028700000000     C                   MOVE      *BLANKS       WWERR1           10
028800000000     C                   Z-ADD     *ZERO         WWCNT1            3 0
028900000000      *
029000000000      * Fill default screen values:
029100000000      *
029200000000     C*
029300000000     C* Fill default screen values from JLD:
029400000000     C*
029500000000     C*
029600000000     C* Protect all input capable fields:
029700000000     C*
029800000000     C                   If        WIACTN = DISPLY or WIACTN = DELETE
029900000000     C                   MOVE      *ON           *IN36
030000000000     C                   ELSE
030100000000     C                   MOVE      *OFF          *IN36
030200000000     C                   END
030300000000      *
030400000000      * Protect key fields in change mode:
030500000000      *
030600000000     C****               IF        WIACTN = CHANGE
030700000000     C****               MOVE      *ON           *IN37
030800000000     C****               ELSE
030900000000     C****               MOVE      *OFF          *IN37
031000000000     C****               EndIf
031100000000      *
031200000000     C                   MOVE      *OFF          *IN60
031300000000      *
031400000000     C     #CLEAR        ENDSR
031500000000     C**************
031600000000     C**  $GETRC  ** - Retrieve Data Base Record
031700000000     C**************
031800000000     C     $GETRC        BEGSR
031900000000      *
032000000000     C                   IF        WIACTN <> ADD
032100000000      *
032200000000      * Do not lock record if copy or display mode:
032300000000      *
032400000000     C                   If        WIACTN = COPY or WIACTN = DISPLY
032500000000     C     psk01         CHAIN(N)  CODUSRM                            99
032600000000     C                   Else
032700000000     C     psk01         CHAIN     CODUSRM                            9960
032800000000     C                   EndIf
032900000000      *
033000000000     C     *IN60         IFEQ      *ON
033100000000     C                   MOVEL     INUSE         WWRCDE
033200000000     C                   ELSE
033300000000     C     *IN99         IFEQ      *OFF
033400000000     C                   EXSR      $MOVIN
033500000000     C                   END
033600000000     C                   END
033700000000      *
033800000000     C                   ELSE
033900000000     C*
034000000000     C                   EXSR      $MOVIN
034100000000     C*
034200000000     C                   END
034300000000     C*
034400000000     C     #GETRC        ENDSR
034500000000     C**************
034600000000     C**  $MOVIN  ** - Move Data Base Fields to Screen Fields
034700000000     C**************
034800000000     C     $MOVIN        BEGSR
034900000000      *
035000000000      * Add/copy mode default values:
035100000000      *
035200000000     C                   If        WIACTN = ADD
035300000000     C                   Eval      WRuser = WIuser
035400000000     C                   Eval      WRcatc = WIcatc
035500000000     C                   EndIf
035600000000      *
035700000000     C                   Select
035800000000      *
035900000000     C                   WHEN      WIACTN = COPY or WIACTN = CHANGE or
036000000000     C                             WIACTN = DISPLY or WIACTN = DELETE
036100000000     C*
036200000000     C* Move DB fields to screen fields here:
036300000000     C*
036400000000     C                   Eval      WRuser = CUUSER
036500000000     C                   Eval      WRcatc = CUCATC
036600000000      *
036700000000      * Display last update user/date:
036800000000      *
036900000000     C                   If        WIACTN <> COPY
037000000000      *
037100000000     C                   Eval      WRLUSR = CULUSR
037200000000     C*
037300000000     c                   If        CULDTE <> 0
037400000000     C                   Eval      Wrldte = %dec(%date(CULDTE:*ISO):*MDY)
037500000000     c                   Else
037600000000     c                   Clear                   wrldte
037700000000     c                   Endif
037800000000     C                   Move      cultim        wrltim
037900000000      *
038000000000     C                   EndIf
038100000000      *
038200000000     C                   ENDSL
038300000000     C*
038400000000     C     #MOVIN        ENDSR
038500000000     C**************
038600000000     C**  $DESCR  ** - Retrieve field descriptions
038700000000     C**************
038800000000     C     $DESCR        BEGSR
038900000000      *
039000000000     C     WRcatc        chain     codehdr
039100000000     C                   If        %found(codehdr)
039200000000     C                   Eval      wrdesc = CHCODD
039300000000     C                   Else
039400000000     C                   Eval      wrdesc = *blank
039500000000     C                   EndIf
039600000000      *
039700000000     C     WRuser        chain     Usefile
039800000000     C                   If        %found(Usefile)
039900000000     C                   Eval      wrname = UPTEXT
040000000000     C                   Else
040100000000     C                   Eval      wrname = *blank
040200000000     C                   EndIf
040300000000      *
040400000000     C     #DESCR        ENDSR
040500000000     C**************
040600000000     C**  $PRMPT  ** - Process Promptable Fields
040700000000     C**************
040800000000     C     $PRMPT        BEGSR
040900000000     C*
041000000000     C*****************************************************************
041100000000     C*  Field HDCSRF (defined in DDS) contains the field name which
041200000000     C*  contains the cursor. If valid, a prompting program may be
041300000000     C*  called to select a record from a list of valid values for
041400000000     C*  the prompted field. The value selected should then be placed
041500000000     C*  in the field which was prompted.
041600000000     C*
041700000000     C* eg; HDCSRF    WHEQ 'WRXXX1'
041800000000     C*      Cursor resides in field WRXXX1
041900000000     C*
042000000000     C*     CALL 'GEN0109R'
042100000000     C*      Codes file prompting program.
042200000000     C*
042300000000     C*     PARM '653'     WWCTAB
042400000000     C*      Outgoing parm.
042500000000     C*
042600000000     C*     PARM *BLANKS   WWCKEY
042700000000     C*      Return parm.
042800000000     C*
042900000000     C*     MOVELWWCKEY    WRXXX1
043000000000     C*      Move return parm into prompted field.
043100000000     C*
043200000000     C*****************************************************************
043300000000     C*
043400000000     C                   SELECT
043500000000     C
043600000000     C     HDCSRF        WHENEQ    'WRUSER'
043700000000     C                   CALL      'USERSL'
043800000000     C                   PARM                    WRUSER
043900000000      *
044000000000     C     HDCSRF        WHENEQ    'WRCATC'
044100000000     C                   CLEAR                   APP2
044200000000     C                   MOVEL     WISEC         A2SEC
044300000000     C                   Eval      A2sel = 'Y'
044400000000     C                   Eval      A2view = 0
044500000000     C                   Eval      A2code = *blank
044600000000     C                   CALL      'CAT0100R'
044700000000     C                   PARM                    jld
044800000000     C                   PARM                    APP2
044900000000     C
045000000000     C                   If        A2code <> *Blanks
045100000000     C                   Eval      Wrcatc = A2code
045200000000     C                   EndIf
045300000000      *
045400000000      * Non propmtable area:
045500000000      *
045600000000     C                   OTHER
045700000000      *
045800000000     C                   MOVEL     'SHL0004'     WWMSGI
045900000000     C                   CALL      'ERMSG1'      MSGP01
046000000000     C*
046100000000     C                   ENDSL
046200000000     C*
046300000000     C     #PRMPT        ENDSR
046400000000     C**************
046500000000     C**  $ERR01  ** - Vaildity Checking
046600000000     C**************
046700000000     C     $ERR01        BEGSR
046800000000     C*
046900000000     C                   CLEAR                   WWERR1
047000000000     C*
047100000000     C*****************************************************************
047200000000     C* All error conditions must have the following lines of code:
047300000000     C*
047400000000     C*   MOVE *ON       *INXX
047500000000     C*     Where *INXX = field error indicator in DDS.
047600000000     C*
047700000000     C*   MOVELERROR     WWERR1
047800000000     C*     Program error flag.
047900000000     C*
048000000000     C*   MOVEL'XXX0001' WWMSGI
048100000000     C*     Where XXX0001 = error message id to be displayed.
048200000000     C*
048300000000     C*   MOVELXXXXXX    WWMSGF
048400000000     C*     Where XXXXXX = name of the message file which contains
048500000000     C*     the message id contained in field WWMSGI.
048600000000     C*
048700000000     C*   CALL 'ERMSG1'MSGP01
048800000000     C*     Message handling program.
048900000000     C*****************************************************************
049000000000      *
049100000000      * Record already exists on file:
049200000000      *
049300000000     C                   IF        WIACTN = ADD or WIACTN = COPY
049400000000     C     psk02         SETLL     CODUSRM
049500000000     C                   IF        %equal(CODUSRM)
049600000000     C                   MOVEL     ERROR         WWERR1
049700000000     C                   MOVEL     'SHL0005'     WWMSGI
049800000000     C                   CALL      'ERMSG1'      MSGP01
049900000000     C                   EndIf
050000000000     C                   EndIf
050100000000      *
050200000000      * Validate User:
050300000000      *
050400000000     C     WRuser        SETLL     USEFILE
050500000000     C                   If        not %equal(USEFILE)
050600000000     C                   MOVEL     ERROR         WWERR1
050700000000     C                   MOVEL     'EDI0003'     WWMSGI
050800000000     C                   CALL      'ERMSG1'      MSGP01
050900000000     C                   EndIf
051000000000      *
051100000000      * Validate Category:
051200000000      *
051300000000     C     WRcatc        SETLL     Codehdr
051400000000     C                   If        not %equal(Codehdr)
051500000000     C                   MOVEL     ERROR         WWERR1
051600000000     C                   MOVEL     'GEN0046'     WWMSGI
051700000000     C                   CALL      'ERMSG1'      MSGP01
051800000000     C                   EndIf
051900000000      *
052000000000     C                   If        WWERR1 = ERROR
052100000000     C                   CLEAR                   WWENTR
052200000000     C                   EndIf
052300000000     C*
052400000000     C     #ERR01        ENDSR
052500000000     C**************
052600000000     C**  $ENTER  ** - Enter Key Pressed
052700000000     C**************
052800000000     C     $ENTER        BEGSR
052900000000      *
053000000000     C*****              ADD       1             WWENTR
053100000000      *
053200000000      * Update only if screen has been changed:
053300000000      *
053400000000     C                   If        *In38 = *ON
053500000000     C                   MOVE      YES           WWUPD1
053600000000     C                   Else
053700000000     C                   If        WIuser <> WRuser or WIcatc <> WRcatc
053800000000     C                   MOVE      YES           WWUPD1
053900000000     C                   EndIf
054000000000     C                   EndIf
054100000000      *
054200000000      * Send verification messages:
054300000000      *
054400000000     C                   IF        WWENTR = 1
054500000000      *
054600000000     C                   SELECT
054700000000      *
054800000000     C                   When      WIACTN = ADD or WIACTN = COPY
054900000000     C                   MOVEL     'SHL0001'     WWMSGI
055000000000     C                   CALL      'ERMSG1'      MSGP01
055100000000      *
055200000000     C                   When      WIACTN = CHANGE
055300000000     C                   MOVEL     'SHL0002'     WWMSGI
055400000000     C                   CALL      'ERMSG1'      MSGP01
055500000000      *
055600000000     C                   When      WIACTN = DELETE
055700000000     C                   MOVEL     'SHL0003'     WWMSGI
055800000000     C                   CALL      'ERMSG1'      MSGP01
055900000000      *
056000000000     C                   EndSl
056100000000      *
056200000000     C                   Else
056300000000      *
056400000000      * Update database according to current mode:
056500000000      *
056600000000     C                   CLEAR                   WWENTR
056700000000     C                   CLEAR                   WWCNT1
056800000000      *
056900000000     C                   MOVEL     NEXT          WWRCDE
057000000000      *
057100000000     C                   SELECT
057200000000      *
057300000000     C                   When      WIACTN = CHANGE and WWUPD1 = YES
057400000000     C                   EXSR      $MOVOU
057500000000     C                   UPDATE    CODUSRR
057600000000      *
057700000000     C                   When      WIACTN = ADD or WIACTN = COPY
057800000000     C                   EXSR      $MOVOU
057900000000     C                   WRITE     CODUSRR
058000000000     C                   Clear                   Wruser
058100000000     C                   Clear                   Wrcatc
058200000000      *
058300000000     C                   When      WIACTN = DELETE
058400000000     C                   DELETE    CODUSRR
058500000000      *
058600000000     C                   EndSl
058700000000      *
058800000000      * Pass 'position to' fields back to calling program:
058900000000      *
059000000000     C                   MOVE      WRuser        WIuser
059100000000     C                   MOVE      WRcatc        WIcatc
059200000000      *
059300000000      * If add mode, initialize all fields and redisplay the screen:
059400000000      *
059500000000     C                   If        WIACTN = ADD
059600000000     C                   CLEAR                   WWRCDE
059700000000     C                   MOVE      YES           WWCLR1
059800000000     C                   MOVE      YES           WWGETR
059900000000     C                   END
060000000000      *
060100000000     C                   MOVE      NO            WWUPD1
060200000000      *
060300000000     C                   END
060400000000      *
060500000000     C     #ENTER        ENDSR
060600000000     C**************
060700000000     C**  $MOVOU  ** - Move Screen Fields to Data Base Fields
060800000000     C**************
060900000000     C     $MOVOU        BEGSR
061000000000      *
061100000000      * Move screen fields to DB fields:
061200000000      *
061300000000     C                   Eval      CUUSER = WRuser
061400000000     C                   Eval      CUCATC = WRcatc
061500000000      *
061600000000      * Retrieve current date in YYYYMMDD for last update date:
061700000000      *
061800000000     C                   Eval      culdte = %int(%char(%date:*iso0))
061900000000     C                   TIME                    cultim
062000000000     C                   MOVEL     DSUSER        culusr
062100000000      *
062200000000     C     #MOVOU        ENDSR
062300000000     C**************
062400000000     C**  $INZSR  ** - Program Initialization
062500000000     C**************
062600000000     C     $INZSR        BEGSR
062700000000      *
062800000000      * Parm lists:
062900000000      *
063000000000     C     *ENTRY        PLIST
063100000000     C                   PARM                    JLD
063200000000     C                   PARM                    APPL
063300000000     C*
063400000000     C* Message file:
063500000000     C*
063600000000     C     MSGP01        PLIST
063700000000     C                   PARM                    WWMSGI            7
063800000000      *
063900000000      * Key lists:
064000000000      *
064100000000     C     CODK01        KLIST
064200000000     C                   KFLD                    WWCTAB
064300000000     C                   KFLD                    WWCKEY
064400000000     C*
064500000000     C*****************************************************************
064600000000     C* Key lists. XXXK01 is used for retieving the record to be
064700000000     C* maintained based on the record key passed to the program.
064800000000     C* XXXK02 is used to determine if a record with a duplicate
064900000000     C* key already exists on file (ADD and COPY modes only) based
065000000000     C* on the current screen field values entered by the user.
065100000000     C*
065200000000     C*   eg; File maintained - ITEMMSTR (Item/Type Code).
065300000000     C*
065400000000     C*
065500000000     C*     XXXK01    KLIST
065600000000     C*               KFLD           WIITM   <-- incoming parm
065700000000     C*               KFLD           WIICDE  <-- incoming parm
065800000000     C*
065900000000     C*     XXXK02    KLIST
066000000000     C*               KFLD           WRITM   <-- screen field
066100000000     C*               KFLD           WRICDE  <-- screen field
066200000000     C*
066300000000     C*****************************************************************
066400000000      *
066500000000     C     psk01         KLIST
066600000000     C                   KFLD                    WIuser
066700000000     C                   KFLD                    WIcatc
066800000000      *
066900000000     C     psk02         KLIST
067000000000     C                   KFLD                    WRuser
067100000000     C                   KFLD                    WRcatc
067200000000      *
067300000000      * Close files if requested by calling program:
067400000000      *
067500000000     C                   If        WIINLR = YES
067600000000     C                   Eval      *INLR = *ON
067700000000     C                   RETURN
067800000000     C                   EndIf
067900000000      *
068000000000      * Open display file:
068100000000      *
068200000000     C                   OPEN      CAT0021D
068300000000      *
068400000000     C                   MOVE      NO            WWGETR            1
068500000000      *
068600000000     C     #INZSR        ENDSR
068700000000      *
068800000000**
068900000000ADD         Create a Record
069000000000COPY         Copy a Record
069100000000CHANGE      Change a Record
069200000000DELETE      Delete a Record
069300000000DISPLY      Display a Record
