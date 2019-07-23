000100941228     F*****************************************************************
000200941228     F*                                                               *
000300080325     F* Program ID...... CAT0101R                                     *
000400080325     F* Program Desc.... Maintain Codes Category Headers              *
000500960626     F* Request Number.. 1234                                         *
000600941228     F*                                                               *
000700080325     F* Written By...... Greg Cannella                                *
000800080325     F* Date Written....  3/24/08                                     *
000900941228     F*                                                               *
001000950711     F* Comments........ Files will remain open until this program is *
001100950711     F*                  called with parm DSINLR equal to 'Y'.        *
001200941228     F*                                                               *
001300941228     F*****************************************************************
001400951010     F* CL Special Processing:                                        *
001500950608     F*                                                               *
001600950719     F*****************************************************************
001700970418     F* Compile Options:                                              *
001800950719     F*                                                               *
001900951009     F*****************************************************************
002000951009     F* Modifications:                                                *
002100951009     F* Req#  By   Date      Modification                             *
002200960611     F* 1234  xxx  xx/xx/xx                                           *
002300960116     F*                                                               *
002400950608     F*****************************************************************
002500950608     F* Indicator Usage:                                              *
002600950608     F* Ind      Use                                                  *
002700950607     F* 01-24    Function keys                                        *
002800950607     F* 25       Rollup key                                           *
002900950608     F* 36       Protect all input fields                             *
003000970108     F* 37       Protect key fields in change mode                    *
003100970108     F* 38       Record format level CHANGE keyword indicator         *
003200950802     F* 40-51    Error Indicators                                     *
003300950626     F* 60       Record lock                                          *
003400950626     F* 90-99    Hit/Miss                                             *
003500950607     F*                                                               *
003600941228     F*****************************************************************
003700960626      /EJECT
003800960626     F*****************************************************************
003900960626     F* Field Definitions                                             *
004000960626     F*                                                               *
004100960626     F* Prefix                                                        *
004200960626     F* WW     - Program described work fields                        *
004300960626     F* WI     - APPL input parameters                                *
004400960626     F* WR     - Display record fields                                *
004500960626     F* HD     - Hidden fields                                        *
004600960626     F* Ax     - APPx output parameters for called programs           *
004700960626     F* DS     - Data structure fields                                *
004800960626     F*                                                               *
004900960626     F*                                                               *
005000960626     F* Display Record Format Definitions                             *
005100960626     F*                                                               *
005200960626     F* Prefix                                                        *
005300960626     F* SCRNK  - Command key                                          *
005400960626     F* SCRNR  - Standard display                                     *
005500960626     F* WNDWB  - Window border                                        *
005600960626     F* WNDWR  - Standard window display                              *
005700960626     F* MSGCTL - Message subfile control                              *
005800960626     F*                                                               *
005900960626     F*                                                               *
006000960626     F* Called programs                                               *
006100960626     F*                                                               *
006200080304     F* ERMSG2 - Clear program message queue                        *
006300080304     F* ERMSG1 - Send program message with message data             *
006400960626     F*                                                               *
006500960626     F*                                                               *
006600960626     F*****************************************************************
006700941228      /EJECT
006800941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
006900941228     F*P          P  R  O  G  R  A  M    S  P  E  C  S                P
007000941228     F*PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
007100941228     F*
007200080325     FCAT0101D  CF   E             WORKSTN USROPN
007300080325     FCodeHdr   UF A E           K DISK
007400950607     D*
007500950607     D* Header screen mode desriptions:
007600950607     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
007700950607     D DSC             S             30    DIM(5) ALT(MOD)
007800941228     D*
007900941228     D*
008000950525     D* General constants:
008100950525     D ERROR           C                   CONST('ERROR')
008200950607     D INUSE           C                   CONST('INUSE')
008300950525     D CHANGE          C                   CONST('CHANGE')
008400950525     D COPY            C                   CONST('COPY')
008500950525     D ADD             C                   CONST('ADD')
008600980716     D DELETE          C                   CONST('DELETE')
008700950525     D DISPLY          C                   CONST('DISPLY')
008800950620     D NEXT            C                   CONST('NEXT')
008900950525     D EXIT            C                   CONST('EXIT')
009000951026     D NO              C                   CONST('N')
009100950525     D YES             C                   CONST('Y')
009200080325     D*
009300080325     D ConvertDate     s               d
009400950525     D*
009500080324     D jld           E DS                  EXTNAME(dsjld)
009600941228     D*
009700950619     D* Incoming parms:
009800941228     D APPL            DS           512
009900960626     D  WISEC                  1      5
010000960626     D  WIIUSE                 6     15
010100960626     D  WIINLR                16     16
010200960626     D  WIACTN                17     26
010300080325     D  WICode                27     36
010400980709     D*
010500941228     D                SDS
010600960705     D  DSPGMN           *PROC
010700950608     D  DSUSER               254    263
010800950626      /EJECT
010900941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011000941228     M*M                 M  A  I  N  L  I  N  E                       M
011100941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011200941228     M*
011300950710     C*
011400950710     C                   EXSR      $INZSR
011500970114     C                   EXSR      $CLEAR
011600950706     C*
011700080304     C                   CALL      'ERMSG2'
011800080324     C                   Parm                    DSPGMN
011900950605     C*
012000960626     C* Retrieve record:
012100950607     C*
012200941228     C                   EXSR      $GETRC
012300950607     C*
012400970108     C* If record is in use, retrieve the user who has the lock,
012500970108     C* close the display file, and return to the previous program:
012600950626     C*
012700950621     C     WWRCDE        IFEQ      INUSE
012800950621     C                   CALL      'GEN8001C'
012900960626     C                   PARM                    WIIUSE
013000941228     C                   MOVEL     WWRCDE        WRRCDE
013100080325     C                   CLOSE     CAT0101D
013200950621     C                   RETURN
013300950621     C                   END
013400970109     C*
013500970109     C* Retrieve field descriptions:
013600970109     C*
013700970109     C                   EXSR      $DESCR
013800950525     C*
013900970109     C* Main loop:
014000970109     C*
014100950728     C     WWRCDE        DOUEQ     EXIT
014200950728     C     WWRCDE        OREQ      NEXT
014300950530     C*
014400970114     C* Clear all fields, if requested:
014500970109     C*
014600970114     C     WWCLR1        IFEQ      YES
014700970114     C                   EXSR      $CLEAR
014800970114     C                   END
014900970114     C*
015000970114     C* Retrieve record, if requested:
015100970114     C*
015200950530     C     WWGETR        IFEQ      YES
015300950530     C                   EXSR      $GETRC
015400960626     C                   EXSR      $DESCR
015500950530     C                   END
015600950607     C*
015700950607     C* Lookup header screen mode description:
015800950607     C*
015900950607     C                   Z-ADD     1             X
016000960626     C     WIACTN        LOOKUP    MOD(X)                                 99
016100950607     C     *IN99         IFEQ      *ON
016200941229     C                   MOVEL     DSC(X)        WRDSC1
016300950607     C                   END
016400950614     C*
016500970109     C* Display screen:
016600970109     C*
016700950706     C                   WRITE     MSGCTL1
016800950614     C                   WRITE     SCRNK01
016900950614     C                   EXFMT     SCRNR01
017000950728     C*
017100970109     C* F12 = return to previous program:
017200970109     C*
017300950608     C     *IN12         IFEQ      *ON
017400950713     C                   MOVEL     NEXT          WWRCDE
017500950608     C                   ELSE
017600950706     C*
017700950706     C     WWFRST        IFEQ      YES
017800950706     C                   MOVE      NO            WWFRST
017900950706     C                   END
018000950530     C*
018100950605     C                   MOVE      NO            WWGETR
018200950605     C*
018300960418     C* Set off error indicators here:
018400950605     C*
018500080325     C                   MOVEA     '0'           *IN(40)
018600960418     C*
018700950605     C                   CLEAR                   WWERR1
018800941228     C*
018900941228     C* Clear messages:
019000941228     C*
019100080304     C                   CALL      'ERMSG2'
019200080324     C                   Parm                    DSPGMN
019300950526     C*
019400080325     C* Process command keys:
019500950526     C*
019600950526     C                   SELECT
019700970114     C*
019800970114     C* F4 = Prompt:
019900970114     C*
020000970114     C     *IN04         WHENEQ    *ON
020100970114     C                   EXSR      $PRMPT
020200970114     C                   EXSR      $DESCR
020300950608     C*
020400950526     C                   OTHER
020500950526     C*
020600950526     C* Enter:
020700950526     C*
020800960626     C     WIACTN        IFEQ      DISPLY
020900950620     C                   MOVEL     NEXT          WWRCDE
021000950615     C                   ELSE
021100941228     C*
021200970109     C* Error check, if in maintenance mode:
021300970109     C*
021400960610     C     *IN36         IFEQ      *OFF
021500960610     C                   EXSR      $ERR01
021600960610     C                   END
021700950615     C*
021800970109     C* If no error, update record:
021900970109     C*
022000960627     C     WWERR1        IFNE      ERROR
022100960627     C                   EXSR      $DESCR
022200960627     C                   EXSR      $ENTER
022300960627     C                   END
022400941228     C*
022500950615     C                   END
022600950526     C*
022700950526     C                   ENDSL
022800950526     C*
022900950526     C                   END
023000950526     C*
023100950526     C                   ENDDO
023200950525     C*
023300080324     C* Pass return code back to calling program through JLD field:
023400951027     C*
023500941228     C                   MOVEL     WWRCDE        WRRCDE
023600950711     C*
023700970108     C* Close the display file:
023800970108     C*
023900080325     C                   CLOSE     CAT0101D
024000950712     C*
024100970108     C* Release record lock:
024200970108     C*
024300960626     C     WIACTN        IFEQ      CHANGE
024400980716     C     WIACTN        OREQ      DELETE
024500080325     C                   UNLOCK    CodeHdr
024600950712     C                   END
024700950620     C*
024800950710     C                   RETURN
024900941228      /EJECT
025000941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025100941228     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
025200941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025300970114     C*
025400970114     C**************
025500970114     C**  $CLEAR  ** - Intialize Program/Database Fields
025600970114     C**************
025700970114     C     $CLEAR        BEGSR
025800970114     C*
025900970114     C* Program stays open. All program/screen fields and indicators
026000970114     C* must be re-initialized here each time this program is called.
026100970114     C*
026200970114     C*
026300970114     C*
026400970114     C* Initialize screen and data base fields:
026500970114     C*
026600970114     C                   CLEAR                   SCRNR01
026700080325     C                   CLEAR                   @CodeHdr
026800970114     C*
026900970114     C* Field definitions and initialization:
027000970114     C*
027100970114     C     *LIKE         DEFINE    WRRCDE        WWRCDE
027200970114     C*
027300970114     C* Clear all *LIKE definitions:
027400970114     C*
027500970114     C                   CLEAR                   WWRCDE
027600970114     C*
027700970114     C* Initialize program described fields:
027800970114     C*
027900970114     C                   MOVE      *ZEROS        WWENTR            2 0
028000970114     C                   MOVE      *ZEROS        X                 1 0
028100970114     C                   MOVE      *BLANKS       WWCTAB            3
028200970114     C                   MOVE      *BLANKS       WWCKEY           27
028300970114     C                   MOVE      YES           WWFRST            1
028400970114     C                   MOVE      NO            WWCLR1            1
028500970114     C                   MOVE      *BLANKS       WWNEXT            1
028600970114     C                   MOVE      *BLANKS       WWUPD1            1
028700970114     C                   MOVE      *BLANKS       WWERR1           10
028800970114     C                   Z-ADD     *ZERO         WWCNT1            3 0
028900970114     C*
029000970114     C* Fill default screen values:
029100970114     C*
029200080325     C*
029300080325     C*
029400080324     C* Fill default screen values from JLD:
029500970114     C*
029600080325     C*
029700970114     C*
029800970114     C* Protect all input capable fields:
029900970114     C*
030000970114     C     WIACTN        IFEQ      DISPLY
030100980716     C     WIACTN        OREQ      DELETE
030200970114     C                   MOVE      *ON           *IN36
030300970114     C                   ELSE
030400970114     C                   MOVE      *OFF          *IN36
030500970114     C                   END
030600970114     C*
030700970114     C* Protect key fields in change mode:
030800970114     C*
030900970114     C     WIACTN        IFEQ      CHANGE
031000970114     C                   MOVE      *ON           *IN37
031100970114     C                   ELSE
031200970114     C                   MOVE      *OFF          *IN37
031300970114     C                   END
031400970114     C*
031500970114     C                   MOVE      *OFF          *IN60
031600970114     C*
031700970114     C                   ENDSR
031800970114      /EJECT
031900941228     C*
032000941228     C**************
032100970109     C**  $GETRC  ** - Retrieve Data Base Record
032200941228     C**************
032300950526     C     $GETRC        BEGSR
032400950608     C*
032500960626     C     WIACTN        IFNE      ADD
032600941228     C*
032700950615     C* Do not lock record if copy or display mode:
032800950615     C*
032900960626     C     WIACTN        IFEQ      COPY
033000960626     C     WIACTN        OREQ      DISPLY
033100080325     C     CHK01         CHAIN(N)  CodeHdr                            99
033200941228     C                   ELSE
033300080325     C     CHK01         CHAIN     CodeHdr                            9960
033400941228     C                   END
033500950530     C*
033600950620     C     *IN60         IFEQ      *ON
033700950607     C                   MOVEL     INUSE         WWRCDE
033800950620     C                   ELSE
033900950620     C     *IN99         IFEQ      *OFF
034000950530     C                   EXSR      $MOVIN
034100950620     C                   END
034200950620     C                   END
034300950530     C*
034400950530     C                   ELSE
034500950530     C*
034600950530     C                   EXSR      $MOVIN
034700941228     C*
034800941228     C                   END
034900941228     C*
035000950526     C                   ENDSR
035100950526      /EJECT
035200950526     C*
035300950526     C**************
035400950607     C**  $MOVIN  ** - Move Data Base Fields to Screen Fields
035500950526     C**************
035600950526     C     $MOVIN        BEGSR
035700950614     C*
035800970108     C* Add/copy mode default values:
035900950614     C*
036000080325     C     WIACTN        IFEQ      ADD
036100960626     C     WIACTN        OREQ      COPY
036200960626     C                   END
036300960610     C*
036400960610     C                   SELECT
036500960610     C*
036600960626     C     WIACTN        WHENEQ    COPY
036700960626     C     WIACTN        OREQ      CHANGE
036800960626     C     WIACTN        OREQ      DISPLY
036900980716     C     WIACTN        OREQ      DELETE
037000970108     C*
037100970109     C* Move DB fields to screen fields here:
037200970108     C*
037300080325     C                   MOVEL     CHCode        WRCode
037400080325     C                   MOVEL     CHCodd        WRCodd
037500090923     C                   MOVEL     CHCodx        WRCodx
037501100519     C                   z-add     CHkeylen      WRkeylen
037502100519     C                   MOVEL     CHkeylab      WRkeylab
037503100519     C                   MOVEL     CHdatalab     WRdatalab
037504100519     C                   MOVEL     CHallowlc     WRallowlc
037505100519     C                   MOVEL     CHdatatype    WRdatatype
037600960610     C*
037700970108     C* Display last update user/date:
037800970108     C*
037900970109     C     WIACTN        IFNE      COPY
038000980709     C*
038100080325     C                   MOVEL     CHLUSR        WRLUSR
038200080325     C                   MOVEL     CHLPGM        WRLPGM
038300980709     C*
038400080325     C                   If        CHLDTE <> 0
038500080325     C                   Move      CHLDTE        ConvertDate
038600080304     C     *mdy          Move      ConvertDate   WRLDTE
038700080324     C                   Else
038800080324     C                   Clear                   wrldte
038900080324     C                   Endif
039000080325     C                   Move      CHLTIM        wrltim
039100960610     C*
039200980709     C                   END
039300980709     C*
039400960610     C                   ENDSL
039500950525     C*
039600950525     C                   ENDSR
039700970109      /EJECT
039800970109     C*
039900970109     C**************
040000080325     C**  $DESCR  ** - Retrieve field descriptions
040100970109     C**************
040200970109     C     $DESCR        BEGSR
040300970109     C*
040400970109     C                   ENDSR
040500970114     C/EJECT
040600970114     C*
040700970114     C**************
040800970114     C**  $PRMPT  ** - Process Promptable Fields
040900970114     C**************
041000970114     C     $PRMPT        BEGSR
041100970114     C*
041200970114     C*****************************************************************
041300970114     C*  Field HDCSRF (defined in DDS) contains the field name which
041400970114     C*  contains the cursor. If valid, a prompting program may be
041500970114     C*  called to select a record from a list of valid values for
041600970114     C*  the prompted field. The value selected should then be placed
041700970114     C*  in the field which was prompted.
041800970114     C*
041900970114     C* eg; HDCSRF    WHEQ 'WRXXX1'
042000970114     C*      Cursor resides in field WRXXX1
042100970114     C*
042200970114     C*     CALL 'GEN0109R'
042300970114     C*      Codes file prompting program.
042400970114     C*
042500970114     C*     PARM '653'     WWCTAB
042600970114     C*      Outgoing parm.
042700970114     C*
042800970114     C*     PARM *BLANKS   WWCKEY
042900970114     C*      Return parm.
043000970114     C*
043100970114     C*     MOVELWWCKEY    WRXXX1
043200970114     C*      Move return parm into prompted field.
043300970114     C*
043400970114     C*****************************************************************
043500970114     C*
043600970114     C                   SELECT
043700970114     C*
043800080325     C*    HDCSRF        WHENEQ    'WRXXX1'
043900080325     C*                  CALL      'GEN0109R'
044000080325     C*                  PARM      '653'         WWCTAB
044100080325     C*                  PARM      *BLANKS       WWCKEY
044200080325     C*
044300080325     C*    WWCKEY        IFNE      *BLANKS
044400080325     C*                  MOVEL     WWCKEY        WRXXX1
044500080325     C*                  ENDIF
044600080325     C*
044700080325     C*    HDCSRF        WHENEQ    'WRXXX2'
044800080325     C*                  CALL      'GEN0109R'
044900080325     C*                  PARM      '654'         WWCTAB
045000080325     C*                  PARM      *BLANKS       WWCKEY
045100970707      *
045200080325     C*    WWCKEY        IFNE      *BLANKS
045300080325     C*                  MOVEL     WWCKEY        WRXXX2
045400080325     C*                  ENDIF
045500970114     C*
045600970114     C* Non propmtable area:
045700970114     C*
045800970114     C                   OTHER
045900970114     C*
046000080324     C                   MOVEL     'SHL0004'     WWMSGI
046100080304     C                   CALL      'ERMSG1'      MSGP01
046200970114     C*
046300970114     C                   ENDSL
046400970114     C*
046500970114     C                   ENDSR
046600970109      /EJECT
046700970109     C*
046800970109     C**************
046900080325     C**  $ERR01  ** - Vaildity Checking
047000970109     C**************
047100970109     C     $ERR01        BEGSR
047200970109     C*
047300970109     C                   CLEAR                   WWERR1
047400970117     C*
047500970117     C*****************************************************************
047600970117     C* All error conditions must have the following lines of code:
047700970117     C*
047800970117     C*   MOVE *ON       *INXX
047900970117     C*     Where *INXX = field error indicator in DDS.
048000970117     C*
048100970117     C*   MOVELERROR     WWERR1
048200970117     C*     Program error flag.
048300970117     C*
048400970117     C*   MOVEL'XXX0001' WWMSGI
048500970117     C*     Where XXX0001 = error message id to be displayed.
048600970117     C*
048700970117     C*   MOVELXXXXXX    WWMSGF
048800970117     C*     Where XXXXXX = name of the message file which contains
048900970117     C*     the message id contained in field WWMSGI.
049000970117     C*
049100080304     C*   CALL 'ERMSG1'MSGP01
049200970117     C*     Message handling program.
049300970117     C*****************************************************************
049400970117     C*
049500970109     C*
049600970109     C* Record already exists on file:
049700970109     C*
049800970109     C     WIACTN        IFEQ      ADD
049900970109     C     WIACTN        OREQ      COPY
050000080325     C     CHK02         SETLL     CodeHdr                                99
050100970109     C     *IN99         IFEQ      *ON
050200970109     C                   MOVEL     ERROR         WWERR1
050300080324     C                   MOVEL     'SHL0005'     WWMSGI
050400080304     C                   CALL      'ERMSG1'      MSGP01
050500970109     C                   END
050600970109     C                   END
050700970109     C*
050701100519     C                   IF        wrkeylen > 20
050702100519     C                   MOVEL     ERROR         WWERR1
050703100519     C                   MOVEL     'CAT0001'     WWMSGI
050704100519     C                   CALL      'ERMSG1'      MSGP01
050705100519     C                   END
050706100519     C*
050707100519     C                   IF        wrallowlc <> 'Y'
050708100519     c                             and wrallowlc <> *blanks
050709100519     C                   MOVEL     ERROR         WWERR1
050710100519     C                   MOVEL     'CAT0002'     WWMSGI
050711100519     C                   CALL      'ERMSG1'      MSGP01
050712100519     C                   END
050713100519     C*
050714100519     C                   IF        wrdatatype <> 'A'
050715100519     c                             and wrdatatype <> 'N'
050716100519     C                   MOVEL     ERROR         WWERR1
050717100519     C                   MOVEL     'CAT0003'     WWMSGI
050718100519     C                   CALL      'ERMSG1'      MSGP01
050719100519     C                   END
050720100519     C*
050800970109     C     WWERR1        IFEQ      ERROR
050900970109     C                   CLEAR                   WWENTR
051000970109     C                   END
051100970109     C*
051200970109     C                   ENDSR
051300941228      /EJECT
051400941228     C*
051500941228     C**************
051600950607     C**  $ENTER  ** - Enter Key Pressed
051700941228     C**************
051800941228     C     $ENTER        BEGSR
051900941228     C*
052000090930     C*****              ADD       1             WWENTR
052100960705     C*
052200960705     C* Update only if screen has been changed:
052300960705     C*
052400960705     C     *IN38         IFEQ      *ON
052500960705     C                   MOVE      YES           WWUPD1
052600960705     C                   END
052700970109     C*
052800970109     C* Send verification messages:
052900950607     C*
053000970109     C     WWENTR        IFEQ      1
053100970109     C*
053200970109     C                   SELECT
053300970109     C*
053400970109     C     WIACTN        WHENEQ    ADD
053500970109     C     WIACTN        OREQ      COPY
053600080324     C                   MOVEL     'SHL0001'     WWMSGI
053700080304     C                   CALL      'ERMSG1'      MSGP01
053800970109     C*
053900970109     C     WIACTN        WHENEQ    CHANGE
054000080324     C                   MOVEL     'SHL0002'     WWMSGI
054100080304     C                   CALL      'ERMSG1'      MSGP01
054200970109     C*
054300980716     C     WIACTN        WHENEQ    DELETE
054400080324     C                   MOVEL     'SHL0003'     WWMSGI
054500080304     C                   CALL      'ERMSG1'      MSGP01
054600970109     C*
054700970109     C                   ENDSL
054800941228     C*
054900941228     C                   ELSE
055000970109     C*
055100970109     C* Update database according to current mode:
055200970109     C*
055300970109     C                   CLEAR                   WWENTR
055400970109     C                   CLEAR                   WWCNT1
055500970114     C*
055600970114     C                   MOVEL     NEXT          WWRCDE
055700970114     C*
055800970114     C                   SELECT
055900970109     C*
056000970109     C     WIACTN        WHENEQ    CHANGE
056100970109     C     WWUPD1        ANDEQ     YES
056200970109     C                   EXSR      $MOVOU
056300080325     C                   UPDATE    @CodeHdr
056400970109     C*
056500970109     C     WIACTN        WHENEQ    ADD
056600970109     C     WIACTN        OREQ      COPY
056700970109     C                   EXSR      $MOVOU
056800080325     C                   WRITE     @CodeHdr
056900970109     C*
057000980716     C     WIACTN        WHENEQ    DELETE
057100080325     C                   DELETE    CodeHdr
057200970109     C*
057300970109     C                   ENDSL
057400970114     C*
057500970114     C* Pass 'position to' fields back to calling program:
057600970114     C*
057700080325     C                   MOVE      WRCode        WICode
057800970114     C*
057900970114     C* If add mode, initialize all fields and redisplay the screen:
058000970114     C*
058100970114     C     WIACTN        IFEQ      ADD
058200970114     C                   CLEAR                   WWRCDE
058300970114     C                   MOVE      YES           WWCLR1
058400970114     C                   MOVE      YES           WWGETR
058500970114     C                   END
058600970109     C*
058700970109     C                   MOVE      NO            WWUPD1
058800941228     C*
058900941228     C                   END
059000941228     C*
059100941228     C                   ENDSR
059200950526      /EJECT
059300950526     C*
059400950526     C**************
059500950607     C**  $MOVOU  ** - Move Screen Fields to Data Base Fields
059600950526     C**************
059700950526     C     $MOVOU        BEGSR
059800950530     C*
059900970108     C* Move screen fields to DB fields:
060000970108     C*
060100080325     C                   MOVEL     WRCode        CHCode
060200080325     C                   MOVEL     WRCodd        CHCodd
060300090923     C                   MOVEL     WRCodx        CHCodx
060301100519     C                   z-add     WRkeylen      CHkeylen
060302100519     C                   MOVEL     WRkeylab      CHkeylab
060303100519     C                   MOVEL     WRdatalab     CHdatalab
060304100519     C                   MOVEL     WRallowlc     CHallowlc
060305100519     C                   MOVEL     WRdatatype    CHdatatype
060400960610     C*
060500970108     C* Retrieve current date in YYYYMMDD for last update date:
060600970108     C*
060700980710     C*
060800080325     C                   Eval      CHLDTE = %int(%char(%date:*iso0))
060900080325     C                   TIME                    CHLTIM
061000080325     C                   MOVEL     DSPGMN        CHLPGM
061100080325     C                   MOVEL     DSUSER        CHLUSR
061200941228     C*
061300950526     C                   ENDSR
061400950608      /EJECT
061500950608     C*
061600950608     C**************
061700950710     C**  $INZSR  ** - Program Initialization
061800950608     C**************
061900950710     C     $INZSR        BEGSR
062000950607     C*
062100950607     C* Parm lists:
062200950607     C*
062300950525     C     *ENTRY        PLIST
062400080324     C                   PARM                    JLD
062500941228     C                   PARM                    APPL
062600941228     C*
062700950607     C* Message file:
062800941228     C*
062900941228     C     MSGP01        PLIST
063000941228     C                   PARM                    WWMSGI            7
063100950530     C*
063200950607     C* Key lists:
063300950607     C*
063400950530     C     CODK01        KLIST
063500950530     C                   KFLD                    WWCTAB
063600950530     C                   KFLD                    WWCKEY
063700950622     C*
063800970120     C*****************************************************************
063900970120     C* Key lists. XXXK01 is used for retieving the record to be
064000970120     C* maintained based on the record key passed to the program.
064100970120     C* XXXK02 is used to determine if a record with a duplicate
064200970120     C* key already exists on file (ADD and COPY modes only) based
064300970120     C* on the current screen field values entered by the user.
064400970120     C*
064500080304     C*   eg; File maintained - ITEMMSTR (Item/Type Code).
064600970120     C*
064700970120     C*
064800970120     C*     XXXK01    KLIST
064900080304     C*               KFLD           WIITM   <-- incoming parm
065000080304     C*               KFLD           WIICDE  <-- incoming parm
065100970120     C*
065200970120     C*     XXXK02    KLIST
065300080304     C*               KFLD           WRITM   <-- screen field
065400080304     C*               KFLD           WRICDE  <-- screen field
065500970120     C*
065600970120     C*****************************************************************
065700970120     C*
065800970120     C*
065900080325     C     CHK01         KLIST
066000080325     C                   KFLD                    WICode
066100970120     C*
066200080325     C     CHK02         KLIST
066300080325     C                   KFLD                    WRCode
066400950710     C*
066500950710     C* Close files if requested by calling program:
066600950710     C*
066700960626     C     WIINLR        IFEQ      YES
066800950710     C                   MOVE      *ON           *INLR
066900950710     C                   RETURN
067000950710     C                   END
067100950713     C*
067200970108     C* Open display file:
067300970108     C*
067400080325     C                   OPEN      CAT0101D
067500970114     C*
067600970114     C                   MOVE      NO            WWGETR            1
067700970114     C*
067800970114     C                   ENDSR
067900080325     C*
068000980716**
068100080325ADD         Create a Category Header
068200080325COPY         Copy a Category Header
068300080325CHANGE      Change a Category Header
068400080325DELETE      Delete a Category Header
068500080325DISPLY      Display a Category Header
