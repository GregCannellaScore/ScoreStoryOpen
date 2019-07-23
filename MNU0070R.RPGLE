000100110219      /COPY QCPYLESRC,stdhspec
000200110219      ********************************************************************
000300110219      *
000400110219      *  Program: MNU0070R
000500110219      *
000600110219      *  Description: Copy a menu from old menu system to new.
000700110219      *
000800110219      *  Programmer: Greg Cannella
000900110219      *
001000110219      *  Date:  2/19/10
001100110219      *
001200110219      ********************************************************************
001300110219      *                   Modification Log
001400110219      *
001500110219      *  Initials  Date      Description
001600110219      *-------------------------------------------------------------------
001700110219      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800110219      *
001900110219      *
002000110219      *
002100110219      ********************************************************************
002200110219      *                   Indicator Usage
002300110219      *
002400110219      *   Ind.   Description
002500110219      *-------------------------------------------------------------------
002600110219      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700110219      *
002800110219      *
002900110219      ********************************************************************
003000110219     fmnu0070d  cf   e             workstn
003100110219     fmsmnu     if   e           k disk
003200110219     fmnuhdrm   if a e           k disk
003300110219     fmnudtlm   o    e           k disk
003400110219     fmnuoptm   o    e           k disk
003500110219      *
003600110219     D                SDS
003700110219     D  DSPGMN           *PROC
003800110219     D  DSUSER               254    263
003900110219      *
004000110219      * Clear messages:
004100110219     c                   Call      'ERMSG2'
004200110219     c                   Parm                    DSPGMN
004300110219
004400110219     c                   Dow       *inlr = *off
004500110219
004600110219     c                   Write     msgctl1
004700110219     c                   ExFmt     scrnk01
004800110219      * Clear messages:
004900110219     c                   Call      'ERMSG2'
005000110219     c                   Parm                    DSPGMN
005100110219>>>>  * Process command keys:
005200110219     c                   Select
005300110219
005400110219     c                   When      *in03
005500110219     c                             or *in12
005600110219     c                   Eval      *inlr = *on
005700110219
005800110220     c                   Other
005900110219     c     wrmenu        chain     mnuhdrm
006000110219     c                   If        not %found
006100110219     c                   Exsr      $Enter
006200110219     c                   Endif
006300110219
006400110219     c                   EndSl
006500110219     c                   EndDo
006600110219      **************************************************************
006700110219     c     $Enter        Begsr
006800110219
006900110219     c     wrmenu        Setll     msmnu
007000110219     c     wrmenu        Reade     msmnu
007100110219     c                   If        not %eof
007200110219     c* Write header
007300110219     c                   Clear                   mnuhdrmr
007400110219     c                   Eval      mhmname = wrmenu
007500110219     c                   Eval      mhmdesc = mfdesc
007600110219     c                   Eval      mhludt = %int(%char(%date:*cymd0))
007700110219     c                   Time                    mhlutm
007800110219     c                   Movel     DSPGMN        mhlupg
007900110219     c                   Movel     DSUSER        mhluus
008000110219     c                   Write     mnuhdrmr
008100110219     c                   If        mfseq = -1
008200110219     c     wrmenu        Reade     msmnu
008300110219     c                   Endif
008400110219      * Build details of menu
008500110219     c                   Dow       not %eof
008600110219     c                   Clear                   mnudtlmr
008700110219     c                   Eval      mdmname = wrmenu
008800110219     c                   Eval      mdseq = mfseq
008900110219     c                   Eval      mdsel = mfsel
009000110219     c                   Eval      mdopt = %trim(%subst(mfmenu:1:6)) +
009100110219     c                               %trim(%char(mfseq))
009200110219     c                   Eval      mdludt = %int(%char(%date:*cymd0))
009300110219     c                   Time                    mdlutm
009400110219     c                   Movel     DSPGMN        mdlupg
009500110219     c                   Movel     DSUSER        mdluus
009600110219     c                   Write     mnudtlmr
009700110219      * Create the option
009800110219     c                   Clear                   mnuoptmr
009900110219     c                   Eval      moopt = mdopt
010000110219     c                   Eval      modesc = mfdesc
010100110219     c                   Eval      mocmd = %trim(mfcmd)
010200110219     c                   Eval      moprompt = 'N'
010300110219     c                   Eval      moseclvl = 1
010400110219     c                   Eval      moludt = %int(%char(%date:*cymd0))
010500110219     c                   Time                    molutm
010600110219     c                   Movel     DSPGMN        molupg
010700110219     c                   Movel     DSUSER        moluus
010800110219     c                   Write     mnuoptmr
010900110219
011000110219     c     wrmenu        Reade     msmnu
011100110219     c                   EndDo
011200110219     c                   Endif
011300110219     c                   Endsr
