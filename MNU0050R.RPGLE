000100101228      /copy qcpylesrc,stdhspec
000200101228      ********************************************************************
000300101228      *
000400101230      *  Program: MNU0050R
000500101228      *
000600101230      *  Description: Maintain security overrides
000700101228      *
000800101228      *  Programmer: Greg Cannella
000900101228      *
001000101230      *  Date: 12/30/10
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
003000101230     fmnu0050d  cf   e             workstn
003100101228     f                                     SFILE(SCRNS01:RRN1)
003200101228     f                                     INFDS(INFDS)
003300101230     fmnuoscm   uf a e           k disk
003400101228     fmnuoptm   if   e           k disk
003500101230     fusefile   if   e           k disk
003600101228      * Variables
003700101229     D ConvertDate     s               d
003800101229     D ReloadSF        s              1
003900101228      *
004000101229     D ERROR           C                   CONST('ERROR')
004100101229
004200101229     D jld           E DS                  EXTNAME(dsjld)
004300101229
004400101228     d INFDS           DS
004500101230     d  curloc               370    371b 0
004600101230     d  SFRRN                376    377b 0
004700101228     d  SFLLOC               378    379B 0
004800101228      *
004900101228     d                SDS
005000101228     d  DSPGMN           *PROC
005100101228     d  DSUSER               254    263
005200101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
005300101228      *M                 M  A  I  N  L  I  N  E                       M
005400101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
005500101228      *
005600101228     c                   Dow       *inlr = *OFF
005700101228      *
005800101228      * Display screen:
005900101228      *
006000101228     c                   Write     MSGCTL1
006100101228     c                   Write     SCRNK01
006200101228      *
006300101228      *
006400101228     c                   Exfmt     SCRNC01
006500101229     C                   MOVE      SFLLOC        HDSFLP
006600101228      *
006700101228      * Clear messages:
006800101228      *
006900101228     c                   Call      'ERMSG2'
007000101228     c                   Parm                    DSPGMN
007100101228      *
007200101228>>>>  * Process command keys:
007300101228      *
007400101228     c                   SELECT
007500101228      *
007600101228      * F3 = Exit
007700101228      *
007800101228     c                   WHEN      *IN03 = *ON
007900101228     c                   Eval      *inlr = *on
008000101228      *
008100101228      * F4 = Prompt
008200101228      *
008300101228     c                   WHEN      *IN04 = *ON
008400101228     c                   EXSR      $Prompt
008500101228      *
008600101228      * F5 = Refresh Sub File
008700101228      *
008800101228     c                   WHEN      *IN05 = *ON
008900101228     c                   EXSR      $LoadSF
009000101228      *
009100101228      * F12 = Previous Menu
009200101228      *
009300101228     c                   WHEN      *IN12 = *ON
009400101228     c                   Eval      *inlr = *on
009500101228      *
009600101228     c                   OTHER
009700101228      *
009800101228      * Enter:
009900101228      *
010000101228     c                   EXSR      $Enter
010100101228      *
010200101228     c                   ENDSL
010300101228      *
010400101228     c                   ENDDO
010500101228      ********************************************************************
010600101228     c     $Enter        Begsr
010700101229
010800101229     c                   Eval      ReloadSF = 'N'
010900101228      * Check for valid records and update file
011000101229     c                   Eval      rrn1 = 0
011100101229     c                   Dow       rrn1 < 400
011200101229     c                   eval      rrn1 = rrn1 + 1
011300101229      * Setoff error indicators
011400101230     c                   Eval      *in40 = *off
011500101230     c                   Eval      *in41 = *off
011600101229
011700101229     c     rrn1          Chain     scrns01
011800101230     c                   If        %found and
011900101230     c                             (wsuser <> *blank or wsuserh <> *blank)
012000101229      * Validate fields
012100101230     c     wsuser        Chain     usefile
012200101229     c                   If        %found
012300101230     c*                  Eval      wsdesc = modesc
012400101229     c                   Else
012500101230     c*                  Eval      wsdesc = *blanks
012600101229     c                   Eval      *in41 = *on
012700101230     c                   MOVEL     'MNU0003'     WWMSGI
012800101229     c                   CALL      'ERMSG1'      MSGP01
012900101229     c                   Endif
013000101229      * Check for delete
013100101230     c                   If        wsuser = *blanks and wsuserh <> *blanks
013200101230     c                   Eval      mcopt   = wcopt
013300101230     c                   Eval      mcuser = wsuserh
013400101230     c     mckey         Chain     mnuoscm
013500101229     c                   If        %found
013600101230     c                   Delete    mnuoscm
013700101230     c                   Eval      ReloadSF = 'Y'
013800101229     c                   Endif
013900101229     c                   Endif
014000101229      * Check for add
014100101230     c                   If        wsuser <> *blanks and wsuserh = *blanks
014200101230     c                   Eval      mcopt = wcopt
014300101230     c                   Eval      mcuser = wsuser
014400101230     c     mckey         Chain     mnuoscm
014500101229     c                   If        not %found
014600101230     c                   Clear                   mnuoscmr
014700101230     c                   Eval      mcopt = wcopt
014800101230     c                   Eval      mcuser = wsuser
014900101230     c                   Eval      mcludt = %int(%char(%date:*cymd0))
015000101230     c                   TIME                    mclutm
015100101230     c                   Eval      mclupg = dspgmn
015200101230     c                   Eval      mcluus = dsuser
015300101230     c                   Write     mnuoscmr
015400101229     c                   Eval      ReloadSF = 'Y'
015500101229     c                   Else
015600101229      * Duplicate record error
015700101229     c                   Eval      *in40 = *on
015800101230     c                   MOVEL     'MNU0004'     WWMSGI
015900101229     c                   CALL      'ERMSG1'      MSGP01
016000101229     c                   Endif
016100101229     c                   Endif
016200101229      * Check for update
016300101230     c                   If        wsuser <> *blanks and wsuserh <> *blanks
016400101230     c                             and (wsuser <> wsuserh)
016500101229      * First validate that this will not cause a duplicate with a different
016600101229      * record.
016700101230     c                   Eval      mcopt = wcopt
016800101230     c                   Eval      mcuser = wsuser
016900101230     c     mckey         Chain     mnuoscm
017000101230     c                   If        (%found and wsuser = wsuserh)
017100101230     c                             or (not %found and wsuser <> wsuserh)
017200101230     c                   Eval      mcopt = wcopt
017300101230     c                   Eval      mcuser = wsuserh
017400101230     c     mckey         Chain     mnuoscm
017500101229     c                   If        %found
017600101230     c                   Eval      mcopt = wcopt
017700101230     c                   Eval      mcuser = wsuser
017800101230     c                   Eval      mcludt = %int(%char(%date:*cymd0))
017900101230     c                   TIME                    mclutm
018000101230     c                   Eval      mclupg = dspgmn
018100101230     c                   Eval      mcluus = dsuser
018200101230     c                   Update    mnuoscmr
018300101229     c                   Endif
018400101229     c                   Else
018500101229      * Duplicate record error
018600101229     c                   Eval      *in40 = *on
018700101230     c                   MOVEL     'MNU0004'     WWMSGI
018800101229     c                   CALL      'ERMSG1'      MSGP01
018900101229     c                   Endif
019000101229     c                   Endif
019100101229
019200101229     c                   Update    scrns01
019300101229     c                   Endif
019400101229     c                   Enddo
019500101228
019600101229     c                   If        ReloadSF = 'Y'
019700101228     c                   Exsr      $LoadSF
019800101229     c                   Endif
019900101228     c
020000101228     c                   Endsr
020100101228      ********************************************************************
020200101228     c     $LoadSF       Begsr
020300101229
020400101229     c                   Z-ADD     1             HDSFLP
020500101228      * Clear sf
020600101229     c                   Eval      *in30 = *on
020700101229     c                   Eval      *in32 = *off
020800101229     c                   Write     scrnc01
020900101229      * Inz SF
021000101229     c                   Eval      *in33 = *on
021100101229     c                   Write     scrnc01
021200101229     c                   Eval      *in33 = *off
021300101229     c                   Eval      *in30 = *off
021400101229     c                   Eval      rrn1 = 0
021500101229     c                   Eval      *in32 = *on
021600101228
021700101228      * Read file and fill sub file
021800101230     c     wcopt         Setll     mnuoscm
021900101230     c     wcopt         Reade     mnuoscm
022000101229     c                   Dow       not %eof
022100101229     c                   Eval      rrn1 = rrn1 + 1
022200101229     c     rrn1          Chain     scrns01
022300101229     c                   If        %found
022400101230     c                   Eval      wsuser = mcuser
022500101230     c                   Eval      wsuserh = mcuser
022600101230     C                   If        mcludt <> 0
022700101230     C     *cymd         Move      mcludt        ConvertDate
022800101230     C     *mdy          Move      ConvertDate   wsludt
022900101230     C                   Else
023000101230     C                   Clear                   wsludt
023100101230     C                   Endif
023200101230     c                   Eval      wslutm = mclutm
023300101230     c                   Eval      wslupg = mclupg
023400101230     c                   Eval      wsluus = mcluus
023500101229     c                   Update    scrns01
023600101229     c                   Endif
023700101230     c     wcopt         Reade     mnuoscm
023800101229     c                   Enddo
023900101228
024000101229     c                   Endsr
024100101229      ********************************************************************
024200101229     c     $Prompt       Begsr
024300101229
024400101229     c                   SELECT
024500101229      *
024600101230>>>> c                   When      HDCSRF = 'WSUSER'
024700101230     c                   call      'USERSLN'
024800101230     c                   Parm                    pmname           10
024900101230     c                   Eval      rrn1 = sflloc + hdrow - 6
025000101230     c     rrn1          Chain     scrns01
025100101230     c                   If        %found and pmname <> *blanks
025200101230     c                   Movel     pmname        wsuser
025300101230     c     wsuser        Chain     usefile
025400101230     c                   If        %found
025500101230     c*                  Eval      wsdesc = modesc
025600101230     c                   Else
025700101230     c*                  Eval      wsdesc = *blanks
025800101230     c                   Eval      *in41 = *on
025900101230     c                   MOVEL     'MNU0002'     WWMSGI
026000101230     c                   CALL      'ERMSG1'      MSGP01
026100101230     c                   Endif
026200101230     c                   Update    scrns01
026300101230     c                   Endif
026400101229      *
026500101229     c*    HDCSRF        WHENEQ    'WCXXX2'
026600101229     c*                  CALL      'GEN0109R'
026700101229     c*                  PARM      '654'         WWCTAB
026800101229     c*                  PARM      *BLANKS       WWCKEY
026900101229     c*                  MOVEL     WWCKEY        WCXXX2
027000101229      *
027100101229      * Non propmtable area:
027200101229      *
027300101229     c                   OTHER
027400101229      *
027500101229     c                   MOVEL     'SHL0004'     WWMSGI
027600101229     c                   CALL      'ERMSG1'      MSGP01
027700101229      *
027800101229     c                   ENDSL
027900101229
028000101228     c                   Endsr
028100101228      ********************************************************************
028200101228     c     *inzsr        Begsr
028300101228
028400101228     c     *Entry        Plist
028500101230     c                   Parm                    pmopt            10
028600101229      *
028700101229      * Message file parm list:
028800101229      *
028900101229     C     MSGP01        PLIST
029000101229     C                   PARM                    WWMSGI            7
029100101228
029200101228      * Key Lists
029300101230     c     mckey         Klist
029400101230     c                   Kfld                    mcopt
029500101230     c                   Kfld                    mcuser
029600101228
029700101230     c                   Eval      mcopt = pmopt
029800101230     c     mcopt         Chain     mnuoptm
029900101229     c                   If        %found
030000101230     c                   Eval      wcdesc = modesc
030100101229     c                   Endif
030200101230     c                   Eval      wcopt = pmopt
030300101228     c                   Exsr      $LoadSF
030400101228      *
030500101228     c                   Endsr
