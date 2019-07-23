000001100601      /copy qcpylesrc,stdhspec
000300941228     F*****************************************************************
000400941228     F*                                                               *
000500080325     F* Program ID...... CAT0111R                                     *
000600080325     F* Program Desc.... Maintain Codes Categories                    *
000700960626     F* Request Number.. 1234                                         *
000800941228     F*                                                               *
000900080325     F* Written By...... Greg Cannella                                *
001000080325     F* Date Written....  3/25/08                                     *
001100941228     F*                                                               *
001200950711     F* Comments........ Files will remain open until this program is *
001300950711     F*                  called with parm DSINLR equal to 'Y'.        *
001400941228     F*                                                               *
001500941228     F*****************************************************************
001600951010     F* CL Special Processing:                                        *
001700950608     F*                                                               *
001800950719     F*****************************************************************
001900970418     F* Compile Options:                                              *
002000950719     F*                                                               *
002100951009     F*****************************************************************
002200951009     F* Modifications:                                                *
002300951009     F* Req#  By   Date      Modification                             *
002400960611     F* 1234  xxx  xx/xx/xx                                           *
002500960116     F*                                                               *
002600950608     F*****************************************************************
002700950608     F* Indicator Usage:                                              *
002800950608     F* Ind      Use                                                  *
002900950607     F* 01-24    Function keys                                        *
003000950607     F* 25       Rollup key                                           *
003100950608     F* 36       Protect all input fields                             *
003200970108     F* 37       Protect key fields in change mode                    *
003300970108     F* 38       Record format level CHANGE keyword indicator         *
003400950802     F* 40-51    Error Indicators                                     *
003500100519     F* 80       Record lock                                          *
003600950626     F* 90-99    Hit/Miss                                             *
003700950607     F*                                                               *
003800941228     F*****************************************************************
003900960626      /EJECT
004000960626     F*****************************************************************
004100960626     F* Field Definitions                                             *
004200960626     F*                                                               *
004300960626     F* Prefix                                                        *
004400960626     F* WW     - Program described work fields                        *
004500960626     F* WI     - APPL input parameters                                *
004600960626     F* WR     - Display record fields                                *
004700960626     F* HD     - Hidden fields                                        *
004800960626     F* Ax     - APPx output parameters for called programs           *
004900960626     F* DS     - Data structure fields                                *
005000960626     F*                                                               *
005100960626     F*                                                               *
005200960626     F* Display Record Format Definitions                             *
005300960626     F*                                                               *
005400960626     F* Prefix                                                        *
005500960626     F* SCRNK  - Command key                                          *
005600960626     F* SCRNR  - Standard display                                     *
005700960626     F* WNDWB  - Window border                                        *
005800960626     F* WNDWR  - Standard window display                              *
005900960626     F* MSGCTL - Message subfile control                              *
006000960626     F*                                                               *
006100960626     F*                                                               *
006200960626     F* Called programs                                               *
006300960626     F*                                                               *
006400080304     F* ERMSG2 - Clear program message queue                        *
006500080304     F* ERMSG1 - Send program message with message data             *
006700960626     F*                                                               *
006800960626     F*                                                               *
006900960626     F*****************************************************************
007000941228      /EJECT
007100941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007200941228     F*P          P  R  O  G  R  A  M    S  P  E  C  S                P
007300941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007400941228     F*
007500080325     FCAT0111D  CF   E             WORKSTN USROPN
007600080325     FCodeCat   UF A E           K DISK
007601100519     FCodeHdr   iF   E           K DISK
007800950607     D*
007900950607     D* Header screen mode desriptions:
008000950607     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
008100950607     D DSC             S             30    DIM(5) ALT(MOD)
008200941228     D*
008300941228     D*
008400950525     D* General constants:
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
009601080325     D*
009602080325     D ConvertDate     s               d
009603100519     D XX              s              2  0
009700950525     D*
009800080324     D jld           E DS                  EXTNAME(dsjld)
009900941228     D*
010000950619     D* Incoming parms:
010100941228     D APPL            DS           512
010200960626     D  WISEC                  1      5
010300960626     D  WIIUSE                 6     15
010400960626     D  WIINLR                16     16
010500960626     D  WIACTN                17     26
010600080325     D  WICode                27     36
010700080325     D  WICatK                37     56
010800980709     D*
012100941228     D                SDS
012200960705     D  DSPGMN           *PROC
012300950608     D  DSUSER               254    263
012400950626      /EJECT
012500941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012600941228     M*M                 M  A  I  N  L  I  N  E                       M
012700941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
012800941228     M*
012900950710     C*
013000950710     C                   EXSR      $INZSR
013100970114     C                   EXSR      $CLEAR
013200950706     C*
013300080304     C                   CALL      'ERMSG2'
013301080324     C                   Parm                    DSPGMN
013400950605     C*
013500960626     C* Retrieve record:
013600950607     C*
013700941228     C                   EXSR      $GETRC
013800950607     C*
013900970108     C* If record is in use, retrieve the user who has the lock,
014000970108     C* close the display file, and return to the previous program:
014100950626     C*
014200950621     C     WWRCDE        IFEQ      INUSE
014300950621     C                   CALL      'GEN8001C'
014400960626     C                   PARM                    WIIUSE
014500941228     C                   MOVEL     WWRCDE        WRRCDE
014600080325     C                   CLOSE     CAT0111D
014700950621     C                   RETURN
014800950621     C                   END
014900970109     C*
015000970109     C* Retrieve field descriptions:
015100970109     C*
015200970109     C                   EXSR      $DESCR
015300950525     C*
015400970109     C* Main loop:
015500970109     C*
015600950728     C     WWRCDE        DOUEQ     EXIT
015700950728     C     WWRCDE        OREQ      NEXT
015800950530     C*
015900970114     C* Clear all fields, if requested:
016000970109     C*
016100970114     C     WWCLR1        IFEQ      YES
016200970114     C                   EXSR      $CLEAR
016300970114     C                   END
016400970114     C*
016500970114     C* Retrieve record, if requested:
016600970114     C*
016700950530     C     WWGETR        IFEQ      YES
016800950530     C                   EXSR      $GETRC
016900960626     C                   EXSR      $DESCR
017000950530     C                   END
017100950607     C*
017200950607     C* Lookup header screen mode description:
017300950607     C*
017400950607     C                   Z-ADD     1             X
017500960626     C     WIACTN        LOOKUP    MOD(X)                                 99
017600950607     C     *IN99         IFEQ      *ON
017700941229     C                   MOVEL     DSC(X)        WRDSC1
017800950607     C                   END
017801100521      *
017802100521     c                   If        *in29 = *on and (*in36 = *on
017803100521     c                             or *in37 = *on)
017804100521     c   51              Movel     wrcatk        wrcatk1l
017805100521     c   52              Movel     wrcatk        wrcatk2l
017806100521     c   53              Movel     wrcatk        wrcatk3l
017807100521     c   54              Movel     wrcatk        wrcatk4l
017808100521     c   55              Movel     wrcatk        wrcatk5l
017809100521     c   56              Movel     wrcatk        wrcatk6l
017810100521     c   57              Movel     wrcatk        wrcatk7l
017811100521     c   58              Movel     wrcatk        wrcatk8l
017812100521     c   59              Movel     wrcatk        wrcatk9l
017813100521     c   60              Movel     wrcatk        wrcatk10l
017814100521     c   61              Movel     wrcatk        wrcatk11l
017815100521     c   62              Movel     wrcatk        wrcatk12l
017816100521     c   63              Movel     wrcatk        wrcatk13l
017817100521     c   64              Movel     wrcatk        wrcatk14l
017818100521     c   65              Movel     wrcatk        wrcatk15l
017819100521     c   66              Movel     wrcatk        wrcatk16l
017820100521     c   67              Movel     wrcatk        wrcatk17l
017821100521     c   68              Movel     wrcatk        wrcatk18l
017822100521     c   69              Movel     wrcatk        wrcatk19l
017823100521     c   70              Movel     wrcatk        wrcatkl
017824100521     c                   Endif
017826100521     c                   If        *in29 = *off and (*in36 = *on
017827100521     c                             or *in37 = *on)
017828100521     c   51              Movel     wrcatk        wrcatk1
017829100521     c   52              Movel     wrcatk        wrcatk2
017830100521     c   53              Movel     wrcatk        wrcatk3
017831100521     c   54              Movel     wrcatk        wrcatk4
017832100521     c   55              Movel     wrcatk        wrcatk5
017833100521     c   56              Movel     wrcatk        wrcatk6
017834100521     c   57              Movel     wrcatk        wrcatk7
017835100521     c   58              Movel     wrcatk        wrcatk8
017836100521     c   59              Movel     wrcatk        wrcatk9
017837100521     c   60              Movel     wrcatk        wrcatk10
017838100521     c   61              Movel     wrcatk        wrcatk11
017839100521     c   62              Movel     wrcatk        wrcatk12
017840100521     c   63              Movel     wrcatk        wrcatk13
017841100521     c   64              Movel     wrcatk        wrcatk14
017842100521     c   65              Movel     wrcatk        wrcatk15
017843100521     c   66              Movel     wrcatk        wrcatk16
017844100521     c   67              Movel     wrcatk        wrcatk17
017845100521     c   68              Movel     wrcatk        wrcatk18
017846100521     c   69              Movel     wrcatk        wrcatk19
017847100521     c                   Endif
017900950614     C*
018000970109     C* Display screen:
018100970109     C*
018200950706     C                   WRITE     MSGCTL1
018300950614     C                   WRITE     SCRNK01
018400950614     C                   EXFMT     SCRNR01
018401100519     c                   If        *in29 = *on
018402100519     c   51              Movel     wrcatk1l      wrcatk
018403100519     c   52              Movel     wrcatk2l      wrcatk
018404100519     c   53              Movel     wrcatk3l      wrcatk
018405100519     c   54              Movel     wrcatk4l      wrcatk
018406100519     c   55              Movel     wrcatk5l      wrcatk
018407100519     c   56              Movel     wrcatk6l      wrcatk
018408100519     c   57              Movel     wrcatk7l      wrcatk
018409100519     c   58              Movel     wrcatk8l      wrcatk
018410100519     c   59              Movel     wrcatk9l      wrcatk
018411100519     c   60              Movel     wrcatk10l     wrcatk
018412100519     c   61              Movel     wrcatk11l     wrcatk
018413100519     c   62              Movel     wrcatk12l     wrcatk
018414100519     c   63              Movel     wrcatk13l     wrcatk
018415100519     c   64              Movel     wrcatk14l     wrcatk
018416100519     c   65              Movel     wrcatk15l     wrcatk
018417100519     c   66              Movel     wrcatk16l     wrcatk
018418100519     c   67              Movel     wrcatk17l     wrcatk
018419100519     c   68              Movel     wrcatk18l     wrcatk
018420100519     c   69              Movel     wrcatk19l     wrcatk
018421100519     c   70              Movel     wrcatkl       wrcatk
018422100519     c                   Endif
018423100519     c                   If        *in29 = *off
018424100519     c   51              Movel     wrcatk1       wrcatk
018425100519     c   52              Movel     wrcatk2       wrcatk
018426100519     c   53              Movel     wrcatk3       wrcatk
018427100519     c   54              Movel     wrcatk4       wrcatk
018428100519     c   55              Movel     wrcatk5       wrcatk
018429100519     c   56              Movel     wrcatk6       wrcatk
018430100519     c   57              Movel     wrcatk7       wrcatk
018431100519     c   58              Movel     wrcatk8       wrcatk
018432100519     c   59              Movel     wrcatk9       wrcatk
018433100519     c   60              Movel     wrcatk10      wrcatk
018434100519     c   61              Movel     wrcatk11      wrcatk
018435100519     c   62              Movel     wrcatk12      wrcatk
018436100519     c   63              Movel     wrcatk13      wrcatk
018437100519     c   64              Movel     wrcatk14      wrcatk
018438100519     c   65              Movel     wrcatk15      wrcatk
018439100519     c   66              Movel     wrcatk16      wrcatk
018440100519     c   67              Movel     wrcatk17      wrcatk
018441100519     c   68              Movel     wrcatk18      wrcatk
018442100519     c   69              Movel     wrcatk19      wrcatk
018443100519     c                   Endif
018500950728     C*
018600970109     C* F12 = return to previous program:
018700970109     C*
018800950608     C     *IN12         IFEQ      *ON
018900950713     C                   MOVEL     NEXT          WWRCDE
019000950608     C                   ELSE
019100950706     C*
019200950706     C     WWFRST        IFEQ      YES
019300950706     C                   MOVE      NO            WWFRST
019400950706     C                   END
019500950530     C*
019600950605     C                   MOVE      NO            WWGETR
019700950605     C*
019800960418     C* Set off error indicators here:
019900950605     C*
020000080325     C                   MOVEA     '0'           *IN(40)
020100960418     C*
020200950605     C                   CLEAR                   WWERR1
020300941228     C*
020400941228     C* Clear messages:
020500941228     C*
020600080304     C                   CALL      'ERMSG2'
020601080324     C                   Parm                    DSPGMN
020700950526     C*
020800080325     C* Process command keys:
020900950526     C*
021000950526     C                   SELECT
021100970114     C*
021200970114     C* F4 = Prompt:
021300970114     C*
021400970114     C     *IN04         WHENEQ    *ON
021500970114     C                   EXSR      $PRMPT
021600970114     C                   EXSR      $DESCR
021700950608     C*
021800950526     C                   OTHER
021900950526     C*
022000950526     C* Enter:
022100950526     C*
022200960626     C     WIACTN        IFEQ      DISPLY
022300950620     C                   MOVEL     NEXT          WWRCDE
022400950615     C                   ELSE
022500941228     C*
022600970109     C* Error check, if in maintenance mode:
022700970109     C*
022800960610     C     *IN36         IFEQ      *OFF
022900960610     C                   EXSR      $ERR01
023000960610     C                   END
023100950615     C*
023200970109     C* If no error, update record:
023300970109     C*
023400960627     C     WWERR1        IFNE      ERROR
023500960627     C                   EXSR      $DESCR
023600960627     C                   EXSR      $ENTER
023700960627     C                   END
023800941228     C*
023900950615     C                   END
024000950526     C*
024100950526     C                   ENDSL
024200950526     C*
024300950526     C                   END
024400950526     C*
024500950526     C                   ENDDO
024600950525     C*
024700080324     C* Pass return code back to calling program through JLD field:
024800951027     C*
024900941228     C                   MOVEL     WWRCDE        WRRCDE
025000950711     C*
025100970108     C* Close the display file:
025200970108     C*
025300080325     C                   CLOSE     CAT0111D
025400950712     C*
025500970108     C* Release record lock:
025600970108     C*
025700960626     C     WIACTN        IFEQ      CHANGE
025800980716     C     WIACTN        OREQ      DELETE
025900080325     C                   UNLOCK    CodeCat
026000950712     C                   END
026100950620     C*
026200950710     C                   RETURN
026300941228      /EJECT
026400941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026500941228     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
026600941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
026700970114     C*
026800970114     C**************
026900970114     C**  $CLEAR  ** - Intialize Program/Database Fields
027000970114     C**************
027100970114     C     $CLEAR        BEGSR
027200970114     C*
027300970114     C* Program stays open. All program/screen fields and indicators
027400970114     C* must be re-initialized here each time this program is called.
027500970114     C*
027600970114     C*
027700970114     C*
027800970114     C* Initialize screen and data base fields:
027900970114     C*
028000970114     C                   CLEAR                   SCRNR01
028100080325     C                   CLEAR                   @CodeCat
028200970114     C*
028300970114     C* Field definitions and initialization:
028400970114     C*
028500970114     C     *LIKE         DEFINE    WRRCDE        WWRCDE
028700970114     C*
028800970114     C* Clear all *LIKE definitions:
028900970114     C*
029000970114     C                   CLEAR                   WWRCDE
029200970114     C*
029300970114     C* Initialize program described fields:
029400970114     C*
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
030500970114     C*
030600970114     C* Fill default screen values:
030700970114     C*
030701100519      * Get category header
030702100519     c     wicode        chain     codehdr
030703100519     c                   If        %found
030704100519     c                   Eval      wrcodd = chcodd
030705100519     C                   MOVEL     chkeylab      WRkeylab
030706100519     C                   MOVEL     chdatalab     WRdatalab
030707100519     c                   If        challowlc = 'Y'
030708100519     c                   Eval      *in29 = *on
030709100519     c                   Else
030710100519     c                   Eval      *in29 = *off
030711100519     c                   Endif
030712100519      * Set key length
030713100519     c                   Movea     '0000000000'  *in(51)
030714100519     c                   Movea     '0000000000'  *in(61)
030715100519     c                   Eval      xx = 50 + chkeylen
030716100519     c                   Eval      *in(xx) = *on
030717100519     c                   Endif
030718080325     C*
030900970114     C*
031000080324     C* Fill default screen values from JLD:
031100970114     C*
031101080325     C*
031900970114     C*
032000970114     C* Protect all input capable fields:
032100970114     C*
032200970114     C     WIACTN        IFEQ      DISPLY
032300980716     C     WIACTN        OREQ      DELETE
032400970114     C                   MOVE      *ON           *IN36
032500970114     C                   ELSE
032600970114     C                   MOVE      *OFF          *IN36
032700970114     C                   END
032800970114     C*
032900970114     C* Protect key fields in change mode:
033000970114     C*
033100970114     C     WIACTN        IFEQ      CHANGE
033200970114     C                   MOVE      *ON           *IN37
033300970114     C                   ELSE
033400970114     C                   MOVE      *OFF          *IN37
033500970114     C                   END
033600970114     C*
033700100519     C                   MOVE      *OFF          *IN80
033800970114     C*
033900970114     C                   ENDSR
034000970114      /EJECT
034100941228     C*
034200941228     C**************
034300970109     C**  $GETRC  ** - Retrieve Data Base Record
034400941228     C**************
034500950526     C     $GETRC        BEGSR
034600950608     C*
034700960626     C     WIACTN        IFNE      ADD
034800941228     C*
034900950615     C* Do not lock record if copy or display mode:
035000950615     C*
035100960626     C     WIACTN        IFEQ      COPY
035200960626     C     WIACTN        OREQ      DISPLY
035300080325     C     CCK01         CHAIN(N)  CodeCat                            99
035400941228     C                   ELSE
035500100519     C     CCK01         CHAIN     CodeCat                            9980
035600941228     C                   END
035700950530     C*
035800100519     C     *IN80         IFEQ      *ON
035900950607     C                   MOVEL     INUSE         WWRCDE
036000950620     C                   ELSE
036100950620     C     *IN99         IFEQ      *OFF
036200950530     C                   EXSR      $MOVIN
036300950620     C                   END
036400950620     C                   END
036500950530     C*
036600950530     C                   ELSE
036700950530     C*
036800950530     C                   EXSR      $MOVIN
036900941228     C*
037000941228     C                   END
037100941228     C*
037200950526     C                   ENDSR
037300950526      /EJECT
037400950526     C*
037500950526     C**************
037600950607     C**  $MOVIN  ** - Move Data Base Fields to Screen Fields
037700950526     C**************
037800950526     C     $MOVIN        BEGSR
037900950614     C*
038000970108     C* Add/copy mode default values:
038100950614     C*
038200080325     C     WIACTN        IFEQ      ADD
038300960626     C     WIACTN        OREQ      COPY
038301080325     C                   Eval      WRCode = WICode
038400960626     C                   END
038500960610     C*
038600960610     C                   SELECT
038700960610     C*
038800960626     C     WIACTN        WHENEQ    COPY
038900960626     C     WIACTN        OREQ      CHANGE
039000960626     C     WIACTN        OREQ      DISPLY
039100980716     C     WIACTN        OREQ      DELETE
039200970108     C*
039300970109     C* Move DB fields to screen fields here:
039400970108     C*
039500080326     C                   MOVEL     CCCATC        WRCode
039501080326     C                   MOVEL     CCCATK        WRCATK
039502080325     C                   MOVEL     CCCATD        WRCATD
039600960610     C*
039700970108     C* Display last update user/date:
039800970108     C*
039900970109     C     WIACTN        IFNE      COPY
040000980709     C*
040100080325     C                   MOVEL     CCLUSR        WRLUSR
040101080325     C                   MOVEL     CCLPGM        WRLPGM
040200980709     C*
040201080325     C                   If        CCLDTE <> 0
040202080325     C                   Move      CCLDTE        ConvertDate
040203080304     C     *mdy          Move      ConvertDate   WRLDTE
040204080324     C                   Else
040205080324     C                   Clear                   wrldte
040206080324     C                   Endif
040207080325     C                   Move      CCLTIM        wrltim
041400960610     C*
041500980709     C                   END
041600980709     C*
041700960610     C                   ENDSL
041800950525     C*
041900950525     C                   ENDSR
042000970109      /EJECT
042100970109     C*
042200970109     C**************
042300970109>>>> C**  $DESCR  ** - Retrieve field descriptions
042400970109     C**************
042500970109     C     $DESCR        BEGSR
042600970109     C*
042700970109     C                   ENDSR
042800970114     C/EJECT
042900970114     C*
043000970114     C**************
043100970114     C**  $PRMPT  ** - Process Promptable Fields
043200970114     C**************
043300970114     C     $PRMPT        BEGSR
043400970114     C*
043500970114     C*****************************************************************
043600970114     C*  Field HDCSRF (defined in DDS) contains the field name which
043700970114     C*  contains the cursor. If valid, a prompting program may be
043800970114     C*  called to select a record from a list of valid values for
043900970114     C*  the prompted field. The value selected should then be placed
044000970114     C*  in the field which was prompted.
044100970114     C*
044200970114     C* eg; HDCSRF    WHEQ 'WRXXX1'
044300970114     C*      Cursor resides in field WRXXX1
044400970114     C*
044500970114     C*     CALL 'GEN0109R'
044600970114     C*      Codes file prompting program.
044700970114     C*
044800970114     C*     PARM '653'     WWCTAB
044900970114     C*      Outgoing parm.
045000970114     C*
045100970114     C*     PARM *BLANKS   WWCKEY
045200970114     C*      Return parm.
045300970114     C*
045400970114     C*     MOVELWWCKEY    WRXXX1
045500970114     C*      Move return parm into prompted field.
045600970114     C*
045700970114     C*****************************************************************
045800970114     C*
045900970114     C                   SELECT
046000970114     C*
046100080325     C*    HDCSRF        WHENEQ    'WRXXX1'
046200080325     C*                  CALL      'GEN0109R'
046300080325     C*                  PARM      '653'         WWCTAB
046400080325     C*                  PARM      *BLANKS       WWCKEY
046500080325     C*
046600080325     C*    WWCKEY        IFNE      *BLANKS
046700080325     C*                  MOVEL     WWCKEY        WRXXX1
046800080325     C*                  ENDIF
046900080325     C*
047000080325     C*    HDCSRF        WHENEQ    'WRXXX2'
047100080325     C*                  CALL      'GEN0109R'
047200080325     C*                  PARM      '654'         WWCTAB
047300080325     C*                  PARM      *BLANKS       WWCKEY
047400080325     C*
047500080325     C*    WWCKEY        IFNE      *BLANKS
047600080325     C*                  MOVEL     WWCKEY        WRXXX2
047700080325     C*                  ENDIF
047800970114     C*
047900970114     C* Non propmtable area:
048000970114     C*
048100970114     C                   OTHER
048200970114     C*
048300080324     C                   MOVEL     'SHL0004'     WWMSGI
048500080304     C                   CALL      'ERMSG1'      MSGP01
048600970114     C*
048700970114     C                   ENDSL
048800970114     C*
048900970114     C                   ENDSR
049000970109      /EJECT
049100970109     C*
049200970109     C**************
049300080325     C**  $ERR01  ** - Vaildity Checking
049400970109     C**************
049500970109     C     $ERR01        BEGSR
049600970109     C*
049700970109     C                   CLEAR                   WWERR1
049800970117     C*
049900970117     C*****************************************************************
050000970117     C* All error conditions must have the following lines of code:
050100970117     C*
050200970117     C*   MOVE *ON       *INXX
050300970117     C*     Where *INXX = field error indicator in DDS.
050400970117     C*
050500970117     C*   MOVELERROR     WWERR1
050600970117     C*     Program error flag.
050700970117     C*
050800970117     C*   MOVEL'XXX0001' WWMSGI
050900970117     C*     Where XXX0001 = error message id to be displayed.
051000970117     C*
051100970117     C*   MOVELXXXXXX    WWMSGF
051200970117     C*     Where XXXXXX = name of the message file which contains
051300970117     C*     the message id contained in field WWMSGI.
051400970117     C*
051500080304     C*   CALL 'ERMSG1'MSGP01
051600970117     C*     Message handling program.
051700970117     C*****************************************************************
051800970117     C*
053000970109     C*
053100970109     C* Record already exists on file:
053200970109     C*
053300970109     C     WIACTN        IFEQ      ADD
053400970109     C     WIACTN        OREQ      COPY
053500080325     C     CCK02         SETLL     CodeCat                                99
053600970109     C     *IN99         IFEQ      *ON
053700970109     C                   MOVEL     ERROR         WWERR1
053800080324     C                   MOVEL     'SHL0005'     WWMSGI
054000080304     C                   CALL      'ERMSG1'      MSGP01
054100970109     C                   END
054200970109     C                   END
054300970109     C*
054301100519     c                   If        chdatatype = 'N' and
054302100519     c                             0 <> %check('0123456789 ':wrcatk)
054303100519     C                   MOVEL     ERROR         WWERR1
054304100519     C                   MOVEL     'CAT0004'     WWMSGI
054305100519     C                   CALL      'ERMSG1'      MSGP01
054306100519     c                   Eval      *in40 = *on
054307100519     C                   END
054308100519     C*
054400970109     C     WWERR1        IFEQ      ERROR
054500970109     C                   CLEAR                   WWENTR
054600970109     C                   END
054700970109     C*
054800970109     C                   ENDSR
054900941228      /EJECT
055000941228     C*
055100941228     C**************
055200950607     C**  $ENTER  ** - Enter Key Pressed
055300941228     C**************
055400941228     C     $ENTER        BEGSR
055500941228     C*
055600090930     C*****              ADD       1             WWENTR
055700960705     C*
055800960705     C* Update only if screen has been changed:
055900960705     C*
056000960705     C     *IN38         IFEQ      *ON
056100960705     C                   MOVE      YES           WWUPD1
056200960705     C                   END
056300970109     C*
056400970109     C* Send verification messages:
056500950607     C*
056600970109     C     WWENTR        IFEQ      1
056700970109     C*
056800970109     C                   SELECT
056900970109     C*
057000970109     C     WIACTN        WHENEQ    ADD
057100970109     C     WIACTN        OREQ      COPY
057200080324     C                   MOVEL     'SHL0001'     WWMSGI
057400080304     C                   CALL      'ERMSG1'      MSGP01
057500970109     C*
057600970109     C     WIACTN        WHENEQ    CHANGE
057700080324     C                   MOVEL     'SHL0002'     WWMSGI
057900080304     C                   CALL      'ERMSG1'      MSGP01
058000970109     C*
058100980716     C     WIACTN        WHENEQ    DELETE
058200080324     C                   MOVEL     'SHL0003'     WWMSGI
058400080304     C                   CALL      'ERMSG1'      MSGP01
058500970109     C*
058600970109     C                   ENDSL
058700941228     C*
058800941228     C                   ELSE
058900970109     C*
059000970109     C* Update database according to current mode:
059100970109     C*
059200970109     C                   CLEAR                   WWENTR
059300970109     C                   CLEAR                   WWCNT1
059400970114     C*
059500970114     C                   MOVEL     NEXT          WWRCDE
059600970114     C*
059700970114     C                   SELECT
059800970109     C*
059900970109     C     WIACTN        WHENEQ    CHANGE
060000970109     C     WWUPD1        ANDEQ     YES
060100970109     C                   EXSR      $MOVOU
060200080325     C                   UPDATE    @CodeCat
060300970109     C*
060400970109     C     WIACTN        WHENEQ    ADD
060500970109     C     WIACTN        OREQ      COPY
060600970109     C                   EXSR      $MOVOU
060700080325     C                   WRITE     @CodeCat
060800970109     C*
060900980716     C     WIACTN        WHENEQ    DELETE
061000080325     C                   DELETE    CodeCat
061100970109     C*
061200970109     C                   ENDSL
061300970114     C*
061400970114     C* Pass 'position to' fields back to calling program:
061500970114     C*
061600080325     C                   MOVE      WRCode        WICode
061700080325     C                   MOVE      WRCatK        WICatK
061800970114     C*
061900970114     C* If add mode, initialize all fields and redisplay the screen:
062000970114     C*
062100970114     C     WIACTN        IFEQ      ADD
062200970114     C                   CLEAR                   WWRCDE
062300970114     C                   MOVE      YES           WWCLR1
062400970114     C                   MOVE      YES           WWGETR
062500970114     C                   END
062600970109     C*
062700970109     C                   MOVE      NO            WWUPD1
062800941228     C*
062900941228     C                   END
063000941228     C*
063100941228     C                   ENDSR
063200950526      /EJECT
063300950526     C*
063400950526     C**************
063500950607     C**  $MOVOU  ** - Move Screen Fields to Data Base Fields
063600950526     C**************
063700950526     C     $MOVOU        BEGSR
063800950530     C*
063900970108     C* Move screen fields to DB fields:
064000970108     C*
064100080325     C                   MOVEL     WRCode        CCCatC
064101080325     C                   MOVEL     WRCatK        CCCatK
064102080325     C                   MOVEL     WRCatD        CCCatD
064300960610     C*
064400970108     C* Retrieve current date in YYYYMMDD for last update date:
064500970108     C*
065200980710     C*
065401080325     C                   Eval      CCLDTE = %int(%char(%date:*iso0))
065500080325     C                   TIME                    CCLTIM
065600080325     C                   MOVEL     DSPGMN        CCLPGM
065700080325     C                   MOVEL     DSUSER        CCLUSR
065900941228     C*
066000950526     C                   ENDSR
066100950608      /EJECT
066200950608     C*
066300950608     C**************
066400950710     C**  $INZSR  ** - Program Initialization
066500950608     C**************
066600950710     C     $INZSR        BEGSR
066700950607     C*
066800950607     C* Parm lists:
066900950607     C*
067000950525     C     *ENTRY        PLIST
067100080324     C                   PARM                    JLD
067200941228     C                   PARM                    APPL
067300100519     C*                       t
067400950607     C* Message file:
067500941228     C*
067600941228     C     MSGP01        PLIST
067700941228     C                   PARM                    WWMSGI            7
068600950530     C*
068700950607     C* Key lists:
068800950607     C*
068900950530     C     CODK01        KLIST
069000950530     C                   KFLD                    WWCTAB
069100950530     C                   KFLD                    WWCKEY
069200950622     C*
069300970120     C*****************************************************************
069400970120     C* Key lists. XXXK01 is used for retieving the record to be
069500970120     C* maintained based on the record key passed to the program.
069600970120     C* XXXK02 is used to determine if a record with a duplicate
069700970120     C* key already exists on file (ADD and COPY modes only) based
069800970120     C* on the current screen field values entered by the user.
069900970120     C*
070000080304     C*   eg; File maintained - ITEMMSTR (Item/Type Code).
070100970120     C*
070200970120     C*
070300970120     C*     XXXK01    KLIST
070400080304     C*               KFLD           WIITM   <-- incoming parm
070500080304     C*               KFLD           WIICDE  <-- incoming parm
070700970120     C*
070800970120     C*     XXXK02    KLIST
070900080304     C*               KFLD           WRITM   <-- screen field
071000080304     C*               KFLD           WRICDE  <-- screen field
071200970120     C*
071300970120     C*****************************************************************
071400970120     C*
071500970120     C*
071600080325     C     CCK01         KLIST
071800080325     C                   KFLD                    WICode
071801080325     C                   KFLD                    WICatK
071900970120     C*
072000080325     C     CCK02         KLIST
072200080325     C                   KFLD                    WRCode
072201080325     C                   KFLD                    WRCatK
072300950710     C*
072400950710     C* Close files if requested by calling program:
072500950710     C*
072600960626     C     WIINLR        IFEQ      YES
072700950710     C                   MOVE      *ON           *INLR
072800950710     C                   RETURN
072900950710     C                   END
073000950713     C*
073100970108     C* Open display file:
073200970108     C*
073300080325     C                   OPEN      CAT0111D
073400970114     C*
073500970114     C                   MOVE      NO            WWGETR            1
073600970114     C*
073700970114     C                   ENDSR
073800080325     C*
073900980716**
074000100519ADD       Create a Code Category Record
074100100519COPY      Copy a Code Category Record
074200100519CHANGE    Change a Code Category Record
074300100519DELETE    Delete a Code Category Record
074400100519DISPLY    Display a Code Category Record
