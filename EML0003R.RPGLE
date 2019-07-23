000100090909      /copy qcpylesrc,stdhspec
000200090909      ********************************************************************
000300090909      *
000400090909      *  Program: EML0003R
000500090909      *
000600090909      *  Description: Write a log record to EMLLOGM
000700090909      *
000800090909      *  Programmer: Greg Cannella
000900090909      *
001000090909      *  Date: 9/9/09
001100090909      *
001200090909      ********************************************************************
001300090909      *                   Modification Log
001400090909      *
001500090909      *  Initials  Date      Description
001600090909      *-------------------------------------------------------------------
001700090909      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800090909      *
001900090909      *
002000090909      *
002100090909      ********************************************************************
002200090909      *                   Indicator Usage
002300090909      *
002400090909      *   Ind.   Description
002500090909      *-------------------------------------------------------------------
002600090909      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700090909      *
002800090909      *
002900090909      ********************************************************************
003000090909     femllogm   o    e             disk
003001090909      *
003002090909     d                sds
003003090909     d  dspgmn           *proc
003004090909     d  dsuser               254    263
003005090909      *
003100090909     c     *entry        Plist
003200090909     c                   Parm                    PMFileName       10
003300090909     c                   Parm                    PMEmail          52
003400090909     c                   Parm                    PMMsgBody       256
003500090909      *
003600090909     c                   Eval      Exfile = PMFileName
003700090909     c                   Eval      Exemad = PMEmail
003800090909     c                   Eval      Exbody = PMMsgBody
003801090909>>>> c                   Eval      Exldte = %int(%char(%date:*cymd0))
003802090909>>>> c                   Time                    exltim
003803090909>>>> c                   Movel     dspgmn        exlpgm
003804090909>>>> c                   Movel     dsuser        exlusr
003900090909      *
004000090909     c                   Write     EMLLOGMR
004100090909      *
004200090909     c                   Eval      *inlr = *on
