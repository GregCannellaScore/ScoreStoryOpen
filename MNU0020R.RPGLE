000100101228      /copy qcpylesrc,stdhspec
000200101228      ********************************************************************
000300101228      *
000400101228      *  Program: MNU0020R
000500101228      *
000600101228      *  Description: Work with menu headers
000700101228      *
000800101228      *  Programmer: Greg Cannella
000900101228      *
001000101228      *  Date: 12/28/10
001100101228      *
001200101228      ********************************************************************
001300101228      *                   Modification Log
001400101228      *
001500101228      *  Initials  Date      Description
001600101228      *-------------------------------------------------------------------
001700101228      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800101228      *
001900101228      *
002000101228      *
002100101228      ********************************************************************
002200101228      *                   Indicator Usage
002300101228      *
002400101228      *   Ind.   Description
002500101228      *-------------------------------------------------------------------
002600101228      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700101228      *
002800101228      *
002900101228      ********************************************************************
003000101228      *****************************************************************
003100101228      * Indicator Usage:                                              *
003200101228      * Ind      Use                                                  *
003300101228      * 01-24    Function keys                                        *
003400101228      * 25       Rollup                                               *
003500101228      * 30-34    Subfile keywords                                     *
003600101228      * 36       Position to                                          *
003700101228      * 37       Error indicator                                      *
003800101228      * 40       Search field change                                  *
003900101228      * 41-42    Search field display                                 *
004000101228      * 61       Subfile option error                                 *
004100101228      * 80-89    Reserved for Security                                *
004200101228      * 90-99    Hit/Miss                                             *
004300101228      *****************************************************************
004400101228      *****************************************************************
004500101228      * Field Definitions                                             *
004600101228      *                                                               *
004700101228      * Prefix                                                        *
004800101228      * WW     - Program described work fields                        *
004900101228      * WI     - APPL *ENTRY input parameters                         *
005000101228      * WS     - Subfile fields                                       *
005100101228      * WC     - Subfile control fields                               *
005200101228      * HD     - Hidden fields                                        *
005300101228      * Ax     - APPx output parameters for called programs           *
005400101228      * DS     - Data structure fields                                *
005500101228      *                                                               *
005600101228      *                                                               *
005700101228      * Display Record Format Definitions                             *
005800101228      *                                                               *
005900101228      * Prefix                                                        *
006000101228      * SCRNS  - Subfile                                              *
006100101228      * SCRNC  - Subfile control                                      *
006200101228      * SCRNK  - Command key                                          *
006300101228      * SCRNR  - Standard display                                     *
006400101228      * WNDWB  - Window border                                        *
006500101228      * WNDWR  - Standard window display                              *
006600101228      * MSGCTL - Message subfile control                              *
006700101228      *                                                               *
006800101228      *                                                               *
006900101228      * Called programs                                               *
007000101228      *                                                               *
007100101228      * ERMSG2 - Clear program message queue                        *
007200101228      * ERMSG1 - Send program message with message data             *
007300101228      * XXX0101R - Maintenance program                                *
007400101228      *                                                               *
007500101228      *                                                               *
007600101228      *****************************************************************
007700101228      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007800101228      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007900101228      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
008000101228      *
008100101228     FMNU0020D  CF   E             WORKSTN
008200101228     F                                     SFILE(SCRNS01:RRN1)
008300101228     F                                     INFDS(INFDS)
008400101228     FMNUHDRM   IF   E           K DISK
008500101228      *
008600101228      * Option authorization:
008700101228     D OPT             S              1    DIM(12) CTDATA PERRCD(1)
008800101228     D INMD            S             12    DIM(12) ALT(OPT)
008900101228      *
009000101228      *
009100101228      *
009200101228      * Max number of 'position to':
009300101228     D WW#POS          C                   CONST(01)
009400101228      *
009500101228      * Number of records to fill S/F page:
009600101228     D WWPGSZ          C                   CONST(10)
009700101228      *
009800101228      * General constants:
009900101228     D LOAD            C                   CONST('LOAD')
010000101228     D ERROR           C                   CONST('ERROR')
010100101228     D INUSE           C                   CONST('INUSE')
010200101228     D SELECT          C                   CONST('SELECT')
010300101228     D ADD             C                   CONST('ADD')
010400101228     D CHANGE          C                   CONST('CHANGE')
010500101228     D COPY            C                   CONST('COPY')
010600101228     D DELETE          C                   CONST('DELETE')
010700101228     D DISPLY          C                   CONST('DISPLY')
010800101228     D WRKWTH          C                   CONST('WRKWTH')
010900120125     D SEC             C                   CONST('SEC')
011000101228     D PGMNAM          C                   CONST('MNU0020R  ')
011100101228     D NO              C                   CONST('N')
011200101228     D YES             C                   CONST('Y')
011300101228      *
011400101228     D jld           E DS                  EXTNAME(dsjld)
011500101228      *
011600101228      * Incoming parms:
011700101228     D APPL            DS           512
011800101228     D  WISEC                  1      5
011900101228     D  WISEL                  6      6
012000101228     D  WIVIEW                 7      8  0
012100101228     D  WImname                9     18
012200101228      *
012300101228      * Calling parms for XXX0101R:
012400101228     D APP2            DS           512
012500101228     D  A2SEC                  1      5
012600101228     D  A2IUSE                 6     15
012700101228     D  A2INLR                16     16
012800101228     D  A2ACTN                17     26
012900101228     D  A2mname               27     36
013000101228      *
013100101228      * Parm to hold message data:
013200101228     D DSMDTA          DS           500
013300101228      *
013400101228      * Split option indicator and action code:
013500101228     D DSSPLT          DS            12
013600101228     D  ZZ                     1      2  0
013700101228     D  DSACTN                 3     12
013800101228      *
013900101228     D INFDS           DS
014000101228     D  SFLLOC               378    379B 0
014100101228      *
014200101228     D                SDS
014300101228     D  DSPGMN           *PROC
014400101228     D  DSUSER               254    263
014500101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014600101228      *M                 M  A  I  N  L  I  N  E                       M
014700101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014800101228      *
014900101228      *
015000101228      * Main loop:
015100101228      *
015200101228     C     *IN03         DOUEQ     *ON
015300101228      *
015400101228      * Reload subfile, if requested:
015500101228      *
015600101228     C     WWLOAD        IFEQ      YES
015700101228     C                   EXSR      $INSFL
015800101228     C                   MOVE      NO            WWLOAD
015900101228     C                   END
016000101228      *
016100101228      * Display screen:
016200101228      *
016300101228     C                   WRITE     MSGCTL1
016400101228     C                   WRITE     SCRNK01
016500101228      *
016600101228     C     *IN32         IFEQ      *OFF
016700101228     C                   WRITE     SCRNR01
016800101228     C                   END
016900101228      *
017000101228     C                   EXFMT     SCRNC01
017100101228     C                   MOVE      THEFLD        *IN69
017200101228      *
017300101228     C     WWFRST        IFEQ      YES
017400101228     C                   MOVE      NO            WWFRST
017500101228     C                   END
017600101228      *
017700101228     C                   MOVE      SFLLOC        HDSFLP
017800101228      *
017900101228      * Clear messages:
018000101228      *
018100101228     C                   CALL      'ERMSG2'
018200101228     C                   Parm                    DSPGMN
018300101228      *
018400101228      * Set off all error indicators here:
018500101228      *
018600101228     C                   MOVE      *OFF          *IN36
018700101228     C                   MOVE      *OFF          *IN38
018800101228     C                   MOVE      *OFF          *IN71
018900101228      *
019000101228     C     *IN03         IFEQ      *OFF
019100101228      *
019200101228      * Process command keys:
019300101228      *
019400101228     C                   SELECT
019500101228      *
019600101228      *
019700101228      * F4 = Prompt:
019800101228      *
019900101228     C     *IN04         WHENEQ    *ON
020000101228     C                   EXSR      $PRMPT
020100101228     C                   EXSR      $INSFL
020200101228      *
020300101228      * F10 = Position to:
020400101228      *
020500101228     C     *IN10         WHENEQ    *ON
020600101228     C                   EXSR      $POSTO
020700101228      *
020800101228      * F5 or 'position to' field value change (*IN40) - reload S/F:
020900101228      *
021000101228     C     *IN05         WHENEQ    *ON
021100101228     C     *IN40         OREQ      *ON
021200101228     C                   EXSR      $INSFL
021300101228      *
021400101228      * Rollup (if records exist in S/F - *IN32):
021500101228      *
021600101228     C     *IN25         WHENEQ    *ON
021700101228     C     *IN32         ANDEQ     *ON
021800101228     C                   EXSR      $LDSFL
021900101228      *
022000101228      * F6 = Add a record:
022100101228      *
022200101228     C                   WHEN      *in06 = *on
022300101228     c                   EXSR      $ADDRC
022400101228      *
022500101228      * F12= Cancel
022600101228      *
022700101228     C     *IN12         WHENEQ    *ON
022800101228     C                   Eval      *in03=*on
022900101228      *
023000101228     C                   OTHER
023100101228      *
023200101228      * Enter:
023300101228      *
023400101228     C                   EXSR      $READC
023500101228      *
023600101228     C                   ENDSL
023700101228      *
023800101228     C                   END
023900101228      *
024000101228     C                   ENDDO
024100101228      *
024200101228      * Close called programs:
024300101228      *
024400101228     C                   MOVE      YES           A2INLR
024500101228      *
024600101228      * End the maintenance program:
024700101228      *
024800101228     C                   CALL      'MNU0021R'
024900101228     C                   PARM                    jld
025000101228     C                   PARM                    APP2
025100101228      *
025200101228     C                   MOVE      *ON           *INLR
025300101228      *
025400101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025500101228      *$              S  U  B  R  O  U  T  I  N  E  S                 $
025600101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025700101228      *
025800101228      **************
025900101228      **  $INSFL  ** - Initialize Subfile
026000101228      **************
026100101228     C     $INSFL        BEGSR
026200101228      *
026300101228     C                   CLEAR                   RRN1
026400101228     C                   Z-ADD     1             HDSFLP
026500101228     C                   MOVE      NO            WWNFND
026600101228      *
026700101228      * Clear subfile:
026800101228      *
026900101228     C     *IN32         IFEQ      *ON
027000101228     C                   MOVE      *OFF          *IN32
027100101228     C                   MOVE      *ON           *IN30
027200101228     C                   WRITE     SCRNC01
027300101228     C                   MOVE      *OFF          *IN30
027400101228     C                   END
027500101228      *
027600101228      * Check for subfile control errors:
027700101228      *
027800101228     C     WWFRST        CASEQ     NO            $ERR01
027900101228     C                   ENDCS
028000101228      *
028100101228      * Position file:
028200101228      *
028300101228      ****************************************************************
028400101228      * WHSXXX - Logical file based on current 'position to' view.
028500101228      *  eg; physical file is INVMF and current 'position to' is
028600101228      *      by style number, WHSXXX = INVMF (key = style #).
028700101228      *
028800101228      *
028900101228      * XXXK01 - Key list based on current 'position to' fields.
029000101228      *  eg; if 'position to' field is item number:
029100101228      *          XXXK01 = INVK01  KLIST
029200101228      *                           KFLD      WCITM#
029300101228      ****************************************************************
029400101228      *
029500101228     C                   SELECT
029600101228      *
029700101228     C     WWCPOS        WHENEQ    1
029800101228     C     mhk01         SETLL     mnuhdrm                                99
029900101228     C     *IN99         IFEQ      *OFF
030000101228     C                   MOVE      YES           WWNFND
030100101228     C                   END
030200101228      *
030300101228     C*    WWCPOS        WHENEQ    2
030400101228     C*    XXXK01        SETLL     WHSXXXX                                99
030500101228     C*    *IN99         IFEQ      *OFF
030600101228     C*                  MOVE      YES           WWNFND
030700101228     C*                  END
030800101228      *
030900101228     C                   ENDSL
031000101228      *
031100101228      * Load subfile:
031200101228      *
031300101228     C                   EXSR      $LDSFL
031400101228      *
031500101228      * Send message if search criteria is not found:
031600101228      *
031700101228     C     WWNFND        IFEQ      YES
031800101228     C     *IN40         IFEQ      *ON
031900101228     C     *IN04         OREQ      *ON
032000101228     C                   MOVEL     'SHL0006'     WWMSGI
032100101228     C                   CALL      'ERMSG1'      MSGP01
032200101228     C                   END
032300101228     C                   END
032400101228      *
032500101228     C                   ENDSR
032600101228      *
032700101228      **************
032800101228      **  $ERR01  ** - Control Screen Validity Checking
032900101228      **************
033000101228     C     $ERR01        BEGSR
033100101228      *
033200101228     C                   CLEAR                   WWERR1
033300101228      *
033400101228      *****************************************************************
033500101228      * All error conditions must have the following lines of code:
033600101228      *
033700101228      *   MOVE *ON       *INXX
033800101228      *     Where *INXX = field error indicator in DDS.
033900101228      *
034000101228      *   MOVELERROR     WWERR1
034100101228      *     Program error flag.
034200101228      *
034300101228      *   MOVEL'XXX0001' WWMSGI
034400101228      *     Where XXX0001 = error message id to be displayed.
034500101228      *
034600101228      *   MOVELXXXXXX    WWMSGF
034700101228      *     Where XXXXXX = name of the message file which contains
034800101228      *     the message id contained in field WWMSGI.
034900101228      *
035000101228      *   CALL 'ERMSG1'  MSGP01
035100101228      *     Message handling program.
035200101228      *****************************************************************
035300101228      *
035400101228      * Field 1:
035500101228     C     *IN41         IFEQ      *ON
035600101228     C     WCmname       ANDNE     *ZERO
035700101228     C     mhk01         SETLL     mnuhdrm                                99
035800101228     C     *IN99         IFEQ      *OFF
035900101228     C                   MOVE      *ON           *IN36
036000101228     C                   MOVEL     ERROR         WWERR1
036100101228     C                   MOVEL     'SHL0006'     WWMSGI
036200101228     C                   CALL      'ERMSG1'      MSGP01
036300101228     C                   END
036400101228     C                   END
036500101228      *
036600101228     C*    *IN42         IFEQ      *ON
036700101228     C*    WCXXX1        ANDNE     *ZERO
036800101228     C*    XXXK01        SETLL     WHSXXXX                                99
036900101228     C*    *IN99         IFEQ      *OFF
037000101228     C*                  MOVE      *ON           *IN36
037100101228     C*                  MOVEL     ERROR         WWERR1
037200101228     C*                  MOVEL     'SHL0006'     WWMSGI
037300101228     C*                  CALL      'ERMSG1'      MSGP01
037400101228     C*                  END
037500101228     C*                  END
037600101228      *
037700101228     C                   ENDSR
037800101228      *
037900101228      **************
038000101228      **  $LDSFL  ** - Load Subfile
038100101228      **************
038200101228     C     $LDSFL        BEGSR
038300101228      *
038400101228     C                   CLEAR                   WWCNT1
038500101228      *
038600101228     C                   MOVE      *OFF          *IN34
038700101228      *
038800101228      * Load one page at a time:
038900101228      *
039000101228     C     WWCNT1        DOWLT     WWPGSZ
039100101228     C     *IN34         ANDEQ     *OFF
039200101228      *****************************************************************
039300101228      *
039400101228     C                   SELECT
039500101228      *
039600101228      * Read from file, based on current 'position to' view:
039700101228      *
039800101228     C     WWCPOS        WHENEQ    1
039900101228     C                   READ      mnuhdrm                                34
040000101228      *
040100101228     C     WWCPOS        WHENEQ    2
040200101228     C                   READ      mnuhdrm                                34
040300101228      *
040400101228     C                   ENDSL
040500101228      *
040600101228     C     *IN34         IFEQ      *OFF
040700101228      *
040800101228     C                   CLEAR                   WSOPT#
040900101228     C                   MOVE      *OFF          *IN61
041000101228      *
041100101228      * Load subfile fields here:
041200101228      *
041300101228      *
041400101228     C                   MOVE      mhmname       WSmname
041500101228     C                   MOVE      mhmdesc       WSmdesc
041600101228      *
041700101228     C                   ADD       1             RRN1
041800101228     C                   ADD       1             WWCNT1
041900101228      *
042000101228     C     WWCNT1        IFEQ      1
042100101228     C                   Z-ADD     RRN1          HDSFLP
042200101228     C                   END
042300101228      *
042400101228     C                   WRITE     SCRNS01
042500101228      *
042600101228     C                   END
042700101228      *
042800101228     C                   ENDDO
042900101228      *
043000101228     C     RRN1          IFGT      *ZERO
043100101228     C                   MOVE      *ON           *IN32
043200101228     C                   END
043300101228      *
043400101228     C                   MOVE      *OFF          *IN25
043500101228      *
043600101228     C                   ENDSR
043700101228      *
043800101228      **************
043900101228      **  $PRMPT  ** - Process Promptable Fields
044000101228      **************
044100101228     C     $PRMPT        BEGSR
044200101228      *
044300101228      *****************************************************************
044400101228      *  Field HDCSRF (defined in DDS) contains the field name which
044500101228      *  contains the cursor. If valid, a prompting program may be
044600101228      *  called to select a record from a list of valid values for
044700101228      *  the prompted field. The value selected should then be placed
044800101228      *  in the field which was prompted.
044900101228      *
045000101228      * eg; HDCSRF    WHEQ 'WCXXX1'
045100101228      *      Cursor resides in field WCXXX1
045200101228      *
045300101228      *     CALL 'GEN0109R'
045400101228      *      Codes file prompting program.
045500101228      *
045600101228      *     PARM '653'     WWCTAB
045700101228      *      Outgoing parm.
045800101228      *
045900101228      *     PARM *BLANKS   WWCKEY
046000101228      *      Return parm.
046100101228      *
046200101228      *     MOVELWWCKEY    WCXXX1
046300101228      *      Move return parm into prompted field.
046400101228      *
046500101228      *****************************************************************
046600101228      *
046700101228     C                   SELECT
046800101228      *
046900101228     C*    HDCSRF        WHENEQ    'WCXXX1'
047000101228     C*                  CALL      'GEN0109R'
047100101228     C*                  PARM      '653'         WWCTAB
047200101228     C*                  PARM      *BLANKS       WWCKEY
047300101228     C*                  MOVEL     WWCKEY        WCXXX1
047400101228      *
047500101228     C*    HDCSRF        WHENEQ    'WCXXX2'
047600101228     C*                  CALL      'GEN0109R'
047700101228     C*                  PARM      '654'         WWCTAB
047800101228     C*                  PARM      *BLANKS       WWCKEY
047900101228     C*                  MOVEL     WWCKEY        WCXXX2
048000101228      *
048100101228      * Non propmtable area:
048200101228      *
048300101228     C                   OTHER
048400101228      *
048500101228     C                   MOVEL     'SHL0004'     WWMSGI
048600101228     C                   CALL      'ERMSG1'      MSGP01
048700101228      *
048800101228     C                   ENDSL
048900101228      *
049000101228     C                   ENDSR
049100101228      *
049200101228      **************
049300101228      **  $POSTO  ** - Position To
049400101228      **************
049500101228     C     $POSTO        BEGSR
049600101228      *
049700101228      * Clear all 'position to' fields here:
049800101228      *
049900101228     C                   CLEAR                   WCmname
050000101228      *
050100101228     C                   CLEAR                   RRN1
050200101228     C                   CLEAR                   HDSFLP
050300101228      *
050400101228      * Clear subfile:
050500101228      *
050600101228     C     *IN32         IFEQ      *ON
050700101228     C                   MOVE      *OFF          *IN32
050800101228     C                   MOVE      *ON           *IN30
050900101228     C                   WRITE     SCRNC01
051000101228     C                   MOVE      *OFF          *IN30
051100101228     C                   END
051200101228      *
051300101228      * Position cursor:
051400101228      *
051500101228     C                   MOVE      *ON           *IN36
051600101228      *
051700101228      * Toggle to next 'position to' field:
051800101228      *
051900101228     C     WWCPOS        ADD       1             WWCPOS
052000101228      *
052100101228     C     WWCPOS        IFGT      WW#POS
052200101228     C                   Z-ADD     1             WWCPOS
052300101228     C                   END
052400101228      *
052500101228      *****************************************************************
052600101228      * When a 'position to' view is changed, the new display
052700101228      * indicator (from DDS) must be set on and all other 'position to'
052800101228      * display indicators must be turned off.
052900101228      *
053000101228      *  eg; 'position to' #1 by agency (display indicator *IN41)
053100101228      *      'position to' #2 by agency/chain (display indicator *IN42)
053200101228      *
053300101228      *  If user toggles to 'position to' by agency/chain, indicator
053400101228      *  *IN41 must be turned off and *IN42 turned on.
053500101228      *
053600101228      *      MOVEA'01'      *IN,41
053700101228      *****************************************************************
053800101228      *
053900101228      * Set 'position to' field display indicator:
054000101228      *
054100101228     C                   SELECT
054200101228      *
054300101228     C     WWCPOS        WHENEQ    1
054400101228     C                   MOVEA     '10'          *IN(41)
054500101228      *
054600101228     C     WWCPOS        WHENEQ    2
054700101228     C                   MOVEA     '01'          *IN(41)
054800101228      *
054900101228     C                   ENDSL
055000101228      *
055100101228     C                   ENDSR
055200101228      *
055300101228      **************
055400101228      **  $ADDRC  ** - Add a record
055500101228      **************
055600101228     C     $ADDRC        BEGSR
055700101228      *
055800101228      *****************************************************************
055900101228      * Parms required to be passed to the maintenance program:
056000101228      *   1. WISEC = program level security.
056100101228      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
056200101228      *
056300101228      *****************************************************************
056400101228      *
056500101228     C                   MOVE      YES           WWLOAD
056600101228      *
056700101228     C                   CLEAR                   APP2
056800101228     C                   MOVEL     WISEC         A2SEC
056900101228     C                   MOVEL     ADD           A2ACTN
057000101228      *
057100101228      * Move key fields to maintenance program for record access:
057200101228      *
057300101228     C                   MOVE      WCmname       A2mname
057400101228      *
057500101228      * Call maintenance program:
057600101228      *
057700101230     C                   CALL      'MNU0021R'
057800101228     C                   PARM                    jld
057900101228     C                   PARM                    APP2
058000101228      *
058100101228      *****************************************************************
058200101228      * When returning from the maintenance program, this program will
058300101228      * automatically position the subfile list to the last record
058400101228      * added to the file. To do this, the maintenance program must
058500101228      * return all 'position to' field values to this program.
058600101228      *
058700101228      *   eg; 'position to' #1 = Item Number
058800101228      *       'position to' #2 = Item Type Code
058900101228      *
059000101228      *
059100101228      *  Using this example, when a record is added to the file, the
059200101228      *  maintenance program will return the values of all of the above
059300101228      *  'position to' fields (Item Number, Item Type Code).
059400101228      *  The subfile list will then automatically be positioned based
059500101228      *  on the current 'position to' view.
059600101228      *
059700101228      *****************************************************************
059800101228      *
059900101228      * Move key fields from maint pgm to 'position to' fields:
060000101228      *
060100101228     C                   MOVE      A2mname       WCmname
060200101228      *
060300101228     C                   MOVEL     WRRCDE        WWRCDE
060400101228      *
060500101228     C                   ENDSR
060600101228      *
060700101228      **************
060800101228      **  $READC  ** - Process Subfile Requests
060900101228      **************
061000101228     C     $READC        BEGSR
061100101228      *
061200101228     C                   CLEAR                   WWERR2
061300101228     C                   CLEAR                   WWRCDE
061400101228     C                   CLEAR                   WWRRN#
061500101228      *
061600101228      * Save current RRN:
061700101228      *
061800101228     C                   Z-ADD     RRN1          WWCRRN
061900101228      *
062000101228      * Read all records in the S/F:
062100101228      *
062200101228     C     WWRRN#        DOWLT     WWCRRN
062300101228     C     WWERR2        ANDNE     ERROR
062400101228     C     WWRCDE        ANDNE     INUSE
062500101228     C     *IN03         ANDEQ     *OFF
062600101228      *
062700101228     C                   ADD       1             WWRRN#
062800101228      *
062900101228     C     WWRRN#        CHAIN     SCRNS01                            99
063000101228     C     *IN99         IFEQ      *OFF
063100101228      *
063200101228     C                   MOVE      *OFF          *IN61
063300101228      *
063400101228      * Option number was entered:
063500101228      *
063600101228     C     WSOPT#        IFNE      *BLANKS
063700101228      *
063800101228      * Check for subfile option errors:
063900101228      *
064000101228     C                   EXSR      $ERR02
064100101228      *
064200101228     C                   Z-ADD     RRN1          HDSFLP
064300101228      *
064400101228      * Error occurred, return to mainline:
064500101228      *
064600101228     C     WWERR2        IFEQ      ERROR
064700101228     C                   MOVE      *ON           *IN61
064800101228     C                   UPDATE    SCRNS01
064900101228     C                   ELSE
065000101228      *
065100101228      *****************************************************************
065200101228      * If this program is called as a record selection program
065300101228      * (WISEL = 'Y'), return the desired field(s) to the calling
065400101228      * program through the APPL parm list.
065500101228      *
065600101228      *   eg; Call this program to retrieve a chain code.
065700101228      *
065800101228      *     DSACTN    IFEQ SELECT
065900101228      *       Record has been selected.
066000101228      *
066100101228      *               MOVE WSCHN     WICHN
066200101228      *                 Move the chain code from the S/F to the APPL
066300101228      *                 parm WICHN.
066400101228      *
066500101228      *               MOVE *ON       *IN03
066600101228      *                 End this program.
066700101228      *
066800101228      *****************************************************************
066900101228      * If select, return the key fields and end program:
067000101228      *
067100101228     C     DSACTN        IFEQ      SELECT
067200101228     C                   MOVE      WSmname       WImname
067300101228     C                   MOVE      *ON           *IN03
067400101228     C                   ELSE
067500101228      *
067600101228      *****************************************************************
067700101228      * If Work with, call new work with program.
067800101228      *
067900101228     C     DSACTN        IFEQ      WRKWTH
068000101229     C                   Call      'MNU0030R'
068100101229     C                   Parm                    wsmname
068200101228     C                   Else
068300120125      *
068400120125      *****************************************************************
068500120125      * If Work with security call menu security program.
068600120125      *
068700120125     C     DSACTN        IFEQ      SEC
068800120125     C                   Call      'MNU0055R'
068900120125     C                   Parm                    wsmname
069000120125     C                   Else
069100101228      *
069200101228      *****************************************************************
069300101228      * Parms required to be passed to the maintenance program:
069400101228      *   1. WISEC = program level security.
069500101228      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
069600101228      *   3. The key of the record to be maintained.
069700101228      *
069800101228      *****************************************************************
069900101228      *
070000101228      * Call maintenance program:
070100101228      *
070200101228     C                   CLEAR                   APP2
070300101228     C                   MOVEL     WISEC         A2SEC
070400101228     C                   MOVEL     DSACTN        A2ACTN
070500101228      *
070600101228      * Move key fields to maintenance program for record access:
070700101228      *
070800101228     C                   MOVE      WSmname       A2mname
070900101228      *
071000101228     C                   CALL      'MNU0021R'
071100101228     C                   PARM                    jld
071200101228     C                   PARM                    APP2
071300101228      *
071400101228      *****************************************************************
071500101228      * When returning from the maintenance program, this program will
071600101228      * automatically position the subfile list to the last record
071700101228      * processed. To do this, the maintenance program must return all
071800101228      * 'position to' field values to this program.
071900101228      *
072000101228      *   eg; 'position to' #1 = Item Number
072100101228      *       'position to' #2 = Item Type Code
072200101228      *
072300101228      *  Using this example, when a record is maintained, the
072400101228      *  maintenance program will return the values of all of the above
072500101228      *  'position to' fields (item number, item type code).
072600101228      *  The subfile list will then automatically be positioned based
072700101228      *  on the current 'position to' view.
072800101228      *
072900101228      *****************************************************************
073000101228      *
073100101228      * Move key fields from maint pgm to 'position to' fields:
073200101228      *
073300101228     C                   MOVE      A2mname       WCmname
073400101228      *
073500101228     C                   MOVE      YES           WWLOAD
073600101228      *
073700101228     C                   MOVEL     WRRCDE        WWRCDE
073800101228      *
073900101228      * If record lock, send record in use message:
074000101228      *
074100101228     C     WWRCDE        IFEQ      INUSE
074200101228     C                   MOVEL     'SHL0007'     WWMSGI
074300101228     C     A2IUSE        CAT       DSMDTA        DSMDTA
074400101228     C                   CALL      'ERMSG1'      MSGP01
074500101228     C                   CLEAR                   DSMDTA
074600101228     C                   MOVE      NO            WWLOAD
074700101228     C                   END
074800101228      *
074900101228     C                   ENDIF
075000101228      *
075100101228     C                   CLEAR                   WSOPT#
075200101228     C                   UPDATE    SCRNS01
075300101228      *
075400101228     C                   END
075500120125     C                   END
075600101228     C                   END
075700101228     C                   END
075800101228     C                   END
075900101228      *
076000101228     C                   ENDDO
076100101228      *
076200101228      * Reset current RRN:
076300101228      *
076400101228     C                   Z-ADD     WWCRRN        RRN1
076500101228      *
076600101228     C                   CLEAR                   WWRCDE
076700101228      *
076800101228     C                   ENDSR
076900101228      *
077000101228      **************
077100101228      **  $ERR02  ** - Subfile Validity Checking
077200101228      **************
077300101228     C     $ERR02        BEGSR
077400101228      *
077500101228      * Check for valid option:
077600101228      *
077700101228     C                   Z-ADD     1             X
077800101228     C     WSOPT#        LOOKUP    OPT(X)                                 90
077900101228     C     *IN90         IFEQ      *ON
078000101228     C                   MOVEL     INMD(X)       DSSPLT
078100101228     C                   ELSE
078200101228     C                   CLEAR                   DSSPLT
078300101228     C                   END
078400101228      *
078500101228     C                   SELECT
078600101228      *
078700101228      * If indicator 90 is off, option number is not valid.
078800101228      * If indicator ZZ is off, user is not authorized to option.
078900101228      *
079000101228     C     *IN90         WHENEQ    *OFF
079100101228     C     *IN(ZZ)       OREQ      *OFF
079200101228     C                   MOVEL     'SHL0008'     WWMSGI
079300101228     C                   CALL      'ERMSG1'      MSGP01
079400101228     C                   MOVEL     ERROR         WWERR2
079500101228      *
079600101228     C                   ENDSL
079700101228      *
079800101228     C                   ENDSR
079900101228      *
080000101228      **************
080100101228      **  *INZSR  ** - Initialize Program
080200101228      **************
080300101228     C     *INZSR        BEGSR
080400101228      *
080500101228      * Incoming parm list:
080600101228      *
080700101228     C     *ENTRY        PLIST
080800101228     C                   PARM                    jld
080900101228     C                   PARM                    APPL
081000101228      *
081100101228      * Message file parm list:
081200101228      *
081300101228     C     MSGP01        PLIST
081400101228     C                   PARM                    WWMSGI            7
081500101228      *
081600101228      * Key lists:
081700101228      *
081800101228     C     CODK01        KLIST
081900101228     C                   KFLD                    WWCTAB
082000101228     C                   KFLD                    WWCKEY
082100101228      *
082200101228     C     mhk01         KLIST
082300101228     C                   KFLD                    WCmname
082400101228      *
082500101228      * Field definitions:
082600101228      *
082700101228     C     *LIKE         DEFINE    HDSFLP        RRN1
082800101228     C     *LIKE         DEFINE    HDSFLP        WWRRN#
082900101228     C     *LIKE         DEFINE    HDSFLP        WWCRRN
083000101228      *
083100101228      * Initialize:
083200101228      *
083300101228     C                   MOVE      *ZEROS        WWCNT1            2 0
083400101228     C                   MOVE      01            WWCPOS            2 0
083500101228     C                   MOVE      *BLANKS       WWCTAB            3
083600101228     C                   MOVE      *BLANKS       WWCKEY           27
083700101228     C                   MOVE      *BLANKS       WWNFND            1
083800101228     C                   MOVE      YES           WWFRST            1
083900101228     C                   MOVE      YES           WWLOAD            1
084000101228     C                   MOVE      *BLANKS       WWERR1           10
084100101228     C                   MOVE      *BLANKS       WWERR2           10
084200101228     C                   MOVE      *BLANKS       WWERR3            1
084300101228     C                   MOVE      *BLANKS       WWRCDE           10
084400101228     C                   MOVE      *ZEROS        X                 2 0
084500101228      *
084600101228      * Load the program name defined in security file PGMSEC.
084700101228      * This name must be defined in the constant 'PGMNAM'.
084800101228      *
084900101228     C                   MOVEL     PGMNAM        WWPGM            10
085000101228      *
085100101228      * Clear message subfile:
085200101228      *
085300101228     C                   CALL      'ERMSG2'
085400101228     C                   Parm                    dspgmn
085500101228      *
085600101228      * Fill default screen values:
085700101228      *
085800101228      *
085900101228      *
086000101228      * Default to the first 'position to' view if value not passed
086100101228      * to this program:
086200101228      *
086300101228     C     WIVIEW        IFEQ      *ZERO
086400101228     C                   Z-ADD     1             WWCPOS            2 0
086500101228     C                   ELSE
086600101228     C                   Z-ADD     WIVIEW        WWCPOS
086700101228     C                   MOVE      *ON           *IN40
086800101228     C                   END
086900101228      *
087000101228      * Set initial 'position to' display indicator. Also load
087100101228      * 'position to' values passed to this program (WIXXX1,2), if
087200101228      * applicable:
087300101228      *
087400101228     C                   SELECT
087500101228      *
087600101228     C     WWCPOS        WHENEQ    1
087700101228     C                   MOVE      *ON           *IN41
087800101228     C                   MOVE      WImname       WCmname
087900101228      *
088000101228     C*    WWCPOS        WHENEQ    2
088100101228     C*                  MOVE      *ON           *IN42
088200101228     C*                  MOVE      WIXXX2        WCXXX2
088300101228      *
088400101228     C                   ENDSL
088500101228      *****************************************************************
088600101228      * Field WISEC is a 5 byte logical indicator field used to control
088700101228      * user access to all maintenance functions (eg; change, delete).
088800101228      * Each byte will have a value of either '0'(not authorized) or
088900101228      * '1'(authorized). This field will be moved into indicator
089000101228      * array *IN,81.
089100101228      *
089200101228      *
089300101228      *  WISEC = '00000'                  *IN81 = Add/Copy
089400101228      *           |||||___ Work With      *IN82 = Change
089500101228      *         Add|||     (Extra)        *IN83 = Delete
089600101228      *            |||                    *IN84 = Display
089700101228      *       Change||                    *IN85 = Work With
089800101228      *             ||
089900101228      *        Delete|
090000101228      *              |
090100101228      *        Display
090200101228      *
090300101228      *****************************************************************
090400101228      *
090500101228      * Set up security options:
090600101228      *
090700101228     C     WISEC         IFEQ      *BLANKS
090800101228     C                   CALL      'SEC0100R'
090900101228     C                   PARM                    WWPGM
091000101228     C                   PARM                    WISEC
091100101228     C                   END
091200101228      *
091300101228      * User not setup in security file:
091400101228      *
091500101228     C     WISEC         IFEQ      '99999'
091600101228     C                   MOVE      '00000'       WISEC
091700101228     C                   MOVE      NO            WWLOAD
091800101228     C                   MOVEL     'SHL0009'     WWMSGI
091900101228     C                   CALL      'ERMSG1'      MSGP01
092000101228      *
092100101228     C                   ELSE
092200101228      *
092300101228      * Clear messages:
092400101228      *
092500101228     C                   CALL      'ERMSG2'
092600101228     C                   Parm                    dspgmn
092700101228     C                   MOVEA     WISEC         *IN(81)
092800101228      *
092900101228      * If program is called to select a record, turn off all
093000101228      * maintenance functions:
093100101228      *
093200101228     C     WISEL         IFEQ      YES
093300101228     C                   MOVE      *ON           *IN86
093400101228     C                   MOVEA     '00010'       *IN(81)
093500101228     C                   END
093600101228      *
093700101228     C                   END
093800101228      *
093900101228      *****************************************************************
094000101228      * All users are authorized to any *IN89 option from table OPT:
094100101228      *
094200101228      *        Option Named
094300101228      *            Constant
094400101228      *              |    |
094500101228      * Authorization|    |
094600101228      *     Indicator|    |
094700101228      *            |||    |
094800101228      *      Option|||    |
094900101228      *          |||||    |
095000101228      *   eg ;    282CHANGE
095100101228      *          2 82CHANGE
095200101228      *           789ITMINQ
095300101228      *          7 89ITMINQ
095400101228      *           989POINQ
095500101228      *          9 89POINQ
095600101228      *
095700101228      *  In this example, option 2 to change a record is available
095800101228      *  only to users which have authorization (*IN82). option 7 to
095900101228      *  view the item inquiry and option 9 to view the PO inquiry are
096000101228      *  setup in the table with indicator *IN89, therefore will be
096100101228      *  available to all users, without restriction.
096200101228      *
096300101228      *****************************************************************
096400101228      *
096500101228     C                   MOVE      *ON           *IN89
096600101228      *
096700101228     C                   MOVE      *ON           *IN36
096800101228      *
096900101228     C                   ENDSR
097000101228**
097100101228186SELECT
097200101228282CHANGE
097300101228381COPY
097400101228483DELETE
097500101228584DISPLY
097600101228985WRKWTH
097700120125S85SEC
