000100171021      /copy qcpylesrc,stdhspec
000200171021      ********************************************************************
000300171021      *
000400171021      *  Program: MNU0100R
000500171021      *
000600171021      *  Description: Setup yourself as admin for menu
000700171021      *
000800171021      *  Programmer: Greg Cannella
000900171021      *
001000171021      *  Date: 10/21/17
001100171021      *
001200171021      ********************************************************************
001300171021      *                   Modification Log
001400171021      *
001500171021      *  Initials  Date      Description
001600171021      *-------------------------------------------------------------------
001700171021      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800171021      *
001900171021      *
002000171021      *
002100171021      ********************************************************************
002200171021      *                   Indicator Usage
002300171021      *
002400171021      *   Ind.   Description
002500171021      *-------------------------------------------------------------------
002600171021      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700171021      *
002800171021      *
002900171021      ********************************************************************
003000171021     fmnuusrm   if a e           k disk
003100171021     fmnuhdrm   if   e           k disk
003200171021     fmnumovm   if a e           k disk
003300171021     fpgmsec    if a e           k disk
003400171021     fcodecat   if a e           k disk
003500171021     d                SDS
003600171021     d  DSPGMN           *PROC
003700171021     d  DSJOB                244    253
003800171021     d  DSUSER               254    263
003900171021     c                   read      mnuusrm
004000181023     c****               If        not %eof
004100181023     c****               Eval      *inlr = *on
004200181023     c****               Return
004300181023     c****               Endif
004400171021      * Add user record
004500171021     c                   Eval      muuser = dsuser
004600171021     c                   Eval      muimenu = 'PGMR'
004700171021     c                   Eval      museclvl = 9
004800171021>>>> c                   Eval      muludt = %int(%char(%date:*cymd0))
004900171021>>>> c                   TIME                    mulutm
005000171021>>>> c                   MOVEL     DSPGMN        mulupg
005100171021>>>> c                   MOVEL     DSUSER        muluus
005200171021     c                   Write     mnuusrmr
005300171021      * Add menu security records
005400171021     c                   Read      mnuhdrm
005500171021     c                   Dow       not %eof
005600171021     c                   Eval      mmopt  = mhmname
005700171021     c                   Eval      mmuser = dsuser
005800171021>>>> c                   Eval      mmludt = %int(%char(%date:*cymd0))
005900171021>>>> c                   TIME                    mmlutm
006000171021>>>> c                   MOVEL     DSUSER        mmluus
006100171021>>>> c                   MOVEL     DSPGMN        mmlupg
006200171021     c                   Write     mnumovmr                             99
006300171021     c                   Read      mnuhdrm
006400171021     c                   Enddo
006500171021      * Add program security
006600171021     c                   Eval      psuser = dsuser
006700171021     c                   Eval      pspgm  = 'CAT0020R'
006800171021     c                   Eval      psopt1 = '1'
006900171021     c                   Eval      psopt2 = '1'
007000171021     c                   Eval      psopt3 = '1'
007100171021     c                   Eval      psopt4 = '1'
007200171021     c                   Eval      psopt5 = '1'
007300171021>>>> c                   Eval      psldte = %int(%char(%date:*cymd0))
007400171021>>>> c                   TIME                    psltim
007500171021>>>> c                   MOVEL     DSUSER        pslusr
007600171021>>>> c                   MOVEL     DSPGMN        pslpgm
007700171021     c                   Write     @pgmsec                              99
007800171021      *
007900171021     c                   Eval      pspgm  = 'CAT0100R'
008000171021     c                   Write     @pgmsec                              99
008100171021     c                   Eval      pspgm  = 'CAT0110R'
008200171021     c                   Write     @pgmsec                              99
008300171021     c                   Eval      pspgm  = 'MNU0010R'
008400171021     c                   Write     @pgmsec                              99
008500171021     c                   Eval      pspgm  = 'MNU0020R'
008600171021     c                   Write     @pgmsec                              99
008700171021     c                   Eval      pspgm  = 'MNU0040R'
008800171021     c                   Write     @pgmsec                              99
008900171021     c                   Eval      pspgm  = 'SEC0001R'
009000171021     c                   Write     @pgmsec                              99
009100171021     c                   Eval      psopt5 = '0'
009200171021     c                   Eval      pspgm  = 'SEC0110R'
009300171021     c                   Write     @pgmsec                              99
009400171021      * Add code category users
009500171021     c                   Eval      cccatc = 'JMAUTMNT'
009600171021     c                   Eval      cccatk = dsuser
009700171021>>>> c                   Eval      ccldte = %int(%char(%date:*cymd0))
009800171021>>>> c                   TIME                    ccltim
009900171021>>>> c                   MOVEL     DSUSER        cclusr
010000171021>>>> c                   MOVEL     DSPGMN        cclpgm
010100171021     c                   Write     @codecat                             99
010200171021      *
010300171021     c                   Eval      *inlr = *on
