000100101228      /copy qcpylesrc,stdhspec
000200101228      ********************************************************************
000300101228      *
000400101228      *  Program: MNU0011R
000500101228      *
000600101228      *  Description: Maintain Menu Users
000700101228      *
000800101228      *  Programmer: Greg Cannella
000900101228      *
001000101228      *  Date: 12/28/10
001100101228      *
001200101228      * Comments........ Files will remain open until this program is
001300101228      *                  called with parm DSINLR equal to 'Y'.
001400101228      *
001500101228      ********************************************************************
001600101228      *                   Modification Log
001700101228      *
001800101228      *  Initials  Date      Description
001900101228      *-------------------------------------------------------------------
002000101228      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002100101228      *
002200101228      *
002300101228      *
002400101228      ********************************************************************
002500101228      *                   Indicator Usage
002600101228      *
002700101228      *   Ind.   Description
002800101228      *-------------------------------------------------------------------
002900101228      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
003000101228      *
003100101228      *
003200101228      ********************************************************************
003300101228      * Indicator Usage:                                              *
003400101228      * Ind      Use                                                  *
003500101228      * 01-24    Function keys                                        *
003600101228      * 25       Rollup key                                           *
003700101228      * 36       Protect all input fields                             *
003800101228      * 37       Protect key fields in change mode                    *
003900101228      * 38       Record format level CHANGE keyword indicator         *
004000101228      * 40-51    Error Indicators                                     *
004100101228      * 60       Record lock                                          *
004200101228      * 90-99    Hit/Miss                                             *
004300101228      *                                                               *
004400101228      *****************************************************************
004500101228      *****************************************************************
004600101228      * Field Definitions                                             *
004700101228      *                                                               *
004800101228      * Prefix                                                        *
004900101228      * WW     - Program described work fields                        *
005000101228      * WI     - APPL input parameters                                *
005100101228      * WR     - Display record fields                                *
005200101228      * HD     - Hidden fields                                        *
005300101228      * Ax     - APPx output parameters for called programs           *
005400101228      * DS     - Data structure fields                                *
005500101228      *                                                               *
005600101228      *                                                               *
005700101228      * Display Record Format Definitions                             *
005800101228      *                                                               *
005900101228      * Prefix                                                        *
006000101228      * SCRNK  - Command key                                          *
006100101228      * SCRNR  - Standard display                                     *
006200101228      * WNDWB  - Window border                                        *
006300101228      * WNDWR  - Standard window display                              *
006400101228      * MSGCTL - Message subfile control                              *
006500101228      *                                                               *
006600101228      *                                                               *
006700101228      * Called programs                                               *
006800101228      *                                                               *
006900101228      * ERMSG2 - Clear program message queue                        *
007000101228      * ERMSG1 - Send program message with message data             *
007100101228      *                                                               *
007200101228      *                                                               *
007300101228      *****************************************************************
007400101228      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007500101228      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007600101228      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007700101228      *
007800101228     FMNU0011D  CF   E             WORKSTN USROPN
007900101228     FMNUUSRM   UF A E           K DISK
008000101228      *
008100101228      * Header screen mode desriptions:
008200101228     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
008300101228     D DSC             S             30    DIM(5) ALT(MOD)
008400101228      *
008500101228      *
008600101228      * General constants:
008700101228     D ERROR           C                   CONST('ERROR')
008800101228     D INUSE           C                   CONST('INUSE')
008900101228     D CHANGE          C                   CONST('CHANGE')
009000101228     D COPY            C                   CONST('COPY')
009100101228     D ADD             C                   CONST('ADD')
009200101228     D DELETE          C                   CONST('DELETE')
009300101228     D DISPLY          C                   CONST('DISPLY')
009400101228     D NEXT            C                   CONST('NEXT')
009500101228     D EXIT            C                   CONST('EXIT')
009600101228     D NO              C                   CONST('N')
009700101228     D YES             C                   CONST('Y')
009800101228      *
009900101228     D ConvertDate     s               d
010000101228      *
010100101228     D jld           E DS                  EXTNAME(dsjld)
010200101228      *
010300101228      * Incoming parms:
010400101228     D APPL            DS           512
010500101228     D  WISEC                  1      5
010600101228     D  WIIUSE                 6     15
010700101228     D  WIINLR                16     16
010800101228     D  WIACTN                17     26
010900101228     D  WIuser                27     36
011000101228      *
011100101228     D                SDS
011200101228     D  DSPGMN           *PROC
011300101228     D  DSUSER               254    263
011400101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011500101228      *M                 M  A  I  N  L  I  N  E                       M
011600101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011700101228      *
011800101228      *
011900101228     C                   EXSR      $INZSR
012000101228     C                   EXSR      $CLEAR
012100101228      *
012200101228     C                   CALL      'ERMSG2'
012300101228     C                   Parm                    DSPGMN
012400101228      *
012500101228      * Retrieve record:
012600101228      *
012700101228     C                   EXSR      $GETRC
012800101228      *
012900101228      * If record is in use, retrieve the user who has the lock,
013000101228      * close the display file, and return to the previous program:
013100101228      *
013200101228     C     WWRCDE        IFEQ      INUSE
013300101228     C                   CALL      'GEN8001C'
013400101228     C                   PARM                    WIIUSE
013500101228     C                   MOVEL     WWRCDE        WRRCDE
013600101228     C                   CLOSE     mnu0011D
013700101228     C                   RETURN
013800101228     C                   END
013900101228      *
014000101228      * Retrieve field descriptions:
014100101228      *
014200101228     C                   EXSR      $DESCR
014300101228      *
014400101228      * Main loop:
014500101228      *
014600101228     C     WWRCDE        DOUEQ     EXIT
014700101228     C     WWRCDE        OREQ      NEXT
014800101228      *
014900101228      * Clear all fields, if requested:
015000101228      *
015100101228     C     WWCLR1        IFEQ      YES
015200101228     C                   EXSR      $CLEAR
015300101228     C                   END
015400101228      *
015500101228      * Retrieve record, if requested:
015600101228      *
015700101228     C     WWGETR        IFEQ      YES
015800101228     C                   EXSR      $GETRC
015900101228     C                   EXSR      $DESCR
016000101228     C                   END
016100101228      *
016200101228      * Lookup header screen mode description:
016300101228      *
016400101228     C                   Z-ADD     1             X
016500101228     C     WIACTN        LOOKUP    MOD(X)                                 99
016600101228     C     *IN99         IFEQ      *ON
016700101228     C                   MOVEL     DSC(X)        WRDSC1
016800101228     C                   END
016900101228      *
017000101228      * Display screen:
017100101228      *
017200101228     C                   WRITE     MSGCTL1
017300101228     C                   WRITE     SCRNK01
017400101228     C                   EXFMT     SCRNR01
017500101228      *
017600101228      * F12 = return to previous program:
017700101228      *
017800101230     C                   IF        *IN03 = *ON
017900101230     C                             OR *IN12 = *ON
018000101228     C                   MOVEL     NEXT          WWRCDE
018100101228     C                   ELSE
018200101228      *
018300101228     C     WWFRST        IFEQ      YES
018400101228     C                   MOVE      NO            WWFRST
018500101228     C                   END
018600101228      *
018700101228     C                   MOVE      NO            WWGETR
018800101228      *
018900101228      * Set off error indicators here:
019000101228      *
019100101228>>>> C                   MOVEA     '0'           *IN(40)
019200101228      *
019300101228     C                   CLEAR                   WWERR1
019400101228      *
019500101228      * Clear messages:
019600101228      *
019700101228     C                   CALL      'ERMSG2'
019800101228     C                   Parm                    DSPGMN
019900101228      *
020000101228      * Process command keys:
020100101228      *
020200101228     C                   SELECT
020300101228      *
020400101228      * F4 = Prompt:
020500101228      *
020600101228     C     *IN04         WHENEQ    *ON
020700101228     C                   EXSR      $PRMPT
020800101228     C                   EXSR      $DESCR
020900101228      *
021000101228     C                   OTHER
021100101228      *
021200101228      * Enter:
021300101228      *
021400101228     C     WIACTN        IFEQ      DISPLY
021500101228     C                   MOVEL     NEXT          WWRCDE
021600101228     C                   ELSE
021700101228      *
021800101228      * Error check, if in maintenance mode:
021900101228      *
022000101228     C     *IN36         IFEQ      *OFF
022100101228     C                   EXSR      $ERR01
022200101228     C                   END
022300101228      *
022400101228      * If no error, update record:
022500101228      *
022600101228     C     WWERR1        IFNE      ERROR
022700101228     C                   EXSR      $DESCR
022800101228     C                   EXSR      $ENTER
022900101228     C                   END
023000101228      *
023100101228     C                   END
023200101228      *
023300101228     C                   ENDSL
023400101228      *
023500101228     C                   END
023600101228      *
023700101228     C                   ENDDO
023800101228      *
023900101228      * Pass return code back to calling program through JLD field:
024000101228      *
024100101228     C                   MOVEL     WWRCDE        WRRCDE
024200101228      *
024300101228      * Close the display file:
024400101228      *
024500101228     C                   CLOSE     MNU0011D
024600101228      *
024700101228      * Release record lock:
024800101228      *
024900101228     C     WIACTN        IFEQ      CHANGE
025000101228     C     WIACTN        OREQ      DELETE
025100101228     C                   UNLOCK    MNUUSRM
025200101228     C                   END
025300101228      *
025400101228     C                   RETURN
025500101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025600101228      *$              S  U  B  R  O  U  T  I  N  E  S                 $
025700101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025800101228      *
025900101228      **************
026000101228      **  $CLEAR  ** - Intialize Program/Database Fields
026100101228      **************
026200101228     C     $CLEAR        BEGSR
026300101228      *
026400101228      * Program stays open. All program/screen fields and indicators
026500101228      * must be re-initialized here each time this program is called.
026600101228      *
026700101228      *
026800101228      *
026900101228      * Initialize screen and data base fields:
027000101228      *
027100101228     C                   CLEAR                   SCRNR01
027200101228     C                   CLEAR                   mnuusrmr
027300101228      *
027400101228      * Field definitions and initialization:
027500101228      *
027600101228     C     *LIKE         DEFINE    WRRCDE        WWRCDE
027700101228      *
027800101228      * Clear all *LIKE definitions:
027900101228      *
028000101228     C                   CLEAR                   WWRCDE
028100101228      *
028200101228      * Initialize program described fields:
028300101228      *
028400101228     C                   MOVE      *ZEROS        WWENTR            2 0
028500101228     C                   MOVE      *ZEROS        X                 1 0
028600101228     C                   MOVE      *BLANKS       WWCTAB            3
028700101228     C                   MOVE      *BLANKS       WWCKEY           27
028800101228     C                   MOVE      YES           WWFRST            1
028900101228     C                   MOVE      NO            WWCLR1            1
029000101228     C                   MOVE      *BLANKS       WWNEXT            1
029100101228     C                   MOVE      *BLANKS       WWUPD1            1
029200101228     C                   MOVE      *BLANKS       WWERR1           10
029300101228     C                   Z-ADD     *ZERO         WWCNT1            3 0
029400101228      *
029500101228      * Fill default screen values:
029600101228      *
029700101228      *
029800101228      *
029900101228      * Fill default screen values from JLD:
030000101228      *
030100101228      *
030200101228      *
030300101228      * Protect all input capable fields:
030400101228      *
030500101228     C     WIACTN        IFEQ      DISPLY
030600101228     C     WIACTN        OREQ      DELETE
030700101228     C                   MOVE      *ON           *IN36
030800101228     C                   ELSE
030900101228     C                   MOVE      *OFF          *IN36
031000101228     C                   END
031100101228      *
031200101228      * Protect key fields in change mode:
031300101228      *
031400101228     C     WIACTN        IFEQ      CHANGE
031500101228     C                   MOVE      *ON           *IN37
031600101228     C                   ELSE
031700101228     C                   MOVE      *OFF          *IN37
031800101228     C                   END
031900101228      *
032000101228     C                   MOVE      *OFF          *IN60
032100101228      *
032200101228     C                   ENDSR
032300101228      *
032400101228      **************
032500101228      **  $GETRC  ** - Retrieve Data Base Record
032600101228      **************
032700101228     C     $GETRC        BEGSR
032800101228      *
032900101228     C     WIACTN        IFNE      ADD
033000101228      *
033100101228      * Do not lock record if copy or display mode:
033200101228      *
033300101228     C     WIACTN        IFEQ      COPY
033400101228     C     WIACTN        OREQ      DISPLY
033500101228     C     muk01         CHAIN(N)  mnuusrm                            99
033600101228     C                   ELSE
033700101228     C     muk01         CHAIN     mnuusrm                            9960
033800101228     C                   END
033900101228      *
034000101228     C     *IN60         IFEQ      *ON
034100101228     C                   MOVEL     INUSE         WWRCDE
034200101228     C                   ELSE
034300101228     C     *IN99         IFEQ      *OFF
034400101228     C                   EXSR      $MOVIN
034500101228     C                   END
034600101228     C                   END
034700101228      *
034800101228     C                   ELSE
034900101228      *
035000101228     C                   EXSR      $MOVIN
035100101228      *
035200101228     C                   END
035300101228      *
035400101228     C                   ENDSR
035500101228      *
035600101228      **************
035700101228      **  $MOVIN  ** - Move Data Base Fields to Screen Fields
035800101228      **************
035900101228     C     $MOVIN        BEGSR
036000101228      *
036100101228      * Add/copy mode default values:
036200101228      *
036300101228     C     WIACTN        IFEQ      ADD
036400101228     C     WIACTN        OREQ      COPY
036500101228     C     WIACTN        IFEQ      ADD
036600101228      * Move key values into key fields:
036700101228     C                   MOVEL     WIuser        WRuser
036800101228     C                   END
036900101228     C                   END
037000101228      *
037100101228     C                   SELECT
037200101228      *
037300101228     C     WIACTN        WHENEQ    COPY
037400101228     C     WIACTN        OREQ      CHANGE
037500101228     C     WIACTN        OREQ      DISPLY
037600101228     C     WIACTN        OREQ      DELETE
037700101228      *
037800101228      * Move DB fields to screen fields here:
037900101228      *
038000101228     C                   MOVEL     muuser        WRuser
038100101228     C                   MOVEL     muimenu       WRimenu
038200101228     C                   MOVEL     museclvl      WRseclvl
038300101228     C                   MOVEL     mucmenu       WRcmenu
038400101228     C                   MOVEL     mucustm       WRcustm
038500101228      *
038600101228      * Display last update user/date:
038700101228      *
038800101228     C     WIACTN        IFNE      COPY
038900101228      *
039000101228     C                   MOVEL     muluus        WRLUSR
039100101228     C                   MOVEL     mulupg        WRLPGM
039200101228      *
039300101228     C                   If        muludt <> 0
039400101228     C     *cymd         Move      muludt        ConvertDate
039500101228     C     *mdy          Move      ConvertDate   WRLDTE
039600101228     C                   Else
039700101228     C                   Clear                   wrldte
039800101228     C                   Endif
039900101228     C                   Move      mulutm        wrltim
040000101228      *
040100101228     C                   END
040200101228      *
040300101228     C                   ENDSL
040400101228      *
040500101228     C                   ENDSR
040600101228      *
040700101228      **************
040800101228      **  $DESCR  ** - Retrieve field descriptions
040900101228      **************
041000101228     C     $DESCR        BEGSR
041100101228      *
041200101228     C                   ENDSR
041300101228      *
041400101228      **************
041500101228      **  $PRMPT  ** - Process Promptable Fields
041600101228      **************
041700101228     C     $PRMPT        BEGSR
041800101228      *
041900101228      *****************************************************************
042000101228      *  Field HDCSRF (defined in DDS) contains the field name which
042100101228      *  contains the cursor. If valid, a prompting program may be
042200101228      *  called to select a record from a list of valid values for
042300101228      *  the prompted field. The value selected should then be placed
042400101228      *  in the field which was prompted.
042500101228      *
042600101228      * eg; HDCSRF    WHEQ 'WRXXX1'
042700101228      *      Cursor resides in field WRXXX1
042800101228      *
042900101228      *     CALL 'GEN0109R'
043000101228      *      Codes file prompting program.
043100101228      *
043200101228      *     PARM '653'     WWCTAB
043300101228      *      Outgoing parm.
043400101228      *
043500101228      *     PARM *BLANKS   WWCKEY
043600101228      *      Return parm.
043700101228      *
043800101228      *     MOVELWWCKEY    WRXXX1
043900101228      *      Move return parm into prompted field.
044000101228      *
044100101228      *****************************************************************
044200101228      *
044300101228     C                   SELECT
044400101228      *
044500101228     C*    HDCSRF        WHENEQ    'WRXXX1'
044600101228     C*                  CALL      'GEN0109R'
044700101228     C*                  PARM      '653'         WWCTAB
044800101228     C*                  PARM      *BLANKS       WWCKEY
044900101228      *
045000101228     C*    WWCKEY        IFNE      *BLANKS
045100101228     C*                  MOVEL     WWCKEY        WRXXX1
045200101228     C*                  ENDIF
045300101228      *
045400101228     C*    HDCSRF        WHENEQ    'WRXXX2'
045500101228     C*                  CALL      'GEN0109R'
045600101228     C*                  PARM      '654'         WWCTAB
045700101228     C*                  PARM      *BLANKS       WWCKEY
045800101228      *
045900101228     C*    WWCKEY        IFNE      *BLANKS
046000101228     C*                  MOVEL     WWCKEY        WRXXX2
046100101228     C*                  ENDIF
046200101228      *
046300101228      * Non propmtable area:
046400101228      *
046500101228     C                   OTHER
046600101228      *
046700101228     C                   MOVEL     'SHL0004'     WWMSGI
046800101228     C                   CALL      'ERMSG1'      MSGP01
046900101228      *
047000101228     C                   ENDSL
047100101228      *
047200101228     C                   ENDSR
047300101228      *
047400101228      **************
047500101228>>>>  **  $ERR01  ** - Validity Checking
047600101228      **************
047700101228     C     $ERR01        BEGSR
047800101228      *
047900101228     C                   CLEAR                   WWERR1
048000101228      *
048100101228      *****************************************************************
048200101228      * All error conditions must have the following lines of code:
048300101228      *
048400101228      *   MOVE *ON       *INXX
048500101228      *     Where *INXX = field error indicator in DDS.
048600101228      *
048700101228      *   MOVELERROR     WWERR1
048800101228      *     Program error flag.
048900101228      *
049000101228      *   MOVEL'XXX0001' WWMSGI
049100101228      *     Where XXX0001 = error message id to be displayed.
049200101228      *
049300101228      *   MOVELXXXXXX    WWMSGF
049400101228      *     Where XXXXXX = name of the message file which contains
049500101228      *     the message id contained in field WWMSGI.
049600101228      *
049700101228      *   CALL 'ERMSG1'MSGP01
049800101228      *     Message handling program.
049900101228      *****************************************************************
050000101228      *
050100101228      *
050200101228      * Record already exists on file:
050300101228      *
050400101228     C     WIACTN        IFEQ      ADD
050500101228     C     WIACTN        OREQ      COPY
050600101228     C     muk02         SETLL     mnuusrm                                99
050700101228     C     *IN99         IFEQ      *ON
050800101228     C                   MOVEL     ERROR         WWERR1
050900101228     C                   MOVEL     'SHL0005'     WWMSGI
051000101228     C                   CALL      'ERMSG1'      MSGP01
051100101228     C                   END
051200101228     C                   END
051300101228      *
051400101228     C     WWERR1        IFEQ      ERROR
051500101228     C                   CLEAR                   WWENTR
051600101228     C                   END
051700101228      *
051800101228     C                   ENDSR
051900101228      *
052000101228      **************
052100101228      **  $ENTER  ** - Enter Key Pressed
052200101228      **************
052300101228     C     $ENTER        BEGSR
052400101228      *
052500101228     C*****              ADD       1             WWENTR
052600101228      *
052700101228      * Update only if screen has been changed:
052800101228      *
052900101228     C     *IN38         IFEQ      *ON
053000101228     C                   MOVE      YES           WWUPD1
053100101228     C                   END
053200101228      *
053300101228      * Send verification messages:
053400101228      *
053500101228     C     WWENTR        IFEQ      1
053600101228      *
053700101228     C                   SELECT
053800101228      *
053900101228     C     WIACTN        WHENEQ    ADD
054000101228     C     WIACTN        OREQ      COPY
054100101228     C                   MOVEL     'SHL0001'     WWMSGI
054200101228     C                   CALL      'ERMSG1'      MSGP01
054300101228      *
054400101228     C     WIACTN        WHENEQ    CHANGE
054500101228     C                   MOVEL     'SHL0002'     WWMSGI
054600101228     C                   CALL      'ERMSG1'      MSGP01
054700101228      *
054800101228     C     WIACTN        WHENEQ    DELETE
054900101228     C                   MOVEL     'SHL0003'     WWMSGI
055000101228     C                   CALL      'ERMSG1'      MSGP01
055100101228      *
055200101228     C                   ENDSL
055300101228      *
055400101228     C                   ELSE
055500101228      *
055600101228      * Update database according to current mode:
055700101228      *
055800101228     C                   CLEAR                   WWENTR
055900101228     C                   CLEAR                   WWCNT1
056000101228      *
056100101228     C                   MOVEL     NEXT          WWRCDE
056200101228      *
056300101228     C                   SELECT
056400101228      *
056500101228     C     WIACTN        WHENEQ    CHANGE
056600101228     C     WWUPD1        ANDEQ     YES
056700101228     C                   EXSR      $MOVOU
056800101228     C                   UPDATE    mnuusrmr
056900101228      *
057000101228     C     WIACTN        WHENEQ    ADD
057100101228     C     WIACTN        OREQ      COPY
057200101228     C                   EXSR      $MOVOU
057300101228     C                   WRITE     mnuusrmr
057400101228      *
057500101228     C     WIACTN        WHENEQ    DELETE
057600101228     C                   DELETE    mnuusrm
057700101228      *
057800101228     C                   ENDSL
057900101228      *
058000101228      * Pass 'position to' fields back to calling program:
058100101228      *
058200101228     C                   MOVE      WRuser        WIuser
058300101228      *
058400101228      * If add mode, initialize all fields and redisplay the screen:
058500101228      *
058600101228     C     WIACTN        IFEQ      ADD
058700101228     C                   CLEAR                   WWRCDE
058800101228     C                   MOVE      YES           WWCLR1
058900101228     C                   MOVE      YES           WWGETR
059000101228     C                   END
059100101228      *
059200101228     C                   MOVE      NO            WWUPD1
059300101228      *
059400101228     C                   END
059500101228      *
059600101228     C                   ENDSR
059700101228      *
059800101228      **************
059900101228      **  $MOVOU  ** - Move Screen Fields to Data Base Fields
060000101228      **************
060100101228     C     $MOVOU        BEGSR
060200101228      *
060300101228      * Move screen fields to DB fields:
060400101228      *
060500101228     C                   MOVEL     WRuser        muuser
060600101228     C                   MOVEL     WRimenu       muimenu
060700101228     C                   MOVEL     WRseclvl      museclvl
060800101228     C                   MOVEL     WRcmenu       mucmenu
060900101228     C                   MOVEL     WRcustm       mucustm
061000101228      *
061100101228      * Retrieve current date in YYYYMMDD for last update date:
061200101228      *
061300101228      *
061400101228     C                   Eval      muludt = %int(%char(%date:*cymd0))
061500101228     C                   TIME                    mulutm
061600101228     C                   MOVEL     DSPGMN        mulupg
061700101228     C                   MOVEL     DSUSER        muluus
061800101228      *
061900101228     C                   ENDSR
062000101228      *
062100101228      **************
062200101228      **  $INZSR  ** - Program Initialization
062300101228      **************
062400101228     C     $INZSR        BEGSR
062500101228      *
062600101228      * Parm lists:
062700101228      *
062800101228     C     *ENTRY        PLIST
062900101228     C                   PARM                    JLD
063000101228     C                   PARM                    APPL
063100101228      *
063200101228      * Message file:
063300101228      *
063400101228     C     MSGP01        PLIST
063500101228     C                   PARM                    WWMSGI            7
063600101228      *
063700101228      * Key lists:
063800101228      *
063900101228     C     CODK01        KLIST
064000101228     C                   KFLD                    WWCTAB
064100101228     C                   KFLD                    WWCKEY
064200101228      *
064300101228      *****************************************************************
064400101228      * Key lists. XXXK01 is used for retieving the record to be
064500101228      * maintained based on the record key passed to the program.
064600101228      * XXXK02 is used to determine if a record with a duplicate
064700101228      * key already exists on file (ADD and COPY modes only) based
064800101228      * on the current screen field values entered by the user.
064900101228      *
065000101228      *   eg; File maintained - ITEMMSTR (Item/Type Code).
065100101228      *
065200101228      *
065300101228      *     XXXK01    KLIST
065400101228      *               KFLD           WIITM   <-- incoming parm
065500101228      *               KFLD           WIICDE  <-- incoming parm
065600101228      *
065700101228      *     XXXK02    KLIST
065800101228      *               KFLD           WRITM   <-- screen field
065900101228      *               KFLD           WRICDE  <-- screen field
066000101228      *
066100101228      *****************************************************************
066200101228      *
066300101228      *
066400101228     C     muk01         KLIST
066500101228     C                   KFLD                    WIuser
066600101228      *
066700101228     C     muk02         KLIST
066800101228     C                   KFLD                    WRuser
066900101228      *
067000101228      * Close files if requested by calling program:
067100101228      *
067200101228     C     WIINLR        IFEQ      YES
067300101228     C                   MOVE      *ON           *INLR
067400101228     C                   RETURN
067500101228     C                   END
067600101228      *
067700101228      * Open display file:
067800101228      *
067900101228     C                   OPEN      mnu0011D
068000101228      *
068100101228     C                   MOVE      NO            WWGETR            1
068200101228      *
068300101228     C                   ENDSR
068400101228      *
068500101228**
068600101228ADD         Create a Menu User
068700101228COPY         Copy a Menu User
068800101228CHANGE      Change a Menu User
068900101228DELETE      Delete a Menu User
069000101228DISPLY      Display a Menu User
