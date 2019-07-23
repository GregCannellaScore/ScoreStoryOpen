000100101228      /copy qcpylesrc,stdhspec
000200101228      ********************************************************************
000300101228      *
000400101228      *  Program: MNU0030R
000500101228      *
000600101228      *  Description: Maintain menu details
000700101228      *
000800101228      *  Programmer: Greg Cannella
000900101228      *
001000101228      *  Date: 12/27/10
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
003000101228     fmnu0030d  cf   e             workstn
003100101228     f                                     SFILE(SCRNS01:RRN1)
003200101228     f                                     INFDS(INFDS)
003300101231     fmnuhdrm   if a e           k disk
003400101228     fmnudtlm   uf a e           k disk
003500101228     fmnuoptm   if   e           k disk
003600101228      * Variables
003700101229     D ConvertDate     s               d
003800101229     D ReloadSF        s              1
003900101228      *
004000101229     D ERROR           C                   CONST('ERROR')
004100101229
004200101229     D jld           E DS                  EXTNAME(dsjld)
004300101229
004400101229      *
004500101229      * Calling parms for MNU0041R:
004600101229     D APP2            DS           512
004700101229     D  A2SEC                  1      5
004800101229     D  A2IUSE                 6     15
004900101229     D  A2INLR                16     16
005000101229     D  A2ACTN                17     26
005100101229     D  A2OPT                 27     36
005200101229
005300101229      * Parms for calling MNU0040R
005400101229     D APPL3           DS           512
005500101229     D  A3SEC                  1      5
005600101229     D  A3SEL                  6      6
005700101229     D  A3VIEW                 7      8  0
005800101229     D  A3opt                  9     18
005900101229
006000101228     d INFDS           DS
006100101230     d  curloc               370    371b 0
006200101230     d  SFRRN                376    377b 0
006300101228     d  SFLLOC               378    379B 0
006400101228      *
006500101228     d                SDS
006600101228     d  DSPGMN           *PROC
006700101228     d  DSUSER               254    263
006800101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
006900101228      *M                 M  A  I  N  L  I  N  E                       M
007000101228      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
007100101228      *
007200101228     c                   Dow       *inlr = *OFF
007300101228      *
007400101228      * Display screen:
007500101228      *
007600101228     c                   Write     MSGCTL1
007700101228     c                   Write     SCRNK01
007800101228      *
007900101228      *
008000101228     c                   Exfmt     SCRNC01
008100101229     C                   MOVE      SFLLOC        HDSFLP
008200101228      *
008300101228      * Clear messages:
008400101228      *
008500101228     c                   Call      'ERMSG2'
008600101228     c                   Parm                    DSPGMN
008700101228      *
008800101228>>>>  * Process command keys:
008900101228      *
009000101228     c                   SELECT
009100101228      *
009200101228      * F3 = Exit
009300101228      *
009400101228     c                   WHEN      *IN03 = *ON
009500101228     c                   Eval      *inlr = *on
009600101228      *
009700101228      * F4 = Prompt
009800101228      *
009900101228     c                   WHEN      *IN04 = *ON
010000101228     c                   EXSR      $Prompt
010100101228      *
010200101228      * F5 = Refresh Sub File
010300101228      *
010400101228     c                   WHEN      *IN05 = *ON
010500101228     c                   EXSR      $LoadSF
010600101228      *
010700101229      * F6 = Add Menu Option
010800101228      *
010900101229     c                   WHEN      *IN06 = *ON
011000101229     C                   CLEAR                   APP2
011100101229     C                   MOVEL     '11111'       A2SEC
011200101229     C                   MOVEL     'ADD'         A2ACTN
011300101229      *
011400101229      * Move key fields to maintenance program for record access:
011500101229      *
011600101229     C*                  MOVE      WCopt         A2opt
011700101229      *
011800101229      * Call maintenance program:
011900101229      *
012000101229     C                   CALL      'MNU0041R'
012100101229     C                   PARM                    jld
012200101229     C                   PARM                    APP2
012300101230      *
012400101230      * F7 = Prompt
012500101230      *
012600101230     c                   WHEN      *IN07 = *ON
012700101230     c                   EXSR      $CHGRC
012800101229      *
012900101230      * F8 = Maintain Options
013000101229      *
013100101230     c                   WHEN      *IN08 = *ON
013200101229     c                   Eval      A3SEL = *blanks
013300101228     c                   call      'MNU0040R'
013400101229     c                   Parm                    jld
013500101229     c                   Parm                    APPL3
013600101228      *
013700101228      * F12 = Previous Menu
013800101228      *
013900101228     c                   WHEN      *IN12 = *ON
014000101228     c                   Eval      *inlr = *on
014100101228      *
014200101228     c                   OTHER
014300101228      *
014400101228      * Enter:
014500101228      *
014600101228     c                   EXSR      $Enter
014700101228      *
014800101228     c                   ENDSL
014900101228      *
015000101228     c                   ENDDO
015100101228      ********************************************************************
015200101228     c     $Enter        Begsr
015300101229
015400101229     c                   Eval      ReloadSF = 'N'
015500101228      * Check for valid records and update file
015600101229     c                   Eval      rrn1 = 0
015700101229     c                   Dow       rrn1 < 400
015800101229     c                   eval      rrn1 = rrn1 + 1
015900101229      * Setoff error indicators
016000101229     c                   Eval      *in40 = *off
016100101229     c                   Eval      *in41 = *off
016200101229
016300101229     c     rrn1          Chain     scrns01
016400101229     c                   If        %found
016500101229     c                             and (wsseq <> 0 or wsseqh <> 0)
016600101229      * Validate fields
016700101229     c     wsopt         Chain     mnuoptm
016800101229     c                   If        %found
016900101229     c                   Eval      wsdesc = modesc
017000101229     c                   Else
017100101229     c                   Eval      wsdesc = *blanks
017200101229     c                   Eval      *in41 = *on
017300101229     c                   MOVEL     'MNU0001'     WWMSGI
017400101229     c                   CALL      'ERMSG1'      MSGP01
017500101229     c                   Endif
017600101229      * Check for delete
017700101229     c                   If        wsseq = 0 and wsseqh <> 0
017800101229     c                   Eval      mdmname = wcmname
017900101229     c                   Eval      mdseq = wsseqh
018000101229     c     mdkey         Chain     mnudtlm
018100101229     c                   If        %found
018200101229     c                   Delete    mnudtlm
018300101229     c                   Endif
018400101229     c                   Endif
018500101229      * Check for add
018600101229     c                   If        wsseq <> 0 and wsseqh = 0
018700101229     c                   Eval      mdmname = wcmname
018800101229     c                   Eval      mdseq = wsseq
018900101229     c     mdkey         Chain     mnudtlm
019000101229     c                   If        not %found
019100101229     c                   Clear                   mnudtlmr
019200101229     c                   Eval      mdmname = wcmname
019300101229     c                   Eval      mdseq = wsseq
019400101229     c                   Eval      mdsel = wssel
019500101229     c                   Eval      mdopt = wsopt
019600101229     c                   Eval      mdludt = %int(%char(%date:*cymd0))
019700101229     c                   TIME                    mdlutm
019800101229     c                   Eval      mdlupg = dspgmn
019900101229     c                   Eval      mdluus = dsuser
020000101229     c                   Write     mnudtlmr
020100101229     c                   Eval      ReloadSF = 'Y'
020200101229     c                   Else
020300101229      * Duplicate record error
020400101229     c                   Eval      *in40 = *on
020500101229     c                   MOVEL     'MNU0002'     WWMSGI
020600101229     c                   CALL      'ERMSG1'      MSGP01
020700101229     c                   Endif
020800101229     c                   Endif
020900101229      * Check for update
021000101229     c                   If        wsseq <> 0 and wsseqh <> 0
021100101229     c                             and (wsseq <> wsseqh or
021200101229     c                             wssel <> wsselh or
021300101229     c                             wsopt <> wsopth)
021400101229      * First validate that this will not cause a duplicate with a different
021500101229      * record.
021600101229     c                   Eval      mdmname = wcmname
021700101229     c                   Eval      mdseq = wsseq
021800101229     c     mdkey         Chain     mnudtlm
021900101229     c                   If        (%found and wsseq = wsseqh)
022000101229     c                             or (not %found and wsseq <> wsseqh)
022100101229     c                   Eval      mdmname = wcmname
022200101229     c                   Eval      mdseq = wsseqh
022300101229     c     mdkey         Chain     mnudtlm
022400101229     c                   If        %found
022500101229     c                   Eval      mdmname = wcmname
022600101229     c                   Eval      mdseq = wsseq
022700101229     c                   Eval      mdsel = wssel
022800101229     c                   Eval      mdopt = wsopt
022900101229     c                   Eval      mdludt = %int(%char(%date:*cymd0))
023000101229     c                   TIME                    mdlutm
023100101229     c                   Eval      mdlupg = dspgmn
023200101229     c                   Eval      mdluus = dsuser
023300101229     c                   Update    mnudtlmr
023400101229     c                   Endif
023500101229     c                   Else
023600101229      * Duplicate record error
023700101229     c                   Eval      *in40 = *on
023800101229     c                   MOVEL     'MNU0002'     WWMSGI
023900101229     c                   CALL      'ERMSG1'      MSGP01
024000101229     c                   Endif
024100101229     c                   Endif
024200101229
024300101229     c                   Update    scrns01
024400101229     c                   Endif
024500101229     c                   Enddo
024600101228
024700101229     c                   If        ReloadSF = 'Y'
024800101228     c                   Exsr      $LoadSF
024900101229     c                   Endif
025000101228     c
025100101228     c                   Endsr
025200101228      ********************************************************************
025300101228     c     $LoadSF       Begsr
025400101229
025500101229     c                   Z-ADD     1             HDSFLP
025600101228      * Clear sf
025700101229     c                   Eval      *in30 = *on
025800101229     c                   Eval      *in32 = *off
025900101229     c                   Write     scrnc01
026000101229      * Inz SF
026100101229     c                   Eval      *in33 = *on
026200101229     c                   Write     scrnc01
026300101229     c                   Eval      *in33 = *off
026400101229     c                   Eval      *in30 = *off
026500101229     c                   Eval      rrn1 = 0
026600101229     c                   Eval      *in32 = *on
026700101228
026800101228      * Read file and fill sub file
026900101229     c     wcmname       Setll     mnudtlm
027000101229     c     wcmname       Reade     mnudtlm
027100101229     c                   Dow       not %eof
027200101229     c                   Eval      rrn1 = rrn1 + 1
027300101229     c     rrn1          Chain     scrns01
027400101229     c                   If        %found
027500101229     c                   Eval      wsseq = mdseq
027600101229     c                   Eval      wsseqh = mdseq
027700101229     c                   Eval      wssel = mdsel
027800101229     c                   Eval      wsselh = mdsel
027900101229     c                   Eval      wsopt = mdopt
028000101229     c                   Eval      wsopth = mdopt
028100101229     c     wsopt         Chain     mnuoptm
028200101229     c                   If        %found
028300101229     c                   Eval      wsdesc = modesc
028400101229     c                   Endif
028500101229     c                   Update    scrns01
028600101229     c                   Endif
028700101229     c     wcmname       Reade     mnudtlm
028800101229     c                   Enddo
028900101228
029000101229     c                   Endsr
029100101229      ********************************************************************
029200101229     c     $Prompt       Begsr
029300101229
029400101229     c                   SELECT
029500101229      *
029600101230>>>> c                   When      HDCSRF = 'WSOPT'
029700101230     c                   Eval      A3SEL = 'Y'
029800101230     c                   call      'MNU0040R'
029900101230     c                   Parm                    jld
030000101230     c                   Parm                    APPL3
030100101230     c                   Eval      rrn1 = sflloc + hdrow - 5
030200101230     c     rrn1          Chain     scrns01
030300101230     c                   If        %found and a3opt <> *blanks
030400101230     c                   Movel     a3opt         wsopt
030500101230     c     wsopt         Chain     mnuoptm
030600101230     c                   If        %found
030700101230     c                   Eval      wsdesc = modesc
030800101230     c                   Else
030900101230     c                   Eval      wsdesc = *blanks
031000101230     c                   Eval      *in41 = *on
031100101230     c                   MOVEL     'MNU0001'     WWMSGI
031200101230     c                   CALL      'ERMSG1'      MSGP01
031300101230     c                   Endif
031400101230     c                   Update    scrns01
031500101230     c                   Endif
031600101229      *
031700101229     c*    HDCSRF        WHENEQ    'WCXXX2'
031800101229     c*                  CALL      'GEN0109R'
031900101229     c*                  PARM      '654'         WWCTAB
032000101229     c*                  PARM      *BLANKS       WWCKEY
032100101229     c*                  MOVEL     WWCKEY        WCXXX2
032200101229      *
032300101229      * Non propmtable area:
032400101229      *
032500101229     c                   OTHER
032600101229      *
032700101229     c                   MOVEL     'SHL0004'     WWMSGI
032800101229     c                   CALL      'ERMSG1'      MSGP01
032900101229      *
033000101229     c                   ENDSL
033100101229
033200101228     c                   Endsr
033300101230      ********************************************************************
033400101230     c     $CHGRC        Begsr
033500101230
033600101230     c                   SELECT
033700101230      *
033800101230>>>> c                   When      HDCSRF = 'WSOPT'
033900101230     C                   CLEAR                   APP2
034000101230     C                   MOVEL     '11111'       A2SEC
034100101230     C                   MOVEL     'CHANGE'      A2ACTN
034200101230      *
034300101230      * Move key fields to maintenance program for record access:
034400101230      *
034500101230     c                   Eval      rrn1 = sflloc + hdrow - 5
034600101230     c     rrn1          Chain     scrns01
034700101230     c                   If        %found and wsopt <> *blanks
034800101230     c                   Move      WSopt         A2opt
034900101230      *
035000101230      * Call maintenance program:
035100101230      *
035200101230     C                   CALL      'MNU0041R'
035300101230     C                   PARM                    jld
035400101230     C                   PARM                    APP2
035500101230     c     wsopt         Chain     mnuoptm
035600101230     c                   If        %found
035700101230     c                   Eval      wsdesc = modesc
035800101230     c                   Else
035900101230     c                   Eval      wsdesc = *blanks
036000101230     c                   Eval      *in41 = *on
036100101230     c                   MOVEL     'MNU0001'     WWMSGI
036200101230     c                   CALL      'ERMSG1'      MSGP01
036300101230     c                   Endif
036400101230     c                   Update    scrns01
036500101230     c                   Endif
036600101230      *
036700101230      * Non propmtable area:
036800101230      *
036900101230     c                   OTHER
037000101230      *
037100101230     c                   MOVEL     'SHL0004'     WWMSGI
037200101230     c                   CALL      'ERMSG1'      MSGP01
037300101230      *
037400101230     c                   ENDSL
037500101230
037600101230     c                   Endsr
037700101228      ********************************************************************
037800101228     c     *inzsr        Begsr
037900101228
038000101228     c     *Entry        Plist
038100101228     c                   Parm                    pmmname          10
038200101229      *
038300101229      * Message file parm list:
038400101229      *
038500101229     C     MSGP01        PLIST
038600101229     C                   PARM                    WWMSGI            7
038700101228
038800101228      * Key Lists
038900101228     c     mdkey         Klist
039000101228     c                   Kfld                    mdmname
039100101228     c                   Kfld                    mdseq
039200101228
039300101229     c                   Eval      mhmname = pmmname
039400101229     c     mhmname       Chain     mnuhdrm
039500101229     c                   If        %found
039600101229     c                   Eval      wcmdesc = mhmdesc
039700101231     c                   Else
039800101231     c                   If        pmmname = dsuser
039900101231     c                   Clear                   mnuhdrmr
040000101231     C                   Eval      mhmname = dsuser
040100101231     C                   Eval      mhmdesc='Custom Menu for ' + dsuser
040200101231     C                   Eval      mhludt = %int(%char(%date:*cymd0))
040300101231     C                   TIME                    mhlutm
040400101231     C                   MOVEL     DSPGMN        mhlupg
040500101231     C                   MOVEL     DSUSER        mhluus
040600101231     C                   WRITE     mnuhdrmr
040700101231     c                   Eval      wcmdesc = mhmdesc
040800101231     c                   Endif
040900101229     c                   Endif
041000101229     c                   Eval      wcmname = pmmname
041100101228     c                   Exsr      $LoadSF
041200101228      *
041300101228     c                   Endsr
