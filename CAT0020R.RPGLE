000100000000      /copy qcpylesrc,stdhspec
000200000000      ********************************************************************
000300000000      *
000400000000      *  Program....: CAT0020R
000500000000      *
000600000000      *  Description: Maintain the List of users who allow to change category
000700000000      *
000800000000      *  Programmer.: Greg Cannella
000900000000      *
001000000000      *  Date.......: 11/30/14
001100000000      *
001200000000      ********************************************************************
001300000000      *                   Modification Log
001400000000      *
001500000000      *  Initials  Date      Description
001600000000      *-------------------------------------------------------------------
001700000000      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800000000      *
001900000000      *
002000000000      *
002100000000      ********************************************************************
002200000000      *                   Indicator Usage
002300000000      *
002400000000      *   Ind.   Description
002500000000      *-------------------------------------------------------------------
002600000000      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700000000      *
002800000000      *
002900000000      *****************************************************************
003000000000      * Indicator Usage:                                              *
003100000000      * Ind      Use                                                  *
003200000000      * 01-24    Function keys                                        *
003300000000      * 25       Rollup                                               *
003400000000      * 30-34    Subfile keywords                                     *
003500000000      * 36       Position to                                          *
003600000000      * 37       Error indicator                                      *
003700000000      * 40       Search field change                                  *
003800000000      * 41-42    Search field display                                 *
003900000000      * 61       Subfile option error                                 *
004000000000      * 80-89    Reserved for Security                                *
004100000000      * 90-99    Hit/Miss                                             *
004200000000      *****************************************************************
004300000000      * Field Definitions                                             *
004400000000      *                                                               *
004500000000      * Prefix                                                        *
004600000000      * WW     - Program described work fields                        *
004700000000      * WI     - APPL *ENTRY input parameters                         *
004800000000      * WS     - Subfile fields                                       *
004900000000      * WC     - Subfile control fields                               *
005000000000      * HD     - Hidden fields                                        *
005100000000      * Ax     - APPx output parameters for called programs           *
005200000000      * DS     - Data structure fields                                *
005300000000      *                                                               *
005400000000      *                                                               *
005500000000      * Display Record Format Definitions                             *
005600000000      *                                                               *
005700000000      * Prefix                                                        *
005800000000      * SCRNS  - Subfile                                              *
005900000000      * SCRNC  - Subfile control                                      *
006000000000      * SCRNK  - Command key                                          *
006100000000      * SCRNR  - Standard display                                     *
006200000000      * WNDWB  - Window border                                        *
006300000000      * WNDWR  - Standard window display                              *
006400000000      * MSGCTL - Message subfile control                              *
006500000000      *                                                               *
006600000000      *                                                               *
006700000000      * Called programs                                               *
006800000000      *                                                               *
006900000000      * ERMSG2 - Clear program message queue                          *
007000000000      * ERMSG1 - Send program message with message data               *
007100000000      * CAT0021R - Maintenance program                                *
007200000000      *                                                               *
007300000000      *                                                               *
007400000000      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007500000000      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007600000000      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007700000000      *
007800000000     FCAT0020D  CF   E             WORKSTN
007900000000     F                                     SFILE(SCRNS01:RRN1)
008000000000     F                                     INFDS(INFDS)
008100000000     FCODUSRM   IF   E           K DISK
008200000000     FCODUSR1   IF   E           K DISK    Rename(CODUSRR:CODUSRL1)
008300000000     FCODEHDR   IF   E           K DISK
008400000000      *
008500000000      * Option authorization:
008600000000     D OPT             S              2    DIM(12) CTDATA PERRCD(1)
008700000000     D INMD            S             12    DIM(12) ALT(OPT)
008800000000      *
008900000000      *
009000000000      *
009100000000      * Max number of 'position to':
009200000000     D WW#POS          C                   CONST(02)
009300000000      *
009400000000      * Number of records to fill S/F page:
009500000000     D WWPGSZ          C                   CONST(10)
009600000000      *
009700000000      * General constants:
009800000000     D LOAD            C                   CONST('LOAD')
009900000000     D ERROR           C                   CONST('ERROR')
010000000000     D INUSE           C                   CONST('INUSE')
010100000000     D SELECT          C                   CONST('SELECT')
010200000000     D ADD             C                   CONST('ADD')
010300000000     D CHANGE          C                   CONST('CHANGE')
010400000000     D COPY            C                   CONST('COPY')
010500000000     D DELETE          C                   CONST('DELETE')
010600000000     D DISPLY          C                   CONST('DISPLY')
010700000000     D WRKWTH          C                   CONST('WRKWTH')
010800000000     D PGMNAM          C                   CONST('CAT0020R  ')
010900000000     D NO              C                   CONST('N')
011000000000     D YES             C                   CONST('Y')
011100000000      *
011200000000     D jld           E DS                  EXTNAME(dsjld)
011300000000      *
011400000000      * Incoming parms:
011500000000     D APPL            DS           512
011600000000     D  WISEC                  1      5
011700000000     D  WISEL                  6      6
011800000000     D  WIVIEW                 7      8  0
011900000000     D  WIUSER                 9     18
012000000000     D  WICATC                19     28
012100000000      *
012200000000      * Calling parms for CAT0021R:
012300000000     D APP2            DS           512
012400000000     D  A2SEC                  1      5
012500000000     D  A2IUSE                 6     15
012600000000     D  A2INLR                16     16
012700000000     D  A2ACTN                17     26
012800000000     D  A2USER                27     36
012900000000     D  A2CATC                37     46
013000000000      *
013100000000      * Parm to hold message data:
013200000000     D DSMDTA          DS           500
013300000000      *
013400000000      * Split option indicator and action code:
013500000000     D DSSPLT          DS            12
013600000000     D  ZZ                     1      2  0
013700000000     D  DSACTN                 3     12
013800000000      *
013900000000     D INFDS           DS
014000000000     D  SFLLOC               378    379B 0
014100000000      *
014200000000     D                SDS
014300000000     D  DSPGMN           *PROC
014400000000     D  DSUSER               254    263
014500000000      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014600000000      *M                 M  A  I  N  L  I  N  E                       M
014700000000      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
014800000000      *
014900000000      * Main loop:
015000000000      *
015100000000     C                   Dou       *IN03 = *ON
015200000000      *
015300000000      * Reload subfile, if requested:
015400000000      *
015500000000     C                   If        WWLOAD = YES
015600000000     C                   Exsr      $INSFL
015700000000     C                   Eval      WWLOAD = NO
015800000000     C                   EndIf
015900000000      *
016000000000      * Display screen:
016100000000      *
016200000000     C                   WRITE     MSGCTL1
016300000000     C                   WRITE     SCRNK01
016400000000      *
016500000000     C                   IF        *IN32 = *OFF
016600000000     C                   WRITE     SCRNR01
016700000000     C                   EndIf
016800000000      *
016900000000     C                   EXFMT     SCRNC01
017000000000     C                   MOVE      THEFLD        *IN69
017100000000      *
017200000000     C                   IF        WWFRST = YES
017300000000     C                   Eval      WWFRST = NO
017400000000     C                   EndIf
017500000000      *
017600000000     C                   MOVE      SFLLOC        HDSFLP
017700000000      *
017800000000      * Clear messages:
017900000000      *
018000000000     C                   CALL      'ERMSG2'
018100000000     C                   Parm                    DSPGMN
018200000000      *
018300000000      * Set off all error indicators here:
018400000000      *
018500000000     C                   Eval      *In36 = *Off
018600000000     C                   Eval      *In38 = *Off
018700000000     C                   Eval      *In71 = *Off
018800000000      *
018900000000     C                   IF        *IN03 = *OFF
019000000000      *
019100000000      * Process command keys:
019200000000      *
019300000000     C                   Select
019400000000      *
019500000000      * F4 = Prompt:
019600000000      *
019700000000     C                   When      *In04 = *ON
019800000000     C                   Exsr      $PRMPT
019900000000     C                   Exsr      $INSFL
020000000000      *
020100000000      * F10 = Position to:
020200000000      *
020300000000     C                   When      *In10 = *ON
020400000000     C                   Exsr      $POSTO
020500000000      *
020600000000      * F5 or 'position to' field value change (*IN40) - reload S/F:
020700000000      *
020800000000     C                   When      *In05 = *ON or *In40 = *ON
020900000000     C                   Exsr      $INSFL
021000000000      *
021100000000      * Rollup (if records exist in S/F - *IN32):
021200000000      *
021300000000     C                   When      *In25 = *ON and *In32 = *ON
021400000000     C                   Exsr      $LDSFL
021500000000      *
021600000000      * Add a record:
021700000000      *
021800000000     C                   WHEN      Wcopta = '1 ' or Wcopta = ' 1'
021900000000     c***                If        Wccata = ' ' or Wcusra = ' '
022000000000     c***                Eval      *in71 = *on
022100000000      * Must fill in key value
022200000000     c***                Else
022300000000     c                   Exsr      $ADDRC
022400000000     c***                Endif
022500000000      *
022600000000      * F12 = Cancel
022700000000      *
022800000000     C                   When      *In12 = *ON
022900000000     C                   Eval      *in03 = *on
023000000000      *
023100000000     C                   Other
023200000000      *
023300000000      * Enter:
023400000000      *
023500000000     C                   Exsr      $READC
023600000000      *
023700000000     C                   EndSl
023800000000      *
023900000000     C                   END
024000000000      *
024100000000     C                   ENDDO
024200000000      *
024300000000      * Close called programs:
024400000000      *
024500000000     C                   MOVE      YES           A2INLR
024600000000      *
024700000000      * End the maintenance program:
024800000000      *
024900000000     C                   CALL      'CAT0021R'
025000000000     C                   PARM                    jld
025100000000     C                   PARM                    APP2
025200000000      *
025300000000     C                   Eval      *Inlr = *ON
025400000000      *
025500000000      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025600000000      *$              S  U  B  R  O  U  T  I  N  E  S                 $
025700000000      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025800000000      *
025900000000      //---------------------------------------------------------------
026000000000      //  $INSFL  ** - Initialize Subfile
026100000000      //---------------------------------------------------------------
026200000000     C     $INSFL        BEGSR
026300000000      *
026400000000     C                   CLEAR                   RRN1
026500000000     C                   Z-ADD     1             HDSFLP
026600000000     C                   MOVE      NO            WWNFND
026700000000      *
026800000000      * Clear subfile:
026900000000      *
027000000000     C                   IF        *In32 = *ON
027100000000     C                   Eval      *IN32 = *OFF
027200000000     C                   Eval      *IN30 = *ON
027300000000     C                   WRITE     SCRNC01
027400000000     C                   Eval      *IN30 = *Off
027500000000     C                   END
027600000000      *
027700000000      * Check for subfile control errors:
027800000000      *
027900000000     C     WWFRST        CASEQ     NO            $ERR01
028000000000     C                   ENDCS
028100000000      *
028200000000      * Position file:
028300000000      *
028400000000     C                   SELECT
028500000000      * Position to User...
028600000000     C                   When      WWCPOS = 1
028700000000     C     PosUserKey    SETLL     CODUSRM
028800000000     C                   IF        not %equal(CODUSRM)
028900000000     C                   Eval      WWNFND = YES
029000000000     C                   EndIf
029100000000      * Position to Category...
029200000000     C                   When      WWCPOS = 2
029300000000     C     PosCatCKey    SETLL     CODUSR1
029400000000     C                   IF        not %equal(CODUSR1)
029500000000     C                   Eval      WWNFND = YES
029600000000     C                   EndIf
029700000000      *
029800000000     C                   EndSl
029900000000      *
030000000000      * Load subfile:
030100000000      *
030200000000     C                   Exsr      $LDSFL
030300000000      *
030400000000      * Send message if search criteria is not found:
030500000000      *
030600000000     C                   IF        WWNFND = YES
030700000000     C                   IF        *In40 = *ON or *In04 = *On
030800000000     C                   MOVEL     'SHL0006'     WWMSGI
030900000000     C                   CALL      'ERMSG1'      MSGP01
031000000000     C                   EndIf
031100000000     C                   EndIf
031200000000      *
031300000000     C     #INSFL        ENDSR
031400000000      //---------------------------------------------------------------
031500000000      //  $ERR01  ** - Control Screen Validity Checking
031600000000      //---------------------------------------------------------------
031700000000     C     $ERR01        BEGSR
031800000000      *
031900000000     C                   CLEAR                   WWERR1
032000000000      * Position to User:
032100000000     C                   IF        *In41 = *ON and WCUSER <> *blanks
032200000000     C     PosUserKey    SETLL     CODUSRM
032300000000     C                   IF        not %equal(CODUSRM)
032400000000     C                   Eval      *In36 = *ON
032500000000     C                   MOVEL     ERROR         WWERR1
032600000000     C                   MOVEL     'SHL0006'     WWMSGI
032700000000     C                   CALL      'ERMSG1'      MSGP01
032800000000     C                   EndIf
032900000000     C                   EndIf
033000000000      * Position to Category:
033100000000     C                   IF        *In42 = *ON and WCCATC <> *blanks
033200000000     C     PosCatCKey    SETLL     CODUSR1
033300000000     C                   IF        not %equal(CODUSR1)
033400000000     C                   Eval      *In36 = *ON
033500000000     C                   MOVEL     ERROR         WWERR1
033600000000     C                   MOVEL     'SHL0006'     WWMSGI
033700000000     C                   CALL      'ERMSG1'      MSGP01
033800000000     C                   EndIf
033900000000     C                   EndIf
034000000000      *
034100000000     C     #ERR01        ENDSR
034200000000      //---------------------------------------------------------------
034300000000      //  $LDSFL  ** - Load Subfile
034400000000      //---------------------------------------------------------------
034500000000     C     $LDSFL        BEGSR
034600000000      *
034700000000     C                   CLEAR                   WWCNT1
034800000000      *
034900000000     C                   Eval      *In34 = *OFF
035000000000      *
035100000000      * Load one page at a time:
035200000000      *
035300000000     C                   Dow       WWCNT1 < WWPGSZ and *In34 = *Off
035400000000      *
035500000000     C                   SELECT
035600000000      *
035700000000      * Read from file, based on current 'position to' view:
035800000000      *
035900000000     C                   When      WWCPOS = 1
036000000000     C                   READ      CODUSRM                                34
036100000000      *
036200000000     C                   When      WWCPOS = 2
036300000000     C                   READ      CODUSR1                                34
036400000000      *
036500000000     C                   EndSl
036600000000      *
036700000000     C                   IF        *In34 = *Off
036800000000      *
036900000000     C                   CLEAR                   WSOPT#
037000000000     C                   Eval      *In61 = *Off
037100000000      *
037200000000      * Load subfile fields here:
037300000000      *
037400000000     C                   Eval      WSUSER = CUuser
037500000000     C                   Eval      WSCATC = CUcatc
037600000000     C     Cucatc        Chain     Codehdr
037700000000     C                   If        %found(Codehdr)
037800000000     C                   Eval      wscodd = chcodd
037900000000     C                   Else
038000000000     C                   Eval      wscodd = *blank
038100000000     C                   EndIf
038200000000      *
038300000000     C                   ADD       1             RRN1
038400000000     C                   ADD       1             WWCNT1
038500000000      *
038600000000     C                   If        WWCNT1 = 1
038700000000     C                   Z-ADD     RRN1          HDSFLP
038800000000     C                   EndIf
038900000000      *
039000000000     C                   WRITE     SCRNS01
039100000000      *
039200000000     C                   END
039300000000      *
039400000000     C                   ENDDO
039500000000      *
039600000000     C                   If        RRN1 > *ZERO
039700000000     C                   Eval      *In32 = *ON
039800000000     C                   EndIf
039900000000      *
040000000000     C                   Eval      *In25 = *Off
040100000000      *
040200000000     C     #LDSFL        ENDSR
040300000000      //---------------------------------------------------------------
040400000000      //  $PRMPT  ** - Process Promptable Fields
040500000000      //---------------------------------------------------------------
040600000000     C     $PRMPT        BEGSR
040700000000      *
040800000000     C                   SELECT
040900000000      *
041000000000      * Non propmtable area:
041100000000      *
041200000000     C                   OTHER
041300000000      *
041400000000     C                   MOVEL     'SHL0004'     WWMSGI
041500000000     C                   CALL      'ERMSG1'      MSGP01
041600000000      *
041700000000     C                   ENDSL
041800000000      *
041900000000     C     #PRMPT        ENDSR
042000000000      //---------------------------------------------------------------
042100000000      //  $POSTO  ** - Position To
042200000000      //---------------------------------------------------------------
042300000000     C     $POSTO        BEGSR
042400000000      *
042500000000      * Clear all 'position to' fields here:
042600000000      *
042700000000     C                   CLEAR                   WCcatc
042800000000     C                   CLEAR                   WCuser
042900000000      *
043000000000     C                   CLEAR                   RRN1
043100000000     C                   CLEAR                   HDSFLP
043200000000      *
043300000000      * Clear subfile:
043400000000      *
043500000000     C                   If        *In32 = *ON
043600000000     C                   Eval      *In32 = *off
043700000000     C                   Eval      *In30 = *on
043800000000     C                   Write     SCRNC01
043900000000     C                   Eval      *In30 = *off
044000000000     C                   EndIf
044100000000      *
044200000000      * Position cursor:
044300000000      *
044400000000     C                   Eval      *In36 = *on
044500000000      *
044600000000      * Toggle to next 'position to' field:
044700000000      *
044800000000     C     WWCPOS        ADD       1             WWCPOS
044900000000      *
045000000000     C     WWCPOS        IFGT      WW#POS
045100000000     C                   Z-ADD     1             WWCPOS
045200000000     C                   END
045300000000      *
045400000000      * Set 'position to' field display indicator:
045500000000      *
045600000000     C                   SELECT
045700000000      *
045800000000     C                   WHEN      WWCPOS = 1
045900000000     C                   MOVEA     '10'          *IN(41)
046000000000      *
046100000000     C                   WHEN      WWCPOS = 2
046200000000     C                   MOVEA     '01'          *IN(41)
046300000000      *
046400000000     C                   ENDSL
046500000000      *
046600000000     C     #POSTO        ENDSR
046700000000      //---------------------------------------------------------------
046800000000      //  $ADDRC  ** - Add a record
046900000000      //---------------------------------------------------------------
047000000000     C     $ADDRC        BEGSR
047100000000      *
047200000000     C                   MOVE      YES           WWLOAD
047300000000      *
047400000000     C                   CLEAR                   APP2
047500000000     C                   MOVEL     WISEC         A2SEC
047600000000     C                   MOVEL     ADD           A2ACTN
047700000000     C                   Eval      A2USER = WCUSRA
047800000000     C                   Eval      A2CATC = WCCATA
047900000000      *
048000000000      * Call maintenance program:
048100000000      *
048200000000     C                   CALL      'CAT0021R'
048300000000     C                   PARM                    jld
048400000000     C                   PARM                    APP2
048500000000      *
048600000000      * Move key fields from maint pgm to 'position to' fields:
048700000000      *
048800000000     C                   Eval      WCUSER = A2USER
048900000000     C                   Eval      WCCATC = A2CATC
049000000000      *
049100000000     C                   MOVEL     WRRCDE        WWRCDE
049200000000      * Clear add fields
049300000000     c                   Clear                   WCOPTA
049400000000     c                   Clear                   WCUSRA
049500000000     c                   Clear                   WCCATA
049600000000      *
049700000000     C     #ADDRC        ENDSR
049800000000      //---------------------------------------------------------------
049900000000      //  $READC  ** - Process Subfile Requests
050000000000      //---------------------------------------------------------------
050100000000     C     $READC        BEGSR
050200000000      *
050300000000     C                   CLEAR                   WWERR2
050400000000     C                   CLEAR                   WWRCDE
050500000000     C                   CLEAR                   WWRRN#
050600000000      *
050700000000      * Save current RRN:
050800000000      *
050900000000     C                   Z-ADD     RRN1          WWCRRN
051000000000      *
051100000000      * Read all records in the S/F:
051200000000      *
051300000000     C                   Dow       WWRRN# < WWCRRN and
051400000000     C                             WWERR2 <> ERROR and
051500000000     C                             WWRCDE <> INUSE and *IN03 = *off
051600000000      *
051700000000     C                   ADD       1             WWRRN#
051800000000      *
051900000000     C     WWRRN#        CHAIN     SCRNS01                            99
052000000000     C     *IN99         IFEQ      *OFF
052100000000      *
052200000000     C                   MOVE      *OFF          *IN61
052300000000      *
052400000000      * Option number was entered:
052500000000      *
052600000000     C                   If        WSOPT# <> *BLANKS
052700000000      *
052800000000      * Check for subfile option errors:
052900000000      *
053000000000     C                   EXSR      $ERR02
053100000000      *
053200000000     C                   Z-ADD     RRN1          HDSFLP
053300000000      *
053400000000      * Error occurred, return to mainline:
053500000000      *
053600000000     C                   If        WWERR2 = ERROR
053700000000     C                   Eval      *IN61 = *ON
053800000000     C                   Update    SCRNS01
053900000000     C                   Else
054000000000      *
054100000000      * If select, return the key fields and end program:
054200000000      *
054300000000     C                   IF        DSACTN = SELECT
054400000000     C                   MOVE      WSuser        WIUSER
054500000000     C                   MOVE      WSCATC        WICATC
054600000000     C                   Eval      *IN03 = *ON
054700000000     C                   Else
054800000000      *
054900000000      * If Work with, call new work with program.
055000000000      *
055100000000     C     DSACTN        IFEQ      WRKWTH
055200000000     C                   Call      'SHLDUMMYR'
055300000000     C                   Else
055400000000      *
055500000000      * Call maintenance program:
055600000000      *
055700000000     C                   CLEAR                   APP2
055800000000     C                   MOVEL     WISEC         A2SEC
055900000000     C                   MOVEL     DSACTN        A2ACTN
056000000000      *
056100000000      * Move key fields to maintenance program for record access:
056200000000      *
056300000000     C                   Eval      A2user = WSuser
056400000000     C                   Eval      A2catc = WScatc
056500000000      *
056600000000     C                   CALL      'CAT0021R'
056700000000     C                   PARM                    jld
056800000000     C                   PARM                    APP2
056900000000      *
057000000000      * Move key fields from maint pgm to 'position to' fields:
057100000000      *
057200000000     C                   Eval      WCuser = A2user
057300000000     C                   Eval      WCcatc = A2catc
057400000000      *
057500000000     C                   MOVE      YES           WWLOAD
057600000000      *
057700000000     C                   MOVEL     WRRCDE        WWRCDE
057800000000      *
057900000000      * If record lock, send record in use message:
058000000000      *
058100000000     C     WWRCDE        IFEQ      INUSE
058200000000     C                   MOVEL     'SHL0007'     WWMSGI
058300000000     C     A2IUSE        CAT       DSMDTA        DSMDTA
058400000000     C                   CALL      'ERMSG1'      MSGP01
058500000000     C                   CLEAR                   DSMDTA
058600000000     C                   MOVE      NO            WWLOAD
058700000000     C                   END
058800000000      *
058900000000     C                   ENDIF
059000000000      *
059100000000     C                   CLEAR                   WSOPT#
059200000000     C                   UPDATE    SCRNS01
059300000000      *
059400000000     C                   END
059500000000     C                   END
059600000000     C                   END
059700000000     C                   END
059800000000      *
059900000000     C                   ENDDO
060000000000      *
060100000000      * Reset current RRN:
060200000000      *
060300000000     C                   Z-ADD     WWCRRN        RRN1
060400000000      *
060500000000     C                   CLEAR                   WWRCDE
060600000000      *
060700000000     C     #READC        ENDSR
060800000000      *
060900000000      //---------------------------------------------------------------
061000000000      //  $ERR02  ** - Subfile Validity Checking
061100000000      //---------------------------------------------------------------
061200000000     C     $ERR02        BEGSR
061300000000      *
061400000000      * Check for valid option:
061500000000      *
061600000000     C                   Z-ADD     1             X
061700000000     C     WSOPT#        LOOKUP    OPT(X)                                 90
061800000000     C     *IN90         IFEQ      *ON
061900000000     C                   MOVEL     INMD(X)       DSSPLT
062000000000     C                   ELSE
062100000000     C                   CLEAR                   DSSPLT
062200000000     C                   EndIf
062300000000      *
062400000000     C                   SELECT
062500000000      *
062600000000      * If indicator 90 is off, option number is not valid.
062700000000      * If indicator ZZ is off, user is not authorized to option.
062800000000      *
062900000000     C     *IN90         WHENEQ    *OFF
063000000000     C     *IN(ZZ)       OREQ      *OFF
063100000000     C                   MOVEL     'SHL0008'     WWMSGI
063200000000     C                   CALL      'ERMSG1'      MSGP01
063300000000     C                   MOVEL     ERROR         WWERR2
063400000000      *
063500000000     C                   ENDSL
063600000000      *
063700000000     C     #ERR02        ENDSR
063800000000      //---------------------------------------------------------------
063900000000      //  *INZSR  ** - Initialize Program
064000000000      //---------------------------------------------------------------
064100000000     C     *INZSR        BEGSR
064200000000      *
064300000000      * Incoming parm list:
064400000000      *
064500000000     C     *ENTRY        PLIST
064600000000     C                   PARM                    jld
064700000000     C                   PARM                    APPL
064800000000      *
064900000000      * Message file parm list:
065000000000      *
065100000000     C     MSGP01        PLIST
065200000000     C                   PARM                    WWMSGI            7
065300000000      *
065400000000      * Key lists:
065500000000      *
065600000000      *
065700000000     C     PosUserKey    KLIST
065800000000     C                   KFLD                    WCUser
065900000000      *
066000000000     C     PosCatCKey    KLIST
066100000000     C                   KFLD                    WCCatC
066200000000      *
066300000000      * Field definitions:
066400000000      *
066500000000     C     *LIKE         DEFINE    HDSFLP        RRN1
066600000000     C     *LIKE         DEFINE    HDSFLP        WWRRN#
066700000000     C     *LIKE         DEFINE    HDSFLP        WWCRRN
066800000000      *
066900000000      * Initialize:
067000000000      *
067100000000     C                   MOVE      *ZEROS        WWCNT1            2 0
067200000000     C                   MOVE      01            WWCPOS            2 0
067300000000     C                   MOVE      *BLANKS       WWCTAB            3
067400000000     C                   MOVE      *BLANKS       WWCKEY           27
067500000000     C                   MOVE      *BLANKS       WWNFND            1
067600000000     C                   MOVE      YES           WWFRST            1
067700000000     C                   MOVE      YES           WWLOAD            1
067800000000     C                   MOVE      *BLANKS       WWERR1           10
067900000000     C                   MOVE      *BLANKS       WWERR2           10
068000000000     C                   MOVE      *BLANKS       WWERR3            1
068100000000     C                   MOVE      *BLANKS       WWRCDE           10
068200000000     C                   MOVE      *ZEROS        X                 2 0
068300000000      *
068400000000      * Load the program name defined in security file PGMSEC.
068500000000      * This name must be defined in the constant 'PGMNAM'.
068600000000      *
068700000000     C                   MOVEL     PGMNAM        WWPGM            10
068800000000      *
068900000000      * Clear message subfile:
069000000000      *
069100000000     C                   CALL      'ERMSG2'
069200000000     C                   Parm                    dspgmn
069300000000      *
069400000000      * Fill default screen values:
069500000000      *
069600000000      *
069700000000      * Default to the first 'position to' view if value not passed
069800000000      * to this program:
069900000000      *
070000000000     C     WIVIEW        IFEQ      *ZERO
070100000000     C                   Z-ADD     1             WWCPOS            2 0
070200000000     C                   ELSE
070300000000     C                   Z-ADD     WIVIEW        WWCPOS
070400000000     C                   MOVE      *ON           *IN40
070500000000     C                   END
070600000000      *
070700000000      * Set initial 'position to' display indicator. Also load
070800000000      * 'position to' values passed to this program (WIXXX1,2), if
070900000000      * applicable:
071000000000      *
071100000000     C                   SELECT
071200000000      *
071300000000     C                   WHEN      WWCPOS = 1
071400000000     C                   MOVE      *ON           *IN41
071500000000     C                   MOVE      WIuser        WCuser
071600000000      *
071700000000     C                   WHEN      WWCPOS = 2
071800000000     C                   MOVE      *ON           *IN42
071900000000     C                   MOVE      WIcatc        WCcatc
072000000000      *
072100000000     C                   ENDSL
072200000000      *
072300000000      * Set up security options:
072400000000      *
072500000000     C     WISEC         IFEQ      *BLANKS
072600000000     C                   CALL      'SEC0100R'
072700000000     C                   PARM                    WWPGM
072800000000     C                   PARM                    WISEC
072900000000     C                   END
073000000000      *
073100000000      * User not setup in security file:
073200000000      *
073300000000     C     WISEC         IFEQ      '99999'
073400000000     C                   MOVE      '00000'       WISEC
073500000000     C                   MOVE      NO            WWLOAD
073600000000     C                   MOVEL     'SHL0009'     WWMSGI
073700000000     C                   CALL      'ERMSG1'      MSGP01
073800000000      *
073900000000     C                   ELSE
074000000000      *
074100000000      * Clear messages:
074200000000      *
074300000000     C                   CALL      'ERMSG2'
074400000000     C                   Parm                    dspgmn
074500000000     C                   MOVEA     WISEC         *IN(81)
074600000000      *
074700000000      * If program is called to select a record, turn off all
074800000000      * maintenance functions:
074900000000      *
075000000000     C     WISEL         IFEQ      YES
075100000000     C                   MOVE      *ON           *IN86
075200000000     C                   MOVEA     '00010'       *IN(81)
075300000000     C                   END
075400000000      *
075500000000     C                   END
075600000000      *
075700000000     C                   MOVE      *ON           *IN89
075800000000      *
075900000000     C                   MOVE      *ON           *IN36
076000000000      *
076100000000     C                   ENDSR
076200000000      //---------------------------------------------------------------
076300000000**
076400000000 186SELECT
0765000000001 86SELECT
076600000000 282CHANGE
0767000000002 82CHANGE
076800000000 381COPY
0769000000003 81COPY
077000000000 483DELETE
0771000000004 83DELETE
077200000000 584DISPLY
0773000000005 84DISPLY
077400000000 985WRKWTH
0775000000009 85WRKWTH
