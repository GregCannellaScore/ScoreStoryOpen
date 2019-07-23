000100140824      /copy qcpylesrc,stdhspec
000200140824     F*****************************************************************
000300140824     F*                                                               *
000400140824     F* Program ID...... MNU0005R                                     *
000500140824     F* Program Desc.... Menu help text - Display and Update          *
000600140824     F* Request Number..                                              *
000700140824     F*                                                               *
000800140824     F* Written By...... Greg Cannella                                *
000900140824     F* Date Written....  8/24/14                                     *
001000140824     F*                                                               *
001100140824     F* Comments........                                              *
001200140824     F*                                                               *
001300140824     F*                                                               *
001400140824     F*****************************************************************
001500140824     F* Compile Options:                                              *
001600140824     F*                                                               *
001700140824     F*****************************************************************
001800140824     F* Modifications:                                                *
001900140824     F* Req#  By   Date      Modification                             *
002000140824     F* 1234  xxx  xx/xx/xx                                           *
002100140824     F*                                                               *
002200140824     F*****************************************************************
002300140824     F* Indicator Usage:                                              *
002400140824     F* Ind      Use                                                  *
002500140824     F* 01-24    Function keys                                        *
002600140824     F* 40-51    Error Indicators                                     *
002700140824     F* 90-99    Hit/Miss                                             *
002800140824     F*                                                               *
002900140824     F*****************************************************************
003000140824     F* Field Definitions                                             *
003100140824     F*                                                               *
003200140824     F* Prefix                                                        *
003300140824     F* WW     - Program described work fields                        *
003400140824     F* WR     - Display record fields                                *
003500140824     F* DS     - Data structure fields                                *
003600140824     F*                                                               *
003700140824     F*                                                               *
003800140824     F* Display Record Format Definitions                             *
003900140824     F*                                                               *
004000140824     F* Prefix                                                        *
004100140824     F* SCRNK  - Command key                                          *
004200140824     F* SCRNR  - Standard display                                     *
004300140824     F* MSGCTL - Message subfile control                              *
004400140824     F*                                                               *
004500140824     F*                                                               *
004600140824     F* Called programs                                               *
004700140824     F*                                                               *
004800140824     F* ERMSG1 - Send program message with message data               *
004900140824     F* ERMSG2 - Clear program message queue                          *
005000140824     F*                                                               *
005100140824     F*****************************************************************
005200140824      *
005300140824     fMNU0005D  CF   E             Workstn
005400140824     f                                     SFILE(SCRNS01:RRN1)
005500140824     f                                     INFDS(INFDS)
005600140824     fmnuhelp   uf a e           k Disk
005700140824     fmnuoptm   if   e           k Disk
005800140914     fmnuhelplogo    e           k Disk
005900140824      *
006000140824     d INFDS           DS
006100140824     d  SFLLOC               378    379B 0
006200140824      *
006300140824     d                SDS
006400140824     d  DSPGMN           *PROC
006500140824     d  DSUSER               254    263
006600140824      *
006700140824      * Work Fields
006800140824      *
006900140824     d Wwerr1          S             10
007000140824     d Wwmsgi          S              7
007100140824     d Wwrcde          S              6
007200140824     d ConvertDate     S               D
007300140824     d Error           c                   Const('ERROR')
007400140824     d NoHelp          c                   Const('No help text exists for +
007500140824     d                                     this menu option.  Press F2 to +
007600140824     d                                     create menu text.')
007700140824      *
007800140824     c                   Exsr      $Clear
007900140824      *
008000140824      * Clear messages:
008100140824      *
008200140824     c                   Call      'ERMSG2'
008300140824     c                   Parm                    Dspgmn
008400140824      *
008500140824      * Load Subfile
008600140824      *
008700140824     c                   Exsr      $Load
008800140824      *
008900140824      * Main loop:
009000140824      *
009100140824     c                   Dou       *inlr = *on
009200140824      *
009300140824      * Display screen
009400140824      *
009500140824     c                   Write     Msgctl1
009600140824     c                   Write     Scrnk01
009700140824     c                   Exfmt     Scrnc01
009800140824      *
009900140824      * F3 or F12 = exit program
010000140824      *
010100140824     c                   If        *In03    = *On
010200140824     c                             or *in12 = *on
010300140824     c                   Eval      *inlr    = *on
010400140824     c                   Else
010500140824      *
010600140824     c                   If        *in02    = *on
010700140824     c                   Eval      *in40 = *on
010800140824     c                   Exsr      $Load
010900140824     c                   Else
011000140824      *
011100140824     c                   Clear                   Wwerr1
011200140824      *
011300140824      * Clear messages:
011400140824      *
011500140824     c                   Call      'ERMSG2'
011600140824     c                   Parm                    Dspgmn
011700140824     c                   Exsr      $Enter
011800140824      *
011900140824     c                   Endif
012000140824     c                   Endif
012100140824      *
012200140824     c                   Enddo
012300140824      *
012400140824      *****************************************************************
012500140824      *   $CLEAR - Intialize Program/Database Fields
012600140824      *****************************************************************
012700140824     C     $Clear        Begsr
012800140824      *
012900140824      * Initialize program described fields
013000140824      *
013100140824     C                   Eval      Wwerr1   = *Blanks
013200140824      *
013300140824     C                   Endsr
013400140824      *
013500140824      *****************************************************************
013600140824      *   $LOAD - Load subfile
013700140824      *****************************************************************
013800140824     c     $Load         Begsr
013900140824      *
014000140824      * Load Header fields
014100140824      *
014200140824     c     pmopt         Chain     mnuoptm
014300140824     c                   If        %found
014400140824     c                   Eval      wropt = pmopt
014500140824     c                   Eval      wrhead = modesc
014600140824     c                   Endif
014700140824      *
014800140824      * Clear subfile
014900140824      *
015000140824     c                   Eval      *in30 = *on
015100140824     c                   Eval      *in32 = *off
015200140824     c                   Write     scrnc01
015300140824     c                   Eval      *in30 = *off
015400140824      *
015500140824     c     pmopt         Setll     mnuhelp
015600140824     c     1             Do        10            Count             3 0
015700140824     c     pmopt         Reade     mnuhelp
015800140824     c                   If        not %eof
015900140824     c                   Eval      wstext = mztext
016000140824     c                   Eval      whtext = mztext
016100140824     c                   Eval      whseq  = mzseq
016200140824     c                   Else
016300140824     c                   If        Count = 1
016400140824     c                   Eval      wstext = NoHelp
016500140824     c                   Eval      whtext = NoHelp
016600140824     c                   Else
016700140824     c                   Eval      wstext = *blanks
016800140824     c                   Eval      whtext = *blanks
016900140824     c                   Endif
017000140824     c                   Eval      whseq  = Count
017100140824     c                   Endif
017200140824     c                   Eval      RRN1 = Count
017300140824     c                   Write     scrns01
017400140824     c                   Eval      *in32 = *on
017500140824     c                   Enddo
017600140824     c                   Eval      hdsflp = 1
017700140824     c                   Eval      *in34 = *on
017800140824      *
017900140824      * Load footer fields
018000140824      *
018100140824>>>> C                   If        mzludt <> 0
018200140824>>>> C     *cymd         Move      mzludt        ConvertDate
018300140824     C     *mdy          Move      ConvertDate   WRLDTE
018400140824>>>> C                   Move      mzlutm        wrltim
018500140824     c                   Eval      wrlusr = mzluus
018600140824     c                   Eval      wrlpgm = mzlupg
018700140824     C                   Else
018800140824     C                   Clear                   wrldte
018900140824>>>> C                   Clear                   wrltim
019000140824     c                   Clear                   wrlusr
019100140824     c                   Clear                   wrlpgm
019200140824     C                   Endif
019300140824      *
019400140824     C                   Endsr
019500140824      *****************************************************************
019600140824      *   $ENTER - Enter Key Pressed
019700140824      *****************************************************************
019800140824     C     $Enter        Begsr
019900140824      *
020000140824      * If update mode, update the file.  Else, exit program.
020100140824      *
020200140824     c                   If        *in40 = *on
020300140824     c                   Exsr      $Update
020400140824     c                   Else
020500140824     c                   Eval      *Inlr    = *On
020600140824     c                   Return
020700140824     c                   Endif
020800140824      *
020900140824     c                   Endsr
021000140824      *****************************************************************
021100140824      *   $Update - Update file
021200140824      *****************************************************************
021300140824     C     $Update       Begsr
021400140824      *
021500140824      * Read all 10 records and see if any need to be added, updated
021600140824      * or deleted.
021700140824     c     1             Do        10            Count
021800140824     c                   Eval      RRN1 = Count
021900140824     c     rrn1          Chain     scrns01                            90
022000140824      * Only update if new text is different than old text.
022100140824     c                   If        wstext <> whtext
022200140824      * If new record, add.
022300140824     c                   If        whtext = NoHelp
022400140824     c                             or whtext = *blanks
022500140824     c                   Clear                   mnuhelpr
022600140824     c                   Eval      mzopt = pmopt
022700140824     c                   Eval      mzseq = whseq
022800140824     c                   Eval      mztext= wstext
022900140824>>>> c                   Eval      mzludt = %int(%char(%date:*cymd0))
023000140824>>>> c                   TIME                    mzlutm
023100140824>>>> c                   MOVEL     DSPGMN        mzlupg
023200140824>>>> c                   MOVEL     DSUSER        mzluus
023300140824     c                   Write     mnuhelpr
023400140914     c                   Eval      mzactn = 'Add'
023500140914     c                   Write     mnuhelplgr
023600140824     c                   Else
023700140824      * If existing record and text changed, update.
023800140824     c                   If        whtext <> *blanks
023900140824     c                             and wstext <> *blanks
024000140824     c                   Eval      mzopt = pmopt
024100140824     c                   Eval      mzseq = whseq
024200140824     c     mzkey         Chain     mnuhelp
024300140824     c                   If        %found
024400140824     c                   Eval      mztext= wstext
024500140824>>>> c                   Eval      mzludt = %int(%char(%date:*cymd0))
024600140824>>>> c                   TIME                    mzlutm
024700140824>>>> c                   MOVEL     DSPGMN        mzlupg
024800140824>>>> c                   MOVEL     DSUSER        mzluus
024900140824     c                   Update    mnuhelpr
025000140914     c                   Eval      mzactn = 'Update'
025100140914     c                   Write     mnuhelplgr
025200140824     c                   Endif
025300140824     c                   Else
025400140824      * If existing record and has been blanked out, delete.
025500140824     c                   If        whtext <> *blanks
025600140824     c                             and wstext = *blanks
025700140824     c                   Eval      mzopt = pmopt
025800140824     c                   Eval      mzseq = whseq
025900140824     c     mzkey         Chain     mnuhelp
026000140824     c                   If        %found
026100140824     c                   Delete    mnuhelpr
026200140914     c                   Eval      mzactn = 'Delete'
026300140914     c                   Write     mnuhelplgr
026400140824     c                   Endif
026500140824     c
026600140824     c                   Endif
026700140824     c                   Endif
026800140824     c                   Endif
026900140824     c                   Endif
027000140824     c                   Enddo
027100140824      *
027200140824      * After update, turn off update mode and reload subfile
027300140824      *
027400140824     c                   Eval      *in40 = *off
027500140824     c                   Exsr      $Load
027600140824      *
027700140824     c                   Endsr
027800140824      *****************************************************************
027900140824      *   *INZSR - Initial subroutine
028000140824      *****************************************************************
028100140824     c     *Inzsr        Begsr
028200140824      *
028300140824     c     *entry        Plist
028400140824     c                   Parm                    pmopt            10
028500140824      *
028600140824     c     mzkey         Klist
028700140824     c                   Kfld                    mzopt
028800140824     c                   Kfld                    mzseq
028900140824      *
029000140824     c                   Endsr
