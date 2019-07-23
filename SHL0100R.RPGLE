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
000012080522      ********************************************************************
000013080522      *                   Modification Log
000014080522      *
000015080522      *  Initials  Date      Description
000016080522      *-------------------------------------------------------------------
000017080522      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
000018080522      *
000019080522      *
000020080522      *
000021080522      ********************************************************************
000022080522      *                   Indicator Usage
000023080522      *
000024080522      *   Ind.   Description
000025080522      *-------------------------------------------------------------------
000026080522      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
000027080522      *
000028080522      *
000029080522      ********************************************************************
002600080522      *****************************************************************
002700080522      * Indicator Usage:                                              *
002800080522      * Ind      Use                                                  *
002900080522      * 01-24    Function keys                                        *
003000080522      * 25       Rollup                                               *
003100080522      * 30-34    Subfile keywords                                     *
003200080522      * 36       Position to                                          *
003300080522      * 37       Error indicator                                      *
003600080522      * 40       Search field change                                  *
003700080522      * 41-42    Search field display                                 *
003800080522      * 61       Subfile option error                                 *
003900080522      * 80-89    Reserved for Security                                *
004000080522      * 90-99    Hit/Miss                                             *
004100080522      *****************************************************************
004300080522      *****************************************************************
004400080522      * Field Definitions                                             *
004500080522      *                                                               *
004600080522      * Prefix                                                        *
004700080522      * WW     - Program described work fields                        *
004800080522      * WI     - APPL *ENTRY input parameters                         *
004900080522      * WS     - Subfile fields                                       *
005000080522      * WC     - Subfile control fields                               *
005100080522      * HD     - Hidden fields                                        *
005200080522      * Ax     - APPx output parameters for called programs           *
005300080522      * DS     - Data structure fields                                *
005400080522      *                                                               *
005500080522      *                                                               *
005600080522      * Display Record Format Definitions                             *
005700080522      *                                                               *
005800080522      * Prefix                                                        *
005900080522      * SCRNS  - Subfile                                              *
006000080522      * SCRNC  - Subfile control                                      *
006100080522      * SCRNK  - Command key                                          *
006200080522      * SCRNR  - Standard display                                     *
006300080522      * WNDWB  - Window border                                        *
006400080522      * WNDWR  - Standard window display                              *
006500080522      * MSGCTL - Message subfile control                              *
006600080522      *                                                               *
006700080522      *                                                               *
006800080522      * Called programs                                               *
006900080522      *                                                               *
007000080522      * ERMSG2 - Clear program message queue                        *
007100080522      * ERMSG1 - Send program message with message data             *
007200080522      * XXX0101R - Maintenance program                                *
007300080522      *                                                               *
007400080522      *                                                               *
007500080522      *****************************************************************
007700080522      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007800080522      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007900080522      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
008000080522      *
008100970108>>>> FXXX0100D  CF   E             WORKSTN
008200941228     F                                     SFILE(SCRNS01:RRN1)
008300950522     F                                     INFDS(INFDS)
008400970108>>>> FWHSXXXX   IF   E           K DISK
008600080522      *
008700080522      * Option authorization:
008800100614     D OPT             S              1    DIM(12) CTDATA PERRCD(1)
008900081020     D INMD            S             12    DIM(12) ALT(OPT)
009000080522      *
009100080522      *
009200080522      *
009300080522      * Max number of 'position to':
009400080325>>>> D WW#POS          C                   CONST(02)
009500080522      *
009600080522      * Number of records to fill S/F page:
009700970108     D WWPGSZ          C                   CONST(10)
009800080522      *
010200080522      * General constants:
010300950526     D LOAD            C                   CONST('LOAD')
010400950526     D ERROR           C                   CONST('ERROR')
010500950607     D INUSE           C                   CONST('INUSE')
010600960610     D SELECT          C                   CONST('SELECT')
010700950530     D ADD             C                   CONST('ADD')
010800950530     D CHANGE          C                   CONST('CHANGE')
010900950525     D COPY            C                   CONST('COPY')
011000980716     D DELETE          C                   CONST('DELETE')
011100950525     D DISPLY          C                   CONST('DISPLY')
011101080323     D WRKWTH          C                   CONST('WRKWTH')
011300080324>>>> D PGMNAM          C                   CONST('SHL0100R  ')
011400950608     D NO              C                   CONST('N')
011500950523     D YES             C                   CONST('Y')
011600080522      *
011700080324     D jld           E DS                  EXTNAME(dsjld)
011800080522      *
011900080522      * Incoming parms:
012000970225     D APPL            DS           512
012100970225     D  WISEC                  1      5
012200970225     D  WISEL                  6      6
012300970225     D  WIVIEW                 7      8  0
012400970225>>>> D  WIXXX1                 9      9
012500970225>>>> D  WIXXX2                10     10
012600080522      *
012700080522      * Calling parms for XXX0101R:
012800950608     D APP2            DS           512
012900960626     D  A2SEC                  1      5
013000960626     D  A2IUSE                 6     15
013100960626     D  A2INLR                16     16
013200960626     D  A2ACTN                17     26
013300970108>>>> D  A2XXX1                27     27
013400970108>>>> D  A2XXX2                28     28
013401080522      *
014600080522      * Parm to hold message data:
014700950906     D DSMDTA          DS           500
014800080522      *
014900080522      * Split option indicator and action code:
015000950525     D DSSPLT          DS            12
015100950525     D  ZZ                     1      2  0
015200950525     D  DSACTN                 3     12
015300080522      *
015400950619     D INFDS           DS
015500950619     D  SFLLOC               378    379B 0
015600080522      *
015700941228     D                SDS
015800960705     D  DSPGMN           *PROC
015900950616     D  DSUSER               254    263
016100080522      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
016200080522      *M                 M  A  I  N  L  I  N  E                       M
016300080522      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
016400080522      *
016500080522      *
016600080522      * Main loop:
016700080522      *
016800941228     C     *IN03         DOUEQ     *ON
016900080522      *
017000080522      * Reload subfile, if requested:
017100080522      *
017200951020     C     WWLOAD        IFEQ      YES
017300951020     C                   EXSR      $INSFL
017400951020     C                   MOVE      NO            WWLOAD
017500951020     C                   END
017600080522      *
017700080522      * Display screen:
017800080522      *
017900950802     C                   WRITE     MSGCTL1
018000950802     C                   WRITE     SCRNK01
018100080522      *
018200950802     C     *IN32         IFEQ      *OFF
018300950802     C                   WRITE     SCRNR01
018400950802     C                   END
018500080522      *
018600941228     C                   EXFMT     SCRNC01
018700000810     C                   MOVE      THEFLD        *IN69
018800080522      *
018900950706     C     WWFRST        IFEQ      YES
019000950706     C                   MOVE      NO            WWFRST
019100950706     C                   END
019200080522      *
019300950523     C                   MOVE      SFLLOC        HDSFLP
019400080522      *
019500080522      * Clear messages:
019600080522      *
019700080324     C                   CALL      'ERMSG2'
019701080324     C                   Parm                    DSPGMN
019800080522      *
019900080522      * Set off all error indicators here:
020000080522      *
020100950523     C                   MOVE      *OFF          *IN36
020200970108     C                   MOVE      *OFF          *IN38
020201080513     C                   MOVE      *OFF          *IN71
020300080522      *
020400941228     C     *IN03         IFEQ      *OFF
020500080522      *
020600080522>>>>  * Process command keys:
020700080522      *
020800950522     C                   SELECT
020900080522      *
022800080522      *
022900080522      * F4 = Prompt:
023000080522      *
023100960626     C     *IN04         WHENEQ    *ON
023200960626     C                   EXSR      $PRMPT
023300960626     C                   EXSR      $INSFL
023400080522      *
023500080522      * F10 = Position to:
023600080522      *
023700950526     C     *IN10         WHENEQ    *ON
023800950526     C                   EXSR      $POSTO
023900080522      *
024000080522      * F5 or 'position to' field value change (*IN40) - reload S/F:
024100080522      *
024200941228     C     *IN05         WHENEQ    *ON
024300941228     C     *IN40         OREQ      *ON
024400941228     C                   EXSR      $INSFL
024500080522      *
024600080522      * Rollup (if records exist in S/F - *IN32):
024700080522      *
024800950605     C     *IN25         WHENEQ    *ON
024900950605     C     *IN32         ANDEQ     *ON
025000950605     C                   EXSR      $LDSFL
025100080522      *
025200080522      * F6 = Add a record:
025300080522      *
025400100725     C                   WHEN      *in06 = *on
025500080522     c                   EXSR      $ADDRC
025503080522      *
025504080522      * F12= Cancel
025505080522      *
025506080325     C     *IN12         WHENEQ    *ON
025507080325     C                   Eval      *in03=*on
025600080522      *
025700950522     C                   OTHER
025800080522      *
025900080522      * Enter:
026000080522      *
026100941229     C                   EXSR      $READC
026200080522      *
026300950522     C                   ENDSL
026400080522      *
026500941228     C                   END
026600080522      *
026700941228     C                   ENDDO
026800080522      *
026900080522      * Close called programs:
027000080522      *
027100960626     C                   MOVE      YES           A2INLR
027200080522      *
027300080522      * End the maintenance program:
027400080522      *
027500970108>>>> C                   CALL      'XXX0101R'
027600080324     C                   PARM                    jld
027700950710     C                   PARM                    APP2
027800080522      *
027900950522     C                   MOVE      *ON           *INLR
028000080522      *
028200080522      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028300080522      *$              S  U  B  R  O  U  T  I  N  E  S                 $
028400080522      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028500080522      *
028600080522      **************
028700080522      **  $INSFL  ** - Initialize Subfile
028800080522      **************
028900950522     C     $INSFL        BEGSR
029000080522      *
029100950522     C                   CLEAR                   RRN1
029200950523     C                   Z-ADD     1             HDSFLP
029300941228     C                   MOVE      NO            WWNFND
029400080522      *
029500080522      * Clear subfile:
029600080522      *
029700950525     C     *IN32         IFEQ      *ON
029800950802     C                   MOVE      *OFF          *IN32
029900950522     C                   MOVE      *ON           *IN30
030000950522     C                   WRITE     SCRNC01
030100950522     C                   MOVE      *OFF          *IN30
030200950525     C                   END
030300080522      *
030400080522      * Check for subfile control errors:
030500080522      *
030600950605     C     WWFRST        CASEQ     NO            $ERR01
030700950605     C                   ENDCS
030800080522      *
030900080522      * Position file:
031000080522      *
031100080522      ****************************************************************
031200080522      * WHSXXX - Logical file based on current 'position to' view.
031300080522      *  eg; physical file is INVMF and current 'position to' is
031400080522      *      by style number, WHSXXX = INVMF (key = style #).
031500080522      *
031600080522      *
031700080522      * XXXK01 - Key list based on current 'position to' fields.
031800080522      *  eg; if 'position to' field is item number:
031900080522      *          XXXK01 = INVK01  KLIST
032100080522      *                           KFLD      WCITM#
032200080522      ****************************************************************
032300080522      *
032400970113     C                   SELECT
032500080522      *
032600950530     C     WWCPOS        WHENEQ    1
032700970108>>>> C     XXXK01        SETLL     WHSXXXX                                99
032800950523     C     *IN99         IFEQ      *OFF
032900941228     C                   MOVE      YES           WWNFND
033000950523     C                   END
033100080522      *
033200970108     C     WWCPOS        WHENEQ    2
033300970108>>>> C     XXXK01        SETLL     WHSXXXX                                99
033400970108     C     *IN99         IFEQ      *OFF
033500970108     C                   MOVE      YES           WWNFND
033600970108     C                   END
033700080522      *
033800950530     C                   ENDSL
033900080522      *
034000080522      * Load subfile:
034100080522      *
034200950522     C                   EXSR      $LDSFL
034300080522      *
034400080522      * Send message if search criteria is not found:
034500080522      *
034600941228     C     WWNFND        IFEQ      YES
034700951020     C     *IN40         IFEQ      *ON
034800951020     C     *IN04         OREQ      *ON
034900080324     C                   MOVEL     'SHL0006'     WWMSGI
035100080304     C                   CALL      'ERMSG1'      MSGP01
035200950523     C                   END
035300951020     C                   END
035400080522      *
035500950522     C                   ENDSR
035700080522      *
035800080522      **************
035900080522      **  $ERR01  ** - Control Screen Validity Checking
036000080522      **************
036100970109     C     $ERR01        BEGSR
036200080522      *
036300970109     C                   CLEAR                   WWERR1
036400080522      *
036500080522      *****************************************************************
036600080522      * All error conditions must have the following lines of code:
036700080522      *
036800080522      *   MOVE *ON       *INXX
036900080522      *     Where *INXX = field error indicator in DDS.
037000080522      *
037100080522      *   MOVELERROR     WWERR1
037200080522      *     Program error flag.
037300080522      *
037400080522      *   MOVEL'XXX0001' WWMSGI
037500080522      *     Where XXX0001 = error message id to be displayed.
037600080522      *
037700080522      *   MOVELXXXXXX    WWMSGF
037800080522      *     Where XXXXXX = name of the message file which contains
037900080522      *     the message id contained in field WWMSGI.
038000080522      *
038100080522      *   CALL 'ERMSG1'  MSGP01
038200080522      *     Message handling program.
038300080522      *****************************************************************
038400080522      *
038500080522      * Field 1:
038600970109>>>> C     *IN41         IFEQ      *ON
038700970109     C     WCXXX1        ANDNE     *ZERO
038800970109     C     XXXK01        SETLL     WHSXXXX                                99
038900970109     C     *IN99         IFEQ      *OFF
039000970109     C                   MOVE      *ON           *IN36
039100970109     C                   MOVEL     ERROR         WWERR1
039200091001     C                   MOVEL     'SHL0006'     WWMSGI
039400080304     C                   CALL      'ERMSG1'      MSGP01
039500970109     C                   END
039600970109     C                   END
039700080522      *
039800970109>>>> C     *IN42         IFEQ      *ON
039900970109     C     WCXXX1        ANDNE     *ZERO
040000970109     C     XXXK01        SETLL     WHSXXXX                                99
040100970109     C     *IN99         IFEQ      *OFF
040200970109     C                   MOVE      *ON           *IN36
040300970109     C                   MOVEL     ERROR         WWERR1
040400091001     C                   MOVEL     'SHL0006'     WWMSGI
040600080304     C                   CALL      'ERMSG1'      MSGP01
040700970109     C                   END
040800970109     C                   END
040900080522      *
041000970109     C                   ENDSR
041200080522      *
041300080522      **************
041400080522      **  $LDSFL  ** - Load Subfile
041500080522      **************
041600950522     C     $LDSFL        BEGSR
041700080522      *
041800950522     C                   CLEAR                   WWCNT1
041900080522      *
042000950727     C                   MOVE      *OFF          *IN34
042100080522      *
042200080522      * Load one page at a time:
042300080522      *
042400950522     C     WWCNT1        DOWLT     WWPGSZ
042500950522     C     *IN34         ANDEQ     *OFF
042600080522      *****************************************************************
044300080522      *
044400950727     C                   SELECT
044500080522      *
044600080522      * Read from file, based on current 'position to' view:
044700080522      *
044800950727     C     WWCPOS        WHENEQ    1
044900080303>>>> C                   READ      WHSXXXX                                34
045000080522      *
045100970108     C     WWCPOS        WHENEQ    2
045200080303>>>> C                   READ      WHSXXXX                                34
045300080522      *
045400950727     C                   ENDSL
045500080522      *
045600950727     C     *IN34         IFEQ      *OFF
045700080522      *
045800950607     C                   CLEAR                   WSOPT#
045900950607     C                   MOVE      *OFF          *IN61
046000080522      *
046100080522      * Load subfile fields here:
046200080522      *
046300970108>>>> C                   CLEAR                   WSXXX1
046400080522      *
046500970108>>>> C                   MOVE      DBXXX1        WSXXX1
046600080522      *
046700950522     C                   ADD       1             RRN1
046800950522     C                   ADD       1             WWCNT1
046900080522      *
047000950523     C     WWCNT1        IFEQ      1
047100950523     C                   Z-ADD     RRN1          HDSFLP
047200950523     C                   END
047300080522      *
047400950522     C                   WRITE     SCRNS01
047500080522      *
047600950727     C                   END
047700080522      *
047800950522     C                   ENDDO
047900080522      *
048000950522     C     RRN1          IFGT      *ZERO
048100950522     C                   MOVE      *ON           *IN32
048200950522     C                   END
048300080522      *
048400950522     C                   MOVE      *OFF          *IN25
048500080522      *
048600950522     C                   ENDSR
051200080522      *
051300080522      **************
051400080522      **  $PRMPT  ** - Process Promptable Fields
051500080522      **************
051600970109     C     $PRMPT        BEGSR
051700080522      *
051800080522      *****************************************************************
051900080522      *  Field HDCSRF (defined in DDS) contains the field name which
052000080522      *  contains the cursor. If valid, a prompting program may be
052100080522      *  called to select a record from a list of valid values for
052200080522      *  the prompted field. The value selected should then be placed
052300080522      *  in the field which was prompted.
052400080522      *
052500080522      * eg; HDCSRF    WHEQ 'WCXXX1'
052600080522      *      Cursor resides in field WCXXX1
052700080522      *
052800080522      *     CALL 'GEN0109R'
052900080522      *      Codes file prompting program.
053000080522      *
053100080522      *     PARM '653'     WWCTAB
053200080522      *      Outgoing parm.
053300080522      *
053400080522      *     PARM *BLANKS   WWCKEY
053500080522      *      Return parm.
053600080522      *
053700080522      *     MOVELWWCKEY    WCXXX1
053800080522      *      Move return parm into prompted field.
053900080522      *
054000080522      *****************************************************************
054100080522      *
054200970113     C                   SELECT
054300080522      *
054400970109>>>> C     HDCSRF        WHENEQ    'WCXXX1'
054500970113     C                   CALL      'GEN0109R'
054600970113     C                   PARM      '653'         WWCTAB
054700970113     C                   PARM      *BLANKS       WWCKEY
054800970113     C                   MOVEL     WWCKEY        WCXXX1
054900080522      *
055000970109>>>> C     HDCSRF        WHENEQ    'WCXXX2'
055100970113     C                   CALL      'GEN0109R'
055200970114     C                   PARM      '654'         WWCTAB
055300970113     C                   PARM      *BLANKS       WWCKEY
055400970113     C                   MOVEL     WWCKEY        WCXXX2
055500080522      *
055600080522      * Non propmtable area:
055700080522      *
055800970109     C                   OTHER
055900080522      *
056000080324     C                   MOVEL     'SHL0004'     WWMSGI
056200080304     C                   CALL      'ERMSG1'      MSGP01
056300080522      *
056400970109     C                   ENDSL
056500080522      *
056600970109     C                   ENDSR
056800080522      *
056900080522      **************
057000080522      **  $POSTO  ** - Position To
057100080522      **************
057200941228     C     $POSTO        BEGSR
057300080522      *
057400080522      * Clear all 'position to' fields here:
057500080522      *
057600970108>>>> C                   CLEAR                   WCXXX1
057700970108>>>> C                   CLEAR                   WCXXX2
057800080522      *
057900950607     C                   CLEAR                   RRN1
058000950607     C                   CLEAR                   HDSFLP
058100080522      *
058200080522      * Clear subfile:
058300080522      *
058400950526     C     *IN32         IFEQ      *ON
058500950802     C                   MOVE      *OFF          *IN32
058600950526     C                   MOVE      *ON           *IN30
058700950526     C                   WRITE     SCRNC01
058800950526     C                   MOVE      *OFF          *IN30
058900950526     C                   END
059000080522      *
059100080522      * Position cursor:
059200080522      *
059300950526     C                   MOVE      *ON           *IN36
059400080522      *
059500080522      * Toggle to next 'position to' field:
059600080522      *
059700941228     C     WWCPOS        ADD       1             WWCPOS
059800080522      *
059900941228     C     WWCPOS        IFGT      WW#POS
060000950525     C                   Z-ADD     1             WWCPOS
060100941228     C                   END
060200080522      *
060300080522      *****************************************************************
060400080522      * When a 'position to' view is changed, the new display
060500080522      * indicator (from DDS) must be set on and all other 'position to'
060600080522      * display indicators must be turned off.
060700080522      *
060800080522      *  eg; 'position to' #1 by agency (display indicator *IN41)
060900080522      *      'position to' #2 by agency/chain (display indicator *IN42)
061000080522      *
061100080522      *  If user toggles to 'position to' by agency/chain, indicator
061200080522      *  *IN41 must be turned off and *IN42 turned on.
061300080522      *
061400080522      *      MOVEA'01'      *IN,41
061500080522      *****************************************************************
061600080522      *
061700080522      * Set 'position to' field display indicator:
061800080522      *
061900950530     C                   SELECT
062000080522      *
062100970108>>>> C     WWCPOS        WHENEQ    1
062200970108     C                   MOVEA     '10'          *IN(41)
062300080522      *
062400970108>>>> C     WWCPOS        WHENEQ    2
062500970108     C                   MOVEA     '01'          *IN(41)
062600080522      *
062700950530     C                   ENDSL
062800080522      *
062900941228     C                   ENDSR
063100080522      *
063200080522      **************
063300080522      **  $ADDRC  ** - Add a record
063400080522      **************
063500970109     C     $ADDRC        BEGSR
063600080522      *
063700080522      *****************************************************************
063800080522      * Parms required to be passed to the maintenance program:
063900080522      *   1. WISEC = program level security.
064000080522      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
064300080522      *
064400080522      *****************************************************************
064500080522      *
064600970109     C                   MOVE      YES           WWLOAD
064700080522      *
064800970109     C                   CLEAR                   APP2
064900970109     C                   MOVEL     WISEC         A2SEC
065000970109     C                   MOVEL     ADD           A2ACTN
065001080522      *
065002080522      * Move key fields to maintenance program for record access:
065003080522      *
065004080513>>>> C                   MOVE      WCKEYA        A2XXX1
065200080522      *
065300080522      * Call maintenance program:
065400080522      *
065500970109>>>> C                   CALL      'XXX0101R'
065600080324     C                   PARM                    jld
065700970109     C                   PARM                    APP2
065800080522      *
065900080522      *****************************************************************
066000080522      * When returning from the maintenance program, this program will
066100080522      * automatically position the subfile list to the last record
066200080522      * added to the file. To do this, the maintenance program must
066300080522      * return all 'position to' field values to this program.
066400080522      *
066600080522      *   eg; 'position to' #1 = Item Number
066700080522      *       'position to' #2 = Item Type Code
066701080522      *
066800080522      *
066900080522      *  Using this example, when a record is added to the file, the
067000080522      *  maintenance program will return the values of all of the above
067100080522      *  'position to' fields (Item Number, Item Type Code).
067200080522      *  The subfile list will then automatically be positioned based
067300080522      *  on the current 'position to' view.
067400080522      *
067500080522      *****************************************************************
067600080522      *
067700080522      * Move key fields from maint pgm to 'position to' fields:
067800080522      *
067900970109>>>> C                   MOVE      A2XXX1        WCXXX1
068000970109>>>> C                   MOVE      A2XXX2        WCXXX2
068100080522      *
068200970109     C                   MOVEL     WRRCDE        WWRCDE
068300080522      *
068600970109     C                   ENDSR
068800080522      *
068900080522      **************
069000080522      **  $READC  ** - Process Subfile Requests
069100080522      **************
069200950607     C     $READC        BEGSR
069300080522      *
069400950525     C                   CLEAR                   WWERR2
069500941228     C                   CLEAR                   WWRCDE
069600941228     C                   CLEAR                   WWRRN#
069700080522      *
069800080522      * Save current RRN:
069900080522      *
070000941228     C                   Z-ADD     RRN1          WWCRRN
070100080522      *
070200080522      * Read all records in the S/F:
070300080522      *
070400941228     C     WWRRN#        DOWLT     WWCRRN
070500950525     C     WWERR2        ANDNE     ERROR
070600950713     C     WWRCDE        ANDNE     INUSE
070700960610     C     *IN03         ANDEQ     *OFF
070800080522      *
070900941228     C                   ADD       1             WWRRN#
071000080522      *
071100941228     C     WWRRN#        CHAIN     SCRNS01                            99
071200941228     C     *IN99         IFEQ      *OFF
071300080522      *
071400950607     C                   MOVE      *OFF          *IN61
071500080522      *
071600080522      * Option number was entered:
071700080522      *
071800941228     C     WSOPT#        IFNE      *BLANKS
071900080522      *
072000080522      * Check for subfile option errors:
072100080522      *
072200950607     C                   EXSR      $ERR02
072300080522      *
072400970109     C                   Z-ADD     RRN1          HDSFLP
072500080522      *
072600080522      * Error occurred, return to mainline:
072700080522      *
072800950607     C     WWERR2        IFEQ      ERROR
072900950607     C                   MOVE      *ON           *IN61
073000950607     C                   UPDATE    SCRNS01
073100950607     C                   ELSE
073200080522      *
073300080522      *****************************************************************
073400080522      * If this program is called as a record selection program
073500080522      * (WISEL = 'Y'), return the desired field(s) to the calling
073600080522      * program through the APPL parm list.
073700080522      *
073800080522      *   eg; Call this program to retrieve a chain code.
073900080522      *
074000080522      *     DSACTN    IFEQ SELECT
074100080522      *       Record has been selected.
074200080522      *
074300080522      *               MOVE WSCHN     WICHN
074400080522      *                 Move the chain code from the S/F to the APPL
074500080522      *                 parm WICHN.
074600080522      *
075100080522      *               MOVE *ON       *IN03
075200080522      *                 End this program.
075300080522      *
075400080522      *****************************************************************
075500080522      * If select, return the key fields and end program:
075600080522      *
075700960626     C     DSACTN        IFEQ      SELECT
075800970108>>>> C                   MOVE      WSXXX1        WIXXX1
076000960610     C                   MOVE      *ON           *IN03
076100960610     C                   ELSE
076101080522      *
076102080522      *****************************************************************
076103080522      * If Work with, call new work with program.
076104080522      *
076105080324     C     DSACTN        IFEQ      WRKWTH
076106080324     C                   Call      'SHLDUMMYR'
076107080324     C                   Else
076200080522      *
076300080522      *****************************************************************
076400080522      * Parms required to be passed to the maintenance program:
076500080522      *   1. WISEC = program level security.
076600080522      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
076900080522      *   3. The key of the record to be maintained.
077000080522      *
077100080522      *****************************************************************
077200080522      *
077300080522      * Call maintenance program:
077400080522      *
077500950608     C                   CLEAR                   APP2
077600960626     C                   MOVEL     WISEC         A2SEC
077700960626     C                   MOVEL     DSACTN        A2ACTN
077900080522      *
078000080522      * Move key fields to maintenance program for record access:
078100080522      *
078200970108>>>> C                   MOVE      WSXXX1        A2XXX1
078300080522      *
078400970108>>>> C                   CALL      'XXX0101R'
078500080324     C                   PARM                    jld
078600950608     C                   PARM                    APP2
078700080522      *
078800080522      *****************************************************************
078900080522      * When returning from the maintenance program, this program will
079000080522      * automatically position the subfile list to the last record
079100080522      * processed. To do this, the maintenance program must return all
079200080522      * 'position to' field values to this program.
079300080522      *
079601080522      *   eg; 'position to' #1 = Item Number
079602080522      *       'position to' #2 = Item Type Code
079700080522      *
079800080522      *  Using this example, when a record is maintained, the
079900080522      *  maintenance program will return the values of all of the above
080000080522      *  'position to' fields (item number, item type code).
080100080522      *  The subfile list will then automatically be positioned based
080200080522      *  on the current 'position to' view.
080300080522      *
080400080522      *****************************************************************
080500080522      *
080600080522      * Move key fields from maint pgm to 'position to' fields:
080700080522      *
080800970108>>>> C                   MOVE      A2XXX1        WCXXX1
080900970108>>>> C                   MOVE      A2XXX2        WCXXX2
081000080522      *
081100960701     C                   MOVE      YES           WWLOAD
081200080522      *
081300941228     C                   MOVEL     WRRCDE        WWRCDE
081400080522      *
081700080522      * If record lock, send record in use message:
081800080522      *
081900951027     C     WWRCDE        IFEQ      INUSE
082000080324     C                   MOVEL     'SHL0007'     WWMSGI
082200970108     C     A2IUSE        CAT       DSMDTA        DSMDTA
082300080304     C                   CALL      'ERMSG1'      MSGP01
082400951027     C                   CLEAR                   DSMDTA
082500951027     C                   MOVE      NO            WWLOAD
082600951027     C                   END
082601080522      *
082602080324     C                   ENDIF
082700080522      *
082800950526     C                   CLEAR                   WSOPT#
082900950525     C                   UPDATE    SCRNS01
083000080522      *
083100950525     C                   END
083200960610     C                   END
083300950526     C                   END
083400941228     C                   END
083500080522      *
083600941228     C                   ENDDO
083700080522      *
083800080522      * Reset current RRN:
083900080522      *
084000941228     C                   Z-ADD     WWCRRN        RRN1
084100080522      *
084200950714     C                   CLEAR                   WWRCDE
084300080522      *
084400950525     C                   ENDSR
084600080522      *
084700080522      **************
084800080522      **  $ERR02  ** - Subfile Validity Checking
084900080522      **************
085000950607     C     $ERR02        BEGSR
085100080522      *
085200080522      * Check for valid option:
085300080522      *
085400950607     C                   Z-ADD     1             X
085500950607     C     WSOPT#        LOOKUP    OPT(X)                                 90
085600950607     C     *IN90         IFEQ      *ON
085700950607     C                   MOVEL     INMD(X)       DSSPLT
085800950612     C                   ELSE
085900950612     C                   CLEAR                   DSSPLT
086000950607     C                   END
086100080522      *
086200950607     C                   SELECT
086300080522      *
086400080522      * If indicator 90 is off, option number is not valid.
086500080522      * If indicator ZZ is off, user is not authorized to option.
086600080522      *
086700950607     C     *IN90         WHENEQ    *OFF
086800950612     C     *IN(ZZ)       OREQ      *OFF
086900080324     C                   MOVEL     'SHL0008'     WWMSGI
087100080304     C                   CALL      'ERMSG1'      MSGP01
087200950607     C                   MOVEL     ERROR         WWERR2
087300080522      *
087400950607     C                   ENDSL
087500080522      *
087600950607     C                   ENDSR
087800080522      *
087900080522      **************
088000080522      **  *INZSR  ** - Initialize Program
088100080522      **************
088200950525     C     *INZSR        BEGSR
088300080522      *
088400080522      * Incoming parm list:
088500080522      *
088600950523     C     *ENTRY        PLIST
088700080324     C                   PARM                    jld
088800950524     C                   PARM                    APPL
088900080522      *
089000080522      * Message file parm list:
089100080522      *
089200950906     C     MSGP01        PLIST
089300950621     C                   PARM                    WWMSGI            7
089600080522      *
089700080522      * Key lists:
089800080522      *
089900970108     C     CODK01        KLIST
090000970108     C                   KFLD                    WWCTAB
090100970108     C                   KFLD                    WWCKEY
090200080522      *
090300970108>>>> C     XXXK01        KLIST
090400080324>>>> C                   KFLD                    WCXXXX
090500080522      *
090600080522      * Field definitions:
090700080522      *
090800950522     C     *LIKE         DEFINE    HDSFLP        RRN1
090900941228     C     *LIKE         DEFINE    HDSFLP        WWRRN#
091000941228     C     *LIKE         DEFINE    HDSFLP        WWCRRN
091100080522      *
091200080522      * Initialize:
091400080522      *
091500970108     C                   MOVE      *ZEROS        WWCNT1            2 0
091600970109     C                   MOVE      01            WWCPOS            2 0
091700941228     C                   MOVE      *BLANKS       WWCTAB            3
091800941228     C                   MOVE      *BLANKS       WWCKEY           27
091900941228     C                   MOVE      *BLANKS       WWNFND            1
092000950526     C                   MOVE      YES           WWFRST            1
092100951020     C                   MOVE      YES           WWLOAD            1
092200950525     C                   MOVE      *BLANKS       WWERR1           10
092300950525     C                   MOVE      *BLANKS       WWERR2           10
092400960610     C                   MOVE      *BLANKS       WWERR3            1
092500950525     C                   MOVE      *BLANKS       WWRCDE           10
092600950525     C                   MOVE      *ZEROS        X                 2 0
092700080522      *
092800080522      * Load the program name defined in security file PGMSEC.
092900080522      * This name must be defined in the constant 'PGMNAM'.
093000080522      *
093100970225     C                   MOVEL     PGMNAM        WWPGM            10
093200080522      *
093300080522      * Clear message subfile:
093400080522      *
093500080304     C                   CALL      'ERMSG2'
093501080304     C                   Parm                    dspgmn
093600080522      *
093700080522      * Fill default screen values:
093800080522      *
094000080522      *
095600080522      *
095700080522      * Default to the first 'position to' view if value not passed
095800080522      * to this program:
095900080522      *
096000970225     C     WIVIEW        IFEQ      *ZERO
096100970225     C                   Z-ADD     1             WWCPOS            2 0
096200970225     C                   ELSE
096300970225     C                   Z-ADD     WIVIEW        WWCPOS
096400970225     C                   MOVE      *ON           *IN40
096500970225     C                   END
096600080522      *
096700080522      * Set initial 'position to' display indicator. Also load
096800080522      * 'position to' values passed to this program (WIXXX1,2), if
096900080522      * applicable:
097000080522      *
097100970225     C                   SELECT
097200080522      *
097300970225     C     WWCPOS        WHENEQ    1
097400970225     C                   MOVE      *ON           *IN41
097500990409>>>> C                   MOVE      WIXXX1        WCXXX1
097600080522      *
097700970225     C     WWCPOS        WHENEQ    2
097800970225     C                   MOVE      *ON           *IN42
097900990409>>>> C                   MOVE      WIXXX2        WCXXX2
098000080522      *
098100970225     C                   ENDSL
098200080522      *****************************************************************
098300080522      * Field WISEC is a 5 byte logical indicator field used to control
098400080522      * user access to all maintenance functions (eg; change, delete).
098500080522      * Each byte will have a value of either '0'(not authorized) or
098600080522      * '1'(authorized). This field will be moved into indicator
098700080522      * array *IN,81.
098800080522      *
098900080522      *
099000080522      *  WISEC = '00000'                  *IN81 = Add/Copy
099100080522      *           |||||___ Work With      *IN82 = Change
099200080522      *         Add|||     (Extra)        *IN83 = Delete
099300080522      *            |||                    *IN84 = Display
099400080522      *       Change||                    *IN85 = Work With
099500080522      *             ||
099600080522      *        Delete|
099700080522      *              |
099800080522      *        Display
099900080522      *
100000080522      *****************************************************************
100100080522      *
100200080522      * Set up security options:
100300080522      *
100400970225     C     WISEC         IFEQ      *BLANKS
100500080324     C                   CALL      'SEC0100R'
100600970225     C                   PARM                    WWPGM
100700970225     C                   PARM                    WISEC
100800970225     C                   END
100900080522      *
101000080522      * User not setup in security file:
101100080522      *
101200970225     C     WISEC         IFEQ      '99999'
101300970225     C                   MOVE      '00000'       WISEC
101400970225     C                   MOVE      NO            WWLOAD
101500080324     C                   MOVEL     'SHL0009'     WWMSGI
101700080304     C                   CALL      'ERMSG1'      MSGP01
101800080522      *
101900970225     C                   ELSE
102000080522      *
102100080522      * Clear messages:
102200080522      *
102301080304     C                   CALL      'ERMSG2'
102302080304     C                   Parm                    dspgmn
102400001221     C                   MOVEA     WISEC         *IN(81)
102500080522      *
102600080522      * If program is called to select a record, turn off all
102700080522      * maintenance functions:
102800080522      *
102900960626     C     WISEL         IFEQ      YES
103000960610     C                   MOVE      *ON           *IN86
103100970108     C                   MOVEA     '00010'       *IN(81)
103200960610     C                   END
103300080522      *
103400970225     C                   END
103500080522      *
103600080522      *****************************************************************
103700080522      * All users are authorized to any *IN89 option from table OPT:
103800080522      *
103900080522      *        Option Named
104000080522      *            Constant
104100080522      *              |    |
104200080522      * Authorization|    |
104300080522      *     Indicator|    |
104400080522      *            |||    |
104500080522      *      Option|||    |
104600080522      *          |||||    |
104700080522      *   eg ;    282CHANGE
104800080522      *          2 82CHANGE
104900080522      *           789ITMINQ
105000080522      *          7 89ITMINQ
105100080522      *           989POINQ
105200080522      *          9 89POINQ
105300080522      *
105400080522      *  In this example, option 2 to change a record is available
105500080522      *  only to users which have authorization (*IN82). option 7 to
105600080522      *  view the item inquiry and option 9 to view the PO inquiry are
105700080522      *  setup in the table with indicator *IN89, therefore will be
105800080522      *  available to all users, without restriction.
105900080522      *
106000080522      *****************************************************************
106100080522      *
106200950612     C                   MOVE      *ON           *IN89
106300080522      *
106400980716     C                   MOVE      *ON           *IN36
106500080522      *
106600941228     C                   ENDSR
106700950525**
106900100614186SELECT
107100100614282CHANGE
107300100614381COPY
107500100614483DELETE
107700100614584DISPLY
107900100614985WRKWTH
