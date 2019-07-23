000100101229      /copy qcpylesrc,stdhspec
000200101229      ********************************************************************
000300101229      *
000400101229      *  Program: MNU0040R
000500101229      *
000600101229      *  Description: Work with menu options
000700101229      *
000800101229      *  Programmer: Greg Cannella
000900101229      *
001000101229      *  Date: 12/29/10
001100101229      *
001200101229      ********************************************************************
001300101229      *                   Modification Log
001400101229      *
001500101229      *  Initials  Date      Description
001600101229      *-------------------------------------------------------------------
001700101229      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800101229      *
001900101229      *
002000101229      *
002100101229      ********************************************************************
002200101229      *                   Indicator Usage
002300101229      *
002400101229      *   Ind.   Description
002500101229      *-------------------------------------------------------------------
002600101229      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700101229      *
002800101229      *
002900101229      ********************************************************************
003000101229      *****************************************************************
003100101229      * Indicator Usage:                                              *
003200101229      * Ind      Use                                                  *
003300101229      * 01-24    Function keys                                        *
003400101229      * 25       Rollup                                               *
003500101229      * 30-34    Subfile keywords                                     *
003600101229      * 36       Position to                                          *
003700101229      * 37       Error indicator                                      *
003800101229      * 40       Search field change                                  *
003900101229      * 41-42    Search field display                                 *
004000101229      * 61       Subfile option error                                 *
004100101229      * 80-89    Reserved for Security                                *
004200101229      * 90-99    Hit/Miss                                             *
004300101229      *****************************************************************
004400101229      *****************************************************************
004500101229      * Field Definitions                                             *
004600101229      *                                                               *
004700101229      * Prefix                                                        *
004800101229      * WW     - Program described work fields                        *
004900101229      * WI     - APPL *ENTRY input parameters                         *
005000101229      * WS     - Subfile fields                                       *
005100101229      * WC     - Subfile control fields                               *
005200101229      * HD     - Hidden fields                                        *
005300101229      * Ax     - APPx output parameters for called programs           *
005400101229      * DS     - Data structure fields                                *
005500101229      *                                                               *
005600101229      *                                                               *
005700101229      * Display Record Format Definitions                             *
005800101229      *                                                               *
005900101229      * Prefix                                                        *
006000101229      * SCRNS  - Subfile                                              *
006100101229      * SCRNC  - Subfile control                                      *
006200101229      * SCRNK  - Command key                                          *
006300101229      * SCRNR  - Standard display                                     *
006400101229      * WNDWB  - Window border                                        *
006500101229      * WNDWR  - Standard window display                              *
006600101229      * MSGCTL - Message subfile control                              *
006700101229      *                                                               *
006800101229      *                                                               *
006900101229      * Called programs                                               *
007000101229      *                                                               *
007100101229      * ERMSG2 - Clear program message queue                        *
007200101229      * ERMSG1 - Send program message with message data             *
007300101229      * XXX0101R - Maintenance program                                *
007400101229      *                                                               *
007500101229      *                                                               *
007600101229      *****************************************************************
007700101229      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007800101229      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007900101229      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
008000101229      *
008100101229     FMNU0040D  CF   E             WORKSTN
008200101229     F                                     SFILE(SCRNS01:RRN1)
008300101229     F                                     INFDS(INFDS)
008400101229     Fmnuoptm   IF   E           K DISK
008500101229      *
008600101229      * Option authorization:
008700101229     D OPT             S              1    DIM(12) CTDATA PERRCD(1)
008800101229     D INMD            S             12    DIM(12) ALT(OPT)
008900101229      *
009000101229      *
009100101229      *
009200101229      * Max number of 'position to':
009300101229     D WW#POS          C                   CONST(01)
009400101229      *
009500101229      * Number of records to fill S/F page:
009600120521     D WWPGSZ          C                   CONST(12)
009700101229      *
009800101229      * General constants:
009900101229     D LOAD            C                   CONST('LOAD')
010000101229     D ERROR           C                   CONST('ERROR')
010100101229     D INUSE           C                   CONST('INUSE')
010200101229     D SELECT          C                   CONST('SELECT')
010300101229     D ADD             C                   CONST('ADD')
010400101229     D CHANGE          C                   CONST('CHANGE')
010500101229     D COPY            C                   CONST('COPY')
010600101229     D DELETE          C                   CONST('DELETE')
010700101229     D DISPLY          C                   CONST('DISPLY')
010800101229     D WRKWTH          C                   CONST('WRKWTH')
010900101229     D PGMNAM          C                   CONST('MNU0040R  ')
011000101229     D NO              C                   CONST('N')
011100101229     D YES             C                   CONST('Y')
011200101229      *
011300101229     D jld           E DS                  EXTNAME(dsjld)
011400101229      *
011500101229      * Incoming parms:
011600101229     D APPL            DS           512
011700101229     D  WISEC                  1      5
011800101229     D  WISEL                  6      6
011900101229     D  WIVIEW                 7      8  0
012000101229     D  WIopt                  9     18
012100101229      *
012200101229      * Calling parms for MNU0041R:
012300101229     D APP2            DS           512
012400101229     D  A2SEC                  1      5
012500101229     D  A2IUSE                 6     15
012600101229     D  A2INLR                16     16
012700101229     D  A2ACTN                17     26
012800101229     D  A2OPT                 27     36
012900101229      *
013000101229      * Parm to hold message data:
013100101229     D DSMDTA          DS           500
013200101229      *
013300101229      * Split option indicator and action code:
013400101229     D DSSPLT          DS            12
013500101229     D  ZZ                     1      2  0
013600101229     D  DSACTN                 3     12
013700101229      *
013800101229     D INFDS           DS
013900101229     D  SFLLOC               378    379B 0
014000101229      *
014100101229     D                SDS
014200101229     D  DSPGMN           *PROC
014300101229     D  DSUSER               254    263
014400101229      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014500101229      *M                 M  A  I  N  L  I  N  E                       M
014600101229      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014700101229      *
014800101229      *
014900101229      * Main loop:
015000101229      *
015100101229     C     *IN03         DOUEQ     *ON
015200101229      *
015300101229      * Reload subfile, if requested:
015400101229      *
015500101229     C     WWLOAD        IFEQ      YES
015600101229     C                   EXSR      $INSFL
015700101229     C                   MOVE      NO            WWLOAD
015800101229     C                   END
015900101229      *
016000101229      * Display screen:
016100101229      *
016200101229     C                   WRITE     MSGCTL1
016300101229     C                   WRITE     SCRNK01
016400101229      *
016500101229     C     *IN32         IFEQ      *OFF
016600101229     C                   WRITE     SCRNR01
016700101229     C                   END
016800101229      *
016900101229     C                   EXFMT     SCRNC01
017000101229     C                   MOVE      THEFLD        *IN69
017100101229      *
017200101229     C     WWFRST        IFEQ      YES
017300101229     C                   MOVE      NO            WWFRST
017400101229     C                   END
017500101229      *
017600101229     C                   MOVE      SFLLOC        HDSFLP
017700101229      *
017800101229      * Clear messages:
017900101229      *
018000101229     C                   CALL      'ERMSG2'
018100101229     C                   Parm                    DSPGMN
018200101229      *
018300101229      * Set off all error indicators here:
018400101229      *
018500101229     C                   MOVE      *OFF          *IN36
018600101229     C                   MOVE      *OFF          *IN38
018700101229     C                   MOVE      *OFF          *IN71
018800101229      *
018900101229     C     *IN03         IFEQ      *OFF
019000101229      *
019100101229      * Process command keys:
019200101229      *
019300101229     C                   SELECT
019400101229      *
019500101229      *
019600101229      * F4 = Prompt:
019700101229      *
019800101229     C     *IN04         WHENEQ    *ON
019900101229     C                   EXSR      $PRMPT
020000101229     C                   EXSR      $INSFL
020100101229      *
020200101229      * F10 = Position to:
020300101229      *
020400101229     C     *IN10         WHENEQ    *ON
020500101229     C                   EXSR      $POSTO
020600101229      *
020700101229      * F5 or 'position to' field value change (*IN40) - reload S/F:
020800101229      *
020900101229     C     *IN05         WHENEQ    *ON
021000101229     C     *IN40         OREQ      *ON
021100101229     C                   EXSR      $INSFL
021200101229      *
021300101229      * Rollup (if records exist in S/F - *IN32):
021400101229      *
021500101229     C     *IN25         WHENEQ    *ON
021600101229     C     *IN32         ANDEQ     *ON
021700101229     C                   EXSR      $LDSFL
021800101229      *
021900101229      * F6 = Add a record:
022000101229      *
022100101229     C                   WHEN      *in06 = *on
022200101229     c                   EXSR      $ADDRC
022300101229      *
022400101229      * F12= Cancel
022500101229      *
022600101229     C     *IN12         WHENEQ    *ON
022700101229     C                   Eval      *in03=*on
022800101229      *
022900101229     C                   OTHER
023000101229      *
023100101229      * Enter:
023200101229      *
023300101229     C                   EXSR      $READC
023400101229      *
023500101229     C                   ENDSL
023600101229      *
023700101229     C                   END
023800101229      *
023900101229     C                   ENDDO
024000101229      *
024100101229      * Close called programs:
024200101229      *
024300101229     C                   MOVE      YES           A2INLR
024400101229      *
024500101229      * End the maintenance program:
024600101229      *
024700101229     C                   CALL      'MNU0041R'
024800101229     C                   PARM                    jld
024900101229     C                   PARM                    APP2
025000101229      *
025100101229     C                   MOVE      *ON           *INLR
025200101229      *
025300101229      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025400101229      *$              S  U  B  R  O  U  T  I  N  E  S                 $
025500101229      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025600101229      *
025700101229      **************
025800101229      **  $INSFL  ** - Initialize Subfile
025900101229      **************
026000101229     C     $INSFL        BEGSR
026100101229      *
026200101229     C                   CLEAR                   RRN1
026300101229     C                   Z-ADD     1             HDSFLP
026400101229     C                   MOVE      NO            WWNFND
026500101229      *
026600101229      * Clear subfile:
026700101229      *
026800101229     C     *IN32         IFEQ      *ON
026900101229     C                   MOVE      *OFF          *IN32
027000101229     C                   MOVE      *ON           *IN30
027100101229     C                   WRITE     SCRNC01
027200101229     C                   MOVE      *OFF          *IN30
027300101229     C                   END
027400101229      *
027500101229      * Check for subfile control errors:
027600101229      *
027700101229     C     WWFRST        CASEQ     NO            $ERR01
027800101229     C                   ENDCS
027900101229      *
028000101229      * Position file:
028100101229      *
028200101229      ****************************************************************
028300101229      * WHSXXX - Logical file based on current 'position to' view.
028400101229      *  eg; physical file is INVMF and current 'position to' is
028500101229      *      by style number, WHSXXX = INVMF (key = style #).
028600101229      *
028700101229      *
028800101229      * XXXK01 - Key list based on current 'position to' fields.
028900101229      *  eg; if 'position to' field is item number:
029000101229      *          XXXK01 = INVK01  KLIST
029100101229      *                           KFLD      WCITM#
029200101229      ****************************************************************
029300101229      *
029400101229     C                   SELECT
029500101229      *
029600101229     C     WWCPOS        WHENEQ    1
029700101229     C     mok01         SETLL     mnuoptm                                99
029800101229     C     *IN99         IFEQ      *OFF
029900101229     C                   MOVE      YES           WWNFND
030000101229     C                   END
030100101229      *
030200101229     C*    WWCPOS        WHENEQ    2
030300101229     C*    XXXK01        SETLL     WHSXXXX                                99
030400101229     C*    *IN99         IFEQ      *OFF
030500101229     C*                  MOVE      YES           WWNFND
030600101229     C*                  END
030700101229      *
030800101229     C                   ENDSL
030900101229      *
031000101229      * Load subfile:
031100101229      *
031200101229     C                   EXSR      $LDSFL
031300101229      *
031400101229      * Send message if search criteria is not found:
031500101229      *
031600101229     C     WWNFND        IFEQ      YES
031700101229     C     *IN40         IFEQ      *ON
031800101229     C     *IN04         OREQ      *ON
031900101229     C                   MOVEL     'SHL0006'     WWMSGI
032000101229     C                   CALL      'ERMSG1'      MSGP01
032100101229     C                   END
032200101229     C                   END
032300101229      *
032400101229     C                   ENDSR
032500101229      *
032600101229      **************
032700101229      **  $ERR01  ** - Control Screen Validity Checking
032800101229      **************
032900101229     C     $ERR01        BEGSR
033000101229      *
033100101229     C                   CLEAR                   WWERR1
033200101229      *
033300101229      *****************************************************************
033400101229      * All error conditions must have the following lines of code:
033500101229      *
033600101229      *   MOVE *ON       *INXX
033700101229      *     Where *INXX = field error indicator in DDS.
033800101229      *
033900101229      *   MOVELERROR     WWERR1
034000101229      *     Program error flag.
034100101229      *
034200101229      *   MOVEL'XXX0001' WWMSGI
034300101229      *     Where XXX0001 = error message id to be displayed.
034400101229      *
034500101229      *   MOVELXXXXXX    WWMSGF
034600101229      *     Where XXXXXX = name of the message file which contains
034700101229      *     the message id contained in field WWMSGI.
034800101229      *
034900101229      *   CALL 'ERMSG1'  MSGP01
035000101229      *     Message handling program.
035100101229      *****************************************************************
035200101229      *
035300101229      * Field 1:
035400101229     C     *IN41         IFEQ      *ON
035500101229     C     WCopt         ANDNE     *blanks
035600101229     C     mok01         SETLL     mnuoptm                                99
035700101229     C     *IN99         IFEQ      *OFF
035800101229     C                   MOVE      *ON           *IN36
035900101229     C                   MOVEL     ERROR         WWERR1
036000101229     C                   MOVEL     'SHL0006'     WWMSGI
036100101229     C                   CALL      'ERMSG1'      MSGP01
036200101229     C                   END
036300101229     C                   END
036400101229      *
036500101229     C*    *IN42         IFEQ      *ON
036600101229     C*    WCXXX1        ANDNE     *ZERO
036700101229     C*    XXXK01        SETLL     WHSXXXX                                99
036800101229     C*    *IN99         IFEQ      *OFF
036900101229     C*                  MOVE      *ON           *IN36
037000101229     C*                  MOVEL     ERROR         WWERR1
037100101229     C*                  MOVEL     'SHL0006'     WWMSGI
037200101229     C*                  CALL      'ERMSG1'      MSGP01
037300101229     C*                  END
037400101229     C*                  END
037500101229      *
037600101229     C                   ENDSR
037700101229      *
037800101229      **************
037900101229      **  $LDSFL  ** - Load Subfile
038000101229      **************
038100101229     C     $LDSFL        BEGSR
038200101229      *
038300101229     C                   CLEAR                   WWCNT1
038400101229      *
038500101229     C                   MOVE      *OFF          *IN34
038600101229      *
038700101229      * Load one page at a time:
038800101229      *
038900101229     C     WWCNT1        DOWLT     WWPGSZ
039000101229     C     *IN34         ANDEQ     *OFF
039100101229      *****************************************************************
039200101229      *
039300101229     C                   SELECT
039400101229      *
039500101229      * Read from file, based on current 'position to' view:
039600101229      *
039700101229     C     WWCPOS        WHENEQ    1
039800101229     C                   READ      MNUOPTM                                34
039900101229      *
040000101229     C     WWCPOS        WHENEQ    2
040100101229     C                   READ      MNUOPTM                                34
040200101229      *
040300101229     C                   ENDSL
040400101229      *
040500101229     C     *IN34         IFEQ      *OFF
040600101229      *
040700101229     C                   CLEAR                   WSOPT#
040800101229     C                   MOVE      *OFF          *IN61
040900101229      *
041000101229      * Load subfile fields here:
041100101229      *
041200101229      *
041300101229     C                   MOVE      moopt         WSopt
041400101229     C                   MOVE      modesc        WSdesc
041500101231     C                   If        mocmd = *blanks
041600101231     c                   Eval      *in62 = *on
041700101231     c                   Else
041800101231     c                   Eval      *in62 = *off
041900101231     c                   Endif
042000101229     C                   MOVE      mocmd         WScmd
042100101229     C                   MOVE      moprompt      WSprompt
042200101229     C                   MOVE      moseclvl      WSseclvl
042300101229      *
042400101229     C                   ADD       1             RRN1
042500101229     C                   ADD       1             WWCNT1
042600101229      *
042700101229     C     WWCNT1        IFEQ      1
042800101229     C                   Z-ADD     RRN1          HDSFLP
042900101229     C                   END
043000101229      *
043100101229     C                   WRITE     SCRNS01
043200101229      *
043300101229     C                   END
043400101229      *
043500101229     C                   ENDDO
043600101229      *
043700101229     C     RRN1          IFGT      *ZERO
043800101229     C                   MOVE      *ON           *IN32
043900101229     C                   END
044000101229      *
044100101229     C                   MOVE      *OFF          *IN25
044200101229      *
044300101229     C                   ENDSR
044400101229      *
044500101229      **************
044600101229      **  $PRMPT  ** - Process Promptable Fields
044700101229      **************
044800101229     C     $PRMPT        BEGSR
044900101229      *
045000101229      *****************************************************************
045100101229      *  Field HDCSRF (defined in DDS) contains the field name which
045200101229      *  contains the cursor. If valid, a prompting program may be
045300101229      *  called to select a record from a list of valid values for
045400101229      *  the prompted field. The value selected should then be placed
045500101229      *  in the field which was prompted.
045600101229      *
045700101229      * eg; HDCSRF    WHEQ 'WCXXX1'
045800101229      *      Cursor resides in field WCXXX1
045900101229      *
046000101229      *     CALL 'GEN0109R'
046100101229      *      Codes file prompting program.
046200101229      *
046300101229      *     PARM '653'     WWCTAB
046400101229      *      Outgoing parm.
046500101229      *
046600101229      *     PARM *BLANKS   WWCKEY
046700101229      *      Return parm.
046800101229      *
046900101229      *     MOVELWWCKEY    WCXXX1
047000101229      *      Move return parm into prompted field.
047100101229      *
047200101229      *****************************************************************
047300101229      *
047400101229     C                   SELECT
047500101229      *
047600101229     C*    HDCSRF        WHENEQ    'WCXXX1'
047700101229     C*                  CALL      'GEN0109R'
047800101229     C*                  PARM      '653'         WWCTAB
047900101229     C*                  PARM      *BLANKS       WWCKEY
048000101229     C*                  MOVEL     WWCKEY        WCXXX1
048100101229      *
048200101229     C*    HDCSRF        WHENEQ    'WCXXX2'
048300101229     C*                  CALL      'GEN0109R'
048400101229     C*                  PARM      '654'         WWCTAB
048500101229     C*                  PARM      *BLANKS       WWCKEY
048600101229     C*                  MOVEL     WWCKEY        WCXXX2
048700101229      *
048800101229      * Non propmtable area:
048900101229      *
049000101229     C                   OTHER
049100101229      *
049200101229     C                   MOVEL     'SHL0004'     WWMSGI
049300101229     C                   CALL      'ERMSG1'      MSGP01
049400101229      *
049500101229     C                   ENDSL
049600101229      *
049700101229     C                   ENDSR
049800101229      *
049900101229      **************
050000101229      **  $POSTO  ** - Position To
050100101229      **************
050200101229     C     $POSTO        BEGSR
050300101229      *
050400101229      * Clear all 'position to' fields here:
050500101229      *
050600101229     C                   CLEAR                   WCopt
050700101229      *
050800101229     C                   CLEAR                   RRN1
050900101229     C                   CLEAR                   HDSFLP
051000101229      *
051100101229      * Clear subfile:
051200101229      *
051300101229     C     *IN32         IFEQ      *ON
051400101229     C                   MOVE      *OFF          *IN32
051500101229     C                   MOVE      *ON           *IN30
051600101229     C                   WRITE     SCRNC01
051700101229     C                   MOVE      *OFF          *IN30
051800101229     C                   END
051900101229      *
052000101229      * Position cursor:
052100101229      *
052200101229     C                   MOVE      *ON           *IN36
052300101229      *
052400101229      * Toggle to next 'position to' field:
052500101229      *
052600101229     C     WWCPOS        ADD       1             WWCPOS
052700101229      *
052800101229     C     WWCPOS        IFGT      WW#POS
052900101229     C                   Z-ADD     1             WWCPOS
053000101229     C                   END
053100101229      *
053200101229      *****************************************************************
053300101229      * When a 'position to' view is changed, the new display
053400101229      * indicator (from DDS) must be set on and all other 'position to'
053500101229      * display indicators must be turned off.
053600101229      *
053700101229      *  eg; 'position to' #1 by agency (display indicator *IN41)
053800101229      *      'position to' #2 by agency/chain (display indicator *IN42)
053900101229      *
054000101229      *  If user toggles to 'position to' by agency/chain, indicator
054100101229      *  *IN41 must be turned off and *IN42 turned on.
054200101229      *
054300101229      *      MOVEA'01'      *IN,41
054400101229      *****************************************************************
054500101229      *
054600101229      * Set 'position to' field display indicator:
054700101229      *
054800101229     C                   SELECT
054900101229      *
055000101229     C     WWCPOS        WHENEQ    1
055100101229     C                   MOVEA     '10'          *IN(41)
055200101229      *
055300101229     C     WWCPOS        WHENEQ    2
055400101229     C                   MOVEA     '01'          *IN(41)
055500101229      *
055600101229     C                   ENDSL
055700101229      *
055800101229     C                   ENDSR
055900101229      *
056000101229      **************
056100101229      **  $ADDRC  ** - Add a record
056200101229      **************
056300101229     C     $ADDRC        BEGSR
056400101229      *
056500101229      *****************************************************************
056600101229      * Parms required to be passed to the maintenance program:
056700101229      *   1. WISEC = program level security.
056800101229      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
056900101229      *
057000101229      *****************************************************************
057100101229      *
057200101229     C                   MOVE      YES           WWLOAD
057300101229      *
057400101229     C                   CLEAR                   APP2
057500101229     C                   MOVEL     WISEC         A2SEC
057600101229     C                   MOVEL     ADD           A2ACTN
057700101229      *
057800101229      * Move key fields to maintenance program for record access:
057900101229      *
058000101229     C*                  MOVE      WCopt         A2opt
058100101229      *
058200101229      * Call maintenance program:
058300101229      *
058400101229     C                   CALL      'MNU0041R'
058500101229     C                   PARM                    jld
058600101229     C                   PARM                    APP2
058700101229      *
058800101229      *****************************************************************
058900101229      * When returning from the maintenance program, this program will
059000101229      * automatically position the subfile list to the last record
059100101229      * added to the file. To do this, the maintenance program must
059200101229      * return all 'position to' field values to this program.
059300101229      *
059400101229      *   eg; 'position to' #1 = Item Number
059500101229      *       'position to' #2 = Item Type Code
059600101229      *
059700101229      *
059800101229      *  Using this example, when a record is added to the file, the
059900101229      *  maintenance program will return the values of all of the above
060000101229      *  'position to' fields (Item Number, Item Type Code).
060100101229      *  The subfile list will then automatically be positioned based
060200101229      *  on the current 'position to' view.
060300101229      *
060400101229      *****************************************************************
060500101229      *
060600101229      * Move key fields from maint pgm to 'position to' fields:
060700101229      *
060800101229     C                   MOVE      A2opt         WCopt
060900101229      *
061000101229     C                   MOVEL     WRRCDE        WWRCDE
061100101229      *
061200101229     C                   ENDSR
061300101229      *
061400101229      **************
061500101229      **  $READC  ** - Process Subfile Requests
061600101229      **************
061700101229     C     $READC        BEGSR
061800101229      *
061900101229     C                   CLEAR                   WWERR2
062000101229     C                   CLEAR                   WWRCDE
062100101229     C                   CLEAR                   WWRRN#
062200101229      *
062300101229      * Save current RRN:
062400101229      *
062500101229     C                   Z-ADD     RRN1          WWCRRN
062600101229      *
062700101229      * Read all records in the S/F:
062800101229      *
062900101229     C     WWRRN#        DOWLT     WWCRRN
063000101229     C     WWERR2        ANDNE     ERROR
063100101229     C     WWRCDE        ANDNE     INUSE
063200101229     C     *IN03         ANDEQ     *OFF
063300101229      *
063400101229     C                   ADD       1             WWRRN#
063500101229      *
063600101229     C     WWRRN#        CHAIN     SCRNS01                            99
063700101229     C     *IN99         IFEQ      *OFF
063800101229      *
063900101229     C                   MOVE      *OFF          *IN61
064000101229      *
064100101229      * Option number was entered:
064200101229      *
064300101229     C     WSOPT#        IFNE      *BLANKS
064400101229      *
064500101229      * Check for subfile option errors:
064600101229      *
064700101229     C                   EXSR      $ERR02
064800101229      *
064900101229     C                   Z-ADD     RRN1          HDSFLP
065000101229      *
065100101229      * Error occurred, return to mainline:
065200101229      *
065300101229     C     WWERR2        IFEQ      ERROR
065400101229     C                   MOVE      *ON           *IN61
065500101229     C                   UPDATE    SCRNS01
065600101229     C                   ELSE
065700101229      *
065800101229      *****************************************************************
065900101229      * If this program is called as a record selection program
066000101229      * (WISEL = 'Y'), return the desired field(s) to the calling
066100101229      * program through the APPL parm list.
066200101229      *
066300101229      *   eg; Call this program to retrieve a chain code.
066400101229      *
066500101229      *     DSACTN    IFEQ SELECT
066600101229      *       Record has been selected.
066700101229      *
066800101229      *               MOVE WSCHN     WICHN
066900101229      *                 Move the chain code from the S/F to the APPL
067000101229      *                 parm WICHN.
067100101229      *
067200101229      *               MOVE *ON       *IN03
067300101229      *                 End this program.
067400101229      *
067500101229      *****************************************************************
067600101229      * If select, return the key fields and end program:
067700101229      *
067800101229     C     DSACTN        IFEQ      SELECT
067900101229     C                   MOVE      WSopt         WIopt
068000101229     C                   MOVE      *ON           *IN03
068100101229     C                   ELSE
068200101229      *
068300101229      *****************************************************************
068400101229      * If Work with, call new work with program.
068500101229      *
068600101229     C     DSACTN        IFEQ      WRKWTH
068700101230     C                   Call      'MNU0050R'
068800101230     C                   Parm                    wsopt
068900101229     C                   Else
069000101229      *
069100101229      *****************************************************************
069200101229      * Parms required to be passed to the maintenance program:
069300101229      *   1. WISEC = program level security.
069400101229      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
069500101229      *   3. The key of the record to be maintained.
069600101229      *
069700101229      *****************************************************************
069800101229      *
069900101229      * Call maintenance program:
070000101229      *
070100101229     C                   CLEAR                   APP2
070200101229     C                   MOVEL     WISEC         A2SEC
070300101229     C                   MOVEL     DSACTN        A2ACTN
070400101229      *
070500101229      * Move key fields to maintenance program for record access:
070600101229      *
070700101229     C                   MOVE      WSopt         A2opt
070800101229      *
070900101229     C                   CALL      'MNU0041R'
071000101229     C                   PARM                    jld
071100101229     C                   PARM                    APP2
071200101229      *
071300101229      *****************************************************************
071400101229      * When returning from the maintenance program, this program will
071500101229      * automatically position the subfile list to the last record
071600101229      * processed. To do this, the maintenance program must return all
071700101229      * 'position to' field values to this program.
071800101229      *
071900101229      *   eg; 'position to' #1 = Item Number
072000101229      *       'position to' #2 = Item Type Code
072100101229      *
072200101229      *  Using this example, when a record is maintained, the
072300101229      *  maintenance program will return the values of all of the above
072400101229      *  'position to' fields (item number, item type code).
072500101229      *  The subfile list will then automatically be positioned based
072600101229      *  on the current 'position to' view.
072700101229      *
072800101229      *****************************************************************
072900101229      *
073000101229      * Move key fields from maint pgm to 'position to' fields:
073100101229      *
073200101229     C                   MOVE      A2opt         WCopt
073300101229      *
073400101229     C                   MOVE      YES           WWLOAD
073500101229      *
073600101229     C                   MOVEL     WRRCDE        WWRCDE
073700101229      *
073800101229      * If record lock, send record in use message:
073900101229      *
074000101229     C     WWRCDE        IFEQ      INUSE
074100101229     C                   MOVEL     'SHL0007'     WWMSGI
074200101229     C     A2IUSE        CAT       DSMDTA        DSMDTA
074300101229     C                   CALL      'ERMSG1'      MSGP01
074400101229     C                   CLEAR                   DSMDTA
074500101229     C                   MOVE      NO            WWLOAD
074600101229     C                   END
074700101229      *
074800101229     C                   ENDIF
074900101229      *
075000101229     C                   CLEAR                   WSOPT#
075100101229     C                   UPDATE    SCRNS01
075200101229      *
075300101229     C                   END
075400101229     C                   END
075500101229     C                   END
075600101229     C                   END
075700101229      *
075800101229     C                   ENDDO
075900101229      *
076000101229      * Reset current RRN:
076100101229      *
076200101229     C                   Z-ADD     WWCRRN        RRN1
076300101229      *
076400101229     C                   CLEAR                   WWRCDE
076500101229      *
076600101229     C                   ENDSR
076700101229      *
076800101229      **************
076900101229      **  $ERR02  ** - Subfile Validity Checking
077000101229      **************
077100101229     C     $ERR02        BEGSR
077200101229      *
077300101229      * Check for valid option:
077400101229      *
077500101229     C                   Z-ADD     1             X
077600101229     C     WSOPT#        LOOKUP    OPT(X)                                 90
077700101229     C     *IN90         IFEQ      *ON
077800101229     C                   MOVEL     INMD(X)       DSSPLT
077900101229     C                   ELSE
078000101229     C                   CLEAR                   DSSPLT
078100101229     C                   END
078200101229      *
078300101229     C                   SELECT
078400101229      *
078500101229      * If indicator 90 is off, option number is not valid.
078600101229      * If indicator ZZ is off, user is not authorized to option.
078700101229      *
078800101229     C     *IN90         WHENEQ    *OFF
078900101229     C     *IN(ZZ)       OREQ      *OFF
079000101229     C                   MOVEL     'SHL0008'     WWMSGI
079100101229     C                   CALL      'ERMSG1'      MSGP01
079200101229     C                   MOVEL     ERROR         WWERR2
079300101229      *
079400101229     C                   ENDSL
079500101229      *
079600101229     C                   ENDSR
079700101229      *
079800101229      **************
079900101229      **  *INZSR  ** - Initialize Program
080000101229      **************
080100101229     C     *INZSR        BEGSR
080200101229      *
080300101229      * Incoming parm list:
080400101229      *
080500101229     C     *ENTRY        PLIST
080600101229     C                   PARM                    jld
080700101229     C                   PARM                    APPL
080800101229      *
080900101229      * Message file parm list:
081000101229      *
081100101229     C     MSGP01        PLIST
081200101229     C                   PARM                    WWMSGI            7
081300101229      *
081400101229      * Key lists:
081500101229      *
081600101229     C     CODK01        KLIST
081700101229     C                   KFLD                    WWCTAB
081800101229     C                   KFLD                    WWCKEY
081900101229      *
082000101229     C     mok01         KLIST
082100101229     C                   KFLD                    WCopt
082200101229      *
082300101229      * Field definitions:
082400101229      *
082500101229     C     *LIKE         DEFINE    HDSFLP        RRN1
082600101229     C     *LIKE         DEFINE    HDSFLP        WWRRN#
082700101229     C     *LIKE         DEFINE    HDSFLP        WWCRRN
082800101229      *
082900101229      * Initialize:
083000101229      *
083100101229     C                   MOVE      *ZEROS        WWCNT1            2 0
083200101229     C                   MOVE      01            WWCPOS            2 0
083300101229     C                   MOVE      *BLANKS       WWCTAB            3
083400101229     C                   MOVE      *BLANKS       WWCKEY           27
083500101229     C                   MOVE      *BLANKS       WWNFND            1
083600101229     C                   MOVE      YES           WWFRST            1
083700101229     C                   MOVE      YES           WWLOAD            1
083800101229     C                   MOVE      *BLANKS       WWERR1           10
083900101229     C                   MOVE      *BLANKS       WWERR2           10
084000101229     C                   MOVE      *BLANKS       WWERR3            1
084100101229     C                   MOVE      *BLANKS       WWRCDE           10
084200101229     C                   MOVE      *ZEROS        X                 2 0
084300101229      *
084400101229      * Load the program name defined in security file PGMSEC.
084500101229      * This name must be defined in the constant 'PGMNAM'.
084600101229      *
084700101229     C                   MOVEL     PGMNAM        WWPGM            10
084800101229      *
084900101229      * Clear message subfile:
085000101229      *
085100101229     C                   CALL      'ERMSG2'
085200101229     C                   Parm                    dspgmn
085300101229      *
085400101229      * Fill default screen values:
085500101229      *
085600101229      *
085700101229      *
085800101229      * Default to the first 'position to' view if value not passed
085900101229      * to this program:
086000101229      *
086100101229     C     WIVIEW        IFEQ      *ZERO
086200101229     C                   Z-ADD     1             WWCPOS            2 0
086300101229     C                   ELSE
086400101229     C                   Z-ADD     WIVIEW        WWCPOS
086500101229     C                   MOVE      *ON           *IN40
086600101229     C                   END
086700101229      *
086800101229      * Set initial 'position to' display indicator. Also load
086900101229      * 'position to' values passed to this program (WIXXX1,2), if
087000101229      * applicable:
087100101229      *
087200101229     C                   SELECT
087300101229      *
087400101229     C     WWCPOS        WHENEQ    1
087500101229     C                   MOVE      *ON           *IN41
087600101229     C                   MOVE      WIopt         WCopt
087700101229      *
087800101229     C*    WWCPOS        WHENEQ    2
087900101229     C*                  MOVE      *ON           *IN42
088000101229     C*                  MOVE      WIXXX2        WCXXX2
088100101229      *
088200101229     C                   ENDSL
088300101229      *****************************************************************
088400101229      * Field WISEC is a 5 byte logical indicator field used to control
088500101229      * user access to all maintenance functions (eg; change, delete).
088600101229      * Each byte will have a value of either '0'(not authorized) or
088700101229      * '1'(authorized). This field will be moved into indicator
088800101229      * array *IN,81.
088900101229      *
089000101229      *
089100101229      *  WISEC = '00000'                  *IN81 = Add/Copy
089200101229      *           |||||___ Work With      *IN82 = Change
089300101229      *         Add|||     (Extra)        *IN83 = Delete
089400101229      *            |||                    *IN84 = Display
089500101229      *       Change||                    *IN85 = Work With
089600101229      *             ||
089700101229      *        Delete|
089800101229      *              |
089900101229      *        Display
090000101229      *
090100101229      *****************************************************************
090200101229      *
090300101229      * Set up security options:
090400101229      *
090500101229     C     WISEC         IFEQ      *BLANKS
090600101229     C                   CALL      'SEC0100R'
090700101229     C                   PARM                    WWPGM
090800101229     C                   PARM                    WISEC
090900101229     C                   END
091000101229      *
091100101229      * User not setup in security file:
091200101229      *
091300101229     C     WISEC         IFEQ      '99999'
091400101229     C                   MOVE      '00000'       WISEC
091500101229     C                   MOVE      NO            WWLOAD
091600101229     C                   MOVEL     'SHL0009'     WWMSGI
091700101229     C                   CALL      'ERMSG1'      MSGP01
091800101229      *
091900101229     C                   ELSE
092000101229      *
092100101229      * Clear messages:
092200101229      *
092300101229     C                   CALL      'ERMSG2'
092400101229     C                   Parm                    dspgmn
092500101229     C                   MOVEA     WISEC         *IN(81)
092600101229      *
092700101229      * If program is called to select a record, turn off all
092800101229      * maintenance functions:
092900101229      *
093000101229     C     WISEL         IFEQ      YES
093100101229     C                   MOVE      *ON           *IN86
093200101229     C                   MOVEA     '00010'       *IN(81)
093300101229     C                   END
093400101229      *
093500101229     C                   END
093600101229      *
093700101229      *****************************************************************
093800101229      * All users are authorized to any *IN89 option from table OPT:
093900101229      *
094000101229      *        Option Named
094100101229      *            Constant
094200101229      *              |    |
094300101229      * Authorization|    |
094400101229      *     Indicator|    |
094500101229      *            |||    |
094600101229      *      Option|||    |
094700101229      *          |||||    |
094800101229      *   eg ;    282CHANGE
094900101229      *          2 82CHANGE
095000101229      *           789ITMINQ
095100101229      *          7 89ITMINQ
095200101229      *           989POINQ
095300101229      *          9 89POINQ
095400101229      *
095500101229      *  In this example, option 2 to change a record is available
095600101229      *  only to users which have authorization (*IN82). option 7 to
095700101229      *  view the item inquiry and option 9 to view the PO inquiry are
095800101229      *  setup in the table with indicator *IN89, therefore will be
095900101229      *  available to all users, without restriction.
096000101229      *
096100101229      *****************************************************************
096200101229      *
096300101229     C                   MOVE      *ON           *IN89
096400101229      *
096500101230     C                   MOVE      *ON           *IN36
096600101229      *
096700101230     C                   MOVE      *ON           *IN69
096800101229     C                   ENDSR
096900101229**
097000101229186SELECT
097100101229282CHANGE
097200101229381COPY
097300101229483DELETE
097400101229584DISPLY
097500101229985WRKWTH
