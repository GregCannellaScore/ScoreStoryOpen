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
001700140824/001  *  Galina  02/05/13  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxx
001800140824/002  *  GMC      8/24/14  Add call to help text program.
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
003000141130     fmnu0001d  cf   e             workstn
003100101227     f                                     SFILE(SCRNS01:RRN1)
003200101227     f                                     INFDS(INFDS)
003300101227     fmnuhdrm   if   e           k disk
003400101227     fmnudtlm   if   e           k disk
003500101227     fmnudtll1  if   e           k disk    rename(mnudtlmr:mdtl1)
003600101227     fmnuoptm   if   e           k disk
003700101227     fmnuoscm   if   e           k disk
003800101227     fmnuusrm   if   e           k disk
003900101227     fmnusysm   if   e           k disk
004000120125     fmnumovm   if   e           k disk
004100101227      * Constants
004200101227     d Upper           C                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ012-
004300101227     d                                     3456789!@#$%^&*();:,.<>/?[]{}\-=_+')
004400101227     d Lower           C                   CONST('abcdefghijklmnopqrstuvwxyz012-
004500101227     d                                     3456789!@#$%^&*();:,.<>/?[]{}\-=_+')
004600101227      * Variables
004700101227>>>> d QCMD            s            256
004800101227>>>> d QLEN            s             15p 5
004900101227     d WWCMD           s             66
005000101227     d WWCurrentMenu   s             10
005100120125     d CurrentUser     s             10
005200120125     d CurrentGroup    s             10
005300171021     d LimitCap        s             10
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
007000130205/001 d ReplValue       s              5
007100101227      *
007200101227     d INFDS           DS
007300101227     d  SFLLOC               378    379B 0
007400101227      *
007500120125     D jld           E DS                  EXTNAME(dsjld)
007600120125
007700120125      *
007800120125      * Calling parms for MNU0041R:
007900120125     d APP2            DS           512
008000120125     d  A2SEC                  1      5
008100120125     d  A2IUSE                 6     15
008200120125     d  A2INLR                16     16
008300120125     d  A2ACTN                17     26
008400120125     d  A2OPT                 27     36
008500120125
008600101227     d                SDS
008700101227     d  DSPGMN           *PROC
008800101229     d  DSJOB                244    253
008900101227     d  DSUSER               254    263
009000101227      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
009100101227      *M                 M  A  I  N  L  I  N  E                       M
009200101227      *MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
009300101227      *
009400101227     c                   DOU       *inlr = *ON
009500101227      *
009600101227      * Display screen:
009700101227      *
009800101227     c                   Write     MSGCTL1
009900101227     c                   Write     SCRNH01
010000101227      *
010100101227     c                   If        *in32 = *OFF
010200101227     c                   Exfmt     SCRNR01
010300101227     c                   Endif
010400101227      *
010500101227     c                   Exfmt     SCRNC01
010600110627
010700110627     c                   Move      SFLLOC        HDSFLP
010800101227      *
010900101227      * Clear messages:
011000101227      *
011100101227     c                   Call      'ERMSG2'
011200101227     c                   Parm                    DSPGMN
011300101231
011400101231     c                   If        *in09 = *off
011500101231     c                   Eval      LastF9 = 'N'
011600101231     c                   Endif
011700101227      *
011800101227>>>>  * Process command keys:
011900101227      *
012000101227     c                   SELECT
012100140824      *
012200140824      * F1 = Call Help
012300140824      *
012400140824     c                   WHEN      *IN01 = *ON
012500140824     c                   EXSR      $HELP
012600111018      *
012700111018      * F2 = DSPMSG
012800111018      *
012900111018     c                   WHEN      *IN02 = *ON
013000111018     c                   EXSR      $DSPMSG
013100101227      *
013200101227      * F3 = Home Menu
013300101227      *
013400101227     c                   WHEN      *IN03 = *ON
013500101227     c                   EXSR      $HomeMenu
013600111018      *
013700111018      * F4 = Prompt Command
013800111018      *
013900111018     c                   WHEN      *IN04 = *ON
014000111018     c                   EXSR      $Prompt
014100101227      *
014200101227      * F6 = Customize Menu
014300101227      *
014400101227     c                   WHEN      *IN06 = *ON
014500101227     c                   EXSR      $Custom
014600101231      *
014700101231      * F9 = Get Previous Command
014800101231      *
014900101231     c                   WHEN      *IN09 = *ON
015000111018     c                   EXSR      $PrevCmd2
015100101230      *
015200101230      * F10 = Call QCMD
015300101230      *
015400171021     c                   WHEN      *IN10 = *ON and LimitCap = '*YES'
015500101230     c                   Call      'QCMD'
015600101227      *
015700101227      * F12 = Previous Menu
015800101227      *
015900101227     c                   WHEN      *IN12 = *ON
016000101227     c                   EXSR      $PrevMenu
016100101230      *
016200101230      * F20 = Change User
016300101230      *
016400101230     c                   WHEN      *IN20 = *ON
016500101230     c                   Exsr      $ChgUser
016600101227      *
016700101229      * F21 = Search Menu Text and Commands
016800101227      *
016900101230     c                   WHEN      *IN21 = *ON
017000101230     c                   Call      'MNU0060R'                           90
017100101227      *
017200101229      * F22 = Menu Maint
017300101227      *
017400101227     c                   WHEN      *IN22 = *ON
017500101229     c                   Call      'MNU0020C'                           90
017600101227      *
017700101228      * F23 = Users
017800101227      *
017900101227     c                   WHEN      *IN23 = *ON
018000101228     c                   Call      'MNU0010C'                           90
018100101227      *
018200101227      *
018300101227      * F01 = Previous Menu
018400101227      *
018500140824     c*                  WHEN      *IN01 = *ON
018600120307     c*                  Eval      *inlr = *on
018700120307     c*                  Return
018800101227      *
018900101227     c                   OTHER
019000101227      *
019100101227      * Enter:
019200101227      *
019300101227     c                   EXSR      $Enter
019400101227      *
019500101227     c                   ENDSL
019600101227      *
019700101227     c                   ENDDO
019800101227      ********************************************************************
019900101227     c     $Enter        Begsr
020000101227     c                   Eval      Stop = *blanks
020100101227      * Make command all upper
020200101227     c                   Eval      wwcmd = %trim(%xlate(Lower:Upper:wccmd))
020300101227      ************
020400101227      * Check for sign off
020500101227      *****
020600101227     c                   if        %trim(wccmd) = '90'
020700101227     c                             or wwcmd = 'SIGNOFF'
020800101227     c                   Eval      *inlr = *on
020900101227     c                   Eval      Stop = 'Y'
021000101227     c                   Endif
021100101227      ************
021200101227      * Check for menu option on current menu
021300101227      *****
021400101227     c                   If        Stop = *blanks
021500101227     c                   Eval      mdmname = MenuStack(CurrentMenu)
021600101227     c                   Eval      mdsel = wwcmd
021700101227     c     mdkey2        Chain     mnudtll1
021800101227     c                   If        %found
021900101227      * Get menu option record
022000101227     c     mdopt         Chain     mnuoptm
022100101227     c                   If        %found
022200101227     c                   Eval      Stop = 'Y'
022300101227     c                   Exsr      $ChkSec
022400101227     c                   Endif
022500101227     c                   Endif
022600101227     c                   Endif
022700101227      ************
022800101227      * Check for menu option global menu
022900101227      *****
023000101227     c                   If        Stop = *blanks
023100141130     c                   Eval      mdmname = 'GLOBAL'
023200101227     c                   Eval      mdsel = wwcmd
023300101227     c     mdkey2        Chain     mnudtll1
023400101227     c                   If        %found
023500101227      * Get menu option record
023600101227     c     mdopt         Chain     mnuoptm
023700101227     c                   If        %found
023800101227     c                   Eval      Stop = 'Y'
023900101227     c                   Exsr      $ChkSec
024000101227     c                   Endif
024100101227     c                   Endif
024200101227     c                   Endif
024300101227     c
024400101227      ************
024500101227      * Check for new menu name
024600101227      *****
024700101227     c                   If        Stop = *blanks
024800101227     c                   Eval      mhmname = wwcmd
024900101227     c     mhmname       Chain     mnuhdrm
025000101227     c                   If        %found
025100120125     c* Check to see if they are authorized to use menu
025200120125     c                   Eval      MnuAuth = ' '
025300120125      * Check individual
025400120125     c                   Eval      mmopt = mhmname
025500120125     c                   Eval      mmuser = CurrentUser
025600120125     c     mmkey         Chain     mnumovm
025700120125     c                   If        %found
025800120125     c                   Eval      MnuAuth = 'Y'
025900120125     c                   Endif
026000120125      * Check group
026100120125     c                   Eval      mmopt = mhmname
026200120125     c                   Eval      mmuser = CurrentGroup
026300120125     c     mmkey         Chain     mnumovm
026400120125     c                   If        %found
026500120125     c                   Eval      MnuAuth = 'Y'
026600120125     c                   Endif
026700120125      * Check individual - *ALL
026800120125     c                   Eval      mmopt = '*ALL'
026900120125     c                   Eval      mmuser = CurrentUser
027000120125     c     mmkey         Chain     mnumovm
027100120125     c                   If        %found
027200120125     c                   Eval      MnuAuth = 'Y'
027300120125     c                   Endif
027400120125      * Check group - *ALL
027500120125     c                   Eval      mmopt = '*ALL'
027600120125     c                   Eval      mmuser = CurrentGroup
027700120125     c     mmkey         Chain     mnumovm
027800120125     c                   If        %found
027900120125     c                   Eval      MnuAuth = 'Y'
028000120125     c                   Endif
028100120125     c* Go if authorized
028200120125     c                   If        MnuAuth = 'Y'
028300101227     c                   Eval      CurrentMenu = CurrentMenu + 1
028400101227     c                   If        CurrentMenu > 100
028500101227     c                   Eval      CurrentMenu = 100
028600101227     c                   Endif
028700101227     c                   Eval      MenuStack(CurrentMenu) = mhmname
028800101227     c                   Eval      Stop = 'Y'
028900101227     c                   Exsr      $LoadSF
029000101227     c                   Eval      wccmd = *blanks
029100101227     c                   Endif
029200120125     c                   Endif
029300101227     c                   Endif
029400101227      ************
029500101227      * Check for i-OS command
029600101227      *****
029700101227     c                   If        Stop = *blanks
029800171021     c                   If        wwcmd <> *blanks and LimitCap <> '*YES'
029900101227     c                   Eval      PMCMD = wwcmd
030000101227     c                   Eval      QLEN = %len(%trim(PMCMD))
030100111018     c                   Eval      PMCommand = PMCMD
030200141130     c                   Call      'MNU0700C'
030300111018     c                   Parm                    PMCommand
030400111018     c                   Parm      'EXECUTE '    PMAction
030500111018     c                   Parm                    PmMessage
030600111018     c*                  Call      'QCMDEXC'                            90
030700111018     c*                  Parm                    PMCMD
030800111018     c*                  Parm                    QLEN
030900101231     c     1             Do        9             index             3 0
031000101231     c                   Eval      CommandStack(11-Index) =
031100101231     c                             CommandStack(10-Index)
031200101231     c                   Enddo
031300101231     c                   Eval      CommandStack(1) = wccmd
031400101231     c                   Eval      wccmd = *blanks
031500101227     c                   Endif
031600101230     c                   Endif
031700130207     c                   If        *in25 = *off
031800130207     c                   Exsr      $LoadSF
031900130207     c                   Endif
032000101227
032100101227     c                   Endsr
032200101227      ********************************************************************
032300101227     c     $ChkSec       Begsr
032400101227      * Check Option Security
032500101227     c                   If        museclvl >= moseclvl
032600101227     c                   If        moprompt = 'Y'
032700101227     c                   Eval      wrmopt = moopt
032800101227     c                   Eval      Center = (50-%len(%trim(mophead)))/2+1
032900101227     c                   Eval      %subst(wrphead:Center) =
033000101227     c                               %trim(mophead)
033100101227     c                   Eval      wrpbody = mopbody
033200101227     c                   Exfmt     Prompt
033300101227     c                   If        *in03 = *off and *in12 = *off
033400101227     c                   Exsr      $RunCommand
033500101227     c                   Else
033600101227     c                   Eval      wccmd = *blanks
033700101227     c                   Endif
033800101227     c                   Else
033900101227     c                   Exsr      $RunCommand
034000101227     c                   Endif
034100101227     c                   Else
034200101227      * Override to grant security access
034300101227     c                   Eval      mcopt = mdopt
034400120203     c                   Eval      mcuser = CurrentUser
034500101227     c     mckey         Chain     mnuoscm
034600121112     c                   If        not %found
034700121112     c                   Eval      mcuser = CurrentGroup
034800121112     c     mckey         Chain     mnuoscm
034900121112     c                   Endif
035000101227     c                   If        %found
035100101227     c                   If        moprompt = 'Y'
035200101227     c                   Eval      wrmopt = moopt
035300101227     c                   Eval      Center = (50-%len(%trim(mophead)))/2+1
035400101227     c                   Eval      %subst(wrphead:Center) =
035500101227     c                               %trim(mophead)
035600101227     c                   Eval      wrpbody = mopbody
035700101227     c                   Exfmt     Prompt
035800101227     c                   If        *in03 = *off and *in12 = *off
035900101227     c                   Exsr      $RunCommand
036000101227     c                   Else
036100101227     c                   Eval      wccmd = *blanks
036200101227     c                   Endif
036300101227     c                   Else
036400101227     c                   Exsr      $RunCommand
036500101227     c                   Endif
036600101227     c                   Endif
036700101227     c                   Endif
036800101227      *
036900101227     c                   Endsr
037000101227      ********************************************************************
037100101227     c     $RunCommand   Begsr
037200101227      * Run menu command
037300101227     c                   Eval      Fullcmd = mocmd
037400101227     c                   Dou       End = 0
037500101227     c                   Eval      End = %scan(';':Fullcmd)
037600101227     c                   If        End <> 0
037700101227     c                   Eval      PMCMD = %trim(%subst(Fullcmd:1:End-1))
037800101227     c                   Eval      Fullcmd = %trim(%subst(Fullcmd:End+1))
037900101227     c                   Eval      QLEN = %len(%trim(PMCMD))
038000111018     c                   Call      'QCMDEXC'                            90
038100111018     c                   Parm                    PMCMD
038200111018     c                   Parm                    QLEN
038300101227     c                   Eval      wccmd = *blanks
038400101227     c                   Endif
038500101227     c                   Enddo
038600101227     c                   Eval      PMCMD = %trim(Fullcmd)
038700101227     c                   Eval      QLEN = %len(%trim(PMCMD))
038800111018     c                   Call      'QCMDEXC'                            90
038900111018     c                   Parm                    PMCMD
039000111018     c                   Parm                    QLEN
039100101227     c                   Eval      wccmd = *blanks
039200110627
039300110627      * If this is a menu, go to a new menu.
039400120125      *
039500120126     c                   Eval      mhmname = mocmd
039600120126     c     mhmname       Chain     mnuhdrm
039700120126     c                   If        %found
039800120126     c                   Eval      CurrentMenu = CurrentMenu + 1
039900120126     c                   If        CurrentMenu > 100
040000120126     c                   Eval      CurrentMenu = 100
040100120126     c                   Endif
040200120126     c                   Eval      MenuStack(CurrentMenu) = mhmname
040300120126     c                   Eval      Stop = 'Y'
040400120126     c                   Exsr      $LoadSF
040500120126     c                   Eval      wccmd = *blanks
040600120126     c                   Endif
040700101227      *
040800101227     c                   Endsr
040900101227      ********************************************************************
041000101227     c     $HomeMenu     Begsr
041100101227      * Go to first menu in the call stack
041200101227     c                   If        CurrentMenu > 1
041300101227     c                   Eval      MenuStack(CurrentMenu) = *blanks
041400101227     c                   Eval      CurrentMenu = 1
041500101227     c                   Exsr      $LoadSF
041600101227     c                   Endif
041700101227      *
041800101227     c                   Endsr
041900140824      ********************************************************************
042000140824     c     $HELP         Begsr
042100140824      * Call help screen
042200140824      * Get menu option record
042300140824     c                   Eval      mdsel = wccmd
042400140824     c     mdkey2        Chain     mnudtll1
042500140824     c                   If        %found
042600140824     c     mdopt         Chain     mnuoptm
042700140824     c                   If        %found
042800140824     c                   Eval      Stop = 'Y'
042900140824     c                   Call      'MNU0005R'                           90
043000140824     c                   Parm                    moopt
043100140824     c                   Clear                   wccmd
043200140824     c                   Endif
043300140824     c                   Endif
043400140824      *
043500140824     c                   Endsr
043600101227      ********************************************************************
043700101227     c     $DSPMSG       Begsr
043800140824      * Display user messages
043900101227     c                   Eval      QCMD = 'DSPMSG'
044000101227     c                   Eval      QLEN = 6
044100101227     c                   Call      'QCMDEXC'                            90
044200101227     c                   Parm                    QCMD
044300101227     c                   Parm                    QLEN
044400101227      *
044500101227     c                   Endsr
044600111018      ********************************************************************
044700111018     c     $Prompt       Begsr
044800111018      * Prompt Command
044900120125     c                   If        HDCSRF = 'WCCMD'
045000111018     c                   Eval      PMCommand = wccmd
045100141130     c                   Call      'MNU0700C'
045200111018     c                   Parm                    PMCommand
045300111018     c                   Parm      'PROMPT  '    PMAction
045400111018     c                   Parm                    PmMessage
045500111018     c                   If        PMMessage = ' '
045600111018     c                   Eval      wccmd = *blanks
045700111018     c                   Endif
045800120125     c                   Else
045900120125      * Show the command maintenance
046000120125     c                   Eval      rrn1 = sflloc + hdrow - 5
046100120125     c                   If        HDcol > 39
046200120125     c                   Eval      rrn1 = rrn1 + 14
046300120125     c                   Endif
046400120125     c     rrn1          chain     scrns01
046500120125     c                   If        %found
046600120125      *
046700120125      * Call maintenance program:
046800120125      *
046900120125     C                   CLEAR                   APP2
047000120125     C                   Eval      a2sec = '11111'
047100120125     C                   Eval      a2actn = 'CHANGE'
047200120125     c                   Eval      A2opt = wsopt
047300120125     C                   CALL      'MNU0041R'
047400120125     C                   PARM                    jld
047500120125     C                   PARM                    APP2
047600120125     c                   Eval      A2inlr = 'Y'
047700120125     C                   CALL      'MNU0041R'
047800120125     C                   PARM                    jld
047900120125     C                   PARM                    APP2
048000120125     c                   Endif
048100120125     c                   Endif
048200111018      *
048300111018     c                   Endsr
048400101227      ********************************************************************
048500101227     c     $Custom       Begsr
048600101227      * Call customize menu program
048700101231     c                   Move      dsuser        pmmname          10
048800101231     c                   Call      'MNU0030R'
048900101231     c                   Parm                    pmmname
049000101227      *
049100101227     c                   Endsr
049200111018      ********************************************************************
049300111018     c     $PrevCmd2     Begsr
049400111018      * Recall previous Command
049500111018     c                   If        wccmd = *blanks
049600111018     c                   Eval      PmMessage = *blanks
049700111018     c                   Endif
049800111018
049900141130     c                   Call      'MNU0700C'
050000111018     c                   Parm                    PMCommand
050100111018     c                   Parm      'RETRIEVE'    PMAction
050200111018     c                   Parm                    PmMessage
050300111018
050400111018     c                   Eval      wccmd = PMCommand
050500111018
050600111018     c                   Endsr
050700101231      ********************************************************************
050800101231     c     $PrevCmd      Begsr
050900101231      * Recall previous Command
051000101231     c                   If        LastF9 = 'Y'
051100101231     c                   Eval      LC# = LC# + 1
051200101231     c                   If        LC# >10
051300101231     c                             or CommandStack(LC#) = *blanks
051400101231     c                   Eval      LC# = 1
051500101231     c                   Endif
051600101231     c                   Eval      wccmd = CommandStack(LC#)
051700101231     c                   Else
051800101231     c                   Eval      LC# = 1
051900101231     c                   Eval      wccmd = CommandStack(LC#)
052000101231     c                   Endif
052100101231     c                   Eval      LastF9 = 'Y'
052200101231      *
052300101231     c                   Endsr
052400101227      ********************************************************************
052500101227     c     $PrevMenu     Begsr
052600101227      * Go to previous menu in the menu stack
052700101227     c                   If        CurrentMenu > 1
052800101227     c                   Eval      MenuStack(CurrentMenu) = *blanks
052900101227     c                   Eval      CurrentMenu = CurrentMenu - 1
053000101227     c                   Exsr      $LoadSF
053100101227     c                   Endif
053200101227      *
053300101227     c                   Endsr
053400101227      ********************************************************************
053500101227     c     $LoadSF       Begsr
053600101227      * Load the menu subfile
053700101227     c                   Eval      *in32 = *off
053800101227     c                   Eval      *in30 = *on
053900101227     c                   Write     scrnc01
054000101227     c                   Eval      *in30 = *off
054100101227     c                   Eval      *in34 = *on
054200101227     c                   Eval      rrn1 = 0
054300101227
054400101227     c                   Eval      mdmname = MenuStack(CurrentMenu)
054500101227     c     mdmname       Setll     mnudtlm
054600101227     c     mdmname       reade     mnudtlm
054700101227     c                   Dow       not %eof
054800101227      * Get menu option record
054900101227     c     mdopt         Chain     mnuoptm
055000101227     c                   If        %found
055100130205      *
055200130205/001 c                   If        Moexpg <> *blank and
055300130205 |   c                             %scan('%%%%%' : Modesc) > 0
055400130205 |   C                   Call      Moexpg
055500130205 |   C                   Parm                    CurrentUser
055600130205 |   C                   Parm                    ReplValue
055700130205/001 C                   If        ReplValue <> *Blanks
055800130205      /free
055900130205           Modesc = %ScanRPL('%%%%%' : ReplValue : Modesc);
056000130205      /end-free
056100130205/001 C                   EndIf
056200130205/001 C                   EndIf
056300120125     c* Check to see if they are authorized to use menu
056400120125     c                   Eval      OptAuth = ' '
056500120125      * Check individual
056600120125     c                   Eval      mcopt = mdopt
056700120125     c                   Eval      mcuser = CurrentUser
056800120125     c     mckey         Chain     mnuoscm
056900120125     c                   If        %found
057000120125     c                   Eval      OptAuth = 'Y'
057100120125     c                   Endif
057200120125      * Check group
057300120125     c                   Eval      mcopt = mdopt
057400120125     c                   Eval      mcuser = CurrentGroup
057500120125     c     mckey         Chain     mnuoscm
057600120125     c                   If        %found
057700120125     c                   Eval      OptAuth = 'Y'
057800120125     c                   Endif
057900101227     c                   If        museclvl >= moseclvl
058000120125     c                             Or OptAuth = 'Y'
058100101227     c                   Evalr     FourAlpha = %trim(mdsel)
058200101230     c                   If        FourAlpha <> *blanks
058300101227     c                   Eval      Wsline = FourAlpha + '. ' + modesc
058400101230     c                   Eval      *in40 = *off
058500101230     c                   Else
058600101230     c                   Eval      Wsline = FourAlpha + '  ' + modesc
058700101230     c                   Eval      *in40 = *on
058800101230     c                   Endif
058900120125     c                   Eval      wsopt = moopt
059000101227     c                   Add       1             rrn1
059100101227     c                   Write     scrns01
059200101227     c                   Eval      *in32 = *on
059300101227     c                   Else
059400101227     c                   Eval      mcopt = mdopt
059500120203     c                   Eval      mcuser = CurrentUser
059600101227     c     mckey         Chain     mnuoscm
059700101227     c                   If        %found
059800101227     c                   Eval      Wsline = mdsel + '.' + modesc
059900101227     c                   Add       1             rrn1
060000101227     c                   Write     scrns01
060100101227     c                   Eval      *in32 = *on
060200101227     c                   Endif
060300101227     c                   Endif
060400101227     c                   Endif
060500101227     c     mdmname       reade     mnudtlm
060600101227     c                   Enddo
060700101227      *
060800101227     c     mdmname       Chain     mnuhdrm
060900101227     c                   If        %found
061000101229     c                   Eval      Center = (40-%len(%trim(mhmdesc)))/2+1
061100110624     c                   Eval      wcmnudesc = *blanks
061200101229     c                   Eval      %subst(wcmnudesc:Center) =
061300101229     c                               %trim(mhmdesc)
061400101227     c                   Eval      wcmenu = mhmname
061500101227     c                   Endif
061600101227      *
061700110627     c                   Eval      hdsflp = 1
061800110627      *
061900101230     c                   Endsr
062000101230      ********************************************************************
062100101230     c     $ChgUser      Begsr
062200101230     c                   Eval      wrchguser = *blanks
062300101230     c                   Exfmt     chguser
062400101230     c                   If        *in03 = *off
062500101230     c                             and *in12 = *off
062600101230     c                             and wrchguser <> *blanks
062700120125     c                   Eval      CurrentUser = wrchguser
062800120125      * Get group profile from use file for security
062900171021     c                   Call      'DSH0117C'
063000171021     c                   Parm                    CurrentUser
063100171021     c                   Parm                    CurrentGroup
063200171021     c                   Call      'DSH0118C'
063300171021     c                   Parm                    CurrentUser
063400171021     c                   Parm                    LimitCap
063500101230      * Load all user defaults - Check for user first
063600120125     c     CurrentUser   Chain     mnuusrm
063700101230      * If no user record, check for group record
063800101230     c                   If        not %found
063900171021     c     CurrentGroup  Chain     mnuusrm
064000171021     c                   If        not %found
064100171021     c                   Eval      muimenu = 'SETUP'
064200171021     c                   Eval      museclvl = 0
064300101230     c                   Endif
064400101230     c                   Endif
064500101230     c                   If        museclvl = 9
064600101230     c                   Eval      *in61 = *on
064700101230     C                   Else
064800101230     c                   Eval      *in61 = *off
064900101230     c                   Endif
065000101230      * Load Initial Menu
065100101230     c                   Eval      CurrentMenu = 1
065200101230     c                   Eval      MenuStack(CurrentMenu) = muimenu
065300101230     c                   Exsr      $LoadSF
065400101230     c                   Endif
065500101230      *
065600101227     c                   Endsr
065700101227      ********************************************************************
065800101227     c     *inzsr        Begsr
065900101227      * Key Lists
066000101227     c     mdkey2        Klist
066100101227     c                   Kfld                    mdmname
066200101227     c                   Kfld                    mdsel
066300101227      *
066400101227     c     mckey         Klist
066500101227     c                   Kfld                    mcopt
066600101227     c                   Kfld                    mcuser
066700120125      *
066800120125     c     mmkey         Klist
066900120125     c                   Kfld                    mmopt
067000120125     c                   Kfld                    mmuser
067100120125      * Set current user = to person signed on.
067200120125     c                   Eval      CurrentUser = dsuser
067300120125      * Get group profile from use file for security
067400171021     c                   Call      'DSH0117C'
067500171021     c                   Parm                    CurrentUser
067600171021     c                   Parm                    CurrentGroup
067700171021     c                   Call      'DSH0118C'
067800171021     c                   Parm                    CurrentUser
067900171021     c                   Parm                    LimitCap
068000120125      *
068100101227      * Load all user defaults - Check for user first
068200120125     c     CurrentUser   Chain     mnuusrm
068300101227      * If no user record, check for group record
068400101227     c                   If        not %found
068500171021     c     CurrentGroup  Chain     mnuusrm
068600171021     c                   If        not %found
068700171021     c                   Eval      muimenu = 'SETUP'
068800101227     c                   Endif
068900101227     c                   Endif
069000101227     c                   If        museclvl = 9
069100101227     c                   Eval      *in61 = *on
069200101227     c                   Endif
069300101227      * Get defaults
069400101227     c                   Read      mnusysm
069500101227     c                   If        not %eof
069600101227     c                   Eval      WCHead1 = mshead1
069700101227     c                   Eval      WcHead2 = mshead2
069800101227     c                   If        muimenu = *blanks
069900101227     c                   Eval      muimenu = msdftmnu
070000101227     c                   Endif
070100101227     c                   Endif
070200101227      * Load Initial Menu
070300101227     c                   Eval      CurrentMenu = 1
070400101227     c                   Eval      MenuStack(CurrentMenu) = muimenu
070500101227     c                   Exsr      $LoadSF
070600101227      *
070700101229     c                   Call      'SYSNAMEC'
070800101229     c                   Parm                    wcsystem
070900101229      *
071000101227     c                   Endsr
