000100000000      /copy qcpylesrc,stdhspec
000200000000      ********************************************************************
000300000000      *
000400000000      *  Program....: SEC0001R
000500000000      *
000600000000      *  Description: Program Level Security
000700000000      *
000800000000      *  Programmer.: Greg Cannella
000900000000      *
001000000000      *  Date.......: 02/27/09
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
007100000000      * SEC0002R - Maintenance program                                *
007200000000      *                                                               *
007300000000      *                                                               *
007400000000      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007500000000      *P          P  R  O  G  R  A  M    S  P  E  C  S                P
007600000000      *PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007700000000      *
007800000000     FSEC0001D  CF   E             WORKSTN
007900000000     F                                     SFILE(SCRNS01:RRN1)
008000000000     F                                     INFDS(INFDS)
008100000000     FSECHDRM   IF   E           K DISK
008200000000      *
008300000000      * Option authorization:
008400000000     D OPT             S              2    DIM(12) CTDATA PERRCD(1)
008500000000     D INMD            S             12    DIM(12) ALT(OPT)
008600000000      *
008700000000      *
008800000000      *
008900000000      * Max number of 'position to':
009000000000     D WW#POS          C                   CONST(02)
009100000000      *
009200000000      * Number of records to fill S/F page:
009300000000     D WWPGSZ          C                   CONST(10)
009400000000      *
009500000000      * General constants:
009600000000     D LOAD            C                   CONST('LOAD')
009700000000     D ERROR           C                   CONST('ERROR')
009800000000     D INUSE           C                   CONST('INUSE')
009900000000     D SELECT          C                   CONST('SELECT')
010000000000     D ADD             C                   CONST('ADD')
010100000000     D CHANGE          C                   CONST('CHANGE')
010200000000     D COPY            C                   CONST('COPY')
010300000000     D DELETE          C                   CONST('DELETE')
010400000000     D DISPLY          C                   CONST('DISPLY')
010500000000     D WRKWTH          C                   CONST('WRKWTH')
010600000000     D NO              C                   CONST('N')
010700000000     D YES             C                   CONST('Y')
010800000000      *
010900000000      * General Variables:
011000000000     D WWCNT1          S              2  0 INZ
011100000000     D WWCPOS          S              2  0 INZ(1)
011200000000     D WWCTAB          S              3    INZ
011300000000     D WWCKEY          S             27    INZ
011400000000     D WWNFND          S              1    INZ
011500000000     D WWFRST          S              1    INZ('Y')
011600000000     D WWLOAD          S              1    INZ('Y')
011700000000     D WWERR1          S             10    INZ
011800000000     D WWERR2          S             10    INZ
011900000000     D WWERR3          S              1    INZ
012000000000     D WWRCDE          S             10    INZ
012100000000     D WWPGM           S             10    INZ('SEC0001R')
012200000000     D WWMSGI          S              7    INZ
012300000000     D X               S              2  0 INZ
012400000000     D RRN1            S                   INZ Like(HDSFLP)
012500000000     D WWRRN#          S                   INZ Like(HDSFLP)
012600000000     D WWCRRN          S                   INZ Like(HDSFLP)
012700000000      *
012800000000     D jld           E DS                  EXTNAME(dsjld)
012900000000      *
013000000000      * Incoming parms:
013100000000     D APPL            DS           512
013200000000     D  WISEC                  1      5
013300000000     D  WISEL                  6      6
013400000000     D  WIVIEW                 7      8  0
013500000000     D  WIpgm                  9     18
013600000000      *
013700000000      * Calling parms for SEC0002R:
013800000000     D APP2            DS           512
013900000000     D  A2SEC                  1      5
014000000000     D  A2IUSE                 6     15
014100000000     D  A2INLR                16     16
014200000000     D  A2ACTN                17     26
014300000000     D  A2pgm                 27     36
014400000000     D  A2seq                 37     39
014500000000     D  A2desc                40     89
014600000000      *
014700000000      * Calling parms for SEC0003R:
014800000000     D APP3            DS           512
014900000000     D  A3SEC                  1      5
015000000000     D  A3SEL                  6      6
015100000000     D  A3VIEW                 7      8  0
015200000000     D  A3pgm                  9     18
015300000000     D  A3seq                 19     21
015400000000     D  A3desc                22     71
015500000000      *
015600000000      * Parm to hold message data:
015700000000     D DSMDTA          DS           500
015800000000      *
015900000000      * Split option indicator and action code:
016000000000     D DSSPLT          DS            12
016100000000     D  ZZ                     1      2  0
016200000000     D  DSACTN                 3     12
016300000000      *
016400000000     D INFDS           DS
016500000000     D  SFLLOC               378    379B 0
016600000000      *
016700000000     D                SDS
016800000000     D  DSPGMN           *PROC
016900000000     D  DSUSER               254    263
017000000000      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
017100000000      *M                 M  A  I  N  L  I  N  E                       M
017200000000      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
017300000000      *
017400000000      * Main loop:
017500000000      *
017600000000     C                   Dou       *IN03 = *ON
017700000000      *
017800000000      * Reload subfile, if requested:
017900000000      *
018000000000     C                   If        WWLOAD = YES
018100000000     C                   Exsr      $INSFL
018200000000     C                   Eval      WWLOAD = NO
018300000000     C                   EndIf
018400000000      *
018500000000      * Display screen:
018600000000      *
018700000000     C                   WRITE     MSGCTL1
018800000000     C                   WRITE     SCRNK01
018900000000      *
019000000000     C                   IF        *IN32 = *OFF
019100000000     C                   WRITE     SCRNR01
019200000000     C                   EndIf
019300000000      *
019400000000     C                   EXFMT     SCRNC01
019500000000     C                   MOVE      THEFLD        *IN69
019600000000      *
019700000000     C                   IF        WWFRST = YES
019800000000     C                   Eval      WWFRST = NO
019900000000     C                   EndIf
020000000000      *
020100000000     C                   MOVE      SFLLOC        HDSFLP
020200000000      *
020300000000      * Clear messages:
020400000000      *
020500000000     C                   CALL      'ERMSG2'
020600000000     C                   Parm                    DSPGMN
020700000000      *
020800000000      * Set off all error indicators here:
020900000000      *
021000000000     C                   Eval      *In36 = *Off
021100000000     C                   Eval      *In38 = *Off
021200000000     C                   Eval      *In71 = *Off
021300000000      *
021400000000     C                   IF        *IN03 = *OFF
021500000000      *
021600000000      * Process command keys:
021700000000      *
021800000000     C                   Select
021900000000      *
022000000000      * F4 = Prompt:
022100000000      *
022200000000     C                   When      *In04 = *ON
022300000000     C                   Exsr      $PRMPT
022400000000     C                   Exsr      $INSFL
022500000000      *
022600000000      * F5 = Refresh or 'position to' field value change (*IN40) - reload S/F:
022700000000      *
022800000000     C                   When      *In05 = *ON or *In40 = *ON
022900000000     C                   Exsr      $INSFL
023000000000      *
023100000000      * Rollup (if records exist in S/F - *IN32):
023200000000      *
023300000000     C                   When      *In25 = *ON and *In32 = *ON
023400000000     C                   Exsr      $LDSFL
023500000000      *
023600000000      * Add a record:
023700000000      *
023800000000     C                   WHEN      Wcopta = '1 ' or Wcopta = ' 1'
023900000000      * Must fill in key value
024000000000     c                   Exsr      $ADDRC
024100000000      *
024200000000      * F12 = Cancel
024300000000      *
024400000000     C                   When      *In12 = *ON
024500000000     C                   Eval      *in03 = *on
024600000000      *
024700000000     C                   Other
024800000000      *
024900000000      * Enter:
025000000000      *
025100000000     C                   Exsr      $READC
025200000000      *
025300000000     C                   EndSl
025400000000      *
025500000000     C                   END
025600000000      *
025700000000     C                   ENDDO
025800000000      *
025900000000      * Close called programs:
026000000000      *
026100000000     C                   MOVE      YES           A2INLR
026200000000      *
026300000000      * End the maintenance program:
026400000000      *
026500000000     C                   CALL      'SEC0002R'
026600000000     C                   PARM                    jld
026700000000     C                   PARM                    APP2
026800000000      *
026900000000     C                   Eval      *Inlr = *ON
027000000000      *
027100000000      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
027200000000      *$              S  U  B  R  O  U  T  I  N  E  S                 $
027300000000      *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
027400000000      *
027500000000      //---------------------------------------------------------------
027600000000      //  $INSFL  ** - Initialize Subfile
027700000000      //---------------------------------------------------------------
027800000000     C     $INSFL        BEGSR
027900000000      *
028000000000     C                   CLEAR                   RRN1
028100000000     C                   Z-ADD     1             HDSFLP
028200000000     C                   MOVE      NO            WWNFND
028300000000      *
028400000000     C                   If        *In05 = *On
028500000000     C                   Clear                   Wcpgm
028600000000     C                   EndIf
028700000000      *
028800000000      * Clear subfile:
028900000000      *
029000000000     C                   IF        *In32 = *ON
029100000000     C                   Eval      *IN32 = *OFF
029200000000     C                   Eval      *IN30 = *ON
029300000000     C                   WRITE     SCRNC01
029400000000     C                   Eval      *IN30 = *Off
029500000000     C                   END
029600000000      *
029700000000      * Check for subfile control errors:
029800000000      *
029900000000     C     WWFRST        CASEQ     NO            $ERR01
030000000000     C                   ENDCS
030100000000      *
030200000000      * Position file:
030300000000      *
030400000000     C                   SELECT
030500000000      * Position to Program...
030600000000     C                   When      WWCPOS = 1
030700000000     C     PosPgmKey     SETLL     SECHDRM
030800000000     C                   IF        not %equal(SECHDRM)
030900000000     C                   Eval      WWNFND = YES
031000000000     C                   EndIf
031100000000      *
031200000000     C                   EndSl
031300000000      *
031400000000      * Load subfile:
031500000000      *
031600000000     C                   Exsr      $LDSFL
031700000000      *
031800000000      * Send message if search criteria is not found:
031900000000      *
032000000000     C                   IF        WWNFND = YES
032100000000     C                   IF        *In40 = *ON or *In04 = *On
032200000000     C                   MOVEL     'SHL0006'     WWMSGI
032300000000     C                   CALL      'ERMSG1'      MSGP01
032400000000     C                   EndIf
032500000000     C                   EndIf
032600000000      *
032700000000     C     #INSFL        ENDSR
032800000000      //---------------------------------------------------------------
032900000000      //  $ERR01  ** - Control Screen Validity Checking
033000000000      //---------------------------------------------------------------
033100000000     C     $ERR01        BEGSR
033200000000      *
033300000000     C                   CLEAR                   WWERR1
033400000000      * Position to Program:
033500000000     C                   IF        *In41 = *ON and WCpgm <> *blanks
033600000000     C     PosPgmKey     SETLL     SECHDRM
033700000000     C                   IF        not %equal(SECHDRM)
033800000000     C                   Eval      *In36 = *ON
033900000000     C                   MOVEL     ERROR         WWERR1
034000000000     C                   MOVEL     'SHL0006'     WWMSGI
034100000000     C                   CALL      'ERMSG1'      MSGP01
034200000000     C                   EndIf
034300000000     C                   EndIf
034400000000      *
034500000000     C     #ERR01        ENDSR
034600000000      //---------------------------------------------------------------
034700000000      //  $LDSFL  ** - Load Subfile
034800000000      //---------------------------------------------------------------
034900000000     C     $LDSFL        BEGSR
035000000000      *
035100000000     C                   CLEAR                   WWCNT1
035200000000      *
035300000000     C                   Eval      *In34 = *OFF
035400000000      *
035500000000      * Load one page at a time:
035600000000      *
035700000000     C                   Dow       WWCNT1 < WWPGSZ and *In34 = *Off
035800000000      *
035900000000     C                   SELECT
036000000000      *
036100000000      * Read from file, based on current 'position to' view:
036200000000      *
036300000000     C                   When      WWCPOS = 1
036400000000     C                   READ      SECHDRM                                34
036500000000      *
036600000000     C                   EndSl
036700000000      *
036800000000     C                   IF        *In34 = *Off
036900000000      *
037000000000     C                   CLEAR                   WSOPT#
037100000000     C                   Eval      *In61 = *Off
037200000000      *
037300000000      * Load subfile fields here:
037400000000      *
037500000000     C                   Eval      WSpgm  = SHpgm
037600000000     C                   Eval      WSseq  = SHseq
037700000000     C                   Eval      WSdesc = SHdesc
037800000000      *
037900000000     C                   ADD       1             RRN1
038000000000     C                   ADD       1             WWCNT1
038100000000      *
038200000000     C                   If        WWCNT1 = 1
038300000000     C                   Z-ADD     RRN1          HDSFLP
038400000000     C                   EndIf
038500000000      *
038600000000     C                   WRITE     SCRNS01
038700000000      *
038800000000     C                   END
038900000000      *
039000000000     C                   ENDDO
039100000000      *
039200000000     C                   If        RRN1 > *ZERO
039300000000     C                   Eval      *In32 = *ON
039400000000     C                   EndIf
039500000000      *
039600000000     C                   Eval      *In25 = *Off
039700000000      *
039800000000     C     #LDSFL        ENDSR
039900000000      //---------------------------------------------------------------
040000000000      //  $PRMPT  ** - Process Promptable Fields
040100000000      //---------------------------------------------------------------
040200000000     C     $PRMPT        BEGSR
040300000000      *
040400000000     C                   SELECT
040500000000      *
040600000000      * Non propmtable area:
040700000000      *
040800000000     C                   OTHER
040900000000      *
041000000000     C                   MOVEL     'SHL0004'     WWMSGI
041100000000     C                   CALL      'ERMSG1'      MSGP01
041200000000      *
041300000000     C                   ENDSL
041400000000      *
041500000000     C     #PRMPT        ENDSR
041600000000      //---------------------------------------------------------------
041700000000      //  $ADDRC  ** - Add a record
041800000000      //---------------------------------------------------------------
041900000000     C     $ADDRC        BEGSR
042000000000      *
042100000000     C                   MOVE      YES           WWLOAD
042200000000      *
042300000000     C                   CLEAR                   APP2
042400000000     C                   MOVEL     WISEC         A2SEC
042500000000     C                   MOVEL     ADD           A2ACTN
042600000000     C                   Eval      A2pgm  = WCpgma
042700000000     C                   Eval      A2seq  = WCseqa
042800000000      *
042900000000      * Call maintenance program:
043000000000      *
043100000000     C                   CALL      'SEC0002R'
043200000000     C                   PARM                    jld
043300000000     C                   PARM                    APP2
043400000000      *
043500000000      * Move key fields from maint pgm to 'position to' fields:
043600000000      *
043700000000     C                   Eval      WCpgm = A2pgm
043800000000      *
043900000000     C                   MOVEL     WRRCDE        WWRCDE
044000000000      * Clear add fields
044100000000     c                   Clear                   WCOPTA
044200000000     c                   Clear                   WCpgmA
044300000000     c                   Clear                   WCseqA
044400000000      *
044500000000     C     #ADDRC        ENDSR
044600000000      //---------------------------------------------------------------
044700000000      //  $READC  ** - Process Subfile Requests
044800000000      //---------------------------------------------------------------
044900000000     C     $READC        BEGSR
045000000000      *
045100000000     C                   CLEAR                   WWERR2
045200000000     C                   CLEAR                   WWRCDE
045300000000     C                   CLEAR                   WWRRN#
045400000000      *
045500000000      * Save current RRN:
045600000000      *
045700000000     C                   Z-ADD     RRN1          WWCRRN
045800000000      *
045900000000      * Read all records in the S/F:
046000000000      *
046100000000     C                   Dow       WWRRN# < WWCRRN and
046200000000     C                             WWERR2 <> ERROR and
046300000000     C                             WWRCDE <> INUSE and *IN03 = *off
046400000000      *
046500000000     C                   ADD       1             WWRRN#
046600000000      *
046700000000     C     WWRRN#        CHAIN     SCRNS01                            99
046800000000     C     *IN99         IFEQ      *OFF
046900000000      *
047000000000     C                   MOVE      *OFF          *IN61
047100000000      *
047200000000      * Option number was entered:
047300000000      *
047400000000     C                   If        WSOPT# <> *BLANKS
047500000000      *
047600000000      * Check for subfile option errors:
047700000000      *
047800000000     C                   EXSR      $ERR02
047900000000      *
048000000000     C                   Z-ADD     RRN1          HDSFLP
048100000000      *
048200000000      * Error occurred, return to mainline:
048300000000      *
048400000000     C                   If        WWERR2 = ERROR
048500000000     C                   Eval      *IN61 = *ON
048600000000     C                   Update    SCRNS01
048700000000     C                   Else
048800000000      *
048900000000      * If select, return the key fields and end program:
049000000000      *
049100000000     C                   IF        DSACTN = SELECT
049200000000     C                   Eval      WIpgm = WSpgm
049300000000     C                   Eval      *IN03 = *ON
049400000000     C                   Else
049500000000      *
049600000000      * If Work with, call new work with program.
049700000000      *
049800000000     C                   IF        DSACTN = WRKWTH
049900000000     C                   Eval      a3view = Wiview
050000000000     C                   Eval      a3sec  = WIsec
050100000000     c                   Eval      a3pgm  = WSpgm
050200000000     c                   Eval      a3seq  = WSseq
050300000000     C                   Eval      a3desc = WSdesc
050400000000      *
050500000000     C                   Call      'SEC0003R'
050600000000     C                   Parm                    JLD
050700000000     C                   Parm                    App3
050800000000     C                   Else
050900000000      *
051000000000      * Call maintenance program:
051100000000      *
051200000000     C                   CLEAR                   APP2
051300000000     C                   MOVEL     WISEC         A2SEC
051400000000     C                   MOVEL     DSACTN        A2ACTN
051500000000      *
051600000000      * Move key fields to maintenance program for record access:
051700000000      *
051800000000     C                   Eval      A2pgm  = WSpgm
051900000000     C                   Eval      A2seq  = WSseq
052000000000     C                   Eval      A2desc = WSdesc
052100000000      *
052200000000     C                   CALL      'SEC0002R'
052300000000     C                   PARM                    jld
052400000000     C                   PARM                    APP2
052500000000      *
052600000000      * Move key fields from maint pgm to 'position to' fields:
052700000000      *
052800000000     C                   Eval      WCpgm  = A2pgm
052900000000      *
053000000000     C                   MOVE      YES           WWLOAD
053100000000      *
053200000000     C                   MOVEL     WRRCDE        WWRCDE
053300000000      *
053400000000      * If record lock, send record in use message:
053500000000      *
053600000000     C     WWRCDE        IFEQ      INUSE
053700000000     C                   MOVEL     'SHL0007'     WWMSGI
053800000000     C     A2IUSE        CAT       DSMDTA        DSMDTA
053900000000     C                   CALL      'ERMSG1'      MSGP01
054000000000     C                   CLEAR                   DSMDTA
054100000000     C                   MOVE      NO            WWLOAD
054200000000     C                   END
054300000000      *
054400000000     C                   ENDIF
054500000000      *
054600000000     C                   CLEAR                   WSOPT#
054700000000     C                   UPDATE    SCRNS01
054800000000      *
054900000000     C                   END
055000000000     C                   END
055100000000     C                   END
055200000000     C                   END
055300000000      *
055400000000     C                   ENDDO
055500000000      *
055600000000      * Reset current RRN:
055700000000      *
055800000000     C                   Z-ADD     WWCRRN        RRN1
055900000000      *
056000000000     C                   CLEAR                   WWRCDE
056100000000      *
056200000000     C     #READC        ENDSR
056300000000      *
056400000000      //---------------------------------------------------------------
056500000000      //  $ERR02  ** - Subfile Validity Checking
056600000000      //---------------------------------------------------------------
056700000000     C     $ERR02        BEGSR
056800000000      *
056900000000      * Check for valid option:
057000000000      *
057100000000     C                   Z-ADD     1             X
057200000000     C     WSOPT#        LOOKUP    OPT(X)                                 90
057300000000     C     *IN90         IFEQ      *ON
057400000000     C                   MOVEL     INMD(X)       DSSPLT
057500000000     C                   ELSE
057600000000     C                   CLEAR                   DSSPLT
057700000000     C                   EndIf
057800000000      *
057900000000     C                   SELECT
058000000000      *
058100000000      * If indicator 90 is off, option number is not valid.
058200000000      * If indicator ZZ is off, user is not authorized to option.
058300000000      *
058400000000     C     *IN90         WHENEQ    *OFF
058500000000     C     *IN(ZZ)       OREQ      *OFF
058600000000     C                   MOVEL     'SHL0008'     WWMSGI
058700000000     C                   CALL      'ERMSG1'      MSGP01
058800000000     C                   MOVEL     ERROR         WWERR2
058900000000      *
059000000000     C                   ENDSL
059100000000      *
059200000000     C     #ERR02        ENDSR
059300000000      //---------------------------------------------------------------
059400000000      //  *INZSR  ** - Initialize Program
059500000000      //---------------------------------------------------------------
059600000000     C     *INZSR        BEGSR
059700000000      *
059800000000      * Incoming parm list:
059900000000      *
060000000000     C     *ENTRY        PLIST
060100000000     C                   PARM                    jld
060200000000     C                   PARM                    APPL
060300000000      *
060400000000      * Message file parm list:
060500000000      *
060600000000     C     MSGP01        PLIST
060700000000     C                   PARM                    WWMSGI
060800000000      *
060900000000      * Key lists:
061000000000      *
061100000000      *
061200000000     C     PosPgmKey     KLIST
061300000000     C                   KFLD                    WCPgm
061400000000      *
061500000000      * Clear message subfile:
061600000000      *
061700000000     C                   CALL      'ERMSG2'
061800000000     C                   Parm                    dspgmn
061900000000      *
062000000000      * Fill default screen values:
062100000000      *
062200000000      *
062300000000      * Default to the first 'position to' view if value not passed
062400000000      * to this program:
062500000000      *
062600000000     C     WIVIEW        IFEQ      *ZERO
062700000000     C                   Z-ADD     1             WWCPOS
062800000000     C                   ELSE
062900000000     C                   Z-ADD     WIVIEW        WWCPOS
063000000000     C                   MOVE      *ON           *IN40
063100000000     C                   END
063200000000      *
063300000000      * Set initial 'position to' display indicator. Also load
063400000000      * 'position to' values passed to this program (WIXXX1,2), if
063500000000      * applicable:
063600000000      *
063700000000     C                   SELECT
063800000000      *
063900000000     C                   WHEN      WWCPOS = 1
064000000000     C                   MOVE      *ON           *IN41
064100000000     C                   MOVE      WIpgm         WCpgm
064200000000      *
064300000000     C                   ENDSL
064400000000      *
064500000000      * Set up security options:
064600000000      *
064700000000     C     WISEC         IFEQ      *BLANKS
064800000000     C                   CALL      'SEC0100R'
064900000000     C                   PARM                    WWPGM
065000000000     C                   PARM                    WISEC
065100000000     C                   END
065200000000      *
065300000000      * User not setup in security file:
065400000000      *
065500000000     C     WISEC         IFEQ      '99999'
065600000000     C                   MOVE      '00000'       WISEC
065700000000     C                   MOVE      NO            WWLOAD
065800000000     C                   MOVEL     'SHL0009'     WWMSGI
065900000000     C                   CALL      'ERMSG1'      MSGP01
066000000000      *
066100000000     C                   ELSE
066200000000      *
066300000000      * Clear messages:
066400000000      *
066500000000     C                   CALL      'ERMSG2'
066600000000     C                   Parm                    dspgmn
066700000000     C                   MOVEA     WISEC         *IN(81)
066800000000      *
066900000000      * If program is called to select a record, turn off all
067000000000      * maintenance functions:
067100000000      *
067200000000     C     WISEL         IFEQ      YES
067300000000     C                   MOVE      *ON           *IN86
067400000000     C                   MOVEA     '00010'       *IN(81)
067500000000     C                   END
067600000000      *
067700000000     C                   END
067800000000      *
067900000000     C                   MOVE      *ON           *IN89
068000000000      *
068100000000     C                   MOVE      *ON           *IN36
068200000000      *
068300000000     C                   ENDSR
068400000000      //---------------------------------------------------------------
068500000000**
068600000000 186SELECT
0687000000001 86SELECT
068800000000 282CHANGE
0689000000002 82CHANGE
069000000000 381COPY
0691000000003 81COPY
069200000000 483DELETE
0693000000004 83DELETE
069400000000 584DISPLY
0695000000005 84DISPLY
069600000000 985WRKWTH
0697000000009 85WRKWTH
