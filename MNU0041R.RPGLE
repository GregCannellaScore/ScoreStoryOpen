000100101229      /copy qcpylesrc,stdhspec
000200101229      ********************************************************************
000300101229      *
000400101229      *  Program: MNU0041R
000500101229      *
000600101229      *  Description: Maintain menu options
000700101229      *
000800101229      *  Programmer: Greg Cannella
000900101229      *
001000101229      *  Date: 12/29/10
001100101229      *
001200101229      * Comments........ Files will remain open until this program is
001300101229      *                  called with parm DSINLR equal to 'Y'.
001400101229      *
001500101229      ********************************************************************
001600101229      *                   Modification Log
001700101229      *
001800101229      *  Initials  Date      Description
001900101229      *-------------------------------------------------------------------
002000101229      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002100101229      *
002200101229      *
002300101229      *
002400101229      ********************************************************************
002500101229      *                   Indicator Usage
002600101229      *
002700101229      *   Ind.   Description
002800101229      *-------------------------------------------------------------------
002900101229      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
003000101229      *
003100101229      *
003200101229      ********************************************************************
003300101229      * Indicator Usage:                                              *
003400101229      * Ind      Use                                                  *
003500101229      * 01-24    Function keys                                        *
003600101229      * 25       Rollup key                                           *
003700101229      * 36       Protect all input fields                             *
003800101229      * 37       Protect key fields in change mode                    *
003900101229      * 38       Record format level CHANGE keyword indicator         *
004000101229      * 40-51    Error Indicators                                     *
004100101229      * 60       Record lock                                          *
004200101229      * 90-99    Hit/Miss                                             *
004300101229      *                                                               *
004400101229      *****************************************************************
004500101229      *****************************************************************
004600101229      * Field Definitions                                             *
004700101229      *                                                               *
004800101229      * Prefix                                                        *
004900101229      * WW     - Program described work fields                        *
005000101229      * WI     - APPL input parameters                                *
005100101229      * WR     - Display record fields                                *
005200101229      * HD     - Hidden fields                                        *
005300101229      * Ax     - APPx output parameters for called programs           *
005400101229      * DS     - Data structure fields                                *
005500101229      *                                                               *
005600101229      *                                                               *
005700101229      * Display Record Format Definitions                             *
005800101229      *                                                               *
005900101229      * Prefix                                                        *
006000101229      * SCRNK  - Command key                                          *
006100101229      * SCRNR  - Standard display                                     *
006200101229      * WNDWB  - Window border                                        *
006300101229      * WNDWR  - Standard window display                              *
006400101229      * MSGCTL - Message subfile control                              *
006500101229      *                                                               *
006600101229      *                                                               *
006700101229      * Called programs                                               *
006800101229      *                                                               *
006900101229      * ERMSG2 - Clear program message queue                        *
007000101229      * ERMSG1 - Send program message with message data             *
007100101229      *                                                               *
007200101229      *                                                               *
007300101229      *****************************************************************
007400101229      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007500101229      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007600101229      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007700101229      *
007800101229     FMNU0041D  CF   E             WORKSTN USROPN
007900101229     FMNUOPTM   UF A E           K DISK
008000101229      *
008100101229      * Header screen mode desriptions:
008200101229     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
008300101229     D DSC             S             30    DIM(5) ALT(MOD)
008400101229      *
008500101229      *
008600101229      * General constants:
008700101229     D ERROR           C                   CONST('ERROR')
008800101229     D INUSE           C                   CONST('INUSE')
008900101229     D CHANGE          C                   CONST('CHANGE')
009000101229     D COPY            C                   CONST('COPY')
009100101229     D ADD             C                   CONST('ADD')
009200101229     D DELETE          C                   CONST('DELETE')
009300101229     D DISPLY          C                   CONST('DISPLY')
009400101229     D NEXT            C                   CONST('NEXT')
009500101229     D EXIT            C                   CONST('EXIT')
009600101229     D NO              C                   CONST('N')
009700101229     D YES             C                   CONST('Y')
009800101229      *
009900101229     D ConvertDate     s               d
010000101229      *
010100101229     D jld           E DS                  EXTNAME(dsjld)
010200101229      *
010300101229      * Incoming parms:
010400101229     D APPL            DS           512
010500101229     D  WISEC                  1      5
010600101229     D  WIIUSE                 6     15
010700101229     D  WIINLR                16     16
010800101229     D  WIACTN                17     26
010900101229     D  WIOPT                 27     36
011000101229      *
011100101229     D                SDS
011200101229     D  DSPGMN           *PROC
011300101229     D  DSUSER               254    263
011400101229      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011500101229      *M                 M  A  I  N  L  I  N  E                       M
011600101229      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011700101229      *
011800101229      *
011900101229     C                   EXSR      $INZSR
012000101229     C                   EXSR      $CLEAR
012100101229      *
012200101229     C                   CALL      'ERMSG2'
012300101229     C                   Parm                    DSPGMN
012400101229      *
012500101229      * Retrieve record:
012600101229      *
012700101229     C                   EXSR      $GETRC
012800101229      *
012900101229      * If record is in use, retrieve the user who has the lock,
013000101229      * close the display file, and return to the previous program:
013100101229      *
013200101229     C     WWRCDE        IFEQ      INUSE
013300101229     C                   CALL      'GEN8001C'
013400101229     C                   PARM                    WIIUSE
013500101229     C                   MOVEL     WWRCDE        WRRCDE
013600101229     C                   CLOSE     MNU0041D
013700101229     C                   RETURN
013800101229     C                   END
013900101229      *
014000101229      * Retrieve field descriptions:
014100101229      *
014200101229     C                   EXSR      $DESCR
014300101229      *
014400101229      * Main loop:
014500101229      *
014600101229     C     WWRCDE        DOUEQ     EXIT
014700101229     C     WWRCDE        OREQ      NEXT
014800101229      *
014900101229      * Clear all fields, if requested:
015000101229      *
015100101229     C     WWCLR1        IFEQ      YES
015200101229     C                   EXSR      $CLEAR
015300101229     C                   END
015400101229      *
015500101229      * Retrieve record, if requested:
015600101229      *
015700101229     C     WWGETR        IFEQ      YES
015800101229     C                   EXSR      $GETRC
015900101229     C                   EXSR      $DESCR
016000101229     C                   END
016100101229      *
016200101229      * Lookup header screen mode description:
016300101229      *
016400101229     C                   Z-ADD     1             X
016500101229     C     WIACTN        LOOKUP    MOD(X)                                 99
016600101229     C     *IN99         IFEQ      *ON
016700101229     C                   MOVEL     DSC(X)        WRDSC1
016800101229     C                   END
016900101229      *
017000101229      * Display screen:
017100101229      *
017200101229     C                   WRITE     MSGCTL1
017300101229     C                   WRITE     SCRNK01
017400101229     C                   EXFMT     SCRNR01
017500101229      *
017600101229      * F12 = return to previous program:
017700101229      *
017800101230     C                   IF        *in03 = *ON
017900101230     C                             or *IN12 = *ON
018000101229     C                   MOVEL     NEXT          WWRCDE
018100101229     C                   ELSE
018200101229      *
018300101229     C     WWFRST        IFEQ      YES
018400101229     C                   MOVE      NO            WWFRST
018500101229     C                   END
018600101229      *
018700101229     C                   MOVE      NO            WWGETR
018800101229      *
018900101229      * Set off error indicators here:
019000101229      *
019100101229>>>> C                   MOVEA     '0'           *IN(40)
019200101229      *
019300101229     C                   CLEAR                   WWERR1
019400101229      *
019500101229      * Clear messages:
019600101229      *
019700101229     C                   CALL      'ERMSG2'
019800101229     C                   Parm                    DSPGMN
019900101229      *
020000101229      * Process command keys:
020100101229      *
020200101229     C                   SELECT
020300101229      *
020400101229      * F4 = Prompt:
020500101229      *
020600101229     C     *IN04         WHENEQ    *ON
020700101229     C                   EXSR      $PRMPT
020800101229     C                   EXSR      $DESCR
020900101230      *
021000101230      * F6 = Prompt:
021100101230      *
021200101230     C     *IN06         WHENEQ    *ON
021300101230     C                   call      'MNU0050R'
021400101230     C                   parm                    wropt
021500101229      *
021600101229     C                   OTHER
021700101229      *
021800101229      * Enter:
021900101229      *
022000101229     C     WIACTN        IFEQ      DISPLY
022100101229     C                   MOVEL     NEXT          WWRCDE
022200101229     C                   ELSE
022300101229      *
022400101229      * Error check, if in maintenance mode:
022500101229      *
022600101229     C     *IN36         IFEQ      *OFF
022700101229     C                   EXSR      $ERR01
022800101229     C                   END
022900101229      *
023000101229      * If no error, update record:
023100101229      *
023200101229     C     WWERR1        IFNE      ERROR
023300101229     C                   EXSR      $DESCR
023400101229     C                   EXSR      $ENTER
023500101229     C                   END
023600101229      *
023700101229     C                   END
023800101229      *
023900101229     C                   ENDSL
024000101229      *
024100101229     C                   END
024200101229      *
024300101229     C                   ENDDO
024400101229      *
024500101229      * Pass return code back to calling program through JLD field:
024600101229      *
024700101229     C                   MOVEL     WWRCDE        WRRCDE
024800101229      *
024900101229      * Close the display file:
025000101229      *
025100101229     C                   CLOSE     MNU0041D
025200101229      *
025300101229      * Release record lock:
025400101229      *
025500101229     C     WIACTN        IFEQ      CHANGE
025600101229     C     WIACTN        OREQ      DELETE
025700101229     C                   UNLOCK    MNUOPTM
025800101229     C                   END
025900101229      *
026000101229     C                   RETURN
026100101229      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026200101229      *$              S  U  B  R  O  U  T  I  N  E  S                 $
026300101229      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026400101229      *
026500101229      **************
026600101229      **  $CLEAR  ** - Intialize Program/Database Fields
026700101229      **************
026800101229     C     $CLEAR        BEGSR
026900101229      *
027000101229      * Program stays open. All program/screen fields and indicators
027100101229      * must be re-initialized here each time this program is called.
027200101229      *
027300101229      *
027400101229      *
027500101229      * Initialize screen and data base fields:
027600101229      *
027700101229     C                   CLEAR                   SCRNR01
027800101229     C                   CLEAR                   MNUOPTMR
027900101229      *
028000101229      * Field definitions and initialization:
028100101229      *
028200101229     C     *LIKE         DEFINE    WRRCDE        WWRCDE
028300101229      *
028400101229      * Clear all *LIKE definitions:
028500101229      *
028600101229     C                   CLEAR                   WWRCDE
028700101229      *
028800101229      * Initialize program described fields:
028900101229      *
029000101229     C                   MOVE      *ZEROS        WWENTR            2 0
029100101229     C                   MOVE      *ZEROS        X                 1 0
029200101229     C                   MOVE      *BLANKS       WWCTAB            3
029300101229     C                   MOVE      *BLANKS       WWCKEY           27
029400101229     C                   MOVE      YES           WWFRST            1
029500101229     C                   MOVE      NO            WWCLR1            1
029600101229     C                   MOVE      *BLANKS       WWNEXT            1
029700101229     C                   MOVE      *BLANKS       WWUPD1            1
029800101229     C                   MOVE      *BLANKS       WWERR1           10
029900101229     C                   Z-ADD     *ZERO         WWCNT1            3 0
030000101229      *
030100101229      * Fill default screen values:
030200101229      *
030300101229      *
030400101229      *
030500101229      * Fill default screen values from JLD:
030600101229      *
030700101229      *
030800101229      *
030900101229      * Protect all input capable fields:
031000101229      *
031100101229     C     WIACTN        IFEQ      DISPLY
031200101229     C     WIACTN        OREQ      DELETE
031300101229     C                   MOVE      *ON           *IN36
031400101229     C                   ELSE
031500101229     C                   MOVE      *OFF          *IN36
031600101229     C                   END
031700101229      *
031800101229      * Protect key fields in change mode:
031900101229      *
032000101229     C     WIACTN        IFEQ      CHANGE
032100101229     C                   MOVE      *ON           *IN37
032200101229     C                   ELSE
032300101229     C                   MOVE      *OFF          *IN37
032400101229     C                   END
032500101229      *
032600101229     C                   MOVE      *OFF          *IN60
032700101229      *
032800101229     C                   ENDSR
032900101229      *
033000101229      **************
033100101229      **  $GETRC  ** - Retrieve Data Base Record
033200101229      **************
033300101229     C     $GETRC        BEGSR
033400101229      *
033500101229     C     WIACTN        IFNE      ADD
033600101229      *
033700101229      * Do not lock record if copy or display mode:
033800101229      *
033900101229     C     WIACTN        IFEQ      COPY
034000101229     C     WIACTN        OREQ      DISPLY
034100101229     C     mok01         CHAIN(N)  mnuoptm                            99
034200101229     C                   ELSE
034300101229     C     mok01         CHAIN     mnuoptm                            9960
034400101229     C                   END
034500101229      *
034600101229     C     *IN60         IFEQ      *ON
034700101229     C                   MOVEL     INUSE         WWRCDE
034800101229     C                   ELSE
034900101229     C     *IN99         IFEQ      *OFF
035000101229     C                   EXSR      $MOVIN
035100101229     C                   END
035200101229     C                   END
035300101229      *
035400101229     C                   ELSE
035500101229      *
035600101229     C                   EXSR      $MOVIN
035700101229      *
035800101229     C                   END
035900101229      *
036000101229     C                   ENDSR
036100101229      *
036200101229      **************
036300101229      **  $MOVIN  ** - Move Data Base Fields to Screen Fields
036400101229      **************
036500101229     C     $MOVIN        BEGSR
036600101229      *
036700101229      * Add/copy mode default values:
036800101229      *
036900101229     C     WIACTN        IFEQ      ADD
037000101229     C     WIACTN        OREQ      COPY
037100101229     C     WIACTN        IFEQ      ADD
037200101229      * Move key values into key fields:
037300101229     C                   MOVEL     WIopt         WRopt
037400101229     C                   END
037500101229     C                   END
037600101229      *
037700101229     C                   SELECT
037800101229      *
037900101229     C     WIACTN        WHENEQ    COPY
038000101229     C     WIACTN        OREQ      CHANGE
038100101229     C     WIACTN        OREQ      DISPLY
038200101229     C     WIACTN        OREQ      DELETE
038300101229      *
038400101229      * Move DB fields to screen fields here:
038500101229      *
038600101229     C                   MOVEL     moopt         WRopt
038700101229     C                   MOVEL     modesc        WRdesc
038800101229     C                   MOVEL     mocmd         WRcmd
038900101229     C                   MOVEL     moprompt      WRprompt
039000101229     C                   MOVEL     mophead       WRphead
039100101229     C                   MOVEL     mopbody       WRpbody
039200101229     C                   MOVEL     moseclvl      WRseclvl
039201130206     C                   MOVEL     moexpg        WRexpg
039300101229      *
039400101229      * Display last update user/date:
039500101229      *
039600101229     C     WIACTN        IFNE      COPY
039700101229      *
039800101229     C                   MOVEL     moluus        WRLUSR
039900101229     C                   MOVEL     molupg        WRLPGM
040000101229      *
040100101229     C                   If        moludt <> 0
040200101229     C     *cymd         Move      moludt        ConvertDate
040300101229     C     *mdy          Move      ConvertDate   WRLDTE
040400101229     C                   Else
040500101229     C                   Clear                   wrldte
040600101229     C                   Endif
040700101229     C                   Move      molutm        wrltim
040800101229      *
040900101229     C                   END
041000101229      *
041100101229     C                   ENDSL
041200101229      *
041300101229     C                   ENDSR
041400101229      *
041500101229      **************
041600101229      **  $DESCR  ** - Retrieve field descriptions
041700101229      **************
041800101229     C     $DESCR        BEGSR
041900101229      *
042000101229     C                   ENDSR
042100101229      *
042200101229      **************
042300101229      **  $PRMPT  ** - Process Promptable Fields
042400101229      **************
042500101229     C     $PRMPT        BEGSR
042600101229      *
042700101229      *****************************************************************
042800101229      *  Field HDCSRF (defined in DDS) contains the field name which
042900101229      *  contains the cursor. If valid, a prompting program may be
043000101229      *  called to select a record from a list of valid values for
043100101229      *  the prompted field. The value selected should then be placed
043200101229      *  in the field which was prompted.
043300101229      *
043400101229      * eg; HDCSRF    WHEQ 'WRXXX1'
043500101229      *      Cursor resides in field WRXXX1
043600101229      *
043700101229      *     CALL 'GEN0109R'
043800101229      *      Codes file prompting program.
043900101229      *
044000101229      *     PARM '653'     WWCTAB
044100101229      *      Outgoing parm.
044200101229      *
044300101229      *     PARM *BLANKS   WWCKEY
044400101229      *      Return parm.
044500101229      *
044600101229      *     MOVELWWCKEY    WRXXX1
044700101229      *      Move return parm into prompted field.
044800101229      *
044900101229      *****************************************************************
045000101229      *
045100101229     C                   SELECT
045200101229      *
045300101229     C*    HDCSRF        WHENEQ    'WRXXX1'
045400101229     C*                  CALL      'GEN0109R'
045500101229     C*                  PARM      '653'         WWCTAB
045600101229     C*                  PARM      *BLANKS       WWCKEY
045700101229      *
045800101229     C*    WWCKEY        IFNE      *BLANKS
045900101229     C*                  MOVEL     WWCKEY        WRXXX1
046000101229     C*                  ENDIF
046100101229      *
046200101229     C*    HDCSRF        WHENEQ    'WRXXX2'
046300101229     C*                  CALL      'GEN0109R'
046400101229     C*                  PARM      '654'         WWCTAB
046500101229     C*                  PARM      *BLANKS       WWCKEY
046600101229      *
046700101229     C*    WWCKEY        IFNE      *BLANKS
046800101229     C*                  MOVEL     WWCKEY        WRXXX2
046900101229     C*                  ENDIF
047000101229      *
047100101229      * Non propmtable area:
047200101229      *
047300101229     C                   OTHER
047400101229      *
047500101229     C                   MOVEL     'SHL0004'     WWMSGI
047600101229     C                   CALL      'ERMSG1'      MSGP01
047700101229      *
047800101229     C                   ENDSL
047900101229      *
048000101229     C                   ENDSR
048100101229      *
048200101229      **************
048300101229>>>>  **  $ERR01  ** - Validity Checking
048400101229      **************
048500101229     C     $ERR01        BEGSR
048600101229      *
048700101229     C                   CLEAR                   WWERR1
048800101229      *
048900101229      *****************************************************************
049000101229      * All error conditions must have the following lines of code:
049100101229      *
049200101229      *   MOVE *ON       *INXX
049300101229      *     Where *INXX = field error indicator in DDS.
049400101229      *
049500101229      *   MOVELERROR     WWERR1
049600101229      *     Program error flag.
049700101229      *
049800101229      *   MOVEL'XXX0001' WWMSGI
049900101229      *     Where XXX0001 = error message id to be displayed.
050000101229      *
050100101229      *   MOVELXXXXXX    WWMSGF
050200101229      *     Where XXXXXX = name of the message file which contains
050300101229      *     the message id contained in field WWMSGI.
050400101229      *
050500101229      *   CALL 'ERMSG1'MSGP01
050600101229      *     Message handling program.
050700101229      *****************************************************************
050800101229      *
050900101229      *
051000101229      * Record already exists on file:
051100101229      *
051200101229     C     WIACTN        IFEQ      ADD
051300101229     C     WIACTN        OREQ      COPY
051400101229     C     mok02         SETLL     mnuoptm                                99
051500101229     C     *IN99         IFEQ      *ON
051600101229     C                   MOVEL     ERROR         WWERR1
051700101229     C                   MOVEL     'SHL0005'     WWMSGI
051800101229     C                   CALL      'ERMSG1'      MSGP01
051900101229     C                   END
052000101229     C                   END
052100101229      *
052200101229     C     WWERR1        IFEQ      ERROR
052300101229     C                   CLEAR                   WWENTR
052400101229     C                   END
052500101229      *
052600101229     C                   ENDSR
052700101229      *
052800101229      **************
052900101229      **  $ENTER  ** - Enter Key Pressed
053000101229      **************
053100101229     C     $ENTER        BEGSR
053200101229      *
053300101229     C*****              ADD       1             WWENTR
053400101229      *
053500101229      * Update only if screen has been changed:
053600101229      *
053700101229     C     *IN38         IFEQ      *ON
053800101229     C                   MOVE      YES           WWUPD1
053900101229     C                   END
054000101229      *
054100101229      * Send verification messages:
054200101229      *
054300101229     C     WWENTR        IFEQ      1
054400101229      *
054500101229     C                   SELECT
054600101229      *
054700101229     C     WIACTN        WHENEQ    ADD
054800101229     C     WIACTN        OREQ      COPY
054900101229     C                   MOVEL     'SHL0001'     WWMSGI
055000101229     C                   CALL      'ERMSG1'      MSGP01
055100101229      *
055200101229     C     WIACTN        WHENEQ    CHANGE
055300101229     C                   MOVEL     'SHL0002'     WWMSGI
055400101229     C                   CALL      'ERMSG1'      MSGP01
055500101229      *
055600101229     C     WIACTN        WHENEQ    DELETE
055700101229     C                   MOVEL     'SHL0003'     WWMSGI
055800101229     C                   CALL      'ERMSG1'      MSGP01
055900101229      *
056000101229     C                   ENDSL
056100101229      *
056200101229     C                   ELSE
056300101229      *
056400101229      * Update database according to current mode:
056500101229      *
056600101229     C                   CLEAR                   WWENTR
056700101229     C                   CLEAR                   WWCNT1
056800101229      *
056900101229     C                   MOVEL     NEXT          WWRCDE
057000101229      *
057100101229     C                   SELECT
057200101229      *
057300101229     C     WIACTN        WHENEQ    CHANGE
057400101229     C     WWUPD1        ANDEQ     YES
057500101229     C                   EXSR      $MOVOU
057600101229     C                   UPDATE    mnuoptmr
057700101229      *
057800101229     C     WIACTN        WHENEQ    ADD
057900101229     C     WIACTN        OREQ      COPY
058000101229     C                   EXSR      $MOVOU
058100101229     C                   WRITE     mnuoptmr
058200101229      *
058300101229     C     WIACTN        WHENEQ    DELETE
058400101229     C                   DELETE    mnuoptm
058500101229      *
058600101229     C                   ENDSL
058700101229      *
058800101229      * Pass 'position to' fields back to calling program:
058900101229      *
059000101229     C                   MOVE      WRopt         WIopt
059100101229      *
059200101229      * If add mode, initialize all fields and redisplay the screen:
059300101229      *
059400101229     C     WIACTN        IFEQ      ADD
059500101229     C                   CLEAR                   WWRCDE
059600101229     C                   MOVE      YES           WWCLR1
059700101229     C                   MOVE      YES           WWGETR
059800101229     C                   END
059900101229      *
060000101229     C                   MOVE      NO            WWUPD1
060100101229      *
060200101229     C                   END
060300101229      *
060400101229     C                   ENDSR
060500101229      *
060600101229      **************
060700101229      **  $MOVOU  ** - Move Screen Fields to Data Base Fields
060800101229      **************
060900101229     C     $MOVOU        BEGSR
061000101229      *
061100101229      * Move screen fields to DB fields:
061200101229      *
061300101229     C                   MOVEL     WRopt         moopt
061400101229     C                   MOVEL     WRdesc        modesc
061500101229     C                   MOVEL     WRcmd         mocmd
061600101229     C                   MOVEL     WRprompt      moprompt
061700101229     C                   MOVEL     WRphead       mophead
061800101229     C                   MOVEL     WRpbody       mopbody
061900101229     C                   MOVEL     WRseclvl      moseclvl
061901130206     C                   MOVEL     WRexpg        moexpg
062000101229      *
062100101229      * Retrieve current date in YYYYMMDD for last update date:
062200101229      *
062300101229      *
062400101229     C                   Eval      moludt = %int(%char(%date:*cymd0))
062500101229     C                   TIME                    molutm
062600101229     C                   MOVEL     DSPGMN        molupg
062700101229     C                   MOVEL     DSUSER        moluus
062800101229      *
062900101229     C                   ENDSR
063000101229      *
063100101229      **************
063200101229      **  $INZSR  ** - Program Initialization
063300101229      **************
063400101229     C     $INZSR        BEGSR
063500101229      *
063600101229      * Parm lists:
063700101229      *
063800101229     C     *ENTRY        PLIST
063900101229     C                   PARM                    JLD
064000101229     C                   PARM                    APPL
064100101229      *
064200101229      * Message file:
064300101229      *
064400101229     C     MSGP01        PLIST
064500101229     C                   PARM                    WWMSGI            7
064600101229      *
064700101229      * Key lists:
064800101229      *
064900101229     C     CODK01        KLIST
065000101229     C                   KFLD                    WWCTAB
065100101229     C                   KFLD                    WWCKEY
065200101229      *
065300101229      *****************************************************************
065400101229      * Key lists. XXXK01 is used for retieving the record to be
065500101229      * maintained based on the record key passed to the program.
065600101229      * XXXK02 is used to determine if a record with a duplicate
065700101229      * key already exists on file (ADD and COPY modes only) based
065800101229      * on the current screen field values entered by the user.
065900101229      *
066000101229      *   eg; File maintained - ITEMMSTR (Item/Type Code).
066100101229      *
066200101229      *
066300101229      *     XXXK01    KLIST
066400101229      *               KFLD           WIITM   <-- incoming parm
066500101229      *               KFLD           WIICDE  <-- incoming parm
066600101229      *
066700101229      *     XXXK02    KLIST
066800101229      *               KFLD           WRITM   <-- screen field
066900101229      *               KFLD           WRICDE  <-- screen field
067000101229      *
067100101229      *****************************************************************
067200101229      *
067300101229      *
067400101229     C     mok01         KLIST
067500101229     C                   KFLD                    WIopt
067600101229      *
067700101229     C     mok02         KLIST
067800101229     C                   KFLD                    WRopt
067900101229      *
068000101229      * Close files if requested by calling program:
068100101229      *
068200101229     C     WIINLR        IFEQ      YES
068300101229     C                   MOVE      *ON           *INLR
068400101229     C                   RETURN
068500101229     C                   END
068600101229      *
068700101229      * Open display file:
068800101229      *
068900101229     C                   OPEN      mnu0041D
069000101229      *
069100101229     C                   MOVE      NO            WWGETR            1
069200101229      *
069300101229     C                   ENDSR
069400101229      *
069500101229**
069600101229ADD         Create a Menu Option
069700101229COPY         Copy a Menu Option
069800101229CHANGE      Change a Menu Option
069900101229DELETE      Delete a Menu Option
070000101229DISPLY      Display a Menu Option
