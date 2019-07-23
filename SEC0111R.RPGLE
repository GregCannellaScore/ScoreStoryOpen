000100941228     F*****************************************************************
000200941228     F*                                                               *
000300080324     F* Program ID...... SEC0111R                                     *
000400080324     F* Program Desc.... Maintain Program Level Security              *
000500960626     F* Request Number.. 1234                                         *
000600941228     F*                                                               *
000700080324     F* Written By...... Greg Cannella                                *
000800080324     F* Date Written....  3/24/08                                     *
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
002100091109     F* Req#  By        Date      Modification                        *
002200091109     F* /001  Galina    11/09/09  Add user and program validation     *
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
007200080324     FSEC0111D  CF   E             WORKSTN USROPN
007300080324     FPGMSEC    UF A E           K DISK
007400091109/011 FUsefile   IF   E           K DISK
007500091109      *---------------------------------------------------------
007600950607     D* Header screen mode desriptions:
007700950607     D MOD             S             10    DIM(5) CTDATA PERRCD(1)
007800950607     D DSC             S             30    DIM(5) ALT(MOD)
007900941228     D*
008000941228     D*
008100950525     D* General constants:
008200950525     D ERROR           C                   CONST('ERROR')
008300950607     D INUSE           C                   CONST('INUSE')
008400950525     D CHANGE          C                   CONST('CHANGE')
008500950525     D COPY            C                   CONST('COPY')
008600950525     D ADD             C                   CONST('ADD')
008700980716     D DELETE          C                   CONST('DELETE')
008800950525     D DISPLY          C                   CONST('DISPLY')
008900950620     D NEXT            C                   CONST('NEXT')
009000950525     D EXIT            C                   CONST('EXIT')
009100951026     D NO              C                   CONST('N')
009200950525     D YES             C                   CONST('Y')
009300950525     D*
009400080324     D ConvertDate     s               d
009500080324     D*
009600080324     D jld           E DS                  EXTNAME(dsjld)
009700941228     D*
009800950619     D* Incoming parms:
009900941228     D APPL            DS           512
010000960626     D  WISEC                  1      5
010100960626     D  WIIUSE                 6     15
010200960626     D  WIINLR                16     16
010300960626     D  WIACTN                17     26
010400080324     D  WIuser                27     36
010500080324     D  WIpgm                 37     46
010600980709     D*
010700941228     D                SDS
010800960705     D  DSPGMN           *PROC
010900950608     D  DSUSER               254    263
011000950626      /EJECT
011100941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011200941228     M*M                 M  A  I  N  L  I  N  E                       M
011300941228     M*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
011400941228     M*
011500950710     C*
011600950710     C                   EXSR      $INZSR
011700970114     C                   EXSR      $CLEAR
011800950706     C*
011900080304     C                   CALL      'ERMSG2'
012000080324     C                   Parm                    DSPGMN
012100950605     C*
012200960626     C* Retrieve record:
012300950607     C*
012400941228     C                   EXSR      $GETRC
012500950607     C*
012600970108     C* If record is in use, retrieve the user who has the lock,
012700970108     C* close the display file, and return to the previous program:
012800950626     C*
012900950621     C     WWRCDE        IFEQ      INUSE
013000950621     C                   CALL      'GEN8001C'
013100960626     C                   PARM                    WIIUSE
013200941228     C                   MOVEL     WWRCDE        WRRCDE
013300080324     C                   CLOSE     SEC0111D
013400950621     C                   RETURN
013500950621     C                   END
013600970109     C*
013700970109     C* Retrieve field descriptions:
013800970109     C*
013900970109     C                   EXSR      $DESCR
014000950525     C*
014100970109     C* Main loop:
014200970109     C*
014300950728     C     WWRCDE        DOUEQ     EXIT
014400950728     C     WWRCDE        OREQ      NEXT
014500950530     C*
014600970114     C* Clear all fields, if requested:
014700970109     C*
014800970114     C     WWCLR1        IFEQ      YES
014900970114     C                   EXSR      $CLEAR
015000970114     C                   END
015100970114     C*
015200970114     C* Retrieve record, if requested:
015300970114     C*
015400950530     C     WWGETR        IFEQ      YES
015500950530     C                   EXSR      $GETRC
015600960626     C                   EXSR      $DESCR
015700950530     C                   END
015800950607     C*
015900950607     C* Lookup header screen mode description:
016000950607     C*
016100950607     C                   Z-ADD     1             X
016200960626     C     WIACTN        LOOKUP    MOD(X)                                 99
016300950607     C     *IN99         IFEQ      *ON
016400941229     C                   MOVEL     DSC(X)        WRDSC1
016500950607     C                   END
016600950614     C*
016700970109     C* Display screen:
016800970109     C*
016900950706     C                   WRITE     MSGCTL1
017000950614     C                   WRITE     SCRNK01
017100950614     C                   EXFMT     SCRNR01
017200950728     C*
017300970109     C* F12 = return to previous program:
017400970109     C*
017500950608     C     *IN12         IFEQ      *ON
017600950713     C                   MOVEL     NEXT          WWRCDE
017700950608     C                   ELSE
017800950706     C*
017900950706     C     WWFRST        IFEQ      YES
018000950706     C                   MOVE      NO            WWFRST
018100950706     C                   END
018200950530     C*
018300950605     C                   MOVE      NO            WWGETR
018400950605     C*
018500960418     C* Set off error indicators here:
018600950605     C*
018700080324     C                   MOVEA     '0'           *IN(40)
018800960418     C*
018900950605     C                   CLEAR                   WWERR1
019000941228     C*
019100941228     C* Clear messages:
019200941228     C*
019300080304     C                   CALL      'ERMSG2'
019400080324     C                   Parm                    DSPGMN
019500950526     C*
019600080324     C* Process command keys:
019700950526     C*
019800950526     C                   SELECT
019900970114     C*
020000970114     C* F4 = Prompt:
020100970114     C*
020200970114     C     *IN04         WHENEQ    *ON
020300970114     C                   EXSR      $PRMPT
020400970114     C                   EXSR      $DESCR
020500950608     C*
020600950526     C                   OTHER
020700950526     C*
020800950526     C* Enter:
020900950526     C*
021000960626     C     WIACTN        IFEQ      DISPLY
021100950620     C                   MOVEL     NEXT          WWRCDE
021200950615     C                   ELSE
021300941228     C*
021400970109     C* Error check, if in maintenance mode:
021500970109     C*
021600960610     C     *IN36         IFEQ      *OFF
021700960610     C                   EXSR      $ERR01
021800960610     C                   END
021900950615     C*
022000970109     C* If no error, update record:
022100970109     C*
022200960627     C     WWERR1        IFNE      ERROR
022300960627     C                   EXSR      $DESCR
022400960627     C                   EXSR      $ENTER
022500960627     C                   END
022600941228     C*
022700950615     C                   END
022800950526     C*
022900950526     C                   ENDSL
023000950526     C*
023100950526     C                   END
023200950526     C*
023300950526     C                   ENDDO
023400950525     C*
023500080324     C* Pass return code back to calling program through JLD field:
023600951027     C*
023700941228     C                   MOVEL     WWRCDE        WRRCDE
023800950711     C*
023900970108     C* Close the display file:
024000970108     C*
024100080324     C                   CLOSE     SEC0111D
024200950712     C*
024300970108     C* Release record lock:
024400970108     C*
024500960626     C     WIACTN        IFEQ      CHANGE
024600980716     C     WIACTN        OREQ      DELETE
024700080324     C                   UNLOCK    pgmsec
024800950712     C                   END
024900950620     C*
025000950710     C                   RETURN
025100941228      /EJECT
025200941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025300941228     C*$              S  U  B  R  O  U  T  I  N  E  S                 $
025400941228     C*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
025500970114     C*
025600970114     C**************
025700970114     C**  $CLEAR  ** - Intialize Program/Database Fields
025800970114     C**************
025900970114     C     $CLEAR        BEGSR
026000970114     C*
026100970114     C* Program stays open. All program/screen fields and indicators
026200970114     C* must be re-initialized here each time this program is called.
026300970114     C*
026400970114     C*
026500970114     C*
026600970114     C* Initialize screen and data base fields:
026700970114     C*
026800970114     C                   CLEAR                   SCRNR01
026900080324     C                   CLEAR                   @pgmsec
027000970114     C*
027100970114     C* Field definitions and initialization:
027200970114     C*
027300970114     C     *LIKE         DEFINE    WRRCDE        WWRCDE
027400970114     C*
027500970114     C* Clear all *LIKE definitions:
027600970114     C*
027700970114     C                   CLEAR                   WWRCDE
027800970114     C*
027900970114     C* Initialize program described fields:
028000970114     C*
028100970114     C                   MOVE      *ZEROS        WWENTR            2 0
028200970114     C                   MOVE      *ZEROS        X                 1 0
028300970114     C                   MOVE      *BLANKS       WWCTAB            3
028400970114     C                   MOVE      *BLANKS       WWCKEY           27
028500970114     C                   MOVE      YES           WWFRST            1
028600970114     C                   MOVE      NO            WWCLR1            1
028700970114     C                   MOVE      *BLANKS       WWNEXT            1
028800970114     C                   MOVE      *BLANKS       WWUPD1            1
028900970114     C                   MOVE      *BLANKS       WWERR1           10
029000970114     C                   Z-ADD     *ZERO         WWCNT1            3 0
029100970114     C*
029200970114     C* Fill default screen values:
029300970114     C*
029400080324     C****               MOVEL     DSUSER        WRUSER
029500970114     C*
029600080324     C* Fill default screen values from JLD:
029700970114     C*
029800970114     C*
029900970114     C* Protect all input capable fields:
030000970114     C*
030100970114     C     WIACTN        IFEQ      DISPLY
030200980716     C     WIACTN        OREQ      DELETE
030300970114     C                   MOVE      *ON           *IN36
030400970114     C                   ELSE
030500970114     C                   MOVE      *OFF          *IN36
030600970114     C                   END
030700970114     C*
030800970114     C* Protect key fields in change mode:
030900970114     C*
031000970114     C     WIACTN        IFEQ      CHANGE
031100970114     C                   MOVE      *ON           *IN37
031200970114     C                   ELSE
031300970114     C                   MOVE      *OFF          *IN37
031400970114     C                   END
031500970114     C*
031600970114     C                   MOVE      *OFF          *IN60
031700970114     C*
031800970114     C                   ENDSR
031900970114      /EJECT
032000941228     C*
032100941228     C**************
032200970109     C**  $GETRC  ** - Retrieve Data Base Record
032300941228     C**************
032400950526     C     $GETRC        BEGSR
032500950608     C*
032600960626     C     WIACTN        IFNE      ADD
032700941228     C*
032800950615     C* Do not lock record if copy or display mode:
032900950615     C*
033000960626     C     WIACTN        IFEQ      COPY
033100960626     C     WIACTN        OREQ      DISPLY
033200080324     C     psk01         CHAIN(N)  pgmsec                             99
033300941228     C                   ELSE
033400080324     C     psk01         CHAIN     pgmsec                             9960
033500941228     C                   END
033600950530     C*
033700950620     C     *IN60         IFEQ      *ON
033800950607     C                   MOVEL     INUSE         WWRCDE
033900950620     C                   ELSE
034000950620     C     *IN99         IFEQ      *OFF
034100950530     C                   EXSR      $MOVIN
034200950620     C                   END
034300950620     C                   END
034400950530     C*
034500950530     C                   ELSE
034600950530     C*
034700950530     C                   EXSR      $MOVIN
034800941228     C*
034900941228     C                   END
035000941228     C*
035100950526     C                   ENDSR
035200950526      /EJECT
035300950526     C*
035400950526     C**************
035500950607     C**  $MOVIN  ** - Move Data Base Fields to Screen Fields
035600950526     C**************
035700950526     C     $MOVIN        BEGSR
035800950614     C*
035900970108     C* Add/copy mode default values:
036000950614     C*
036100080324     C     WIACTN        IFEQ      ADD
036200960626     C     WIACTN        OREQ      COPY
036300960626     C                   END
036400960610     C*
036500960610     C                   SELECT
036600960610     C*
036700960626     C     WIACTN        WHENEQ    COPY
036800960626     C     WIACTN        OREQ      CHANGE
036900960626     C     WIACTN        OREQ      DISPLY
037000980716     C     WIACTN        OREQ      DELETE
037100970108     C*
037200970109     C* Move DB fields to screen fields here:
037300970108     C*
037400080324     C                   MOVEL     psuser        WRuser
037500080324     C                   MOVEL     pspgm         WRpgm
037600080324     C                   MOVEL     psopt1        WRopt1
037700080324     C                   MOVEL     psopt2        WRopt2
037800080324     C                   MOVEL     psopt3        WRopt3
037900080324     C                   MOVEL     psopt4        WRopt4
038000080324     C                   MOVEL     psopt5        WRopt5
038100960610     C*
038200970108     C* Display last update user/date:
038300970108     C*
038400970109     C     WIACTN        IFNE      COPY
038500980709     C*
038600080324     C                   MOVEL     pslusr        WRLUSR
038700080324     C                   MOVEL     pslpgm        WRLPGM
038800980709     C*
038900080324     c                   If        psldte <> 0
039000080324     C                   Move      psldte        ConvertDate
039100080304     C     *mdy          Move      ConvertDate   WRLDTE
039200080324     c                   Else
039300080324     c                   Clear                   wrldte
039400080324     c                   Endif
039500080324     C                   Move      psltim        wrltim
039600960610     C*
039700980709     C                   END
039800980709     C*
039900960610     C                   ENDSL
040000950525     C*
040100950525     C                   ENDSR
040200970109      /EJECT
040300970109     C*
040400970109     C**************
040500080324     C**  $DESCR  ** - Retrieve field descriptions
040600970109     C**************
040700970109     C     $DESCR        BEGSR
040800970109     C*
040900970109     C                   ENDSR
041000970114     C/EJECT
041100970114     C*
041200970114     C**************
041300970114     C**  $PRMPT  ** - Process Promptable Fields
041400970114     C**************
041500970114     C     $PRMPT        BEGSR
041600970114     C*
041700970114     C*****************************************************************
041800970114     C*  Field HDCSRF (defined in DDS) contains the field name which
041900970114     C*  contains the cursor. If valid, a prompting program may be
042000970114     C*  called to select a record from a list of valid values for
042100970114     C*  the prompted field. The value selected should then be placed
042200970114     C*  in the field which was prompted.
042300970114     C*
042400970114     C* eg; HDCSRF    WHEQ 'WRXXX1'
042500970114     C*      Cursor resides in field WRXXX1
042600970114     C*
042700970114     C*     CALL 'GEN0109R'
042800970114     C*      Codes file prompting program.
042900970114     C*
043000970114     C*     PARM '653'     WWCTAB
043100970114     C*      Outgoing parm.
043200970114     C*
043300970114     C*     PARM *BLANKS   WWCKEY
043400970114     C*      Return parm.
043500970114     C*
043600970114     C*     MOVELWWCKEY    WRXXX1
043700970114     C*      Move return parm into prompted field.
043800970114     C*
043900970114     C*****************************************************************
044000970114     C*
044100970114     C                   SELECT
044200970114     C*
044300110517     C     HDCSRF        WHENEQ    'WRUSER'
044400110517     C                   CALL      'USERSL'
044500110517     C                   PARM                    WRUSER
044600080324     C*
044700080324     C*    WWCKEY        IFNE      *BLANKS
044800080324     C*                  MOVEL     WWCKEY        WRXXX1
044900080324     C*                  ENDIF
045000080324     C*
045100080324     C*    HDCSRF        WHENEQ    'WRXXX2'
045200080324     C*                  CALL      'GEN0109R'
045300080324     C*                  PARM      '654'         WWCTAB
045400080324     C*                  PARM      *BLANKS       WWCKEY
045500080324     C*
045600080324     C*    WWCKEY        IFNE      *BLANKS
045700080324     C*                  MOVEL     WWCKEY        WRXXX2
045800080324     C*                  ENDIF
045900970114     C*
046000970114     C* Non propmtable area:
046100970114     C*
046200970114     C                   OTHER
046300970114     C*
046400080324     C                   MOVEL     'SHL0004'     WWMSGI
046500080304     C                   CALL      'ERMSG1'      MSGP01
046600970114     C*
046700970114     C                   ENDSL
046800970114     C*
046900970114     C                   ENDSR
047000970109      /EJECT
047100970109     C*
047200970109     C**************
047300080324     C**  $ERR01  ** - Vaildity Checking
047400970109     C**************
047500970109     C     $ERR01        BEGSR
047600970109     C*
047700970109     C                   CLEAR                   WWERR1
047800970117     C*
047900970117     C*****************************************************************
048000970117     C* All error conditions must have the following lines of code:
048100970117     C*
048200970117     C*   MOVE *ON       *INXX
048300970117     C*     Where *INXX = field error indicator in DDS.
048400970117     C*
048500970117     C*   MOVELERROR     WWERR1
048600970117     C*     Program error flag.
048700970117     C*
048800970117     C*   MOVEL'XXX0001' WWMSGI
048900970117     C*     Where XXX0001 = error message id to be displayed.
049000970117     C*
049100970117     C*   MOVELXXXXXX    WWMSGF
049200970117     C*     Where XXXXXX = name of the message file which contains
049300970117     C*     the message id contained in field WWMSGI.
049400970117     C*
049500080304     C*   CALL 'ERMSG1'MSGP01
049600970117     C*     Message handling program.
049700970117     C*****************************************************************
049800970117     C*
049900970109     C*
050000970109     C* Record already exists on file:
050100970109     C*
050200970109     C     WIACTN        IFEQ      ADD
050300970109     C     WIACTN        OREQ      COPY
050400080324     C     psk02         SETLL     pgmsec                                 99
050500970109     C     *IN99         IFEQ      *ON
050600970109     C                   MOVEL     ERROR         WWERR1
050700080324     C                   MOVEL     'SHL0005'     WWMSGI
050800080304     C                   CALL      'ERMSG1'      MSGP01
050900091109     C                   EndIf
051000091109     C                   EndIf
051100091109     C*
051200091109     C* Validate user:
051300091109     C*
051400091109/011 C     Wruser        SETLL     usefile
051500091109/011 C                   If        not %equal(Usefile) or Wruser = *blank
051600091109/011 C                   MOVEL     ERROR         WWERR1
051700141130/011 C                   MOVEL     'SHL0011'     WWMSGI
051800091109/011 C                   CALL      'ERMSG1'      MSGP01
051900091109/011 C                   EndIf
052000091109     C*
052100091109     C* Program has to be entered:
052200091109     C*
052300091109/011 C                   If        Wrpgm = *blank
052400091109/011 C                   MOVEL     ERROR         WWERR1
052500141130/011 C                   MOVEL     'SHL0012'     WWMSGI
052600091109/011 C                   CALL      'ERMSG1'      MSGP01
052700091109/011 C                   EndIf
052800091109     C*
052900970109     C     WWERR1        IFEQ      ERROR
053000970109     C                   CLEAR                   WWENTR
053100091109     C                   EndIf
053200970109     C*
053300970109     C                   ENDSR
053400941228      /EJECT
053500941228     C*
053600941228     C**************
053700950607     C**  $ENTER  ** - Enter Key Pressed
053800941228     C**************
053900941228     C     $ENTER        BEGSR
054000941228     C*
054100090930     C*****              ADD       1             WWENTR
054200960705     C*
054300960705     C* Update only if screen has been changed:
054400960705     C*
054500960705     C     *IN38         IFEQ      *ON
054600960705     C                   MOVE      YES           WWUPD1
054700960705     C                   END
054800970109     C*
054900970109     C* Send verification messages:
055000950607     C*
055100970109     C     WWENTR        IFEQ      1
055200970109     C*
055300970109     C                   SELECT
055400970109     C*
055500970109     C     WIACTN        WHENEQ    ADD
055600970109     C     WIACTN        OREQ      COPY
055700080324     C                   MOVEL     'SHL0001'     WWMSGI
055800080304     C                   CALL      'ERMSG1'      MSGP01
055900970109     C*
056000970109     C     WIACTN        WHENEQ    CHANGE
056100080324     C                   MOVEL     'SHL0002'     WWMSGI
056200080304     C                   CALL      'ERMSG1'      MSGP01
056300970109     C*
056400980716     C     WIACTN        WHENEQ    DELETE
056500080324     C                   MOVEL     'SHL0003'     WWMSGI
056600080304     C                   CALL      'ERMSG1'      MSGP01
056700970109     C*
056800970109     C                   ENDSL
056900941228     C*
057000941228     C                   ELSE
057100970109     C*
057200970109     C* Update database according to current mode:
057300970109     C*
057400970109     C                   CLEAR                   WWENTR
057500970109     C                   CLEAR                   WWCNT1
057600970114     C*
057700970114     C                   MOVEL     NEXT          WWRCDE
057800970114     C*
057900970114     C                   SELECT
058000970109     C*
058100970109     C     WIACTN        WHENEQ    CHANGE
058200970109     C     WWUPD1        ANDEQ     YES
058300970109     C                   EXSR      $MOVOU
058400080324     C                   UPDATE    @pgmsec
058500970109     C*
058600970109     C     WIACTN        WHENEQ    ADD
058700970109     C     WIACTN        OREQ      COPY
058800970109     C                   EXSR      $MOVOU
058900080324     C                   WRITE     @pgmsec
059000970109     C*
059100980716     C     WIACTN        WHENEQ    DELETE
059200080324     C                   DELETE    pgmsec
059300970109     C*
059400970109     C                   ENDSL
059500970114     C*
059600970114     C* Pass 'position to' fields back to calling program:
059700970114     C*
059800080324     C                   MOVE      WRuser        WIuser
059900080324     C                   MOVE      WRpgm         WIpgm
060000970114     C*
060100970114     C* If add mode, initialize all fields and redisplay the screen:
060200970114     C*
060300970114     C     WIACTN        IFEQ      ADD
060400970114     C                   CLEAR                   WWRCDE
060500970114     C                   MOVE      YES           WWCLR1
060600970114     C                   MOVE      YES           WWGETR
060700970114     C                   END
060800970109     C*
060900970109     C                   MOVE      NO            WWUPD1
061000941228     C*
061100941228     C                   END
061200941228     C*
061300941228     C                   ENDSR
061400950526      /EJECT
061500950526     C*
061600950526     C**************
061700950607     C**  $MOVOU  ** - Move Screen Fields to Data Base Fields
061800950526     C**************
061900950526     C     $MOVOU        BEGSR
062000950530     C*
062100970108     C* Move screen fields to DB fields:
062200970108     C*
062300080324     C                   MOVEL     WRuser        psuser
062400080324     C                   MOVEL     WRpgm         pspgm
062500080324     C                   MOVEL     WRopt1        psopt1
062600080324     C                   MOVEL     WRopt2        psopt2
062700080324     C                   MOVEL     WRopt3        psopt3
062800080324     C                   MOVEL     WRopt4        psopt4
062900080324     C                   MOVEL     WRopt5        psopt5
063000960610     C*
063100970108     C* Retrieve current date in YYYYMMDD for last update date:
063200970108     C*
063300980710     C*
063400080324     C                   Eval      psldte = %int(%char(%date:*iso0))
063500080324     C                   TIME                    psltim
063600080324     C                   MOVEL     DSPGMN        pslpgm
063700080324     C                   MOVEL     DSUSER        pslusr
063800941228     C*
063900950526     C                   ENDSR
064000950608      /EJECT
064100950608     C*
064200950608     C**************
064300950710     C**  $INZSR  ** - Program Initialization
064400950608     C**************
064500950710     C     $INZSR        BEGSR
064600950607     C*
064700950607     C* Parm lists:
064800950607     C*
064900950525     C     *ENTRY        PLIST
065000080324     C                   PARM                    JLD
065100941228     C                   PARM                    APPL
065200941228     C*
065300950607     C* Message file:
065400941228     C*
065500941228     C     MSGP01        PLIST
065600941228     C                   PARM                    WWMSGI            7
065700950530     C*
065800950607     C* Key lists:
065900950607     C*
066000950530     C     CODK01        KLIST
066100950530     C                   KFLD                    WWCTAB
066200950530     C                   KFLD                    WWCKEY
066300950622     C*
066400970120     C*****************************************************************
066500970120     C* Key lists. XXXK01 is used for retieving the record to be
066600970120     C* maintained based on the record key passed to the program.
066700970120     C* XXXK02 is used to determine if a record with a duplicate
066800970120     C* key already exists on file (ADD and COPY modes only) based
066900970120     C* on the current screen field values entered by the user.
067000970120     C*
067100080304     C*   eg; File maintained - ITEMMSTR (Item/Type Code).
067200970120     C*
067300970120     C*
067400970120     C*     XXXK01    KLIST
067500080304     C*               KFLD           WIITM   <-- incoming parm
067600080304     C*               KFLD           WIICDE  <-- incoming parm
067700970120     C*
067800970120     C*     XXXK02    KLIST
067900080304     C*               KFLD           WRITM   <-- screen field
068000080304     C*               KFLD           WRICDE  <-- screen field
068100970120     C*
068200970120     C*****************************************************************
068300970120     C*
068400970120     C*
068500080324     C     psk01         KLIST
068600080324     C                   KFLD                    WIuser
068700080324     C                   KFLD                    WIpgm
068800970120     C*
068900080324     C     psk02         KLIST
069000080324     C                   KFLD                    WRuser
069100080324     C                   KFLD                    WRpgm
069200950710     C*
069300950710     C* Close files if requested by calling program:
069400950710     C*
069500960626     C     WIINLR        IFEQ      YES
069600950710     C                   MOVE      *ON           *INLR
069700950710     C                   RETURN
069800950710     C                   END
069900950713     C*
070000970108     C* Open display file:
070100970108     C*
070200080324     C                   OPEN      SEC0111D
070300970114     C*
070400970114     C                   MOVE      NO            WWGETR            1
070500970114     C*
070600970114     C                   ENDSR
070700080324     C*
070800980716**
070900080324ADD         Create a Security Record
071000080324COPY         Copy a Security Record
071100080324CHANGE      Change a Security Record
071200080324DELETE      Delete a Security Record
071300080324DISPLY      Display a Security Record
