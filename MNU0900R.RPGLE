000100140914      /copy qcpylesrc,stdhspec
000200140914      ********************************************************************
000300140914      *
000400140914      *  Program: MNU0900R
000500140914      *
000600140914      *  Description: Copy all menu options to the new names
000700140914      *
000800140914      *  Programmer: Greg Cannella
000900140914      *
001000140914      *  Date: 9/14/14
001100140914      *
001200140914      ********************************************************************
001300140914      *                   Modification Log
001400140914      *
001500140914      *  Initials  Date      Description
001600140914      *-------------------------------------------------------------------
001700140914      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800140914      *
001900140914      *
002000140914      *
002100140914      ********************************************************************
002200140914     fmenuopt   if   e             disk    rename(menuopt:in)
002300140914     fmnuoptm   if a e           k disk
002400140914     c                   Read      menuopt
002500140914     c                   Dow       not %eof
002600140914     c                   if        f2 <> *blanks
002700140914     c     f2            Chain     mnuoptm
002800140914     c                   If        not %found
002900140914     c                   Eval      moopt = f1
003000140914     c     moopt         Chain     mnuoptm
003100140914     c                   If        %found
003200140914     c                   Eval      moopt = f2
003300140914     c                   Write     mnuoptmr
003400140914     c                   Endif
003500140914     c                   Endif
003600140914     c                   Endif
003700140914     c                   Read      menuopt
003800140914     c                   Enddo
003900140914      *
004000140914     c                   Eval      *inlr = *on
