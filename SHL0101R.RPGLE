000001080522      /copy qcpylesrc,stdhspec
000002080522      ********************************************************************
000003080522      *
000004080522      *  Program:
000005080522      *
000006080522      *  Description:
000007080522      *
000008080522      *  Programmer:
000009080522      *
000010080522      *  Date:
000011080522      *
000012080522      * Comments........ Files will remain open until this program is
000013080522      *                  called with parm DSINLR equal to 'Y'.
000014080522      *
000015080522      ********************************************************************
000016080522      *                   Modification Log
000017080522      *
000018080522      *  Initials  Date      Description
000019080522      *-------------------------------------------------------------------
000020080522      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
000021080522      *
000022080522      *
000023080522      *
000024080522      ********************************************************************
000025080522      *                   Indicator Usage
000026080522      *
000027080522      *   Ind.   Description
000028080522      *-------------------------------------------------------------------
000029080522      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
000030080522      *
000031080522      *
000032080522      ********************************************************************
002700080522      * Indicator Usage:                                              *
002800080522      * Ind      Use                                                  *
002900080522      * 01-24    Function keys                                        *
003000080522      * 25       Rollup key                                           *
003100080522      * 36       Protect all input fields                             *
003200080522      * 37       Protect key fields in change mode                    *
003300080522      * 38       Record format level CHANGE keyword indicator         *
003400080522      * 40-51    Error Indicators                                     *
003500080522      * 60       Record lock                                          *
003600080522      * 90-99    Hit/Miss                                             *
003700080522      *                                                               *
003800080522      *****************************************************************
004000080522      *****************************************************************
004100080522      * Field Definitions                                             *
004200080522      *                                                               *
004300080522      * Prefix                                                        *
004400080522      * WW     - Program described work fields                        *
004500080522      * WI     - APPL input parameters                                *
004600080522      * WR     - Display record fields                                *
004700080522      * HD     - Hidden fields                                        *
004800080522      * Ax     - APPx output parameters for called programs           *
004900080522      * DS     - Data structure fields                                *
005000080522      *                                                               *
005100080522      *                                                               *
005200080522      * Display Record Format Definitions                             *
005300080522      *                                                               *
005400080522      * Prefix                                                        *
005500080522      * SCRNK  - Command key                                          *
005600080522      * SCRNR  - Standard display                                     *
005700080522      * WNDWB  - Window border                                        *
005800080522      * WNDWR  - Standard window display                              *
005900080522      * MSGCTL - Message subfile control                              *
006000080522      *                                                               *
006100080522      *                                                               *
006200080522      * Called programs                                               *
006300080522      *                                                               *
006400080522      * ERMSG2 - Clear program message queue                        *
006500080522      * ERMSG1 - Send program message with message data             *
006700080522      *                                                               *
006800080522      *                                                               *
006900080522      *****************************************************************
007100080522      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007200080522      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007300080522      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007400080522      *
007500970108>>>> FXXX0101D  CF   E             WORKSTN USROPN
007600080304>>>> FFILXXXX   UF A E           K DISK
007800080522      *
007900080522      * Header screen mode desriptions:
008000950607     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
008100950607     D DSC             S             30    DIM(5) ALT(MOD)
008200080522      *
008300080522      *
008400080522      * General constants:
008500950525     D ERROR           C                   CONST('ERROR')
008600950607     D INUSE           C                   CONST('INUSE')
008700950525     D CHANGE          C                   CONST('CHANGE')
008800950525     D COPY            C                   CONST('COPY')
008900950525     D ADD             C                   CONST('ADD')
009000980716     D DELETE          C                   CONST('DELETE')
009100950525     D DISPLY          C                   CONST('DISPLY')
009300950620     D NEXT            C                   CONST('NEXT')
009400950525     D EXIT            C                   CONST('EXIT')
009500951026     D NO              C                   CONST('N')
009600950525     D YES             C                   CONST('Y')
009601080522      *
009602080325     D ConvertDate     s               d
009700080522      *
009800080324     D jld           E DS                  EXTNAME(dsjld)
009900080522      *
010000080522      * Incoming parms:
010100941228     D APPL            DS           512
010200960626     D  WISEC                  1      5
010300960626     D  WIIUSE                 6     15
010400960626     D  WIINLR                16     16
010500960626     D  WIACTN                17     26
010600970108>>>> D  WIXXX1                27     27
010700970108>>>> D  WIXXX2                28     28
010800080522      *
012100941228     D                SDS
012200960705     D  DSPGMN           *PROC
012300950608     D  DSUSER               254    263
012500080522      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012600080522      *M                 M  A  I  N  L  I  N  E                       M
012700080522      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012800080522      *
012900080522      *
013000950710     C                   EXSR      $INZSR
013100970114     C                   EXSR      $CLEAR
013200080522      *
013300080304     C                   CALL      'ERMSG2'
013301080324     C                   Parm                    DSPGMN
013400080522      *
013500080522      * Retrieve record:
013600080522      *
013700941228     C                   EXSR      $GETRC
013800080522      *
013900080522      * If record is in use, retrieve the user who has the lock,
014000080522      * close the display file, and return to the previous program:
014100080522      *
014200950621     C     WWRCDE        IFEQ      INUSE
014300950621     C                   CALL      'GEN8001C'
014400960626     C                   PARM                    WIIUSE
014500941228     C                   MOVEL     WWRCDE        WRRCDE
014600970108>>>> C                   CLOSE     XXX0101D
014700950621     C                   RETURN
014800950621     C                   END
014900080522      *
015000080522      * Retrieve field descriptions:
015100080522      *
015200970109     C                   EXSR      $DESCR
015300080522      *
015400080522      * Main loop:
015500080522      *
015600950728     C     WWRCDE        DOUEQ     EXIT
015700950728     C     WWRCDE        OREQ      NEXT
015800080522      *
015900080522      * Clear all fields, if requested:
016000080522      *
016100970114     C     WWCLR1        IFEQ      YES
016200970114     C                   EXSR      $CLEAR
016300970114     C                   END
016400080522      *
016500080522      * Retrieve record, if requested:
016600080522      *
016700950530     C     WWGETR        IFEQ      YES
016800950530     C                   EXSR      $GETRC
016900960626     C                   EXSR      $DESCR
017000950530     C                   END
017100080522      *
017200080522      * Lookup header screen mode description:
017300080522      *
017400950607     C                   Z-ADD     1             X
017500960626     C     WIACTN        LOOKUP    MOD(X)                                 99
017600950607     C     *IN99         IFEQ      *ON
017700941229     C                   MOVEL     DSC(X)        WRDSC1
017800950607     C                   END
017900080522      *
018000080522      * Display screen:
018100080522      *
018200950706     C                   WRITE     MSGCTL1
018300950614     C                   WRITE     SCRNK01
018400950614     C                   EXFMT     SCRNR01
018500080522      *
018600080522      * F12 = return to previous program:
018700080522      *
018800101230     C                   IF        *IN03 = *ON
018801101230     C                             OR *IN12 = *ON
018900950713     C                   MOVEL     NEXT          WWRCDE
019000950608     C                   ELSE
019100080522      *
019200950706     C     WWFRST        IFEQ      YES
019300950706     C                   MOVE      NO            WWFRST
019400950706     C                   END
019500080522      *
019600950605     C                   MOVE      NO            WWGETR
019700080522      *
019800080522      * Set off error indicators here:
019900080522      *
020000970108>>>> C                   MOVEA     '0'           *IN(40)
020100080522      *
020200950605     C                   CLEAR                   WWERR1
020300080522      *
020400080522      * Clear messages:
020500080522      *
020600080304     C                   CALL      'ERMSG2'
020601080324     C                   Parm                    DSPGMN
020700080522      *
020800080522>>>>  * Process command keys:
020900080522      *
021000950526     C                   SELECT
021100080522      *
021200080522      * F4 = Prompt:
021300080522      *
021400970114     C     *IN04         WHENEQ    *ON
021500970114     C                   EXSR      $PRMPT
021600970114     C                   EXSR      $DESCR
021700080522      *
021800950526     C                   OTHER
021900080522      *
022000080522      * Enter:
022100080522      *
022200960626     C     WIACTN        IFEQ      DISPLY
022300950620     C                   MOVEL     NEXT          WWRCDE
022400950615     C                   ELSE
022500080522      *
022600080522      * Error check, if in maintenance mode:
022700080522      *
022800960610     C     *IN36         IFEQ      *OFF
022900960610     C                   EXSR      $ERR01
023000960610     C                   END
023100080522      *
023200080522      * If no error, update record:
023300080522      *
023400960627     C     WWERR1        IFNE      ERROR
023500960627     C                   EXSR      $DESCR
023600960627     C                   EXSR      $ENTER
023700960627     C                   END
023800080522      *
023900950615     C                   END
024000080522      *
024100950526     C                   ENDSL
024200080522      *
024300950526     C                   END
024400080522      *
024500950526     C                   ENDDO
024600080522      *
024700080522      * Pass return code back to calling program through JLD field:
024800080522      *
024900941228     C                   MOVEL     WWRCDE        WRRCDE
025000080522      *
025100080522      * Close the display file:
025200080522      *
025300970108>>>> C                   CLOSE     XXX0101D
025400080522      *
025500080522      * Release record lock:
025600080522      *
025700960626     C     WIACTN        IFEQ      CHANGE
025800980716     C     WIACTN        OREQ      DELETE
025900080304>>>> C                   UNLOCK    FILXXXX
026000950712     C                   END
026100080522      *
026200950710     C                   RETURN
026400080522      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026500080522      *$              S  U  B  R  O  U  T  I  N  E  S                 $
026600080522      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026700080522      *
026800080522      **************
026900080522      **  $CLEAR  ** - Intialize Program/Database Fields
027000080522      **************
027100970114     C     $CLEAR        BEGSR
027200080522      *
027300080522      * Program stays open. All program/screen fields and indicators
027400080522      * must be re-initialized here each time this program is called.
027500080522      *
027600080522      *
027700080522      *
027800080522      * Initialize screen and data base fields:
027900080522      *
028000970114     C                   CLEAR                   SCRNR01
028100080304>>>> C                   CLEAR                   @FILXXXX
028200080522      *
028300080522      * Field definitions and initialization:
028400080522      *
028500970114     C     *LIKE         DEFINE    WRRCDE        WWRCDE
028700080522      *
028800080522      * Clear all *LIKE definitions:
028900080522      *
029000970114     C                   CLEAR                   WWRCDE
029200080522      *
029300080522      * Initialize program described fields:
029400080522      *
029500970114     C                   MOVE      *ZEROS        WWENTR            2 0
029600970114     C                   MOVE      *ZEROS        X                 1 0
029700970114     C                   MOVE      *BLANKS       WWCTAB            3
029800970114     C                   MOVE      *BLANKS       WWCKEY           27
029900970114     C                   MOVE      YES           WWFRST            1
030000970114     C                   MOVE      NO            WWCLR1            1
030100970114     C                   MOVE      *BLANKS       WWNEXT            1
030200970114     C                   MOVE      *BLANKS       WWUPD1            1
030300970114     C                   MOVE      *BLANKS       WWERR1           10
030400970114     C                   Z-ADD     *ZERO         WWCNT1            3 0
030500080522      *
030600080522      * Fill default screen values:
030700080522      *
030701080522      *
030900080522      *
031000080522      * Fill default screen values from JLD:
031100080522      *
031101080522      *
031900080522      *
032000080522      * Protect all input capable fields:
032100080522      *
032200970114     C     WIACTN        IFEQ      DISPLY
032300980716     C     WIACTN        OREQ      DELETE
032400970114     C                   MOVE      *ON           *IN36
032500970114     C                   ELSE
032600970114     C                   MOVE      *OFF          *IN36
032700970114     C                   END
032800080522      *
032900080522      * Protect key fields in change mode:
033000080522      *
033100970114     C     WIACTN        IFEQ      CHANGE
033200970114     C                   MOVE      *ON           *IN37
033300970114     C                   ELSE
033400970114     C                   MOVE      *OFF          *IN37
033500970114     C                   END
033600080522      *
033700970114     C                   MOVE      *OFF          *IN60
033800080522      *
033900970114     C                   ENDSR
034100080522      *
034200080522      **************
034300080522      **  $GETRC  ** - Retrieve Data Base Record
034400080522      **************
034500950526     C     $GETRC        BEGSR
034600080522      *
034700960626     C     WIACTN        IFNE      ADD
034800080522      *
034900080522      * Do not lock record if copy or display mode:
035000080522      *
035100960626     C     WIACTN        IFEQ      COPY
035200960626     C     WIACTN        OREQ      DISPLY
035300080304>>>> C     XXXK01        CHAIN(N)  FILXXXX                            99
035400941228     C                   ELSE
035500080304>>>> C     XXXK01        CHAIN     FILXXXX                            9960
035600941228     C                   END
035700080522      *
035800950620     C     *IN60         IFEQ      *ON
035900950607     C                   MOVEL     INUSE         WWRCDE
036000950620     C                   ELSE
036100950620     C     *IN99         IFEQ      *OFF
036200950530     C                   EXSR      $MOVIN
036300950620     C                   END
036400950620     C                   END
036500080522      *
036600950530     C                   ELSE
036700080522      *
036800950530     C                   EXSR      $MOVIN
036900080522      *
037000941228     C                   END
037100080522      *
037200950526     C                   ENDSR
037400080522      *
037500080522      **************
037600080522      **  $MOVIN  ** - Move Data Base Fields to Screen Fields
037700080522      **************
037800950526     C     $MOVIN        BEGSR
037900080522      *
038000080522      * Add/copy mode default values:
038100080522      *
038200970108>>>> C     WIACTN        IFEQ      ADD
038300960626     C     WIACTN        OREQ      COPY
038301080513     C     WIACTN        IFEQ      ADD
038302080513      * Move key values into key fields:
038304080513>>>> C                   MOVEL     WIXXX1        WR0001
038305080513     C                   END
038400960626     C                   END
038500080522      *
038600960610     C                   SELECT
038700080522      *
038800960626     C     WIACTN        WHENEQ    COPY
038900960626     C     WIACTN        OREQ      CHANGE
039000960626     C     WIACTN        OREQ      DISPLY
039100980716     C     WIACTN        OREQ      DELETE
039200080522      *
039300080522      * Move DB fields to screen fields here:
039400080522      *
039500970108>>>> C                   MOVEL     DB0001        WR0001
039600080522      *
039700080522      * Display last update user/date:
039800080522      *
039900970109     C     WIACTN        IFNE      COPY
040000080522      *
040100970109>>>> C                   MOVEL     DBLUSR        WRLUSR
040101081010>>>> C                   MOVEL     DBLPGM        WRLPGM
040200080522      *
040201080324>>>> C                   If        DBLDTE <> 0
040202080324>>>> C                   Move      DBLDTE        ConvertDate
040203080304     C     *mdy          Move      ConvertDate   WRLDTE
040204080324     C                   Else
040205080324     C                   Clear                   wrldte
040206080324     C                   Endif
040207080324>>>> C                   Move      DBLTIM        wrltim
041400080522      *
041500980709     C                   END
041600080522      *
041700960610     C                   ENDSL
041800080522      *
041900950525     C                   ENDSR
042100080522      *
042200080522      **************
042300080522>>>>  **  $DESCR  ** - Retrieve field descriptions
042400080522      **************
042500970109     C     $DESCR        BEGSR
042600080522      *
042700970109     C                   ENDSR
042900080522      *
043000080522      **************
043100080522      **  $PRMPT  ** - Process Promptable Fields
043200080522      **************
043300970114     C     $PRMPT        BEGSR
043400080522      *
043500080522      *****************************************************************
043600080522      *  Field HDCSRF (defined in DDS) contains the field name which
043700080522      *  contains the cursor. If valid, a prompting program may be
043800080522      *  called to select a record from a list of valid values for
043900080522      *  the prompted field. The value selected should then be placed
044000080522      *  in the field which was prompted.
044100080522      *
044200080522      * eg; HDCSRF    WHEQ 'WRXXX1'
044300080522      *      Cursor resides in field WRXXX1
044400080522      *
044500080522      *     CALL 'GEN0109R'
044600080522      *      Codes file prompting program.
044700080522      *
044800080522      *     PARM '653'     WWCTAB
044900080522      *      Outgoing parm.
045000080522      *
045100080522      *     PARM *BLANKS   WWCKEY
045200080522      *      Return parm.
045300080522      *
045400080522      *     MOVELWWCKEY    WRXXX1
045500080522      *      Move return parm into prompted field.
045600080522      *
045700080522      *****************************************************************
045800080522      *
045900970114     C                   SELECT
046000080522      *
046100970114>>>> C     HDCSRF        WHENEQ    'WRXXX1'
046200970114     C                   CALL      'GEN0109R'
046300970114     C                   PARM      '653'         WWCTAB
046400970114     C                   PARM      *BLANKS       WWCKEY
046500970707      *
046600970707     C     WWCKEY        IFNE      *BLANKS
046700970114     C                   MOVEL     WWCKEY        WRXXX1
046800970707     C                   ENDIF
046900080522      *
047000970114>>>> C     HDCSRF        WHENEQ    'WRXXX2'
047100970114     C                   CALL      'GEN0109R'
047200970114     C                   PARM      '654'         WWCTAB
047300970114     C                   PARM      *BLANKS       WWCKEY
047400970707      *
047500970707     C     WWCKEY        IFNE      *BLANKS
047600970114     C                   MOVEL     WWCKEY        WRXXX2
047700970707     C                   ENDIF
047800080522      *
047900080522      * Non propmtable area:
048000080522      *
048100970114     C                   OTHER
048200080522      *
048300080324     C                   MOVEL     'SHL0004'     WWMSGI
048500080304     C                   CALL      'ERMSG1'      MSGP01
048600080522      *
048700970114     C                   ENDSL
048800080522      *
048900970114     C                   ENDSR
049100080522      *
049200080522      **************
049300091002>>>>  **  $ERR01  ** - Validity Checking
049400080522      **************
049500970109     C     $ERR01        BEGSR
049600080522      *
049700970109     C                   CLEAR                   WWERR1
049800080522      *
049900080522      *****************************************************************
050000080522      * All error conditions must have the following lines of code:
050100080522      *
050200080522      *   MOVE *ON       *INXX
050300080522      *     Where *INXX = field error indicator in DDS.
050400080522      *
050500080522      *   MOVELERROR     WWERR1
050600080522      *     Program error flag.
050700080522      *
050800080522      *   MOVEL'XXX0001' WWMSGI
050900080522      *     Where XXX0001 = error message id to be displayed.
051000080522      *
051100080522      *   MOVELXXXXXX    WWMSGF
051200080522      *     Where XXXXXX = name of the message file which contains
051300080522      *     the message id contained in field WWMSGI.
051400080522      *
051500080522      *   CALL 'ERMSG1'MSGP01
051600080522      *     Message handling program.
051700080522      *****************************************************************
051800080522      *
053000080522      *
053100080522      * Record already exists on file:
053200080522      *
053300970109     C     WIACTN        IFEQ      ADD
053400970109     C     WIACTN        OREQ      COPY
053500101230>>>> C     XXXK02        SETLL     FILXXXX                                99
053600970109     C     *IN99         IFEQ      *ON
053700970109     C                   MOVEL     ERROR         WWERR1
053800080324     C                   MOVEL     'SHL0005'     WWMSGI
054000080304     C                   CALL      'ERMSG1'      MSGP01
054100970109     C                   END
054200970109     C                   END
054300080522      *
054400970109     C     WWERR1        IFEQ      ERROR
054500970109     C                   CLEAR                   WWENTR
054600970109     C                   END
054700080522      *
054800970109     C                   ENDSR
055000080522      *
055100080522      **************
055200080522      **  $ENTER  ** - Enter Key Pressed
055300080522      **************
055400941228     C     $ENTER        BEGSR
055500080522      *
055600090930     C*****              ADD       1             WWENTR
055700080522      *
055800080522      * Update only if screen has been changed:
055900080522      *
056000960705     C     *IN38         IFEQ      *ON
056100960705     C                   MOVE      YES           WWUPD1
056200960705     C                   END
056300080522      *
056400080522      * Send verification messages:
056500080522      *
056600970109     C     WWENTR        IFEQ      1
056700080522      *
056800970109     C                   SELECT
056900080522      *
057000970109     C     WIACTN        WHENEQ    ADD
057100970109     C     WIACTN        OREQ      COPY
057200080324     C                   MOVEL     'SHL0001'     WWMSGI
057400080304     C                   CALL      'ERMSG1'      MSGP01
057500080522      *
057600970109     C     WIACTN        WHENEQ    CHANGE
057700080324     C                   MOVEL     'SHL0002'     WWMSGI
057900080304     C                   CALL      'ERMSG1'      MSGP01
058000080522      *
058100980716     C     WIACTN        WHENEQ    DELETE
058200080324     C                   MOVEL     'SHL0003'     WWMSGI
058400080304     C                   CALL      'ERMSG1'      MSGP01
058500080522      *
058600970109     C                   ENDSL
058700080522      *
058800941228     C                   ELSE
058900080522      *
059000080522      * Update database according to current mode:
059100080522      *
059200970109     C                   CLEAR                   WWENTR
059300970109     C                   CLEAR                   WWCNT1
059400080522      *
059500970114     C                   MOVEL     NEXT          WWRCDE
059600080522      *
059700970114     C                   SELECT
059800080522      *
059900970109     C     WIACTN        WHENEQ    CHANGE
060000970109     C     WWUPD1        ANDEQ     YES
060100970109     C                   EXSR      $MOVOU
060200080304>>>> C                   UPDATE    @FILXXXX
060300080522      *
060400970109     C     WIACTN        WHENEQ    ADD
060500970109     C     WIACTN        OREQ      COPY
060600970109     C                   EXSR      $MOVOU
060700080304>>>> C                   WRITE     @FILXXXX
060800080522      *
060900980716     C     WIACTN        WHENEQ    DELETE
061000080304>>>> C                   DELETE    FILXXXX
061100080522      *
061200970109     C                   ENDSL
061300080522      *
061400080522      * Pass 'position to' fields back to calling program:
061500080522      *
061600970114>>>> C                   MOVE      WRXXX1        WIXXX1
061700970114>>>> C                   MOVE      WRXXX2        WIXXX2
061800080522      *
061900080522      * If add mode, initialize all fields and redisplay the screen:
062000080522      *
062100970114     C     WIACTN        IFEQ      ADD
062200970114     C                   CLEAR                   WWRCDE
062300970114     C                   MOVE      YES           WWCLR1
062400970114     C                   MOVE      YES           WWGETR
062500970114     C                   END
062600080522      *
062700970109     C                   MOVE      NO            WWUPD1
062800080522      *
062900941228     C                   END
063000080522      *
063100941228     C                   ENDSR
063300080522      *
063400080522      **************
063500080522      **  $MOVOU  ** - Move Screen Fields to Data Base Fields
063600080522      **************
063700950526     C     $MOVOU        BEGSR
063800080522      *
063900080522      * Move screen fields to DB fields:
064000080522      *
064100970108>>>> C                   MOVEL     WR0001        DB0001
064300080522      *
064400080522      * Retrieve current date in YYYYMMDD for last update date:
064500080522      *
065200080522      *
065401091001>>>> C                   Eval      DBLDTE = %int(%char(%date:*cymd0))
065500980710>>>> C                   TIME                    DBLTIM
065600080325>>>> C                   MOVEL     DSPGMN        DBLPGM
065700980710>>>> C                   MOVEL     DSUSER        DBLUSR
065900080522      *
066000950526     C                   ENDSR
066200080522      *
066300080522      **************
066400080522      **  $INZSR  ** - Program Initialization
066500080522      **************
066600950710     C     $INZSR        BEGSR
066700080522      *
066800080522      * Parm lists:
066900080522      *
067000950525     C     *ENTRY        PLIST
067100080324     C                   PARM                    JLD
067200941228     C                   PARM                    APPL
067300080522      *
067400080522      * Message file:
067500080522      *
067600941228     C     MSGP01        PLIST
067700941228     C                   PARM                    WWMSGI            7
068600080522      *
068700080522      * Key lists:
068800080522      *
068900950530     C     CODK01        KLIST
069000950530     C                   KFLD                    WWCTAB
069100950530     C                   KFLD                    WWCKEY
069200080522      *
069300080522      *****************************************************************
069400080522      * Key lists. XXXK01 is used for retieving the record to be
069500080522      * maintained based on the record key passed to the program.
069600080522      * XXXK02 is used to determine if a record with a duplicate
069700080522      * key already exists on file (ADD and COPY modes only) based
069800080522      * on the current screen field values entered by the user.
069900080522      *
070000080522      *   eg; File maintained - ITEMMSTR (Item/Type Code).
070100080522      *
070200080522      *
070300080522      *     XXXK01    KLIST
070400080522      *               KFLD           WIITM   <-- incoming parm
070500080522      *               KFLD           WIICDE  <-- incoming parm
070700080522      *
070800080522      *     XXXK02    KLIST
070900080522      *               KFLD           WRITM   <-- screen field
071000080522      *               KFLD           WRICDE  <-- screen field
071200080522      *
071300080522      *****************************************************************
071400080522      *
071500080522      *
071600970108>>>> C     XXXK01        KLIST
071800970120>>>> C                   KFLD                    WIXXX1
071900080522      *
072000970120>>>> C     XXXK02        KLIST
072200970120>>>> C                   KFLD                    WRXXX1
072300080522      *
072400080522      * Close files if requested by calling program:
072500080522      *
072600960626     C     WIINLR        IFEQ      YES
072700950710     C                   MOVE      *ON           *INLR
072800950710     C                   RETURN
072900950710     C                   END
073000080522      *
073100080522      * Open display file:
073200080522      *
073300970108>>>> C                   OPEN      XXX0101D
073400080522      *
073500970114     C                   MOVE      NO            WWGETR            1
073600080522      *
073700970114     C                   ENDSR
073800080522>>>>  *
073900980716**
074000980716ADD         Create a
074100980716COPY         Copy a
074200980716CHANGE      Change a
074300980716DELETE      Delete a
074400980716DISPLY      Display a
