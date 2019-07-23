000100091204      /copy qcpylesrc,stdhspec
000200091204      ********************************************************************
000300091204      *
000400091204      *  Program: CAT0002R
000500091204      *
000600091204      *  Description: Does a record exist in a codes category?
000700091204      *
000800091204      *  Programmer: Greg Cannella
000900091204      *
001000091204      *  Date: 12/4/09
001100091204      *
001200091204      ********************************************************************
001300091204      *                   Modification Log
001400091204      *
001500091204      *  Initials  Date      Description
001600091204      *-------------------------------------------------------------------
001700091204      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800091204      *
001900091204      *
002000091204      *
002100091204      ********************************************************************
002200091204      *                   Indicator Usage
002300091204      *
002400091204      *   Ind.   Description
002500091204      *-------------------------------------------------------------------
002600091204      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700091204      *
002800091204      *
002900091204      ********************************************************************
003000091204     fcodecat   if   e           k disk
003100091204     c     *entry        Plist
003200091204     c                   Parm                    pccatc           10
003300091204     c                   Parm                    pccatk           20
003301091206     c                   Parm                    Return            1
003400091204      *
003500091206     c     ckey          Klist
003600091206     c                   Kfld                    cccatc
003700091206     c                   Kfld                    cccatk
003701091206      * Set return value to blanks
003702091206     c                   Eval      Return = *blanks
003800091206      * Set key values
003900091206     c                   Eval      cccatc = pccatc
004000091206     c                   Eval      cccatk = pccatk
004100091206      * Check for record
004200091206     c     ckey          chain     codecat
004300091206     c                   If        %found
004400091206     c                   Eval      Return = 'R'
004500091206     c                   Endif
004600091206      *
004700091206     c                   Eval      *inlr = *on
