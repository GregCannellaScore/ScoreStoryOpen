000100110605      /copy qcpylesrc,stdhspec
000200110605     F*****************************************************************
000300110605     F*                                                               *
000400110605     F* Program ID...... CAT0100R                                     *
000500110605     F* Program Desc.... Work With Codes Category Headers             *
000600110605     F* Log Number...... 1234                                         *
000700110605     F*                                                               *
000800110605     F* Written By...... Greg Cannella                                *
000900110605     F* Date Written....  3/24/08                                     *
001000110605     F*                                                               *
001100110605     F* Comments........                                              *
001200110605     F*                                                               *
001300110605     F*                                                               *
001400110605     F*****************************************************************
001500110605     F* CL Special Processing:                                        *
001600110605     F*                                                               *
001700950719     F*****************************************************************
001800950719     F* Compile Options:                                              *
001900950719     F*                                                               *
002000951009     F*****************************************************************
002100951009     F* Modifications:                                                *
002200951009     F* Req#  By   Date      Modification                             *
002300141130     F*                                                               *
002400951009     F*                                                               *
002500950612     F*****************************************************************
002600941228     F* Indicator Usage:                                              *
002700941228     F* Ind      Use                                                  *
002800950707     F* 01-24    Function keys                                        *
002900950707     F* 25       Rollup                                               *
003000950626     F* 30-34    Subfile keywords                                     *
003100950626     F* 36       Position to                                          *
003200950626     F* 37       Error indicator                                      *
003300950626     F* 40       Search field change                                  *
003400960418     F* 41-42    Search field display                                 *
003500950626     F* 61       Subfile option error                                 *
003600960610     F* 80-89    Reserved for Security                                *
003700950524     F* 90-99    Hit/Miss                                             *
003800941228     F*****************************************************************
003900941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
004000941228     F*P          P  R  O  G  R  A  M    S  P  E  C  S                P
004100941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
004200941228     F*
004300141001     FCAT0100D  CF   E             WORKSTN SFILE(SCRNS01:RRN1)
004400950522     F                                     INFDS(INFDS)
004500141001     FCODEHDR1  IF   E           K DISK
004600120404      *----------------------------------------------------------------
004700120404      * Option authorization:
004800141001/002 D*OPT             S              2    DIM(11) CTDATA PERRCD(1)
004900141001/002 D*INMD            S             12    DIM(11) ALT(OPT)
005000141001/002 D OPT             S              2    DIM(13) CTDATA PERRCD(1)
005100141001/002 D INMD            S             12    DIM(13) ALT(OPT)
005200120404      *
005300141130     D SQL             S            200
005400141130     D Search1         S             20
005500141130     D Search2         S             80
005600141130     D Search3         S             80
005700141130     D Percents        s             39
005800120404      *
005900120404      * Max number of 'position to':
006000080324     D WW#POS          C                   CONST(01)
006100120404      *
006200120404      * Number of records to fill S/F page:
006300970108     D WWPGSZ          C                   CONST(10)
006400120404      *
006500120404      * General constants:
006600950526     D LOAD            C                   CONST('LOAD')
006700950526     D ERROR           C                   CONST('ERROR')
006800950607     D INUSE           C                   CONST('INUSE')
006900960610     D SELECT          C                   CONST('SELECT')
007000950530     D ADD             C                   CONST('ADD')
007100950530     D CHANGE          C                   CONST('CHANGE')
007200950525     D COPY            C                   CONST('COPY')
007300980716     D DELETE          C                   CONST('DELETE')
007400950525     D DISPLY          C                   CONST('DISPLY')
007500141001/002 D DLFILE          C                   CONST('DLFILE')
007600080323     D WRKWTH          C                   CONST('WRKWTH')
007700080324     D PGMNAM          C                   CONST('CAT0100R  ')
007800950608     D NO              C                   CONST('N')
007900950523     D YES             C                   CONST('Y')
008000120404      *
008100080324     D jld           E DS                  EXTNAME(dsjld)
008200120404      *
008300120404      * Incoming parms:
008400970225     D APPL            DS           512
008500970225     D  WISEC                  1      5
008600970225     D  WISEL                  6      6
008700970225     D  WIVIEW                 7      8  0
008800080324     D  WICode                 9     18
008900120404      *
009000120404      * Calling parms for CAT0101R:
009100950608     D APP2            DS           512
009200960626     D  A2SEC                  1      5
009300960626     D  A2IUSE                 6     15
009400960626     D  A2INLR                16     16
009500960626     D  A2ACTN                17     26
009600080324     D  A2Code                27     36
009700120404      *
009800120404      * Calling parms for CAT0110R:
009900080325     D APP3            DS           512
010000080325     D  A3SEC                  1      5
010100080325     D  A3SEL                  6      6
010200080325     D  A3VIEW                 7      8  0
010300080325     D  A3Code                 9     18
010400080325     D  A3CatK                19     38
010500120404      *
010600120404      * Parm to hold message data:
010700950906     D DSMDTA          DS           500
010800120404      *
010900120404      * Split option indicator and action code:
011000950525     D DSSPLT          DS            12
011100950525     D  ZZ                     1      2  0
011200950525     D  DSACTN                 3     12
011300120404      *
011400950619     D INFDS           DS
011500950619     D  SFLLOC               378    379B 0
011600120404      *
011700120406     D DScodehdr       DS
011800120406     D  CHCODE                       10
011900120406     D  CHCODD                       40
012000120406      *
012100941228     D                SDS
012200960705     D  DSPGMN           *PROC
012300950616     D  DSUSER               254    263
012400941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012500941228     M*M                 M  A  I  N  L  I  N  E                       M
012600941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012700941228     M*
012800950526     C*
012900970108     C* Main loop:
013000970108     C*
013100941228     C     *IN03         DOUEQ     *ON
013200951020     C*
013300970108     C* Reload subfile, if requested:
013400970108     C*
013500951020     C     WWLOAD        IFEQ      YES
013600951020     C                   EXSR      $INSFL
013700951020     C                   MOVE      NO            WWLOAD
013800141001     C                   END
013900950802     C*
014000970113     C* Display screen:
014100970113     C*
014200950802     C                   WRITE     MSGCTL1
014300950802     C                   WRITE     SCRNK01
014400950802     C*
014500950802     C     *IN32         IFEQ      *OFF
014600950802     C                   WRITE     SCRNR01
014700950802     C                   END
014800950802     C*
014900941228     C                   EXFMT     SCRNC01
015000000810     C                   MOVE      THEFLD        *IN69
015100950706     C*
015200950706     C     WWFRST        IFEQ      YES
015300950706     C                   MOVE      NO            WWFRST
015400950706     C                   END
015500950614     C*
015600950523     C                   MOVE      SFLLOC        HDSFLP
015700950523     C*
015800950523     C* Clear messages:
015900950523     C*
016000080324     C                   CALL      'ERMSG2'
016100080324     C                   Parm                    DSPGMN
016200941228     C*
016300970113     C* Set off all error indicators here:
016400960418     C*
016500950523     C                   MOVE      *OFF          *IN36
016600970108     C                   MOVE      *OFF          *IN38
016700941228     C*
016800941228     C     *IN03         IFEQ      *OFF
016900950522     C*
017000080324     C* Process command keys:
017100941228     C*
017200950522     C                   SELECT
017300950524     C*
017400960626     C*
017500960626     C* F4 = Prompt:
017600960626     C*
017700960626     C     *IN04         WHENEQ    *ON
017800960626     C                   EXSR      $PRMPT
017900960626     C                   EXSR      $INSFL
018000950526     C*
018100950526     C* F10 = Position to:
018200950526     C*
018300120404     C*
018400120404     C* F60 = Search:
018500120404     C*
018600141130     C     *IN60         WHENEQ    *ON
018700141130     C     Wcsearch      Andne     *Blank
018800141130     C                   EXSR      $Search
018900950522     C*
019000970108     C* F5 or 'position to' field value change (*IN40) - reload S/F:
019100950523     C*
019200941228     C     *IN05         WHENEQ    *ON
019300941228     C     *IN40         OREQ      *ON
019400941228     C                   EXSR      $INSFL
019500950605     C*
019600950605     C* Rollup (if records exist in S/F - *IN32):
019700950605     C*
019800950605     C     *IN25         WHENEQ    *ON
019900950605     C     *IN32         ANDEQ     *ON
020000141130     C                   If        Wcsearch = *Blank
020100950605     C                   EXSR      $LDSFL
020200141130     C                   EndIf
020300950605     C*
020400960418     C* F6 = Add a record:
020500950605     C*
020600950605     C     *IN06         WHENEQ    *ON
020700960626     C                   EXSR      $ADDRC
020800080325     C*
020900080325     C* F12= Cancel
021000080325     C*
021100080325     C     *IN12         WHENEQ    *ON
021200080325     C                   Eval      *in03=*on
021300950522     C*
021400950522     C                   OTHER
021500950522     C*
021600950522     C* Enter:
021700120406     C*
021800941229     C                   EXSR      $READC
021900941228     C*
022000950522     C                   ENDSL
022100950522     C*
022200941228     C                   END
022300941228     C*
022400941228     C                   ENDDO
022500950710     C*
022600960611     C* Close called programs:
022700950710     C*
022800960626     C                   MOVE      YES           A2INLR
022900950710     C*
023000970113     C* End the maintenance program:
023100970113     C*
023200080324     C                   CALL      'CAT0101R'
023300080324     C                   PARM                    jld
023400950710     C                   PARM                    APP2
023500950526     C*
023600950522     C                   MOVE      *ON           *INLR
023700941228     C*
023800941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
023900941228     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
024000941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
024100941228     C*
024200941228     C**************
024300950522     C**  $INSFL  ** - Initialize Subfile
024400941228     C**************
024500950522     C     $INSFL        BEGSR
024600950522     C*
024700950522     C                   CLEAR                   RRN1
024800950523     C                   Z-ADD     1             HDSFLP
024900941228     C                   MOVE      NO            WWNFND
025000141130     C                   CLEAR                   WCSearch
025100120409      *
025200141130     C                   If        *In05 = *On
025300141130     C                   Clear                   Wccode
025400141130     C                   EndIf
025500120409      *
025600950522     C* Clear subfile:
025700950522     C*
025800950525     C     *IN32         IFEQ      *ON
025900950802     C                   MOVE      *OFF          *IN32
026000950522     C                   MOVE      *ON           *IN30
026100950522     C                   WRITE     SCRNC01
026200950522     C                   MOVE      *OFF          *IN30
026300950525     C                   END
026400950523     C*
026500960418     C* Check for subfile control errors:
026600950605     C*
026700950605     C     WWFRST        CASEQ     NO            $ERR01
026800950605     C                   ENDCS
026900950605     C*
027000970108     C* Position file:
027100970113     C*
027200970113     C****************************************************************
027300970113     C* WHSXXX - Logical file based on current 'position to' view.
027400080303     C*  eg; physical file is INVMF and current 'position to' is
027500080303     C*      by style number, WHSXXX = INVMF (key = style #).
027600970113     C*
027700950530     C*
027800970113     C* XXXK01 - Key list based on current 'position to' fields.
027900970113     C*  eg; if 'position to' field is item number:
028000080303     C*          XXXK01 = INVK01  KLIST
028100970113     C*                           KFLD      WCITM#
028200970113     C****************************************************************
028300970113     C*
028400970113     C                   SELECT
028500970113     C*
028600950530     C     WWCPOS        WHENEQ    1
028700081217     C     CHK01         SETLL     CodeHdr1                               99
028800950523     C     *IN99         IFEQ      *OFF
028900941228     C                   MOVE      YES           WWNFND
029000950523     C                   END
029100970108     C*
029200080324     C*    WWCPOS        WHENEQ    2
029300080324     C*    XXXK01        SETLL     WHSXXXX                                99
029400080324     C*    *IN99         IFEQ      *OFF
029500080324     C*                  MOVE      YES           WWNFND
029600080324     C*                  END
029700950530     C*
029800950530     C                   ENDSL
029900950522     C*
030000970108     C* Load subfile:
030100970108     C*
030200950522     C                   EXSR      $LDSFL
030300950523     C*
030400950523     C* Send message if search criteria is not found:
030500950523     C*
030600941228     C     WWNFND        IFEQ      YES
030700951020     C     *IN40         IFEQ      *ON
030800951020     C     *IN04         OREQ      *ON
030900080324     C                   MOVEL     'SHL0006'     WWMSGI
031000080304     C                   CALL      'ERMSG1'      MSGP01
031100950523     C                   END
031200951020     C                   END
031300950522     C*
031400950522     C                   ENDSR
031500970109     C*
031600970109     C**************
031700970109     C**  $ERR01  ** - Control Screen Validity Checking
031800970109     C**************
031900970109     C     $ERR01        BEGSR
032000970109     C*
032100970109     C                   CLEAR                   WWERR1
032200970109     C*
032300970113     C*****************************************************************
032400970113     C* All error conditions must have the following lines of code:
032500970113     C*
032600970113     C*   MOVE *ON       *INXX
032700970113     C*     Where *INXX = field error indicator in DDS.
032800970113     C*
032900970113     C*   MOVELERROR     WWERR1
033000970113     C*     Program error flag.
033100970113     C*
033200970113     C*   MOVEL'XXX0001' WWMSGI
033300970113     C*     Where XXX0001 = error message id to be displayed.
033400970113     C*
033500970113     C*   MOVELXXXXXX    WWMSGF
033600970113     C*     Where XXXXXX = name of the message file which contains
033700970113     C*     the message id contained in field WWMSGI.
033800970113     C*
033900080304     C*   CALL 'ERMSG1'  MSGP01
034000970113     C*     Message handling program.
034100970113     C*****************************************************************
034200970113     C*
034300970114     C* Field 1:
034400080324     C     *IN41         IFEQ      *ON
034500120409     C     WCCode        ANDNE     *Blank
034600081217     C     CHK01         SETLL     CodeHdr1                               99
034700970109     C     *IN99         IFEQ      *OFF
034800970109     C                   MOVE      *ON           *IN36
034900970109     C                   MOVEL     ERROR         WWERR1
035000080324     C                   MOVEL     'SHL0006'     WWMSGI
035100080304     C                   CALL      'ERMSG1'      MSGP01
035200970109     C                   END
035300970109     C                   END
035400970109     C*
035500080324     C*    *IN42         IFEQ      *ON
035600080324     C*    WCXXX1        ANDNE     *ZERO
035700080324     C*    XXXK01        SETLL     WHSXXXX                                99
035800080324     C*    *IN99         IFEQ      *OFF
035900080324     C*                  MOVE      *ON           *IN36
036000080324     C*                  MOVEL     ERROR         WWERR1
036100080324     C*                  MOVEL     'XXX0001'     WWMSGI
036200080324     C*                  CALL      'ERMSG1'      MSGP01
036300080324     C*                  END
036400080324     C*                  END
036500970109     C*
036600970109     C                   ENDSR
036700950522     C*
036800950522     C**************
036900950522     C**  $LDSFL  ** - Load Subfile
037000950522     C**************
037100950522     C     $LDSFL        BEGSR
037200950522     C*
037300950522     C                   CLEAR                   WWCNT1
037400950727     C*
037500950727     C                   MOVE      *OFF          *IN34
037600950522     C*
037700970108     C* Load one page at a time:
037800970108     C*
037900950522     C     WWCNT1        DOWLT     WWPGSZ
038000950522     C     *IN34         ANDEQ     *OFF
038100970113     C*****************************************************************
038200970113     C*
038300950727     C                   SELECT
038400950727     C*
038500970108     C* Read from file, based on current 'position to' view:
038600970108     C*
038700950727     C     WWCPOS        WHENEQ    1
038800081217     C                   READ      CodeHdr1                               34
038900970108     C*
039000080324     C**   WWCPOS        WHENEQ    2
039100080324     C**                 READ      WHSXXXX                                34
039200950727     C*
039300950727     C                   ENDSL
039400950727     C*
039500950727     C     *IN34         IFEQ      *OFF
039600960418     C*
039700950607     C                   CLEAR                   WSOPT#
039800950607     C                   MOVE      *OFF          *IN61
039900960606     C*
040000970108     C* Load subfile fields here:
040100970108     C*
040200080324     C****               CLEAR                   WSXXX1
040300950522     C*
040400080324     C                   MOVE      CHCode        WSCode
040500080324     C                   MOVE      CHCodD        WSCodD
040600960627     C*
040700950522     C                   ADD       1             RRN1
040800950522     C                   ADD       1             WWCNT1
040900950523     C*
041000950523     C     WWCNT1        IFEQ      1
041100950523     C                   Z-ADD     RRN1          HDSFLP
041200950523     C                   END
041300950522     C*
041400950522     C                   WRITE     SCRNS01
041500120406     C                   MOVE      *ON           *IN32
041600950727     C*
041700950727     C                   END
041800950522     C*
041900950522     C                   ENDDO
042000950522     C*
042100950522     C     RRN1          IFGT      *ZERO
042200120406     C****               MOVE      *ON           *IN32
042300950522     C                   END
042400950522     C*
042500950522     C                   MOVE      *OFF          *IN25
042600950522     C*
042700950522     C                   ENDSR
042800970109     C*
042900970109     C**************
043000970109     C**  $PRMPT  ** - Process Promptable Fields
043100970109     C**************
043200970109     C     $PRMPT        BEGSR
043300970113     C*
043400970113     C*****************************************************************
043500970113     C*  Field HDCSRF (defined in DDS) contains the field name which
043600970113     C*  contains the cursor. If valid, a prompting program may be
043700970113     C*  called to select a record from a list of valid values for
043800970113     C*  the prompted field. The value selected should then be placed
043900970113     C*  in the field which was prompted.
044000970113     C*
044100970113     C* eg; HDCSRF    WHEQ 'WCXXX1'
044200970113     C*      Cursor resides in field WCXXX1
044300970113     C*
044400970113     C*     CALL 'GEN0109R'
044500970113     C*      Codes file prompting program.
044600970113     C*
044700970113     C*     PARM '653'     WWCTAB
044800970113     C*      Outgoing parm.
044900970113     C*
045000970113     C*     PARM *BLANKS   WWCKEY
045100970113     C*      Return parm.
045200970113     C*
045300970113     C*     MOVELWWCKEY    WCXXX1
045400970113     C*      Move return parm into prompted field.
045500970113     C*
045600970113     C*****************************************************************
045700970113     C*
045800970113     C                   SELECT
045900970113     C*
046000080324     C*    HDCSRF        WHENEQ    'WCXXX1'
046100080324     C*                  CALL      'GEN0109R'
046200080324     C*                  PARM      '653'         WWCTAB
046300080324     C*                  PARM      *BLANKS       WWCKEY
046400080324     C*                  MOVEL     WWCKEY        WCXXX1
046500080324     C*
046600080324     C*    HDCSRF        WHENEQ    'WCXXX2'
046700080324     C*                  CALL      'GEN0109R'
046800080324     C*                  PARM      '654'         WWCTAB
046900080324     C*                  PARM      *BLANKS       WWCKEY
047000080324     C*                  MOVEL     WWCKEY        WCXXX2
047100970109     C*
047200970109     C* Non propmtable area:
047300970109     C*
047400970109     C                   OTHER
047500970109     C*
047600080324     C                   MOVEL     'SHL0004'     WWMSGI
047700080304     C                   CALL      'ERMSG1'      MSGP01
047800970109     C*
047900970109     C                   ENDSL
048000970109     C*
048100970109     C                   ENDSR
048200941228     C*
048300941228     C**************
048400941228     C**  $POSTO  ** - Position To
048500941228     C**************
048600941228     C     $POSTO        BEGSR
048700941228     C*
048800970108     C* Clear all 'position to' fields here:
048900960418     C*
049000080324     C                   CLEAR                   WCCode
049100141130     C                   CLEAR                   WCSearch
049200960418     C*
049300950607     C                   CLEAR                   RRN1
049400950607     C                   CLEAR                   HDSFLP
049500950526     C*
049600950526     C* Clear subfile:
049700950526     C*
049800950526     C     *IN32         IFEQ      *ON
049900950802     C                   MOVE      *OFF          *IN32
050000950526     C                   MOVE      *ON           *IN30
050100950526     C                   WRITE     SCRNC01
050200950526     C                   MOVE      *OFF          *IN30
050300950526     C                   END
050400950526     C*
050500960418     C* Position cursor:
050600960418     C*
050700950526     C                   MOVE      *ON           *IN36
050800941228     C*
050900970108     C* Toggle to next 'position to' field:
051000960418     C*
051100941228     C     WWCPOS        ADD       1             WWCPOS
051200941228     C*
051300941228     C     WWCPOS        IFGT      WW#POS
051400950525     C                   Z-ADD     1             WWCPOS
051500941228     C                   END
051600941228     C*
051700970113     C*****************************************************************
051800970114     C* When a 'position to' view is changed, the new display
051900970113     C* indicator (from DDS) must be set on and all other 'position to'
052000970113     C* display indicators must be turned off.
052100970113     C*
052200970113     C*  eg; 'position to' #1 by agency (display indicator *IN41)
052300970113     C*      'position to' #2 by agency/chain (display indicator *IN42)
052400970113     C*
052500970113     C*  If user toggles to 'position to' by agency/chain, indicator
052600970113     C*  *IN41 must be turned off and *IN42 turned on.
052700970113     C*
052800970113     C*      MOVEA'01'      *IN,41
052900970113     C*****************************************************************
053000970113     C*
053100970113     C* Set 'position to' field display indicator:
053200970113     C*
053300950530     C                   SELECT
053400950530     C*
053500080324     C     WWCPOS        WHENEQ    1
053600970108     C                   MOVEA     '10'          *IN(41)
053700970108     C*
053800080324     C     WWCPOS        WHENEQ    2
053900970108     C                   MOVEA     '01'          *IN(41)
054000950530     C*
054100950530     C                   ENDSL
054200941228     C*
054300941228     C                   ENDSR
054400970109     C*
054500120404     C**************
054600120404     C**  $Search ** - Search text
054700120404     C**************
054800141130     C     $Search       BEGSR
054900141130      *
055000141130     C                   CLEAR                   RRN1
055100141130     C                   CLEAR                   WCCode
055200141130     C*
055300141130     C* Clear subfile:
055400141130     C*
055500141130     C     *IN32         IFEQ      *ON
055600141130     C                   MOVE      *OFF          *IN32
055700141130     C                   Z-ADD     *Zero         WWCRRN
055800141130     C                   MOVE      *ON           *IN30
055900141130     C                   WRITE     SCRNC01
056000141130     C                   MOVE      *OFF          *IN30
056100141130     C                   EndIf
056200141130     c
056300141130     c                   Eval      SQL = 'SELECT DISTINCT CHCODE, CHCODD +
056400141130     c                                    FROM CODEHDR, CODECAT +
056500141130     c                                    WHERE CHCODE = CCCATC +
056600141130     c                                    AND   (UPPER(CHCODE) LIKE ?  +
056700141130     c                                    OR    UPPER(CHCODD) LIKE ?   +
056800141130     c                                    OR    UPPER(CCCATD) LIKE ? ) +
056900141130     c                                    ORDER BY CHCODE'
057000141130
057100141130     c                   Eval      Search1='%%%%%%%%%' +
057200141130     c                             %trim(wcsearch) +
057300141130     c                             '%%%%%%%%%'
057400141130     c                   Eval      Percents = '%%%%%%%%%%%%%%%%%%%%' +
057500141130     c                             '%%%%%%%%%%%%%%%%%%%'
057600141130     c                   Eval      Search2=Percents +
057700141130     c                             %trim(wcsearch) +
057800141130     c                             Percents
057900141130     c                   Eval      Search3=Percents +
058000141130     c                             %trim(wcsearch) +
058100141130     c                             Percents
058200141130      *
058300141130     c/EXEC SQL
058400141130     c+ PREPARE HHANDLE from :SQL
058500141130     c/END-EXEC
058600141130
058700141130     c/EXEC SQL
058800141130     c+ DECLARE CATSearch CURSOR FOR HHANDLE
058900141130     c/END-EXEC
059000141130     c/EXEC SQL
059100141130     C+ OPEN CATSEARCH USING :search1, :search2, :search3
059200141130     c/END-EXEC
059300141130     c/EXEC SQL
059400141130     c+ FETCH Next From CATSearch into :DScodehdr
059500141130     c/END-EXEC
059600141130     c                   DoW       SQLCOD = 0
059700141130      *
059800141130      * Load subfile fields
059900141130     C                   CLEAR                   WSOPT#
060000141130     C                   MOVE      *OFF          *IN61
060100141130     c                   Eval      wsCode = CHCode
060200141130     c                   Eval      wsCodD = CHCodD
060300141130     C                   ADD       1             RRN1
060400141130     c                   Write     SCRNS01
060500141130     C                   MOVE      *On           *IN32
060600141130     C                   Z-ADD     1             HDSFLP
060700141130      *
060800141130     c/EXEC SQL
060900141130     c+ FETCH Next From CATSearch into :DScodehdr
061000141130     c/END-EXEC
061100141130     c                   EndDo
061200141130     c/EXEC SQL
061300141130     c+ CLOSE CATSearch
061400141130     c/END-EXEC
061500141130     C*
061600141130     C                   Eval      *in34 = *on
061700141130     C     #Search       EndSr
061800970109     C**************
061900970109     C**  $ADDRC  ** - Add a record
062000970109     C**************
062100970109     C     $ADDRC        BEGSR
062200970109     C*
062300970113     C*****************************************************************
062400970113     C* Parms required to be passed to the maintenance program:
062500970113     C*   1. WISEC = program level security.
062600970113     C*   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
062700970113     C*
062800970113     C*****************************************************************
062900970113     C*
063000970109     C                   MOVE      YES           WWLOAD
063100970109     C*
063200970109     C                   CLEAR                   APP2
063300970109     C                   MOVEL     WISEC         A2SEC
063400970109     C                   MOVEL     ADD           A2ACTN
063500970113     C*
063600970113     C* Call maintenance program:
063700970109     C*
063800080324     C                   CALL      'CAT0101R'
063900080324     C                   PARM                    jld
064000970109     C                   PARM                    APP2
064100970109     C*
064200970113     C*****************************************************************
064300970113     C* When returning from the maintenance program, this program will
064400970113     C* automatically position the subfile list to the last record
064500970113     C* added to the file. To do this, the maintenance program must
064600970113     C* return all 'position to' field values to this program.
064700970113     C*
064800080303     C*   eg; 'position to' #1 = Item Number
064900080303     C*       'position to' #2 = Item Type Code
065000080303     C*
065100970113     C*
065200970113     C*  Using this example, when a record is added to the file, the
065300970113     C*  maintenance program will return the values of all of the above
065400080303     C*  'position to' fields (Item Number, Item Type Code).
065500970113     C*  The subfile list will then automatically be positioned based
065600970113     C*  on the current 'position to' view.
065700970113     C*
065800970113     C*****************************************************************
065900970113     C*
066000970109     C* Move key fields from maint pgm to 'position to' fields:
066100970109     C*
066200080324     C                   MOVE      A2Code        WCCode
066300970109     C*
066400970109     C                   MOVEL     WRRCDE        WWRCDE
066500970109     C*
066600970109     C                   ENDSR
066700950607     C*
066800950607     C**************
066900950607     C**  $READC  ** - Process Subfile Requests
067000950607     C**************
067100950607     C     $READC        BEGSR
067200950525     C*
067300950525     C                   CLEAR                   WWERR2
067400941228     C                   CLEAR                   WWRCDE
067500941228     C                   CLEAR                   WWRRN#
067600941228     C*
067700950626     C* Save current RRN:
067800950626     C*
067900941228     C                   Z-ADD     RRN1          WWCRRN
068000950525     C*
068100941228     C* Read all records in the S/F:
068200941228     C*
068300941228     C     WWRRN#        DOWLT     WWCRRN
068400950525     C     WWERR2        ANDNE     ERROR
068500950713     C     WWRCDE        ANDNE     INUSE
068600960610     C     *IN03         ANDEQ     *OFF
068700941228     C*
068800941228     C                   ADD       1             WWRRN#
068900941228     C*
069000941228     C     WWRRN#        CHAIN     SCRNS01                            99
069100941228     C     *IN99         IFEQ      *OFF
069200950525     C*
069300950607     C                   MOVE      *OFF          *IN61
069400941228     C*
069500970109     C* Option number was entered:
069600970109     C*
069700941228     C     WSOPT#        IFNE      *BLANKS
069800950607     C*
069900970109     C* Check for subfile option errors:
070000970109     C*
070100950607     C                   EXSR      $ERR02
070200950607     C*
070300970109     C                   Z-ADD     RRN1          HDSFLP
070400970109     C*
070500970109     C* Error occurred, return to mainline:
070600970109     C*
070700950607     C     WWERR2        IFEQ      ERROR
070800950607     C                   MOVE      *ON           *IN61
070900950607     C                   UPDATE    SCRNS01
071000950607     C                   ELSE
071100951027     C*
071200970113     C*****************************************************************
071300970113     C* If this program is called as a record selection program
071400970113     C* (WISEL = 'Y'), return the desired field(s) to the calling
071500970113     C* program through the APPL parm list.
071600970113     C*
071700970113     C*   eg; Call this program to retrieve a chain code.
071800970113     C*
071900970113     C*     DSACTN    IFEQ SELECT
072000970113     C*       Record has been selected.
072100970113     C*
072200970113     C*               MOVE WSCHN     WICHN
072300970113     C*                 Move the chain code from the S/F to the APPL
072400970113     C*                 parm WICHN.
072500970113     C*
072600970113     C*               MOVE *ON       *IN03
072700970113     C*                 End this program.
072800970113     C*
072900970113     C*****************************************************************
073000970108     C* If select, return the key fields and end program:
073100960610     C*
073200960626     C     DSACTN        IFEQ      SELECT
073300080324     C                   MOVE      WSCode        WICode
073400960610     C                   MOVE      *ON           *IN03
073500960610     C                   ELSE
073600080324     C*
073700080324     C*****************************************************************
073800080324     C* If Work with, call new work with program.
073900080324     C*
074000080324     C     DSACTN        IFEQ      WRKWTH
074100100329     C                   Eval      a3view = wiview
074200080325     c                   Eval      a3Code = WSCode
074300080325     c                   Eval      a3CatK = *blanks
074400080325     C                   Call      'CAT0110R'
074500080325     C                   Parm                    JLD
074600080325     C                   Parm                    App3
074700080324     C                   Else
074800141130     C*
074900141130     C     DSACTN        IFEQ      DLFILE
075000141130     C                   CALL      'CAT0130C'
075100141130     C                   PARM                    Wscode
075200141130     C                   ELSE
075300970113     C*
075400970113     C*****************************************************************
075500970113     C* Parms required to be passed to the maintenance program:
075600970113     C*   1. WISEC = program level security.
075700970113     C*   2. Maintenance action code (eg; CHANGE, ADD, DISPLAY).
075800080303     C*   3. The key of the record to be maintained.
075900970117     C*
076000970113     C*****************************************************************
076100950525     C*
076200960418     C* Call maintenance program:
076300941228     C*
076400950608     C                   CLEAR                   APP2
076500960626     C                   MOVEL     WISEC         A2SEC
076600960626     C                   MOVEL     DSACTN        A2ACTN
076700970108     C*
076800970113     C* Move key fields to maintenance program for record access:
076900970108     C*
077000080324     C                   MOVE      WSCode        A2Code
077100950525     C*
077200080324     C                   CALL      'CAT0101R'
077300080324     C                   PARM                    jld
077400950608     C                   PARM                    APP2
077500970113     C*
077600970113     C*****************************************************************
077700970113     C* When returning from the maintenance program, this program will
077800970113     C* automatically position the subfile list to the last record
077900970113     C* processed. To do this, the maintenance program must return all
078000970113     C* 'position to' field values to this program.
078100970113     C*
078200080303     C*   eg; 'position to' #1 = Item Number
078300080303     C*       'position to' #2 = Item Type Code
078400970113     C*
078500970113     C*  Using this example, when a record is maintained, the
078600970113     C*  maintenance program will return the values of all of the above
078700080303     C*  'position to' fields (item number, item type code).
078800970113     C*  The subfile list will then automatically be positioned based
078900970113     C*  on the current 'position to' view.
079000970113     C*
079100970113     C*****************************************************************
079200960701     C*
079300970108     C* Move key fields from maint pgm to 'position to' fields:
079400960701     C*
079500080324     C                   MOVE      A2Code        WCCode
079600960701     C*
079700960701     C                   MOVE      YES           WWLOAD
079800950608     C*
079900941228     C                   MOVEL     WRRCDE        WWRCDE
080000941228     C*
080100970113     C* If record lock, send record in use message:
080200951027     C*
080300951027     C     WWRCDE        IFEQ      INUSE
080400080324     C                   MOVEL     'SHL0007'     WWMSGI
080500970108     C     A2IUSE        CAT       DSMDTA        DSMDTA
080600080304     C                   CALL      'ERMSG1'      MSGP01
080700951027     C                   CLEAR                   DSMDTA
080800951027     C                   MOVE      NO            WWLOAD
080900951027     C                   END
081000080324     C*
081100080324     C                   ENDIF
081200941228     C*
081300950526     C                   CLEAR                   WSOPT#
081400950525     C                   UPDATE    SCRNS01
081500950525     C*
081600950525     C                   END
081700960610     C                   END
081800950526     C                   END
081900941228     C                   END
082000141001/002 C                   ENDIF
082100950525     C*
082200941228     C                   ENDDO
082300941228     C*
082400941228     C* Reset current RRN:
082500941228     C*
082600941228     C                   Z-ADD     WWCRRN        RRN1
082700950714     C*
082800950714     C                   CLEAR                   WWRCDE
082900950525     C*
083000950525     C                   ENDSR
083100950607     C*
083200950607     C**************
083300950607     C**  $ERR02  ** - Subfile Validity Checking
083400950607     C**************
083500950607     C     $ERR02        BEGSR
083600950607     C*
083700950607     C* Check for valid option:
083800950607     C*
083900950607     C                   Z-ADD     1             X
084000950607     C     WSOPT#        LOOKUP    OPT(X)                                 90
084100950607     C     *IN90         IFEQ      *ON
084200950607     C                   MOVEL     INMD(X)       DSSPLT
084300950612     C                   ELSE
084400950612     C                   CLEAR                   DSSPLT
084500950607     C                   END
084600950607     C*
084700950607     C                   SELECT
084800950607     C*
084900950714     C* If indicator 90 is off, option number is not valid.
085000950714     C* If indicator ZZ is off, user is not authorized to option.
085100950714     C*
085200950607     C     *IN90         WHENEQ    *OFF
085300950612     C     *IN(ZZ)       OREQ      *OFF
085400080324     C                   MOVEL     'SHL0008'     WWMSGI
085500080304     C                   CALL      'ERMSG1'      MSGP01
085600950607     C                   MOVEL     ERROR         WWERR2
085700950607     C*
085800950607     C                   ENDSL
085900950607     C*
086000950607     C                   ENDSR
086100950525     C*
086200950525     C**************
086300950626     C**  *INZSR  ** - Initialize Program
086400950525     C**************
086500950525     C     *INZSR        BEGSR
086600950522     C*
086700950522     C* Incoming parm list:
086800950522     C*
086900950523     C     *ENTRY        PLIST
087000080324     C                   PARM                    jld
087100950524     C                   PARM                    APPL
087200950523     C*
087300950523     C* Message file parm list:
087400950523     C*
087500950906     C     MSGP01        PLIST
087600950621     C                   PARM                    WWMSGI            7
087700950522     C*
087800950522     C* Key lists:
087900970108     C*
088000970108     C     CODK01        KLIST
088100970108     C                   KFLD                    WWCTAB
088200970108     C                   KFLD                    WWCKEY
088300950522     C*
088400080324     C     CHK01         KLIST
088500080324     C                   KFLD                    WCCode
088600950522     C*
088700950522     C* Field definitions:
088800950522     C*
088900950522     C     *LIKE         DEFINE    HDSFLP        RRN1
089000941228     C     *LIKE         DEFINE    HDSFLP        WWRRN#
089100941228     C     *LIKE         DEFINE    HDSFLP        WWCRRN
089200950522     C*
089300950522     C* Initialize:
089400950522     C*
089500960610     C*
089600970108     C                   MOVE      *ZEROS        WWCNT1            2 0
089700970109     C                   MOVE      01            WWCPOS            2 0
089800941228     C                   MOVE      *BLANKS       WWCTAB            3
089900941228     C                   MOVE      *BLANKS       WWCKEY           27
090000941228     C                   MOVE      *BLANKS       WWNFND            1
090100950526     C                   MOVE      YES           WWFRST            1
090200951020     C                   MOVE      YES           WWLOAD            1
090300950525     C                   MOVE      *BLANKS       WWERR1           10
090400950525     C                   MOVE      *BLANKS       WWERR2           10
090500960610     C                   MOVE      *BLANKS       WWERR3            1
090600950525     C                   MOVE      *BLANKS       WWRCDE           10
090700950525     C                   MOVE      *ZEROS        X                 2 0
090800970225     C*
090900970225     C* Load the program name defined in security file PGMSEC.
091000970225     C* This name must be defined in the constant 'PGMNAM'.
091100970225     C*
091200970225     C                   MOVEL     PGMNAM        WWPGM            10
091300970225     C*
091400970225     C* Clear message subfile:
091500970225     C*
091600080304     C                   CALL      'ERMSG2'
091700080304     C                   Parm                    dspgmn
091800960705     C*
091900960705     C* Fill default screen values:
092000960705     C*
092100950524     C*
092200970225     C*
092300970225     C* Default to the first 'position to' view if value not passed
092400970225     C* to this program:
092500970225     C*
092600970225     C     WIVIEW        IFEQ      *ZERO
092700970225     C                   Z-ADD     1             WWCPOS            2 0
092800970225     C                   ELSE
092900970225     C                   Z-ADD     WIVIEW        WWCPOS
093000970225     C                   MOVE      *ON           *IN40
093100970225     C                   END
093200970225     C*
093300970225     C* Set initial 'position to' display indicator. Also load
093400970225     C* 'position to' values passed to this program (WIXXX1,2), if
093500970225     C* applicable:
093600970225     C*
093700970225     C                   SELECT
093800970225     C*
093900970225     C     WWCPOS        WHENEQ    1
094000970225     C                   MOVE      *ON           *IN41
094100080324     C                   MOVE      WICode        WCCode
094200970225     C*
094300080324     C*    WWCPOS        WHENEQ    2
094400080324     C*                  MOVE      *ON           *IN42
094500080324     C*                  MOVE      WICode        WCCode
094600970225     C*
094700970225     C                   ENDSL
094800970114     C*****************************************************************
094900970114     C* Field WISEC is a 5 byte logical indicator field used to control
095000970114     C* user access to all maintenance functions (eg; change, delete).
095100970114     C* Each byte will have a value of either '0'(not authorized) or
095200970114     C* '1'(authorized). This field will be moved into indicator
095300970114     C* array *IN,81.
095400970114     C*
095500970114     C*
095600970114     C*  WISEC = '00000'                  *IN81 = Add/Copy
095700080323     C*           |||||___ Work With      *IN82 = Change
095800080323     C*         Add|||     (Extra)        *IN83 = Delete
095900970114     C*            |||                    *IN84 = Display
096000080323     C*       Change||                    *IN85 = Work With
096100970114     C*             ||
096200970114     C*        Delete|
096300970114     C*              |
096400970114     C*        Display
096500970114     C*
096600970114     C*****************************************************************
096700970114     C*
096800950524     C* Set up security options:
096900950524     C*
097000970225     C     WISEC         IFEQ      *BLANKS
097100080324     C                   CALL      'SEC0100R'
097200970225     C                   PARM                    WWPGM
097300970225     C                   PARM                    WISEC
097400970225     C                   END
097500970225     C*
097600970225     C* User not setup in security file:
097700970225     C*
097800970225     C     WISEC         IFEQ      '99999'
097900970225     C                   MOVE      '00000'       WISEC
098000970225     C                   MOVE      NO            WWLOAD
098100080324     C                   MOVEL     'SHL0009'     WWMSGI
098200080304     C                   CALL      'ERMSG1'      MSGP01
098300970225     C*
098400970225     C                   ELSE
098500980716     C*
098600980716     C* Clear messages:
098700980716     C*
098800080304     C                   CALL      'ERMSG2'
098900080304     C                   Parm                    dspgmn
099000001221     C                   MOVEA     WISEC         *IN(81)
099100960610     C*
099200970108     C* If program is called to select a record, turn off all
099300970108     C* maintenance functions:
099400970108     C*
099500960626     C     WISEL         IFEQ      YES
099600960610     C                   MOVE      *ON           *IN86
099700970108     C                   MOVEA     '00010'       *IN(81)
099800960610     C                   END
099900970225     C*
100000970225     C                   END
100100970225     C*
100200970114     C*****************************************************************
100300950612     C* All users are authorized to any *IN89 option from table OPT:
100400970113     C*
100500970114     C*        Option Named
100600970114     C*            Constant
100700970113     C*              |    |
100800970113     C* Authorization|    |
100900970113     C*     Indicator|    |
101000970113     C*            |||    |
101100970113     C*      Option|||    |
101200970113     C*          |||||    |
101300970113     C*   eg ;    282CHANGE
101400970113     C*          2 82CHANGE
101500970113     C*           789ITMINQ
101600970113     C*          7 89ITMINQ
101700970113     C*           989POINQ
101800970113     C*          9 89POINQ
101900970113     C*
102000970113     C*  In this example, option 2 to change a record is available
102100970113     C*  only to users which have authorization (*IN82). option 7 to
102200970128     C*  view the item inquiry and option 9 to view the PO inquiry are
102300970113     C*  setup in the table with indicator *IN89, therefore will be
102400970113     C*  available to all users, without restriction.
102500970114     C*
102600970114     C*****************************************************************
102700970113     C*
102800950612     C                   MOVE      *ON           *IN89
102900980716     C*
103000980716     C                   MOVE      *ON           *IN36
103100950522     C*
103200941228     C                   ENDSR
103300950525**
103400960610 186SELECT
1035009606101 86SELECT
103600960610 282CHANGE
1037009606102 82CHANGE
103800950525 381COPY
1039009505253 81COPY
104000980716 483DELETE
1041009807164 83DELETE
104200950525 584DISPLY
1043009505255 84DISPLY
104400141001 884DLFILE
1045001410018 84DLFILE
1046000803231285WRKWTH
