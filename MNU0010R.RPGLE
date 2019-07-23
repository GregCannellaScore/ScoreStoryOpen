000100101228      /copy qcpylesrc,stdhspec
000200101228      ********************************************************************
000300101228      *
000400101228      *  Program: MNU0010R
000500101228      *
000600101228      *  Description: Maintain menu system parameters and users
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
008100101228     FMNU0010D  CF   E             WORKSTN
008200101228     F                                     SFILE(SCRNS01:RRN1)
008300101228     F                                     INFDS(INFDS)
008400101228     Fmnuusrm   IF   E           K DISK
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
010900101228     D PGMNAM          C                   CONST('MNU0010R  ')
011000101228     D NO              C                   CONST('N')
011100101228     D YES             C                   CONST('Y')
011200101228      *
011300101228     D jld           E DS                  EXTNAME(dsjld)
011400101228      *
011500101228      * Incoming parms:
011600101228     D APPL            DS           512
011700101228     D  WISEC                  1      5
011800101228     D  WISEL                  6      6
011900101228     D  WIVIEW                 7      8  0
012000101228     D  WIuser                 9     18
012100101228      *
012200101228      * Calling parms for MNU0011R:
012300101228     D APP2            DS           512
012400101228     D  A2SEC                  1      5
012500101228     D  A2IUSE                 6     15
012600101228     D  A2INLR                16     16
012700101228     D  A2ACTN                17     26
012800101228     D  A2user                27     36
012900101228      *
013000101228      * Parm to hold message data:
013100101228     D DSMDTA          DS           500
013200101228      *
013300101228      * Split option indicator and action code:
013400101228     D DSSPLT          DS            12
013500101228     D  ZZ                     1      2  0
013600101228     D  DSACTN                 3     12
013700101228      *
013800101228     D INFDS           DS
013900101228     D  SFLLOC               378    379B 0
014000101228      *
014100101228     D                SDS
014200101228     D  DSPGMN           *PROC
014300101228     D  DSUSER               254    263
014400101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014500101228      *M                 M  A  I  N  L  I  N  E                       M
014600101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014700101228      *
014800101228      *
014900101228      * Main loop:
015000101228      *
015100101228     C     *IN03         DOUEQ     *ON
015200101228      *
015300101228      * Reload subfile, if requested:
015400101228      *
015500101228     C     WWLOAD        IFEQ      YES
015600101228     C                   EXSR      $INSFL
015700101228     C                   MOVE      NO            WWLOAD
015800101228     C                   END
015900101228      *
016000101228      * Display screen:
016100101228      *
016200101228     C                   WRITE     MSGCTL1
016300101228     C                   WRITE     SCRNK01
016400101228      *
016500101228     C     *IN32         IFEQ      *OFF
016600101228     C                   WRITE     SCRNR01
016700101228     C                   END
016800101228      *
016900101228     C                   EXFMT     SCRNC01
017000101228     C                   MOVE      THEFLD        *IN69
017100101228      *
017200101228     C     WWFRST        IFEQ      YES
017300101228     C                   MOVE      NO            WWFRST
017400101228     C                   END
017500101228      *
017600101228     C                   MOVE      SFLLOC        HDSFLP
017700101228      *
017800101228      * Clear messages:
017900101228      *
018000101228     C                   CALL      'ERMSG2'
018100101228     C                   Parm                    DSPGMN
018200101228      *
018300101228      * Set off all error indicators here:
018400101228      *
018500101228     C                   MOVE      *OFF          *IN36
018600101228     C                   MOVE      *OFF          *IN38
018700101228     C                   MOVE      *OFF          *IN71
018800101228      *
018900101228     C     *IN03         IFEQ      *OFF
019000101228      *
019100101228      * Process command keys:
019200101228      *
019300101228     C                   SELECT
019400101228      *
019500101228      *
019600101228      * F4 = Prompt:
019700101228      *
019800101228     C     *IN04         WHENEQ    *ON
019900101228     C                   EXSR      $PRMPT
020000101228     C                   EXSR      $INSFL
020100101228      *
020200101228      * F10 = Position to:
020300101228      *
020400101228     C     *IN10         WHENEQ    *ON
020500101228     C                   EXSR      $POSTO
020600101228      *
020700101228      * F5 or 'position to' field value change (*IN40) - reload S/F:
020800101228      *
020900101228     C     *IN05         WHENEQ    *ON
021000101228     C     *IN40         OREQ      *ON
021100101228     C                   EXSR      $INSFL
021200101228      *
021300101228      * Rollup (if records exist in S/F - *IN32):
021400101228      *
021500101228     C     *IN25         WHENEQ    *ON
021600101228     C     *IN32         ANDEQ     *ON
021700101228     C                   EXSR      $LDSFL
021800101228      *
021900101228      * F6 = Add a record:
022000101228      *
022100101228     C                   WHEN      *in06 = *on
022200101228     c                   EXSR      $ADDRC
022300101228      *
022400101228      * F12= Cancel
022500101228      *
022600101228     C     *IN12         WHENEQ    *ON
022700101228     C                   Eval      *in03=*on
022800101228      *
022900101228     C                   OTHER
023000101228      *
023100101228      * Enter:
023200101228      *
023300101228     C                   EXSR      $READC
023400101228      *
023500101228     C                   ENDSL
023600101228      *
023700101228     C                   END
023800101228      *
023900101228     C                   ENDDO
024000101228      *
024100101228      * Close called programs:
024200101228      *
024300101228     C                   MOVE      YES           A2INLR
024400101228      *
024500101228      * End the maintenance program:
024600101228      *
024700101228     C                   CALL      'MNU0011R'
024800101228     C                   PARM                    jld
024900101228     C                   PARM                    APP2
025000101228      *
025100101228     C                   MOVE      *ON           *INLR
025200101228      *
025300101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025400101228      *$              S  U  B  R  O  U  T  I  N  E  S                 $
025500101228      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025600101228      *
025700101228      **************
025800101228      **  $INSFL  ** - Initialize Subfile
025900101228      **************
026000101228     C     $INSFL        BEGSR
026100101228      *
026200101228     C                   CLEAR                   RRN1
026300101228     C                   Z-ADD     1             HDSFLP
026400101228     C                   MOVE      NO            WWNFND
026500101228      *
026600101228      * Clear subfile:
026700101228      *
026800101228     C     *IN32         IFEQ      *ON
026900101228     C                   MOVE      *OFF          *IN32
027000101228     C                   MOVE      *ON           *IN30
027100101228     C                   WRITE     SCRNC01
027200101228     C                   MOVE      *OFF          *IN30
027300101228     C                   END
027400101228      *
027500101228      * Check for subfile control errors:
027600101228      *
027700101228     C     WWFRST        CASEQ     NO            $ERR01
027800101228     C                   ENDCS
027900101228      *
028000101228      * Position file:
028100101228      *
028200101228      ****************************************************************
028300101228      * WHSXXX - Logical file based on current 'position to' view.
028400101228      *  eg; physical file is INVMF and current 'position to' is
028500101228      *      by style number, WHSXXX = INVMF (key = style #).
028600101228      *
028700101228      *
028800101228      * XXXK01 - Key list based on current 'position to' fields.
028900101228      *  eg; if 'position to' field is item number:
029000101228      *          XXXK01 = INVK01  KLIST
029100101228      *                           KFLD      WCITM#
029200101228      ****************************************************************
029300101228      *
029400101228     C                   SELECT
029500101228      *
029600101228     C     WWCPOS        WHENEQ    1
029700101228     C     muk01         SETLL     mnuusrm                                99
029800101228     C     *IN99         IFEQ      *OFF
029900101228     C                   MOVE      YES           WWNFND
030000101228     C                   END
030100101228      *
030200101228     C*    WWCPOS        WHENEQ    2
030300101228     C*    XXXK01        SETLL     WHSXXXX                                99
030400101228     C*    *IN99         IFEQ      *OFF
030500101228     C*                  MOVE      YES           WWNFND
030600101228     C*                  END
030700101228      *
030800101228     C                   ENDSL
030900101228      *
031000101228      * Load subfile:
031100101228      *
031200101228     C                   EXSR      $LDSFL
031300101228      *
031400101228      * Send message if search criteria is not found:
031500101228      *
031600101228     C     WWNFND        IFEQ      YES
031700101228     C     *IN40         IFEQ      *ON
031800101228     C     *IN04         OREQ      *ON
031900101228     C                   MOVEL     'SHL0006'     WWMSGI
032000101228     C                   CALL      'ERMSG1'      MSGP01
032100101228     C                   END
032200101228     C                   END
032300101228      *
032400101228     C                   ENDSR
032500101228      *
032600101228      **************
032700101228      **  $ERR01  ** - Control Screen Validity Checking
032800101228      **************
032900101228     C     $ERR01        BEGSR
033000101228      *
033100101228     C                   CLEAR                   WWERR1
033200101228      *
033300101228      *****************************************************************
033400101228      * All error conditions must have the following lines of code:
033500101228      *
033600101228      *   MOVE *ON       *INXX
033700101228      *     Where *INXX = field error indicator in DDS.
033800101228      *
033900101228      *   MOVELERROR     WWERR1
034000101228      *     Program error flag.
034100101228      *
034200101228      *   MOVEL'XXX0001' WWMSGI
034300101228      *     Where XXX0001 = error message id to be displayed.
034400101228      *
034500101228      *   MOVELXXXXXX    WWMSGF
034600101228      *     Where XXXXXX = name of the message file which contains
034700101228      *     the message id contained in field WWMSGI.
034800101228      *
034900101228      *   CALL 'ERMSG1'  MSGP01
035000101228      *     Message handling program.
035100101228      *****************************************************************
035200101228      *
035300101228      * Field 1:
035400101228     C     *IN41         IFEQ      *ON
035500101228     C     WCuser        ANDNE     *ZERO
035600101228     C     muk01         SETLL     mnuusrm                                99
035700101228     C     *IN99         IFEQ      *OFF
035800101228     C                   MOVE      *ON           *IN36
035900101228     C                   MOVEL     ERROR         WWERR1
036000101228     C                   MOVEL     'SHL0006'     WWMSGI
036100101228     C                   CALL      'ERMSG1'      MSGP01
036200101228     C                   END
036300101228     C                   END
036400101228      *
036500101228     C*    *IN42         IFEQ      *ON
036600101228     C*    WCXXX1        ANDNE     *ZERO
036700101228     C*    XXXK01        SETLL     WHSXXXX                                99
036800101228     C*    *IN99         IFEQ      *OFF
036900101228     C*                  MOVE      *ON           *IN36
037000101228     C*                  MOVEL     ERROR         WWERR1
037100101228     C*                  MOVEL     'SHL0006'     WWMSGI
037200101228     C*                  CALL      'ERMSG1'      MSGP01
037300101228     C*                  END
037400101228     C*                  END
037500101228      *
037600101228     C                   ENDSR
037700101228      *
037800101228      **************
037900101228      **  $LDSFL  ** - Load Subfile
038000101228      **************
038100101228     C     $LDSFL        BEGSR
038200101228      *
038300101228     C                   CLEAR                   WWCNT1
038400101228      *
038500101228     C                   MOVE      *OFF          *IN34
038600101228      *
038700101228      * Load one page at a time:
038800101228      *
038900101228     C     WWCNT1        DOWLT     WWPGSZ
039000101228     C     *IN34         ANDEQ     *OFF
039100101228      *****************************************************************
039200101228      *
039300101228     C                   SELECT
039400101228      *
039500101228      * Read from file, based on current 'position to' view:
039600101228      *
039700101228     C     WWCPOS        WHENEQ    1
039800101228     C                   READ      mnuusrm                                34
039900101228      *
040000101228     C*    WWCPOS        WHENEQ    2
040100101228     C*                  READ      WHSXXXX                                34
040200101228      *
040300101228     C                   ENDSL
040400101228      *
040500101228     C     *IN34         IFEQ      *OFF
040600101228      *
040700101228     C                   CLEAR                   WSOPT#
040800101228     C                   MOVE      *OFF          *IN61
040900101228      *
041000101228      * Load subfile fields here:
041100101228      *
041200101228      *
041300101228     C                   MOVE      muuser        WSuser
041400101228     C                   MOVE      muimenu       WSimenu
041500101228     C                   MOVE      museclvl      WSseclvl
041600101228     C                   MOVE      mucmenu       WScmenu
041700101228     C                   MOVE      mucustm       WScustm
041800101228      *
041900101228     C                   ADD       1             RRN1
042000101228     C                   ADD       1             WWCNT1
042100101228      *
042200101228     C     WWCNT1        IFEQ      1
042300101228     C                   Z-ADD     RRN1          HDSFLP
042400101228     C                   END
042500101228      *
042600101228     C                   WRITE     SCRNS01
042700101228      *
042800101228     C                   END
042900101228      *
043000101228     C                   ENDDO
043100101228      *
043200101228     C     RRN1          IFGT      *ZERO
043300101228     C                   MOVE      *ON           *IN32
043400101228     C                   END
043500101228      *
043600101228     C                   MOVE      *OFF          *IN25
043700101228      *
043800101228     C                   ENDSR
043900101228      *
044000101228      **************
044100101228      **  $PRMPT  ** - Process Promptable Fields
044200101228      **************
044300101228     C     $PRMPT        BEGSR
044400101228      *
044500101228      *****************************************************************
044600101228      *  Field HDCSRF (defined in DDS) contains the field name which
044700101228      *  contains the cursor. If valid, a prompting program may be
044800101228      *  called to select a record from a list of valid values for
044900101228      *  the prompted field. The value selected should then be placed
045000101228      *  in the field which was prompted.
045100101228      *
045200101228      * eg; HDCSRF    WHEQ 'WCXXX1'
045300101228      *      Cursor resides in field WCXXX1
045400101228      *
045500101228      *     CALL 'GEN0109R'
045600101228      *      Codes file prompting program.
045700101228      *
045800101228      *     PARM '653'     WWCTAB
045900101228      *      Outgoing parm.
046000101228      *
046100101228      *     PARM *BLANKS   WWCKEY
046200101228      *      Return parm.
046300101228      *
046400101228      *     MOVELWWCKEY    WCXXX1
046500101228      *      Move return parm into prompted field.
046600101228      *
046700101228      *****************************************************************
046800101228      *
046900101228     C                   SELECT
047000101228      *
047100101228     C*    HDCSRF        WHENEQ    'WCXXX1'
047200101228     C*                  CALL      'GEN0109R'
047300101228     C*                  PARM      '653'         WWCTAB
047400101228     C*                  PARM      *BLANKS       WWCKEY
047500101228     C*                  MOVEL     WWCKEY        WCXXX1
047600101228      *
047700101228     C*    HDCSRF        WHENEQ    'WCXXX2'
047800101228     C*                  CALL      'GEN0109R'
047900101228     C*                  PARM      '654'         WWCTAB
048000101228     C*                  PARM      *BLANKS       WWCKEY
048100101228     C*                  MOVEL     WWCKEY        WCXXX2
048200101228      *
048300101228      * Non propmtable area:
048400101228      *
048500101228     C                   OTHER
048600101228      *
048700101228     C                   MOVEL     'SHL0004'     WWMSGI
048800101228     C                   CALL      'ERMSG1'      MSGP01
048900101228      *
049000101228     C                   ENDSL
049100101228      *
049200101228     C                   ENDSR
049300101228      *
049400101228      **************
049500101228      **  $POSTO  ** - Position To
049600101228      **************
049700101228     C     $POSTO        BEGSR
049800101228      *
049900101228      * Clear all 'position to' fields here:
050000101228      *
050100101228     C                   CLEAR                   WCUSER
050200101228      *
050300101228     C                   CLEAR                   RRN1
050400101228     C                   CLEAR                   HDSFLP
050500101228      *
050600101228      * Clear subfile:
050700101228      *
050800101228     C     *IN32         IFEQ      *ON
050900101228     C                   MOVE      *OFF          *IN32
051000101228     C                   MOVE      *ON           *IN30
051100101228     C                   WRITE     SCRNC01
051200101228     C                   MOVE      *OFF          *IN30
051300101228     C                   END
051400101228      *
051500101228      * Position cursor:
051600101228      *
051700101228     C                   MOVE      *ON           *IN36
051800101228      *
051900101228      * Toggle to next 'position to' field:
052000101228      *
052100101228     C     WWCPOS        ADD       1             WWCPOS
052200101228      *
052300101228     C     WWCPOS        IFGT      WW#POS
052400101228     C                   Z-ADD     1             WWCPOS
052500101228     C                   END
052600101228      *
052700101228      *****************************************************************
052800101228      * When a 'position to' view is changed, the new display
052900101228      * indicator (from DDS) must be set on and all other 'position to'
053000101228      * display indicators must be turned off.
053100101228      *
053200101228      *  eg; 'position to' #1 by agency (display indicator *IN41)
053300101228      *      'position to' #2 by agency/chain (display indicator *IN42)
053400101228      *
053500101228      *  If user toggles to 'position to' by agency/chain, indicator
053600101228      *  *IN41 must be turned off and *IN42 turned on.
053700101228      *
053800101228      *      MOVEA'01'      *IN,41
053900101228      *****************************************************************
054000101228      *
054100101228      * Set 'position to' field display indicator:
054200101228      *
054300101228     C                   SELECT
054400101228      *
054500101228     C     WWCPOS        WHENEQ    1
054600101228     C                   MOVEA     '10'          *IN(41)
054700101228      *
054800101228     C     WWCPOS        WHENEQ    2
054900101228     C                   MOVEA     '01'          *IN(41)
055000101228      *
055100101228     C                   ENDSL
055200101228      *
055300101228     C                   ENDSR
055400101228      *
055500101228      **************
055600101228      **  $ADDRC  ** - Add a record
055700101228      **************
055800101228     C     $ADDRC        BEGSR
055900101228      *
056000101228      *****************************************************************
056100101228      * Parms required to be passed to the maintenance program:
056200101228      *   1. WISEC = program level security.
056300101228      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
056400101228      *
056500101228      *****************************************************************
056600101228      *
056700101228     C                   MOVE      YES           WWLOAD
056800101228      *
056900101228     C                   CLEAR                   APP2
057000101228     C                   MOVEL     WISEC         A2SEC
057100101228     C                   MOVEL     ADD           A2ACTN
057200101228      *
057300101228      * Move key fields to maintenance program for record access:
057400101228      *
057500101228     C                   MOVE      WCuser        A2user
057600101228      *
057700101228      * Call maintenance program:
057800101228      *
057900101228     C                   CALL      'MNU0011R'
058000101228     C                   PARM                    jld
058100101228     C                   PARM                    APP2
058200101228      *
058300101228      *****************************************************************
058400101228      * When returning from the maintenance program, this program will
058500101228      * automatically position the subfile list to the last record
058600101228      * added to the file. To do this, the maintenance program must
058700101228      * return all 'position to' field values to this program.
058800101228      *
058900101228      *   eg; 'position to' #1 = Item Number
059000101228      *       'position to' #2 = Item Type Code
059100101228      *
059200101228      *
059300101228      *  Using this example, when a record is added to the file, the
059400101228      *  maintenance program will return the values of all of the above
059500101228      *  'position to' fields (Item Number, Item Type Code).
059600101228      *  The subfile list will then automatically be positioned based
059700101228      *  on the current 'position to' view.
059800101228      *
059900101228      *****************************************************************
060000101228      *
060100101228      * Move key fields from maint pgm to 'position to' fields:
060200101228      *
060300101228     C                   MOVE      A2user        WCuser
060400101228      *
060500101228     C                   MOVEL     WRRCDE        WWRCDE
060600101228      *
060700101228     C                   ENDSR
060800101228      *
060900101228      **************
061000101228      **  $READC  ** - Process Subfile Requests
061100101228      **************
061200101228     C     $READC        BEGSR
061300101228      *
061400101228     C                   CLEAR                   WWERR2
061500101228     C                   CLEAR                   WWRCDE
061600101228     C                   CLEAR                   WWRRN#
061700101228      *
061800101228      * Save current RRN:
061900101228      *
062000101228     C                   Z-ADD     RRN1          WWCRRN
062100101228      *
062200101228      * Read all records in the S/F:
062300101228      *
062400101228     C     WWRRN#        DOWLT     WWCRRN
062500101228     C     WWERR2        ANDNE     ERROR
062600101228     C     WWRCDE        ANDNE     INUSE
062700101228     C     *IN03         ANDEQ     *OFF
062800101228      *
062900101228     C                   ADD       1             WWRRN#
063000101228      *
063100101228     C     WWRRN#        CHAIN     SCRNS01                            99
063200101228     C     *IN99         IFEQ      *OFF
063300101228      *
063400101228     C                   MOVE      *OFF          *IN61
063500101228      *
063600101228      * Option number was entered:
063700101228      *
063800101228     C     WSOPT#        IFNE      *BLANKS
063900101228      *
064000101228      * Check for subfile option errors:
064100101228      *
064200101228     C                   EXSR      $ERR02
064300101228      *
064400101228     C                   Z-ADD     RRN1          HDSFLP
064500101228      *
064600101228      * Error occurred, return to mainline:
064700101228      *
064800101228     C     WWERR2        IFEQ      ERROR
064900101228     C                   MOVE      *ON           *IN61
065000101228     C                   UPDATE    SCRNS01
065100101228     C                   ELSE
065200101228      *
065300101228      *****************************************************************
065400101228      * If this program is called as a record selection program
065500101228      * (WISEL = 'Y'), return the desired field(s) to the calling
065600101228      * program through the APPL parm list.
065700101228      *
065800101228      *   eg; Call this program to retrieve a chain code.
065900101228      *
066000101228      *     DSACTN    IFEQ SELECT
066100101228      *       Record has been selected.
066200101228      *
066300101228      *               MOVE WSCHN     WICHN
066400101228      *                 Move the chain code from the S/F to the APPL
066500101228      *                 parm WICHN.
066600101228      *
066700101228      *               MOVE *ON       *IN03
066800101228      *                 End this program.
066900101228      *
067000101228      *****************************************************************
067100101228      * If select, return the key fields and end program:
067200101228      *
067300101228     C     DSACTN        IFEQ      SELECT
067400101228     C                   MOVE      WSuser        WIuser
067500101228     C                   MOVE      *ON           *IN03
067600101228     C                   ELSE
067700101228      *
067800101228      *****************************************************************
067900101228      * If Work with, call new work with program.
068000101228      *
068100101228     C     DSACTN        IFEQ      WRKWTH
068200101228     C                   Call      'SHLDUMMYR'
068300101228     C                   Else
068400101228      *
068500101228      *****************************************************************
068600101228      * Parms required to be passed to the maintenance program:
068700101228      *   1. WISEC = program level security.
068800101228      *   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
068900101228      *   3. The key of the record to be maintained.
069000101228      *
069100101228      *****************************************************************
069200101228      *
069300101228      * Call maintenance program:
069400101228      *
069500101228     C                   CLEAR                   APP2
069600101228     C                   MOVEL     WISEC         A2SEC
069700101228     C                   MOVEL     DSACTN        A2ACTN
069800101228      *
069900101228      * Move key fields to maintenance program for record access:
070000101228      *
070100101228     C                   MOVE      WSuser        A2user
070200101228      *
070300101228     C                   CALL      'MNU0011R'
070400101228     C                   PARM                    jld
070500101228     C                   PARM                    APP2
070600101228      *
070700101228      *****************************************************************
070800101228      * When returning from the maintenance program, this program will
070900101228      * automatically position the subfile list to the last record
071000101228      * processed. To do this, the maintenance program must return all
071100101228      * 'position to' field values to this program.
071200101228      *
071300101228      *   eg; 'position to' #1 = Item Number
071400101228      *       'position to' #2 = Item Type Code
071500101228      *
071600101228      *  Using this example, when a record is maintained, the
071700101228      *  maintenance program will return the values of all of the above
071800101228      *  'position to' fields (item number, item type code).
071900101228      *  The subfile list will then automatically be positioned based
072000101228      *  on the current 'position to' view.
072100101228      *
072200101228      *****************************************************************
072300101228      *
072400101228      * Move key fields from maint pgm to 'position to' fields:
072500101228      *
072600101228     C                   MOVE      A2user        WCuser
072700101228      *
072800101228     C                   MOVE      YES           WWLOAD
072900101228      *
073000101228     C                   MOVEL     WRRCDE        WWRCDE
073100101228      *
073200101228      * If record lock, send record in use message:
073300101228      *
073400101228     C     WWRCDE        IFEQ      INUSE
073500101228     C                   MOVEL     'SHL0007'     WWMSGI
073600101228     C     A2IUSE        CAT       DSMDTA        DSMDTA
073700101228     C                   CALL      'ERMSG1'      MSGP01
073800101228     C                   CLEAR                   DSMDTA
073900101228     C                   MOVE      NO            WWLOAD
074000101228     C                   END
074100101228      *
074200101228     C                   ENDIF
074300101228      *
074400101228     C                   CLEAR                   WSOPT#
074500101228     C                   UPDATE    SCRNS01
074600101228      *
074700101228     C                   END
074800101228     C                   END
074900101228     C                   END
075000101228     C                   END
075100101228      *
075200101228     C                   ENDDO
075300101228      *
075400101228      * Reset current RRN:
075500101228      *
075600101228     C                   Z-ADD     WWCRRN        RRN1
075700101228      *
075800101228     C                   CLEAR                   WWRCDE
075900101228      *
076000101228     C                   ENDSR
076100101228      *
076200101228      **************
076300101228      **  $ERR02  ** - Subfile Validity Checking
076400101228      **************
076500101228     C     $ERR02        BEGSR
076600101228      *
076700101228      * Check for valid option:
076800101228      *
076900101228     C                   Z-ADD     1             X
077000101228     C     WSOPT#        LOOKUP    OPT(X)                                 90
077100101228     C     *IN90         IFEQ      *ON
077200101228     C                   MOVEL     INMD(X)       DSSPLT
077300101228     C                   ELSE
077400101228     C                   CLEAR                   DSSPLT
077500101228     C                   END
077600101228      *
077700101228     C                   SELECT
077800101228      *
077900101228      * If indicator 90 is off, option number is not valid.
078000101228      * If indicator ZZ is off, user is not authorized to option.
078100101228      *
078200101228     C     *IN90         WHENEQ    *OFF
078300101228     C     *IN(ZZ)       OREQ      *OFF
078400101228     C                   MOVEL     'SHL0008'     WWMSGI
078500101228     C                   CALL      'ERMSG1'      MSGP01
078600101228     C                   MOVEL     ERROR         WWERR2
078700101228      *
078800101228     C                   ENDSL
078900101228      *
079000101228     C                   ENDSR
079100101228      *
079200101228      **************
079300101228      **  *INZSR  ** - Initialize Program
079400101228      **************
079500101228     C     *INZSR        BEGSR
079600101228      *
079700101228      * Incoming parm list:
079800101228      *
079900101228     C     *ENTRY        PLIST
080000101228     C                   PARM                    jld
080100101228     C                   PARM                    APPL
080200101228      *
080300101228      * Message file parm list:
080400101228      *
080500101228     C     MSGP01        PLIST
080600101228     C                   PARM                    WWMSGI            7
080700101228      *
080800101228      * Key lists:
080900101228      *
081000101228     C     CODK01        KLIST
081100101228     C                   KFLD                    WWCTAB
081200101228     C                   KFLD                    WWCKEY
081300101228      *
081400101228     C     muk01         KLIST
081500101228     C                   KFLD                    WCuser
081600101228      *
081700101228      * Field definitions:
081800101228      *
081900101228     C     *LIKE         DEFINE    HDSFLP        RRN1
082000101228     C     *LIKE         DEFINE    HDSFLP        WWRRN#
082100101228     C     *LIKE         DEFINE    HDSFLP        WWCRRN
082200101228      *
082300101228      * Initialize:
082400101228      *
082500101228     C                   MOVE      *ZEROS        WWCNT1            2 0
082600101228     C                   MOVE      01            WWCPOS            2 0
082700101228     C                   MOVE      *BLANKS       WWCTAB            3
082800101228     C                   MOVE      *BLANKS       WWCKEY           27
082900101228     C                   MOVE      *BLANKS       WWNFND            1
083000101228     C                   MOVE      YES           WWFRST            1
083100101228     C                   MOVE      YES           WWLOAD            1
083200101228     C                   MOVE      *BLANKS       WWERR1           10
083300101228     C                   MOVE      *BLANKS       WWERR2           10
083400101228     C                   MOVE      *BLANKS       WWERR3            1
083500101228     C                   MOVE      *BLANKS       WWRCDE           10
083600101228     C                   MOVE      *ZEROS        X                 2 0
083700101228      *
083800101228      * Load the program name defined in security file PGMSEC.
083900101228      * This name must be defined in the constant 'PGMNAM'.
084000101228      *
084100101228     C                   MOVEL     PGMNAM        WWPGM            10
084200101228      *
084300101228      * Clear message subfile:
084400101228      *
084500101228     C                   CALL      'ERMSG2'
084600101228     C                   Parm                    dspgmn
084700101228      *
084800101228      * Fill default screen values:
084900101228      *
085000101228      *
085100101228      *
085200101228      * Default to the first 'position to' view if value not passed
085300101228      * to this program:
085400101228      *
085500101228     C     WIVIEW        IFEQ      *ZERO
085600101228     C                   Z-ADD     1             WWCPOS            2 0
085700101228     C                   ELSE
085800101228     C                   Z-ADD     WIVIEW        WWCPOS
085900101228     C                   MOVE      *ON           *IN40
086000101228     C                   END
086100101228      *
086200101228      * Set initial 'position to' display indicator. Also load
086300101228      * 'position to' values passed to this program (WIXXX1,2), if
086400101228      * applicable:
086500101228      *
086600101228     C                   SELECT
086700101228      *
086800101228     C     WWCPOS        WHENEQ    1
086900101228     C                   MOVE      *ON           *IN41
087000101228     C                   MOVE      WIuser        WCuser
087100101228      *
087200101228     C*    WWCPOS        WHENEQ    2
087300101228     C*                  MOVE      *ON           *IN42
087400101228     C*                  MOVE      WIXXX2        WCXXX2
087500101228      *
087600101228     C                   ENDSL
087700101228      *****************************************************************
087800101228      * Field WISEC is a 5 byte logical indicator field used to control
087900101228      * user access to all maintenance functions (eg; change, delete).
088000101228      * Each byte will have a value of either '0'(not authorized) or
088100101228      * '1'(authorized). This field will be moved into indicator
088200101228      * array *IN,81.
088300101228      *
088400101228      *
088500101228      *  WISEC = '00000'                  *IN81 = Add/Copy
088600101228      *           |||||___ Work With      *IN82 = Change
088700101228      *         Add|||     (Extra)        *IN83 = Delete
088800101228      *            |||                    *IN84 = Display
088900101228      *       Change||                    *IN85 = Work With
089000101228      *             ||
089100101228      *        Delete|
089200101228      *              |
089300101228      *        Display
089400101228      *
089500101228      *****************************************************************
089600101228      *
089700101228      * Set up security options:
089800101228      *
089900101228     C     WISEC         IFEQ      *BLANKS
090000101228     C                   CALL      'SEC0100R'
090100101228     C                   PARM                    WWPGM
090200101228     C                   PARM                    WISEC
090300101228     C                   END
090400101228      *
090500101228      * User not setup in security file:
090600101228      *
090700101228     C     WISEC         IFEQ      '99999'
090800101228     C                   MOVE      '00000'       WISEC
090900101228     C                   MOVE      NO            WWLOAD
091000101228     C                   MOVEL     'SHL0009'     WWMSGI
091100101228     C                   CALL      'ERMSG1'      MSGP01
091200101228      *
091300101228     C                   ELSE
091400101228      *
091500101228      * Clear messages:
091600101228      *
091700101228     C                   CALL      'ERMSG2'
091800101228     C                   Parm                    dspgmn
091900101228     C                   MOVEA     WISEC         *IN(81)
092000101228      *
092100101228      * If program is called to select a record, turn off all
092200101228      * maintenance functions:
092300101228      *
092400101228     C     WISEL         IFEQ      YES
092500101228     C                   MOVE      *ON           *IN86
092600101228     C                   MOVEA     '00010'       *IN(81)
092700101228     C                   END
092800101228      *
092900101228     C                   END
093000101228      *
093100101228      *****************************************************************
093200101228      * All users are authorized to any *IN89 option from table OPT:
093300101228      *
093400101228      *        Option Named
093500101228      *            Constant
093600101228      *              |    |
093700101228      * Authorization|    |
093800101228      *     Indicator|    |
093900101228      *            |||    |
094000101228      *      Option|||    |
094100101228      *          |||||    |
094200101228      *   eg ;    282CHANGE
094300101228      *          2 82CHANGE
094400101228      *           789ITMINQ
094500101228      *          7 89ITMINQ
094600101228      *           989POINQ
094700101228      *          9 89POINQ
094800101228      *
094900101228      *  In this example, option 2 to change a record is available
095000101228      *  only to users which have authorization (*IN82). option 7 to
095100101228      *  view the item inquiry and option 9 to view the PO inquiry are
095200101228      *  setup in the table with indicator *IN89, therefore will be
095300101228      *  available to all users, without restriction.
095400101228      *
095500101228      *****************************************************************
095600101228      *
095700101228     C                   MOVE      *ON           *IN89
095800101228      *
095900101228     C                   MOVE      *ON           *IN36
096000101228      *
096100101228     C                   ENDSR
096200101228**
096300101228186SELECT
096400101228282CHANGE
096500101228381COPY
096600101228483DELETE
096700101228584DISPLY
