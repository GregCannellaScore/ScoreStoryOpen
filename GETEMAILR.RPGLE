000100180225      /copy qcpylesrc,stdhspec
000200180225      ********************************************************************
000300180225      *
000400180225      *  Program: GETEMAILR
000500180225      *
000600180225      *  Description: Get an email address from the codes category.
000700180225      *
000800180225      *  Programmer: Greg Cannella
000900180225      *
001000180225      *  Date: 2/25/18
001100180225      *
001200180225      ********************************************************************
001300180225      *                   Modification Log
001400180225      *
001500180225      *  Initials  Date      Description
001600180225      *-------------------------------------------------------------------
001700180225      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800180225      *
001900180225      *
002000180225      *
002100180225      ********************************************************************
002200180225      *                   Indicator Usage
002300180225      *
002400180225      *   Ind.   Description
002500180225      *-------------------------------------------------------------------
002600180225      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700180225      *
002800180225      *
002900180225      ********************************************************************
003000180225     fcodecat   if   e           k disk
003100180225      *
003200180225     d                SDS
003300180225     d  DSPGMN           *PROC
003400180225     d  DSUSER               254    263
003500180225      *
003600180225     c     *entry        Plist
003700180225     c                   Parm                    pmemail          52
003800180225      *
003900180225     c     ckey          Klist
004000180225     c                   Kfld                    cccatc
004100180225     c                   Kfld                    cccatk
004200180225      * Set return value to blanks
004300180225     c                   Eval      Pmemail = *blanks
004400180225      * Set key values
004500180225     c                   Eval      cccatc = 'EMAILADD'
004600180225     c                   Eval      cccatk = dsuser
004700180225      * Check for record
004800180225     c     ckey          chain     codecat
004900180225     c                   If        %found
005000180225     c                   Eval      pmemail = CCCATD
005100180225     c                   Endif
005200180225      *
005300180225     c                   Eval      *inlr = *on
