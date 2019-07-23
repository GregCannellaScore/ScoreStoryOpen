000300941228     F*****************************************************************
000400941228     F*                                                               *
000500080323     F* Program ID...... SEC0110R                                     *
000600080323     F* Program Desc.... Work With Program Level Security             *
000700080303     F* Log Number...... 1234                                         *
000800941228     F*                                                               *
000900080323     F* Written By...... Greg Cannella                                *
001000080323     F* Date Written....  3/23/08                                     *
001100941228     F*                                                               *
001200941228     F* Comments........                                              *
001300941228     F*                                                               *
001400941228     F*                                                               *
001500941228     F*****************************************************************
001600951010     F* CL Special Processing:                                        *
001700950719     F*                                                               *
001800950719     F*****************************************************************
001900950719     F* Compile Options:                                              *
002000950719     F*                                                               *
002100951009     F*****************************************************************
002200951009     F* Modifications:                                                *
002300951009     F* Req#  By   Date      Modification                             *
002400000706     F* 1234  XXX  XX/XX/XX                                           *
002500951009     F*                                                               *
002600950612     F*****************************************************************
002700941228     F* Indicator Usage:                                              *
002800941228     F* Ind      Use                                                  *
002900950707     F* 01-24    Function keys                                        *
003000950707     F* 25       Rollup                                               *
003100950626     F* 30-34    Subfile keywords                                     *
003200950626     F* 36       Position to                                          *
003300950626     F* 37       Error indicator                                      *
003600950626     F* 40       Search field change                                  *
003700960418     F* 41-42    Search field display                                 *
003800950626     F* 61       Subfile option error                                 *
003900960610     F* 80-89    Reserved for Security                                *
004000950524     F* 90-99    Hit/Miss                                             *
004100941228     F*****************************************************************
004200960418      /EJECT
004300960418     F*****************************************************************
004400960418     F* Field Definitions                                             *
004500960418     F*                                                               *
004600960418     F* Prefix                                                        *
004700960418     F* WW     - Program described work fields                        *
004800960626     F* WI     - APPL *ENTRY input parameters                         *
004900960418     F* WS     - Subfile fields                                       *
005000960418     F* WC     - Subfile control fields                               *
005100960418     F* HD     - Hidden fields                                        *
005200960626     F* Ax     - APPx output parameters for called programs           *
005300960626     F* DS     - Data structure fields                                *
005400960418     F*                                                               *
005500960418     F*                                                               *
005600960418     F* Display Record Format Definitions                             *
005700960418     F*                                                               *
005800960418     F* Prefix                                                        *
005900960418     F* SCRNS  - Subfile                                              *
006000960418     F* SCRNC  - Subfile control                                      *
006100960418     F* SCRNK  - Command key                                          *
006200960418     F* SCRNR  - Standard display                                     *
006300960418     F* WNDWB  - Window border                                        *
006400960418     F* WNDWR  - Standard window display                              *
006500960418     F* MSGCTL - Message subfile control                              *
006600960418     F*                                                               *
006700960418     F*                                                               *
006800960418     F* Called programs                                               *
006900960418     F*                                                               *
007000080304     F* ERMSG2 - Clear program message queue                        *
007100080304     F* ERMSG1 - Send program message with message data             *
007200080324     F* SEC0111R - Maintenance program                                *
007300960418     F*                                                               *
007400960418     F*                                                               *
007500960418     F*****************************************************************
007600941228      /EJECT
007700941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007800941228     F*P          P  R  O  G  R  A  M    S  P  E  C  S                P
007900941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
008000941228     F*
008100080323     FSEC0110D  CF   E             WORKSTN
008200941228     F                                     SFILE(SCRNS01:RRN1)
008300950522     F                                     INFDS(INFDS)
008400080323     FPGMSEC    IF   E           K DISK
008600950524     D*
008601080323     FPGMSEC1   IF   E           K DISK    rename(@pgmsec:@pgmsec1)
008602080323     D*
008700950524     D* Option authorization:
008800080323     D OPT             S              2    DIM(11) CTDATA PERRCD(1)
008900080323     D INMD            S             12    DIM(11) ALT(OPT)
009000941228     D*
009100950522     D*
009200950522     D*
009300970108     D* Max number of 'position to':
009400970108     D WW#POS          C                   CONST(02)
009500941228     D*
009600950522     D* Number of records to fill S/F page:
009700970108     D WWPGSZ          C                   CONST(10)
009800941228     D*
010200950523     D* General constants:
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
011300080324     D PGMNAM          C                   CONST('SEC0110R  ')
011400950608     D NO              C                   CONST('N')
011500950523     D YES             C                   CONST('Y')
011600950522     D*
011700080324     Djld            E DS                  EXTNAME(dsjld)
011800950524     D*
011900950619     D* Incoming parms:
012000970225     D APPL            DS           512
012100970225     D  WISEC                  1      5
012200970225     D  WISEL                  6      6
012300970225     D  WIVIEW                 7      8  0
012400080323     D  WIUSER                 9     18
012500080323     D  WIPGM                 19     28
012600950608     D*
012700080324     D* Calling parms for SEC0111R:
012800950608     D APP2            DS           512
012900960626     D  A2SEC                  1      5
013000960626     D  A2IUSE                 6     15
013100960626     D  A2INLR                16     16
013200960626     D  A2ACTN                17     26
013300080323     D  A2USER                27     36
013400080323     D  A2PGM                 37     46
014500950906     D*
014600080304     D* Parm to hold message data:
014700950906     D DSMDTA          DS           500
014800950525     D*
014900950525     D* Split option indicator and action code:
015000950525     D DSSPLT          DS            12
015100950525     D  ZZ                     1      2  0
015200950525     D  DSACTN                 3     12
015300950619     D*
015400950619     D INFDS           DS
015500950619     D  SFLLOC               378    379B 0
015600941228     D*
015700941228     D                SDS
015800960705     D  DSPGMN           *PROC
015900950616     D  DSUSER               254    263
016000950626      /EJECT
016100941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
016200941228     M*M                 M  A  I  N  L  I  N  E                       M
016300941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
016400941228     M*
016500950526     C*
016600970108     C* Main loop:
016700970108     C*
016800941228     C     *IN03         DOUEQ     *ON
016900951020     C*
017000970108     C* Reload subfile, if requested:
017100970108     C*
017200951020     C     WWLOAD        IFEQ      YES
017300951020     C                   EXSR      $INSFL
017400951020     C                   MOVE      NO            WWLOAD
017500951020     C                   END
017600950802     C*
017700970113     C* Display screen:
017800970113     C*
017900950802     C                   WRITE     MSGCTL1
018000950802     C                   WRITE     SCRNK01
018100950802     C*
018200950802     C     *IN32         IFEQ      *OFF
018300950802     C                   WRITE     SCRNR01
018400950802     C                   END
018500950802     C*
018600941228     C                   EXFMT     SCRNC01
018700000810     C                   MOVE      THEFLD        *IN69
018800950706     C*
018900950706     C     WWFRST        IFEQ      YES
019000950706     C                   MOVE      NO            WWFRST
019100950706     C                   END
019200950614     C*
019300950523     C                   MOVE      SFLLOC        HDSFLP
019400950523     C*
019500950523     C* Clear messages:
019600950523     C*
019700080324     C                   CALL      'ERMSG2'
019701080324     C                   Parm                    DSPGMN
019800941228     C*
019900970113     C* Set off all error indicators here:
020000960418     C*
020100950523     C                   MOVE      *OFF          *IN36
020200970108     C                   MOVE      *OFF          *IN38
020300941228     C*
020400941228     C     *IN03         IFEQ      *OFF
020500950522     C*
020600080323     C* Process command keys:
020700941228     C*
020800950522     C                   SELECT
020900950524     C*
022800960626     C*
022900960626     C* F4 = Prompt:
023000960626     C*
023100960626     C     *IN04         WHENEQ    *ON
023200960626     C                   EXSR      $PRMPT
023300960626     C                   EXSR      $INSFL
023400950526     C*
023500950526     C* F10 = Position to:
023600950526     C*
023700950526     C     *IN10         WHENEQ    *ON
023800950526     C                   EXSR      $POSTO
023900950522     C*
024000970108     C* F5 or 'position to' field value change (*IN40) - reload S/F:
024100950523     C*
024200941228     C     *IN05         WHENEQ    *ON
024300941228     C     *IN40         OREQ      *ON
024400941228     C                   EXSR      $INSFL
024500950605     C*
024600950605     C* Rollup (if records exist in S/F - *IN32):
024700950605     C*
024800950605     C     *IN25         WHENEQ    *ON
024900950605     C     *IN32         ANDEQ     *ON
025000950605     C                   EXSR      $LDSFL
025100950605     C*
025200960418     C* F6 = Add a record:
025300950605     C*
025400950605     C     *IN06         WHENEQ    *ON
025500960626     C                   EXSR      $ADDRC
025501080325     C*
025502080325     C* F12= Cancel
025503080325     C*
025504080325     C     *IN12         WHENEQ    *ON
025505080325     C                   Eval      *in03=*on
025600950522     C*
025700950522     C                   OTHER
025800950522     C*
025900950522     C* Enter:
026000950522     C*
026100941229     C                   EXSR      $READC
026200941228     C*
026300950522     C                   ENDSL
026400950522     C*
026500941228     C                   END
026600941228     C*
026700941228     C                   ENDDO
026800950710     C*
026900960611     C* Close called programs:
027000950710     C*
027100960626     C                   MOVE      YES           A2INLR
027200950710     C*
027300970113     C* End the maintenance program:
027400970113     C*
027500080323     C                   CALL      'SEC0111R'
027600080324     C                   PARM                    jld
027700950710     C                   PARM                    APP2
027800950526     C*
027900950522     C                   MOVE      *ON           *INLR
028000941228     C*
028100950626      /EJECT
028200941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028300941228     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
028400941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
028500941228     C*
028600941228     C**************
028700950522     C**  $INSFL  ** - Initialize Subfile
028800941228     C**************
028900950522     C     $INSFL        BEGSR
029000950522     C*
029100950522     C                   CLEAR                   RRN1
029200950523     C                   Z-ADD     1             HDSFLP
029300941228     C                   MOVE      NO            WWNFND
029400950522     C*
029500950522     C* Clear subfile:
029600950522     C*
029700950525     C     *IN32         IFEQ      *ON
029800950802     C                   MOVE      *OFF          *IN32
029900950522     C                   MOVE      *ON           *IN30
030000950522     C                   WRITE     SCRNC01
030100950522     C                   MOVE      *OFF          *IN30
030200950525     C                   END
030300950523     C*
030400960418     C* Check for subfile control errors:
030500950605     C*
030600950605     C     WWFRST        CASEQ     NO            $ERR01
030700950605     C                   ENDCS
030800950605     C*
030900970108     C* Position file:
031000970113     C*
031100970113     C****************************************************************
031200970113     C* WHSXXX - Logical file based on current 'position to' view.
031300080303     C*  eg; physical file is INVMF and current 'position to' is
031400080303     C*      by style number, WHSXXX = INVMF (key = style #).
031500970113     C*
031600950530     C*
031700970113     C* XXXK01 - Key list based on current 'position to' fields.
031800970113     C*  eg; if 'position to' field is item number:
031900080303     C*          XXXK01 = INVK01  KLIST
032100970113     C*                           KFLD      WCITM#
032200970113     C****************************************************************
032300970113     C*
032400970113     C                   SELECT
032500970113     C*
032600950530     C     WWCPOS        WHENEQ    1
032700080323     C     psk01         SETLL     pgmsec                                 99
032800950523     C     *IN99         IFEQ      *OFF
032900941228     C                   MOVE      YES           WWNFND
033000950523     C                   END
033100970108     C*
033200970108     C     WWCPOS        WHENEQ    2
033300080323     C     psk02         SETLL     pgmsec                                 99
033400970108     C     *IN99         IFEQ      *OFF
033500970108     C                   MOVE      YES           WWNFND
033600970108     C                   END
033700950530     C*
033800950530     C                   ENDSL
033900950522     C*
034000970108     C* Load subfile:
034100970108     C*
034200950522     C                   EXSR      $LDSFL
034300950523     C*
034400950523     C* Send message if search criteria is not found:
034500950523     C*
034600941228     C     WWNFND        IFEQ      YES
034700951020     C     *IN40         IFEQ      *ON
034800951020     C     *IN04         OREQ      *ON
034900080324     C                   MOVEL     'SHL0006'     WWMSGI
035100080304     C                   CALL      'ERMSG1'      MSGP01
035200950523     C                   END
035300951020     C                   END
035400950522     C*
035500950522     C                   ENDSR
035600970109     C/EJECT
035700970109     C*
035800970109     C**************
035900970109     C**  $ERR01  ** - Control Screen Validity Checking
036000970109     C**************
036100970109     C     $ERR01        BEGSR
036200970109     C*
036300970109     C                   CLEAR                   WWERR1
036400970109     C*
036500970113     C*****************************************************************
036600970113     C* All error conditions must have the following lines of code:
036700970113     C*
036800970113     C*   MOVE *ON       *INXX
036900970113     C*     Where *INXX = field error indicator in DDS.
037000970113     C*
037100970113     C*   MOVELERROR     WWERR1
037200970113     C*     Program error flag.
037300970113     C*
037400970113     C*   MOVEL'XXX0001' WWMSGI
037500970113     C*     Where XXX0001 = error message id to be displayed.
037600970113     C*
037700970113     C*   MOVELXXXXXX    WWMSGF
037800970113     C*     Where XXXXXX = name of the message file which contains
037900970113     C*     the message id contained in field WWMSGI.
038000970113     C*
038100080304     C*   CALL 'ERMSG1'  MSGP01
038200970113     C*     Message handling program.
038300970113     C*****************************************************************
038400970113     C*
038500970114     C* Field 1:
038600080323     C     *IN41         IFEQ      *ON
038700080324     C     WCuser        ANDNE     ' '
038800080323     C     psk01         SETLL     pgmsec                                 99
038900970109     C     *IN99         IFEQ      *OFF
039000970109     C                   MOVE      *ON           *IN36
039100970109     C                   MOVEL     ERROR         WWERR1
039200080324     C                   MOVEL     'SHL0006'     WWMSGI
039400080304     C                   CALL      'ERMSG1'      MSGP01
039500970109     C                   END
039600970109     C                   END
039700970109     C*
039800080323     C     *IN42         IFEQ      *ON
039900080324     C     WCpgm         ANDNE     ' '
040000080323     C     psk02         SETLL     pgmsec1                                99
040100970109     C     *IN99         IFEQ      *OFF
040200970109     C                   MOVE      *ON           *IN36
040300970109     C                   MOVEL     ERROR         WWERR1
040400080324     C                   MOVEL     'SHL0006'     WWMSGI
040600080304     C                   CALL      'ERMSG1'      MSGP01
040700970109     C                   END
040800970109     C                   END
040900970109     C*
041000970109     C                   ENDSR
041100950523     C/EJECT
041200950522     C*
041300950522     C**************
041400950522     C**  $LDSFL  ** - Load Subfile
041500950522     C**************
041600950522     C     $LDSFL        BEGSR
041700950522     C*
041800950522     C                   CLEAR                   WWCNT1
041900950727     C*
042000950727     C                   MOVE      *OFF          *IN34
042100950522     C*
042200970108     C* Load one page at a time:
042300970108     C*
042400950522     C     WWCNT1        DOWLT     WWPGSZ
042500950522     C     *IN34         ANDEQ     *OFF
042600970113     C*****************************************************************
044300970113     C*
044400950727     C                   SELECT
044500950727     C*
044600970108     C* Read from file, based on current 'position to' view:
044700970108     C*
044800950727     C     WWCPOS        WHENEQ    1
044900080323     C                   READ      pgmsec                                 34
045000970108     C*
045100970108     C     WWCPOS        WHENEQ    2
045200080323     C                   READ      pgmsec1                                34
045300950727     C*
045400950727     C                   ENDSL
045500950727     C*
045600950727     C     *IN34         IFEQ      *OFF
045700960418     C*
045800950607     C                   CLEAR                   WSOPT#
045900950607     C                   MOVE      *OFF          *IN61
046000960606     C*
046100970108     C* Load subfile fields here:
046400950522     C*
046500080323     C                   MOVE      psuser        WSuser
046501080323     C                   MOVE      pspgm         WSpgm
046502080323     C                   MOVE      psopt1        WSopt1
046503080323     C                   MOVE      psopt2        WSopt2
046504080323     C                   MOVE      psopt3        WSopt3
046505080323     C                   MOVE      psopt4        WSopt4
046506080323     C                   MOVE      psopt5        WSopt5
046600960627     C*
046700950522     C                   ADD       1             RRN1
046800950522     C                   ADD       1             WWCNT1
046900950523     C*
047000950523     C     WWCNT1        IFEQ      1
047100950523     C                   Z-ADD     RRN1          HDSFLP
047200950523     C                   END
047300950522     C*
047400950522     C                   WRITE     SCRNS01
047500950727     C*
047600950727     C                   END
047700950522     C*
047800950522     C                   ENDDO
047900950522     C*
048000950522     C     RRN1          IFGT      *ZERO
048100950522     C                   MOVE      *ON           *IN32
048200950522     C                   END
048300950522     C*
048400950522     C                   MOVE      *OFF          *IN25
048500950522     C*
048600950522     C                   ENDSR
051100970109     C/EJECT
051200970109     C*
051300970109     C**************
051400970109     C**  $PRMPT  ** - Process Promptable Fields
051500970109     C**************
051600970109     C     $PRMPT        BEGSR
051700970113     C*
051800970113     C*****************************************************************
051900970113     C*  Field HDCSRF (defined in DDS) contains the field name which
052000970113     C*  contains the cursor. If valid, a prompting program may be
052100970113     C*  called to select a record from a list of valid values for
052200970113     C*  the prompted field. The value selected should then be placed
052300970113     C*  in the field which was prompted.
052400970113     C*
052500970113     C* eg; HDCSRF    WHEQ 'WCXXX1'
052600970113     C*      Cursor resides in field WCXXX1
052700970113     C*
052800970113     C*     CALL 'GEN0109R'
052900970113     C*      Codes file prompting program.
053000970113     C*
053100970113     C*     PARM '653'     WWCTAB
053200970113     C*      Outgoing parm.
053300970113     C*
053400970113     C*     PARM *BLANKS   WWCKEY
053500970113     C*      Return parm.
053600970113     C*
053700970113     C*     MOVELWWCKEY    WCXXX1
053800970113     C*      Move return parm into prompted field.
053900970113     C*
054000970113     C*****************************************************************
054100970113     C*
054200970113     C                   SELECT
054300970113     C*
054400080323     C*    HDCSRF        WHENEQ    'WCXXX1'
054500080323     C*                  CALL      'GEN0109R'
054600080323     C*                  PARM      '653'         WWCTAB
054700080323     C*                  PARM      *BLANKS       WWCKEY
054800080323     C*                  MOVEL     WWCKEY        WCXXX1
054900080323     C*
055000080323     C*    HDCSRF        WHENEQ    'WCXXX2'
055100080323     C*                  CALL      'GEN0109R'
055200080323     C*                  PARM      '654'         WWCTAB
055300080323     C*                  PARM      *BLANKS       WWCKEY
055400080323     C*                  MOVEL     WWCKEY        WCXXX2
055500970109     C*
055600970109     C* Non propmtable area:
055700970109     C*
055800970109     C                   OTHER
055900970109     C*
056000080324     C                   MOVEL     'SHL0004'     WWMSGI
056200080304     C                   CALL      'ERMSG1'      MSGP01
056300970109     C*
056400970109     C                   ENDSL
056500970109     C*
056600970109     C                   ENDSR
056700950523     C/EJECT
056800941228     C*
056900941228     C**************
057000941228     C**  $POSTO  ** - Position To
057100941228     C**************
057200941228     C     $POSTO        BEGSR
057300941228     C*
057400970108     C* Clear all 'position to' fields here:
057500960418     C*
057600080323     C                   CLEAR                   WCuser
057700080323     C                   CLEAR                   WCpgm
057800960418     C*
057900950607     C                   CLEAR                   RRN1
058000950607     C                   CLEAR                   HDSFLP
058100950526     C*
058200950526     C* Clear subfile:
058300950526     C*
058400950526     C     *IN32         IFEQ      *ON
058500950802     C                   MOVE      *OFF          *IN32
058600950526     C                   MOVE      *ON           *IN30
058700950526     C                   WRITE     SCRNC01
058800950526     C                   MOVE      *OFF          *IN30
058900950526     C                   END
059000950526     C*
059100960418     C* Position cursor:
059200960418     C*
059300950526     C                   MOVE      *ON           *IN36
059400941228     C*
059500970108     C* Toggle to next 'position to' field:
059600960418     C*
059700941228     C     WWCPOS        ADD       1             WWCPOS
059800941228     C*
059900941228     C     WWCPOS        IFGT      WW#POS
060000950525     C                   Z-ADD     1             WWCPOS
060100941228     C                   END
060200941228     C*
060300970113     C*****************************************************************
060400970114     C* When a 'position to' view is changed, the new display
060500970113     C* indicator (from DDS) must be set on and all other 'position to'
060600970113     C* display indicators must be turned off.
060700970113     C*
060800970113     C*  eg; 'position to' #1 by agency (display indicator *IN41)
060900970113     C*      'position to' #2 by agency/chain (display indicator *IN42)
061000970113     C*
061100970113     C*  If user toggles to 'position to' by agency/chain, indicator
061200970113     C*  *IN41 must be turned off and *IN42 turned on.
061300970113     C*
061400970113     C*      MOVEA'01'      *IN,41
061500970113     C*****************************************************************
061600970113     C*
061700970113     C* Set 'position to' field display indicator:
061800970113     C*
061900950530     C                   SELECT
062000950530     C*
062100080323     C     WWCPOS        WHENEQ    1
062200970108     C                   MOVEA     '10'          *IN(41)
062300970108     C*
062400080323     C     WWCPOS        WHENEQ    2
062500970108     C                   MOVEA     '01'          *IN(41)
062600950530     C*
062700950530     C                   ENDSL
062800941228     C*
062900941228     C                   ENDSR
063000970109     C/EJECT
063100970109     C*
063200970109     C**************
063300970109     C**  $ADDRC  ** - Add a record
063400970109     C**************
063500970109     C     $ADDRC        BEGSR
063600970109     C*
063700970113     C*****************************************************************
063800970113     C* Parms required to be passed to the maintenance program:
063900970113     C*   1. WISEC = program level security.
064000970113     C*   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
064300970113     C*
064400970113     C*****************************************************************
064500970113     C*
064600970109     C                   MOVE      YES           WWLOAD
064700970109     C*
064800970109     C                   CLEAR                   APP2
064900970109     C                   MOVEL     WISEC         A2SEC
065000970109     C                   MOVEL     ADD           A2ACTN
065200970113     C*
065300970113     C* Call maintenance program:
065400970109     C*
065500080323     C                   CALL      'SEC0111R'
065600080324     C                   PARM                    jld
065700970109     C                   PARM                    APP2
065800970109     C*
065900970113     C*****************************************************************
066000970113     C* When returning from the maintenance program, this program will
066100970113     C* automatically position the subfile list to the last record
066200970113     C* added to the file. To do this, the maintenance program must
066300970113     C* return all 'position to' field values to this program.
066400970113     C*
066600080303     C*   eg; 'position to' #1 = Item Number
066700080303     C*       'position to' #2 = Item Type Code
066701080303     C*
066800970113     C*
066900970113     C*  Using this example, when a record is added to the file, the
067000970113     C*  maintenance program will return the values of all of the above
067100080303     C*  'position to' fields (Item Number, Item Type Code).
067200970113     C*  The subfile list will then automatically be positioned based
067300970113     C*  on the current 'position to' view.
067400970113     C*
067500970113     C*****************************************************************
067600970113     C*
067700970109     C* Move key fields from maint pgm to 'position to' fields:
067800970109     C*
067900080323     C                   MOVE      A2user        WCuser
068000080323     C                   MOVE      A2pgm         WCpgm
068100970109     C*
068200970109     C                   MOVEL     WRRCDE        WWRCDE
068300970109     C*
068600970109     C                   ENDSR
068700950607     C/EJECT
068800950607     C*
068900950607     C**************
069000950607     C**  $READC  ** - Process Subfile Requests
069100950607     C**************
069200950607     C     $READC        BEGSR
069300950525     C*
069400950525     C                   CLEAR                   WWERR2
069500941228     C                   CLEAR                   WWRCDE
069600941228     C                   CLEAR                   WWRRN#
069700941228     C*
069800950626     C* Save current RRN:
069900950626     C*
070000941228     C                   Z-ADD     RRN1          WWCRRN
070100950525     C*
070200941228     C* Read all records in the S/F:
070300941228     C*
070400941228     C     WWRRN#        DOWLT     WWCRRN
070500950525     C     WWERR2        ANDNE     ERROR
070600950713     C     WWRCDE        ANDNE     INUSE
070700960610     C     *IN03         ANDEQ     *OFF
070800941228     C*
070900941228     C                   ADD       1             WWRRN#
071000941228     C*
071100941228     C     WWRRN#        CHAIN     SCRNS01                            99
071200941228     C     *IN99         IFEQ      *OFF
071300950525     C*
071400950607     C                   MOVE      *OFF          *IN61
071500941228     C*
071600970109     C* Option number was entered:
071700970109     C*
071800941228     C     WSOPT#        IFNE      *BLANKS
071900950607     C*
072000970109     C* Check for subfile option errors:
072100970109     C*
072200950607     C                   EXSR      $ERR02
072300950607     C*
072400970109     C                   Z-ADD     RRN1          HDSFLP
072500970109     C*
072600970109     C* Error occurred, return to mainline:
072700970109     C*
072800950607     C     WWERR2        IFEQ      ERROR
072900950607     C                   MOVE      *ON           *IN61
073000950607     C                   UPDATE    SCRNS01
073100950607     C                   ELSE
073200951027     C*
073300970113     C*****************************************************************
073400970113     C* If this program is called as a record selection program
073500970113     C* (WISEL = 'Y'), return the desired field(s) to the calling
073600970113     C* program through the APPL parm list.
073700970113     C*
073800970113     C*   eg; Call this program to retrieve a chain code.
073900970113     C*
074000970113     C*     DSACTN    IFEQ SELECT
074100970113     C*       Record has been selected.
074200970113     C*
074300970113     C*               MOVE WSCHN     WICHN
074400970113     C*                 Move the chain code from the S/F to the APPL
074500970113     C*                 parm WICHN.
074600970113     C*
075100970113     C*               MOVE *ON       *IN03
075200970113     C*                 End this program.
075300970113     C*
075400970113     C*****************************************************************
075500970108     C* If select, return the key fields and end program:
075600960610     C*
075700960626     C     DSACTN        IFEQ      SELECT
075800080323     C                   MOVE      WSuser        WIuser
075801080323     C                   MOVE      WSpgm         WIpgm
076000960610     C                   MOVE      *ON           *IN03
076100960610     C                   ELSE
076200970113     C*
076201080324     C*
076202080324     C*****************************************************************
076203080324     C* If Work with, call new work with program.
076204080324     C*
076205080324     C     DSACTN        IFEQ      WRKWTH
076206080324     C                   Call      'SHLDUMMYR'
076207080324     C                   Else
076300970113     C*****************************************************************
076400970113     C* Parms required to be passed to the maintenance program:
076500970113     C*   1. WISEC = program level security.
076600970113     C*   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
076900080303     C*   3. The key of the record to be maintained.
077000970117     C*
077100970113     C*****************************************************************
077200950525     C*
077300960418     C* Call maintenance program:
077400941228     C*
077500950608     C                   CLEAR                   APP2
077600960626     C                   MOVEL     WISEC         A2SEC
077700960626     C                   MOVEL     DSACTN        A2ACTN
077900970108     C*
078000970113     C* Move key fields to maintenance program for record access:
078100970108     C*
078200080323     C                   MOVE      WSuser        A2user
078201080323     C                   MOVE      WSpgm         A2pgm
078300950525     C*
078400080323     C                   CALL      'SEC0111R'
078500080324     C                   PARM                    jld
078600950608     C                   PARM                    APP2
078700970113     C*
078800970113     C*****************************************************************
078900970113     C* When returning from the maintenance program, this program will
079000970113     C* automatically position the subfile list to the last record
079100970113     C* processed. To do this, the maintenance program must return all
079200970113     C* 'position to' field values to this program.
079300970113     C*
079601080303     C*   eg; 'position to' #1 = Item Number
079602080303     C*       'position to' #2 = Item Type Code
079700970113     C*
079800970113     C*  Using this example, when a record is maintained, the
079900970113     C*  maintenance program will return the values of all of the above
080000080303     C*  'position to' fields (item number, item type code).
080100970113     C*  The subfile list will then automatically be positioned based
080200970113     C*  on the current 'position to' view.
080300970113     C*
080400970113     C*****************************************************************
080500960701     C*
080600970108     C* Move key fields from maint pgm to 'position to' fields:
080700960701     C*
080800080323     C                   MOVE      A2user        WCuser
080900080323     C                   MOVE      A2pgm         WCpgm
081000960701     C*
081100960701     C                   MOVE      YES           WWLOAD
081200950608     C*
081300941228     C                   MOVEL     WRRCDE        WWRCDE
081400941228     C*
081700970113     C* If record lock, send record in use message:
081800951027     C*
081900951027     C     WWRCDE        IFEQ      INUSE
082000080324     C                   MOVEL     'SHL0007'     WWMSGI
082200970108     C     A2IUSE        CAT       DSMDTA        DSMDTA
082300080304     C                   CALL      'ERMSG1'      MSGP01
082400951027     C                   CLEAR                   DSMDTA
082500951027     C                   MOVE      NO            WWLOAD
082600951027     C                   END
082700941228     C*
082701080324     C                   ENDIF
082702080324     C*
082800950526     C                   CLEAR                   WSOPT#
082900950525     C                   UPDATE    SCRNS01
083000950525     C*
083100950525     C                   END
083200960610     C                   END
083300950526     C                   END
083400941228     C                   END
083500950525     C*
083600941228     C                   ENDDO
083700941228     C*
083800941228     C* Reset current RRN:
083900941228     C*
084000941228     C                   Z-ADD     WWCRRN        RRN1
084100950714     C*
084200950714     C                   CLEAR                   WWRCDE
084300950525     C*
084400950525     C                   ENDSR
084500950607     C/EJECT
084600950607     C*
084700950607     C**************
084800950607     C**  $ERR02  ** - Subfile Validity Checking
084900950607     C**************
085000950607     C     $ERR02        BEGSR
085100950607     C*
085200950607     C* Check for valid option:
085300950607     C*
085400950607     C                   Z-ADD     1             X
085500950607     C     WSOPT#        LOOKUP    OPT(X)                                 90
085600950607     C     *IN90         IFEQ      *ON
085700950607     C                   MOVEL     INMD(X)       DSSPLT
085800950612     C                   ELSE
085900950612     C                   CLEAR                   DSSPLT
086000950607     C                   END
086100950607     C*
086200950607     C                   SELECT
086300950607     C*
086400950714     C* If indicator 90 is off, option number is not valid.
086500950714     C* If indicator ZZ is off, user is not authorized to option.
086600950714     C*
086700950607     C     *IN90         WHENEQ    *OFF
086800950612     C     *IN(ZZ)       OREQ      *OFF
086900080324     C                   MOVEL     'SHL0008'     WWMSGI
087100080304     C                   CALL      'ERMSG1'      MSGP01
087200950607     C                   MOVEL     ERROR         WWERR2
087300950607     C*
087400950607     C                   ENDSL
087500950607     C*
087600950607     C                   ENDSR
087700950525     C/EJECT
087800950525     C*
087900950525     C**************
088000950626     C**  *INZSR  ** - Initialize Program
088100950525     C**************
088200950525     C     *INZSR        BEGSR
088300950522     C*
088400950522     C* Incoming parm list:
088500950522     C*
088600950523     C     *ENTRY        PLIST
088700080324     C                   PARM                    jld
088800950524     C                   PARM                    APPL
088900950523     C*
089000950523     C* Message file parm list:
089100950523     C*
089200950906     C     MSGP01        PLIST
089300950621     C                   PARM                    WWMSGI            7
089600950522     C*
089700950522     C* Key lists:
089800970108     C*
089900970108     C     CODK01        KLIST
090000970108     C                   KFLD                    WWCTAB
090100970108     C                   KFLD                    WWCKEY
090200950522     C*
090300080323     C     psk01         KLIST
090400080323     C                   KFLD                    wcuser
090401080323     C*
090402080323     C     psk02         KLIST
090403080323     C                   KFLD                    wcpgm
090500950522     C*
090600950522     C* Field definitions:
090700950522     C*
090800950522     C     *LIKE         DEFINE    HDSFLP        RRN1
090900941228     C     *LIKE         DEFINE    HDSFLP        WWRRN#
091000941228     C     *LIKE         DEFINE    HDSFLP        WWCRRN
091100950522     C*
091200950522     C* Initialize:
091300950522     C*
091400960610     C*
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
092700970225     C*
092800970225     C* Load the program name defined in security file PGMSEC.
092900970225     C* This name must be defined in the constant 'PGMNAM'.
093000970225     C*
093100970225     C                   MOVEL     PGMNAM        WWPGM            10
093200970225     C*
093300970225     C* Clear message subfile:
093400970225     C*
093500080304     C                   CALL      'ERMSG2'
093501080304     C                   Parm                    dspgmn
093600960705     C*
093700960705     C* Fill default screen values:
093800960705     C*
093900950616     C                   MOVEL     DSUSER        WCUSER
094000950524     C*
095600970225     C*
095700970225     C* Default to the first 'position to' view if value not passed
095800970225     C* to this program:
095900970225     C*
096000970225     C     WIVIEW        IFEQ      *ZERO
096100970225     C                   Z-ADD     1             WWCPOS            2 0
096200970225     C                   ELSE
096300970225     C                   Z-ADD     WIVIEW        WWCPOS
096400970225     C                   MOVE      *ON           *IN40
096500970225     C                   END
096600970225     C*
096700970225     C* Set initial 'position to' display indicator. Also load
096800970225     C* 'position to' values passed to this program (WIXXX1,2), if
096900970225     C* applicable:
097000970225     C*
097100970225     C                   SELECT
097200970225     C*
097300970225     C     WWCPOS        WHENEQ    1
097400970225     C                   MOVE      *ON           *IN41
097500080323     C                   MOVE      WIuser        WCuser
097600970225     C*
097700970225     C     WWCPOS        WHENEQ    2
097800970225     C                   MOVE      *ON           *IN42
097900080323     C                   MOVE      WIpgm         WCpgm
098000970225     C*
098100970225     C                   ENDSL
098200970114     C*****************************************************************
098300970114     C* Field WISEC is a 5 byte logical indicator field used to control
098400970114     C* user access to all maintenance functions (eg; change, delete).
098500970114     C* Each byte will have a value of either '0'(not authorized) or
098600970114     C* '1'(authorized). This field will be moved into indicator
098700970114     C* array *IN,81.
098800970114     C*
098900970114     C*
099000970114     C*  WISEC = '00000'                  *IN81 = Add/Copy
099100080323     C*           |||||___ Work With      *IN82 = Change
099200080323     C*         Add|||     (Extra)        *IN83 = Delete
099300970114     C*            |||                    *IN84 = Display
099400080323     C*       Change||                    *IN85 = Work With
099500970114     C*             ||
099600970114     C*        Delete|
099700970114     C*              |
099800970114     C*        Display
099900970114     C*
100000970114     C*****************************************************************
100100970114     C*
100200950524     C* Set up security options:
100300950524     C*
100400970225     C     WISEC         IFEQ      *BLANKS
100500080324     C                   CALL      'SEC0100R'
100600970225     C                   PARM                    WWPGM
100700970225     C                   PARM                    WISEC
100800970225     C                   END
100900970225     C*
101000970225     C* User not setup in security file:
101100970225     C*
101200970225     C     WISEC         IFEQ      '99999'
101300970225     C                   MOVE      '00000'       WISEC
101400970225     C                   MOVE      NO            WWLOAD
101500080324     C                   MOVEL     'SHL0009'     WWMSGI
101700080304     C                   CALL      'ERMSG1'      MSGP01
101800970225     C*
101900970225     C                   ELSE
102000980716     C*
102100980716     C* Clear messages:
102200980716     C*
102301080304     C                   CALL      'ERMSG2'
102302080304     C                   Parm                    dspgmn
102400001221     C                   MOVEA     WISEC         *IN(81)
102500960610     C*
102600970108     C* If program is called to select a record, turn off all
102700970108     C* maintenance functions:
102800970108     C*
102900960626     C     WISEL         IFEQ      YES
103000960610     C                   MOVE      *ON           *IN86
103100970108     C                   MOVEA     '00010'       *IN(81)
103200960610     C                   END
103300970225     C*
103400970225     C                   END
103500970225     C*
103600970114     C*****************************************************************
103700950612     C* All users are authorized to any *IN89 option from table OPT:
103800970113     C*
103900970114     C*        Option Named
104000970114     C*            Constant
104100970113     C*              |    |
104200970113     C* Authorization|    |
104300970113     C*     Indicator|    |
104400970113     C*            |||    |
104500970113     C*      Option|||    |
104600970113     C*          |||||    |
104700970113     C*   eg ;    282CHANGE
104800970113     C*          2 82CHANGE
104900970113     C*           789ITMINQ
105000970113     C*          7 89ITMINQ
105100970113     C*           989POINQ
105200970113     C*          9 89POINQ
105300970113     C*
105400970113     C*  In this example, option 2 to change a record is available
105500970113     C*  only to users which have authorization (*IN82). option 7 to
105600970128     C*  view the item inquiry and option 9 to view the PO inquiry are
105700970113     C*  setup in the table with indicator *IN89, therefore will be
105800970113     C*  available to all users, without restriction.
105900970114     C*
106000970114     C*****************************************************************
106100970113     C*
106200950612     C                   MOVE      *ON           *IN89
106300980716     C*
106400980716     C                   MOVE      *ON           *IN36
106500950522     C*
106600941228     C                   ENDSR
106700950525**
106800960610 186SELECT
1069009606101 86SELECT
107000960610 282CHANGE
1071009606102 82CHANGE
107200950525 381COPY
1073009505253 81COPY
107400980716 483DELETE
1075009807164 83DELETE
107600950525 584DISPLY
1077009505255 84DISPLY
1078000803231285WRKWTH
