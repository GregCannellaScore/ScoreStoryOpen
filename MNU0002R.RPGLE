000100101227      /copy qcpylesrc,stdhspec
000200101227      ********************************************************************
000300101227      *
000400101227      *  Program: MNU0001R
000500101227      *
000600101227      *  Description: Process Menus
000700101227      *
000800101227      *  Programmer: Greg Cannella
000900101227      *
001000101227      *  Date: 12/27/10
001100101227      *
001200101227      ********************************************************************
001300101227      *                   Modification Log
001400101227      *
001500101227      *  Initials  Date      Description
001600101227      *-------------------------------------------------------------------
001700101227      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800101227      *
001900101227      *
002000101227      *
002100101227      ********************************************************************
002200101227      *                   Indicator Usage
002300101227      *
002400101227      *   Ind.   Description
002500101227      *-------------------------------------------------------------------
002600101227      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700101227      *
002800101227      *
002900101227      ********************************************************************
003000120125     fmnu0001d  cf   e             workstn
003100101227     f                                     SFILE(SCRNS01:RRN1)
003200101227     f                                     INFDS(INFDS)
003300101227     fmnuhdrm   if   e           k disk
003400101227     fmnudtlm   if   e           k disk
003500101227     fmnudtll1  if   e           k disk    rename(mnudtlmr:mdtl1)
003600101227     fmnuoptm   if   e           k disk
003700101227     fmnuoscm   if   e           k disk
003800101227     fmnuusrm   if   e           k disk
003900101227     fmnusysm   if   e           k disk
004000101227     fusefile   if   e           k disk
004100120125     fmnumovm   if   e           k disk
004200101227      * Constants
004300101227     d Upper           C                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ012-
004400101227     d                                     3456789!@#$%^&*();:,.<>/?[]{}\-=_+')
004500101227     d Lower           C                   CONST('abcdefghijklmnopqrstuvwxyz012-
004600101227     d                                     3456789!@#$%^&*();:,.<>/?[]{}\-=_+')
004700101227      * Variables
004800101227>>>> d QCMD            s            256
004900101227>>>> d QLEN            s             15p 5
005000101227     d WWCMD           s             66
005100101227     d WWCurrentMenu   s             10
005200120125     d CurrentUser     s             10
005300120125     d CurrentGroup    s             10
005400101227     d MenuStack       s             10    DIM(100)
005500101227     d CurrentMenu     s              3  0
005600101227     d Stop            s              1
005700101227     d PMCMD           s            256
005800101227     d Fullcmd         s            160
005900101227     d End             s              5  0
006000101227     d FourAlpha       s              4
006100101227     d Center          s              3  0
006200101231     d CommandStack    s            256    DIM(10)
006300101231     d LastF9          s              1
006400101231     d LC#             s              2  0
006500111018     d PMCommand       s           2000
006600111018     d PMAction        s              8
006700111018     d PMMessage       s              4
006800120125     d MNUAuth         s              1
006900120125     d OptAuth         s              1
007000101227      *
007100101227     d INFDS           DS
007200101227     d  SFLLOC               378    379B 0
007300101227      *
007400120125     D jld           E DS                  EXTNAME(dsjld)
007500120125
007600120125      *
007700120125      * Calling parms for MNU0041R:
007800120125     d APP2            DS           512
007900120125     d  A2SEC                  1      5
008000120125     d  A2IUSE                 6     15
008100120125     d  A2INLR                16     16
008200120125     d  A2ACTN                17     26
008300120125     d  A2OPT                 27     36
008400120125
008500101227     d                SDS
008600101227     d  DSPGMN           *PROC
008700101229     d  DSJOB                244    253
008800101227     d  DSUSER               254    263
008900101227      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
009000101227      *M                 M  A  I  N  L  I  N  E                       M
009100101227      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
009200101227      *
009300101227     c                   DOU       *inlr = *ON
009400101227      *
009500101227      * Display screen:
009600101227      *
009700101227     c                   Write     MSGCTL1
009800101227     c                   Write     SCRNH01
009900101227      *
010000101227     c                   If        *in32 = *OFF
010100101227     c                   Exfmt     SCRNR01
010200101227     c                   Endif
010300101227      *
010400101227     c                   Exfmt     SCRNC01
010500110627
010600110627     c                   Move      SFLLOC        HDSFLP
010700101227      *
010800101227      * Clear messages:
010900101227      *
011000101227     c                   Call      'ERMSG2'
011100101227     c                   Parm                    DSPGMN
011200101231
011300101231     c                   If        *in09 = *off
011400101231     c                   Eval      LastF9 = 'N'
011500101231     c                   Endif
011600101227      *
011700101227>>>>  * Process command keys:
011800101227      *
011900101227     c                   SELECT
012000111018      *
012100111018      * F2 = DSPMSG
012200111018      *
012300111018     c                   WHEN      *IN02 = *ON
012400111018     c                   EXSR      $DSPMSG
012500101227      *
012600101227      * F3 = Home Menu
012700101227      *
012800101227     c                   WHEN      *IN03 = *ON
012900101227     c                   EXSR      $HomeMenu
013000111018      *
013100111018      * F4 = Prompt Command
013200111018      *
013300111018     c                   WHEN      *IN04 = *ON
013400111018     c                   EXSR      $Prompt
013500101227      *
013600101227      * F6 = Customize Menu
013700101227      *
013800101227     c                   WHEN      *IN06 = *ON
013900101227     c                   EXSR      $Custom
014000101231      *
014100101231      * F9 = Get Previous Command
014200101231      *
014300101231     c                   WHEN      *IN09 = *ON
014400111018     c                   EXSR      $PrevCmd2
014500101230      *
014600101230      * F10 = Call QCMD
014700101230      *
014800101230     c                   WHEN      *IN10 = *ON and upltcp <> '*YES'
014900101230     c                   Call      'QCMD'
015000101227      *
015100101227      * F12 = Previous Menu
015200101227      *
015300101227     c                   WHEN      *IN12 = *ON
015400101227     c                   EXSR      $PrevMenu
015500101230      *
015600101230      * F20 = Change User
015700101230      *
015800101230     c                   WHEN      *IN20 = *ON
015900101230     c                   Exsr      $ChgUser
016000101227      *
016100101229      * F21 = Search Menu Text and Commands
016200101227      *
016300101230     c                   WHEN      *IN21 = *ON
016400101230     c                   Call      'MNU0060R'                           90
016500101227      *
016600101229      * F22 = Menu Maint
016700101227      *
016800101227     c                   WHEN      *IN22 = *ON
016900101229     c                   Call      'MNU0020C'                           90
017000101227      *
017100101228      * F23 = Users
017200101227      *
017300101227     c                   WHEN      *IN23 = *ON
017400101228     c                   Call      'MNU0010C'                           90
017500101227      *
017600101227      *
017700101227      * F01 = Previous Menu
017800101227      *
017900101227     c                   WHEN      *IN01 = *ON
018000120307     c*                  Eval      *inlr = *on
018100120307     c*                  Return
018200101227      *
018300101227     c                   OTHER
018400101227      *
018500101227      * Enter:
018600101227      *
018700101227     c                   EXSR      $Enter
018800101227      *
018900101227     c                   ENDSL
019000101227      *
019100101227     c                   ENDDO
019200101227      ********************************************************************
019300101227     c     $Enter        Begsr
019400101227     c                   Eval      Stop = *blanks
019500101227      * Make command all upper
019600101227     c                   Eval      wwcmd = %trim(%xlate(Lower:Upper:wccmd))
019700101227      ************
019800101227      * Check for sign off
019900101227      *****
020000101227     c                   if        %trim(wccmd) = '90'
020100101227     c                             or wwcmd = 'SIGNOFF'
020200101227     c                   Eval      *inlr = *on
020300101227     c                   Eval      Stop = 'Y'
020400101227     c                   Endif
020500101227      ************
020600101227      * Check for menu option on current menu
020700101227      *****
020800101227     c                   If        Stop = *blanks
020900101227     c                   Eval      mdmname = MenuStack(CurrentMenu)
021000101227     c                   Eval      mdsel = wwcmd
021100101227     c     mdkey2        Chain     mnudtll1
021200101227     c                   If        %found
021300101227      * Get menu option record
021400101227     c     mdopt         Chain     mnuoptm
021500101227     c                   If        %found
021600101227     c                   Eval      Stop = 'Y'
021700101227     c                   Exsr      $ChkSec
021800101227     c                   Endif
021900101227     c                   Endif
022000101227     c                   Endif
022100101227      ************
022200101227      * Check for menu option global menu
022300101227      *****
022400101227     c                   If        Stop = *blanks
022500110624     c                   Eval      mdmname = 'UMENU'
022600101227     c                   Eval      mdsel = wwcmd
022700101227     c     mdkey2        Chain     mnudtll1
022800101227     c                   If        %found
022900101227      * Get menu option record
023000101227     c     mdopt         Chain     mnuoptm
023100101227     c                   If        %found
023200101227     c                   Eval      Stop = 'Y'
023300101227     c                   Exsr      $ChkSec
023400101227     c                   Endif
023500101227     c                   Endif
023600101227     c                   Endif
023700101227     c
023800101227      ************
023900101227      * Check for new menu name
024000101227      *****
024100101227     c                   If        Stop = *blanks
024200101227     c                   Eval      mhmname = wwcmd
024300101227     c     mhmname       Chain     mnuhdrm
024400101227     c                   If        %found
024500120125     c* Check to see if they are authorized to use menu
024600120125     c                   Eval      MnuAuth = ' '
024700120125      * Check individual
024800120125     c                   Eval      mmopt = mhmname
024900120125     c                   Eval      mmuser = CurrentUser
025000120125     c     mmkey         Chain     mnumovm
025100120125     c                   If        %found
025200120125     c                   Eval      MnuAuth = 'Y'
025300120125     c                   Endif
025400120125      * Check group
025500120125     c                   Eval      mmopt = mhmname
025600120125     c                   Eval      mmuser = CurrentGroup
025700120125     c     mmkey         Chain     mnumovm
025800120125     c                   If        %found
025900120125     c                   Eval      MnuAuth = 'Y'
026000120125     c                   Endif
026100120125      * Check individual - *ALL
026200120125     c                   Eval      mmopt = '*ALL'
026300120125     c                   Eval      mmuser = CurrentUser
026400120125     c     mmkey         Chain     mnumovm
026500120125     c                   If        %found
026600120125     c                   Eval      MnuAuth = 'Y'
026700120125     c                   Endif
026800120125      * Check group - *ALL
026900120125     c                   Eval      mmopt = '*ALL'
027000120125     c                   Eval      mmuser = CurrentGroup
027100120125     c     mmkey         Chain     mnumovm
027200120125     c                   If        %found
027300120125     c                   Eval      MnuAuth = 'Y'
027400120125     c                   Endif
027500120125     c* Go if authorized
027600120125     c                   If        MnuAuth = 'Y'
027700101227     c                   Eval      CurrentMenu = CurrentMenu + 1
027800101227     c                   If        CurrentMenu > 100
027900101227     c                   Eval      CurrentMenu = 100
028000101227     c                   Endif
028100101227     c                   Eval      MenuStack(CurrentMenu) = mhmname
028200101227     c                   Eval      Stop = 'Y'
028300101227     c                   Exsr      $LoadSF
028400101227     c                   Eval      wccmd = *blanks
028500101227     c                   Endif
028600120125     c                   Endif
028700101227     c                   Endif
028800101227      ************
028900101227      * Check for i-OS command
029000101227      *****
029100101227     c                   If        Stop = *blanks
029200101230     c                   If        wwcmd <> *blanks and upltcp <> '*YES'
029300101227     c                   Eval      PMCMD = wwcmd
029400101227     c                   Eval      QLEN = %len(%trim(PMCMD))
029500111018     c                   Eval      PMCommand = PMCMD
029600111018     c                   Call      'PRO905C'
029700111018     c                   Parm                    PMCommand
029800111018     c                   Parm      'EXECUTE '    PMAction
029900111018     c                   Parm                    PmMessage
030000111018     c*                  Call      'QCMDEXC'                            90
030100111018     c*                  Parm                    PMCMD
030200111018     c*                  Parm                    QLEN
030300101231     c     1             Do        9             index             3 0
030400101231     c                   Eval      CommandStack(11-Index) =
030500101231     c                             CommandStack(10-Index)
030600101231     c                   Enddo
030700101231     c                   Eval      CommandStack(1) = wccmd
030800101231     c                   Eval      wccmd = *blanks
030900101227     c                   Endif
031000101230     c                   Endif
031100101227
031200101227     c                   Endsr
031300101227      ********************************************************************
031400101227     c     $ChkSec       Begsr
031500101227      * Check Option Security
031600101227     c                   If        museclvl >= moseclvl
031700101227     c                   If        moprompt = 'Y'
031800101227     c                   Eval      wrmopt = moopt
031900101227     c                   Eval      Center = (50-%len(%trim(mophead)))/2+1
032000101227     c                   Eval      %subst(wrphead:Center) =
032100101227     c                               %trim(mophead)
032200101227     c                   Eval      wrpbody = mopbody
032300101227     c                   Exfmt     Prompt
032400101227     c                   If        *in03 = *off and *in12 = *off
032500101227     c                   Exsr      $RunCommand
032600101227     c                   Else
032700101227     c                   Eval      wccmd = *blanks
032800101227     c                   Endif
032900101227     c                   Else
033000101227     c                   Exsr      $RunCommand
033100101227     c                   Endif
033200101227     c                   Else
033300101227      * Override to grant security access
033400101227     c                   Eval      mcopt = mdopt
033500120203     c                   Eval      mcuser = CurrentUser
033600101227     c     mckey         Chain     mnuoscm
033700121112     c                   If        not %found
033800121112     c                   Eval      mcuser = CurrentGroup
033900121112     c     mckey         Chain     mnuoscm
034000121112     c                   Endif
034100101227     c                   If        %found
034200101227     c                   If        moprompt = 'Y'
034300101227     c                   Eval      wrmopt = moopt
034400101227     c                   Eval      Center = (50-%len(%trim(mophead)))/2+1
034500101227     c                   Eval      %subst(wrphead:Center) =
034600101227     c                               %trim(mophead)
034700101227     c                   Eval      wrpbody = mopbody
034800101227     c                   Exfmt     Prompt
034900101227     c                   If        *in03 = *off and *in12 = *off
035000101227     c                   Exsr      $RunCommand
035100101227     c                   Else
035200101227     c                   Eval      wccmd = *blanks
035300101227     c                   Endif
035400101227     c                   Else
035500101227     c                   Exsr      $RunCommand
035600101227     c                   Endif
035700101227     c                   Endif
035800101227     c                   Endif
035900101227      *
036000101227     c                   Endsr
036100101227      ********************************************************************
036200101227     c     $RunCommand   Begsr
036300101227      * Run menu command
036400101227     c                   Eval      Fullcmd = mocmd
036500101227     c                   Dou       End = 0
036600101227     c                   Eval      End = %scan(';':Fullcmd)
036700101227     c                   If        End <> 0
036800101227     c                   Eval      PMCMD = %trim(%subst(Fullcmd:1:End-1))
036900101227     c                   Eval      Fullcmd = %trim(%subst(Fullcmd:End+1))
037000101227     c                   Eval      QLEN = %len(%trim(PMCMD))
037100111018     c                   Call      'QCMDEXC'                            90
037200111018     c                   Parm                    PMCMD
037300111018     c                   Parm                    QLEN
037400101227     c                   Eval      wccmd = *blanks
037500101227     c                   Endif
037600101227     c                   Enddo
037700101227     c                   Eval      PMCMD = %trim(Fullcmd)
037800101227     c                   Eval      QLEN = %len(%trim(PMCMD))
037900111018     c                   Call      'QCMDEXC'                            90
038000111018     c                   Parm                    PMCMD
038100111018     c                   Parm                    QLEN
038200101227     c                   Eval      wccmd = *blanks
038300110627
038400110627      * If this is a menu, go to a new menu.
038500120125      *
038600120126     c                   Eval      mhmname = mocmd
038700120126     c     mhmname       Chain     mnuhdrm
038800120126     c                   If        %found
038900120126     c                   Eval      CurrentMenu = CurrentMenu + 1
039000120126     c                   If        CurrentMenu > 100
039100120126     c                   Eval      CurrentMenu = 100
039200120126     c                   Endif
039300120126     c                   Eval      MenuStack(CurrentMenu) = mhmname
039400120126     c                   Eval      Stop = 'Y'
039500120126     c                   Exsr      $LoadSF
039600120126     c                   Eval      wccmd = *blanks
039700120126     c                   Endif
039800101227      *
039900101227     c                   Endsr
040000101227      ********************************************************************
040100101227     c     $HomeMenu     Begsr
040200101227      * Go to first menu in the call stack
040300101227     c                   If        CurrentMenu > 1
040400101227     c                   Eval      MenuStack(CurrentMenu) = *blanks
040500101227     c                   Eval      CurrentMenu = 1
040600101227     c                   Exsr      $LoadSF
040700101227     c                   Endif
040800101227      *
040900101227     c                   Endsr
041000101227      ********************************************************************
041100101227     c     $DSPMSG       Begsr
041200101227      * Go to first menu in the call stack
041300101227     c                   Eval      QCMD = 'DSPMSG'
041400101227     c                   Eval      QLEN = 6
041500101227     c                   Call      'QCMDEXC'                            90
041600101227     c                   Parm                    QCMD
041700101227     c                   Parm                    QLEN
041800101227      *
041900101227     c                   Endsr
042000111018      ********************************************************************
042100111018     c     $Prompt       Begsr
042200111018      * Prompt Command
042300120125     c                   If        HDCSRF = 'WCCMD'
042400111018     c                   Eval      PMCommand = wccmd
042500111018     c                   Call      'PRO905C'
042600111018     c                   Parm                    PMCommand
042700111018     c                   Parm      'PROMPT  '    PMAction
042800111018     c                   Parm                    PmMessage
042900111018     c                   If        PMMessage = ' '
043000111018     c                   Eval      wccmd = *blanks
043100111018     c                   Endif
043200120125     c                   Else
043300120125      * Show the command maintenance
043400120125     c                   Eval      rrn1 = sflloc + hdrow - 5
043500120125     c                   If        HDcol > 39
043600120125     c                   Eval      rrn1 = rrn1 + 14
043700120125     c                   Endif
043800120125     c     rrn1          chain     scrns01
043900120125     c                   If        %found
044000120125      *
044100120125      * Call maintenance program:
044200120125      *
044300120125     C                   CLEAR                   APP2
044400120125     C                   Eval      a2sec = '11111'
044500120125     C                   Eval      a2actn = 'CHANGE'
044600120125     c                   Eval      A2opt = wsopt
044700120125     C                   CALL      'MNU0041R'
044800120125     C                   PARM                    jld
044900120125     C                   PARM                    APP2
045000120125     c                   Eval      A2inlr = 'Y'
045100120125     C                   CALL      'MNU0041R'
045200120125     C                   PARM                    jld
045300120125     C                   PARM                    APP2
045400120125     c                   Endif
045500120125     c                   Endif
045600111018      *
045700111018     c                   Endsr
045800101227      ********************************************************************
045900101227     c     $Custom       Begsr
046000101227      * Call customize menu program
046100101231     c                   Move      dsuser        pmmname          10
046200101231     c                   Call      'MNU0030R'
046300101231     c                   Parm                    pmmname
046400101227      *
046500101227     c                   Endsr
046600111018      ********************************************************************
046700111018     c     $PrevCmd2     Begsr
046800111018      * Recall previous Command
046900111018     c                   If        wccmd = *blanks
047000111018     c                   Eval      PmMessage = *blanks
047100111018     c                   Endif
047200111018
047300111018     c                   Call      'PRO905C'
047400111018     c                   Parm                    PMCommand
047500111018     c                   Parm      'RETRIEVE'    PMAction
047600111018     c                   Parm                    PmMessage
047700111018
047800111018     c                   Eval      wccmd = PMCommand
047900111018
048000111018     c                   Endsr
048100101231      ********************************************************************
048200101231     c     $PrevCmd      Begsr
048300101231      * Recall previous Command
048400101231     c                   If        LastF9 = 'Y'
048500101231     c                   Eval      LC# = LC# + 1
048600101231     c                   If        LC# >10
048700101231     c                             or CommandStack(LC#) = *blanks
048800101231     c                   Eval      LC# = 1
048900101231     c                   Endif
049000101231     c                   Eval      wccmd = CommandStack(LC#)
049100101231     c                   Else
049200101231     c                   Eval      LC# = 1
049300101231     c                   Eval      wccmd = CommandStack(LC#)
049400101231     c                   Endif
049500101231     c                   Eval      LastF9 = 'Y'
049600101231      *
049700101231     c                   Endsr
049800101227      ********************************************************************
049900101227     c     $PrevMenu     Begsr
050000101227      * Go to previous menu in the menu stack
050100101227     c                   If        CurrentMenu > 1
050200101227     c                   Eval      MenuStack(CurrentMenu) = *blanks
050300101227     c                   Eval      CurrentMenu = CurrentMenu - 1
050400101227     c                   Exsr      $LoadSF
050500101227     c                   Endif
050600101227      *
050700101227     c                   Endsr
050800101227      ********************************************************************
050900101227     c     $LoadSF       Begsr
051000101227      * Load the menu subfile
051100101227     c                   Eval      *in32 = *off
051200101227     c                   Eval      *in30 = *on
051300101227     c                   Write     scrnc01
051400101227     c                   Eval      *in30 = *off
051500101227     c                   Eval      *in34 = *on
051600101227     c                   Eval      rrn1 = 0
051700101227
051800101227     c                   Eval      mdmname = MenuStack(CurrentMenu)
051900101227     c     mdmname       Setll     mnudtlm
052000101227     c     mdmname       reade     mnudtlm
052100101227     c                   Dow       not %eof
052200101227      * Get menu option record
052300101227     c     mdopt         Chain     mnuoptm
052400101227     c                   If        %found
052500120125     c* Check to see if they are authorized to use menu
052600120125     c                   Eval      OptAuth = ' '
052700120125      * Check individual
052800120125     c                   Eval      mcopt = mdopt
052900120125     c                   Eval      mcuser = CurrentUser
053000120125     c     mckey         Chain     mnuoscm
053100120125     c                   If        %found
053200120125     c                   Eval      OptAuth = 'Y'
053300120125     c                   Endif
053400120125      * Check group
053500120125     c                   Eval      mcopt = mdopt
053600120125     c                   Eval      mcuser = CurrentGroup
053700120125     c     mckey         Chain     mnuoscm
053800120125     c                   If        %found
053900120125     c                   Eval      OptAuth = 'Y'
054000120125     c                   Endif
054100101227     c                   If        museclvl >= moseclvl
054200120125     c                             Or OptAuth = 'Y'
054300101227     c                   Evalr     FourAlpha = %trim(mdsel)
054400101230     c                   If        FourAlpha <> *blanks
054500101227     c                   Eval      Wsline = FourAlpha + '. ' + modesc
054600101230     c                   Eval      *in40 = *off
054700101230     c                   Else
054800101230     c                   Eval      Wsline = FourAlpha + '  ' + modesc
054900101230     c                   Eval      *in40 = *on
055000101230     c                   Endif
055100120125     c                   Eval      wsopt = moopt
055200101227     c                   Add       1             rrn1
055300101227     c                   Write     scrns01
055400101227     c                   Eval      *in32 = *on
055500101227     c                   Else
055600101227     c                   Eval      mcopt = mdopt
055700120203     c                   Eval      mcuser = CurrentUser
055800101227     c     mckey         Chain     mnuoscm
055900101227     c                   If        %found
056000101227     c                   Eval      Wsline = mdsel + '.' + modesc
056100101227     c                   Add       1             rrn1
056200101227     c                   Write     scrns01
056300101227     c                   Eval      *in32 = *on
056400101227     c                   Endif
056500101227     c                   Endif
056600101227     c                   Endif
056700101227     c     mdmname       reade     mnudtlm
056800101227     c                   Enddo
056900101227      *
057000101227     c     mdmname       Chain     mnuhdrm
057100101227     c                   If        %found
057200101229     c                   Eval      Center = (40-%len(%trim(mhmdesc)))/2+1
057300110624     c                   Eval      wcmnudesc = *blanks
057400101229     c                   Eval      %subst(wcmnudesc:Center) =
057500101229     c                               %trim(mhmdesc)
057600101227     c                   Eval      wcmenu = mhmname
057700101227     c                   Endif
057800101227      *
057900110627     c                   Eval      hdsflp = 1
058000110627      *
058100101230     c                   Endsr
058200101230      ********************************************************************
058300101230     c     $ChgUser      Begsr
058400101230     c                   Eval      wrchguser = *blanks
058500101230     c                   Exfmt     chguser
058600101230     c                   If        *in03 = *off
058700101230     c                             and *in12 = *off
058800101230     c                             and wrchguser <> *blanks
058900120125     c                   Eval      CurrentUser = wrchguser
059000120125      * Get group profile from use file for security
059100120125     c     CurrentUser   Chain     usefile
059200120125     c                   If        %found
059300120125     c                   Eval      CurrentGroup = upgrpf
059400120125     c                   Endif
059500101230      * Load all user defaults - Check for user first
059600120125     c     CurrentUser   Chain     mnuusrm
059700101230      * If no user record, check for group record
059800101230     c                   If        not %found
059900120125     c     CurrentUser   Chain     usefile
060000101230     c                   If        %found
060100101230     c     upgrpf        Chain     mnuusrm
060200101230     c                   Else
060300101230     c                   Eval      *inlr = *on
060400101230     c                   Endif
060500101230     c                   Endif
060600101230     c                   If        museclvl = 9
060700101230     c                   Eval      *in61 = *on
060800101230     C                   Else
060900101230     c                   Eval      *in61 = *off
061000101230     c                   Endif
061100101230      * Load Initial Menu
061200101230     c                   Eval      CurrentMenu = 1
061300101230     c                   Eval      MenuStack(CurrentMenu) = muimenu
061400101230     c                   Exsr      $LoadSF
061500101230     c                   Endif
061600101230      *
061700101227     c                   Endsr
061800101227      ********************************************************************
061900101227     c     *inzsr        Begsr
062000101227      * Key Lists
062100101227     c     mdkey2        Klist
062200101227     c                   Kfld                    mdmname
062300101227     c                   Kfld                    mdsel
062400101227      *
062500101227     c     mckey         Klist
062600101227     c                   Kfld                    mcopt
062700101227     c                   Kfld                    mcuser
062800120125      *
062900120125     c     mmkey         Klist
063000120125     c                   Kfld                    mmopt
063100120125     c                   Kfld                    mmuser
063200120125      * Set current user = to person signed on.
063300120125     c                   Eval      CurrentUser = dsuser
063400120125      * Get group profile from use file for security
063500120125     c     CurrentUser   Chain     usefile
063600120125     c                   If        %found
063700120125     c                   Eval      CurrentGroup = upgrpf
063800120125     c                   Endif
063900120125      *
064000101227      * Load all user defaults - Check for user first
064100120125     c     CurrentUser   Chain     mnuusrm
064200101227      * If no user record, check for group record
064300101227     c                   If        not %found
064400120125     c     CurrentUser   Chain     usefile
064500101227     c                   If        %found
064600101227     c     upgrpf        Chain     mnuusrm
064700101227     c                   Else
064800101227     c                   Eval      *inlr = *on
064900101227     c                   Endif
065000101227     c                   Endif
065100101227     c                   If        museclvl = 9
065200101227     c                   Eval      *in61 = *on
065300101227     c                   Endif
065400101227      * Get defaults
065500101227     c                   Read      mnusysm
065600101227     c                   If        not %eof
065700101227     c                   Eval      WCHead1 = mshead1
065800101227     c                   Eval      WcHead2 = mshead2
065900101227     c                   If        muimenu = *blanks
066000101227     c                   Eval      muimenu = msdftmnu
066100101227     c                   Endif
066200101227     c                   Endif
066300101227      * Load Initial Menu
066400101227     c                   Eval      CurrentMenu = 1
066500101227     c                   Eval      MenuStack(CurrentMenu) = muimenu
066600101227     c                   Exsr      $LoadSF
066700101227      *
066800101229     c                   Call      'SYSNAMEC'
066900101229     c                   Parm                    wcsystem
067000101229      *
067100101227     c                   Endsr
