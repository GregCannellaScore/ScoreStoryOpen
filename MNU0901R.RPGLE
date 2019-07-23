000100140914      /copy qcpylesrc,stdhspec
000200140914      ********************************************************************
000300140914      *
000400140914      *  Program: MNU0901R
000500140914      *
000600140914      *  Description: Change all menu options to the new compressed options
000700140914      *
000800140914      *  Programmer: Greg Cannella
000900140914      *
001000140914      *  Date: 9/14/14
001100140914      *          `
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
002200140914     fmnudtlm   uf   e             disk
002300140914     fmenuoptl  if   e           k disk
002400140914     c                   read      mnudtlm
002500140914     c                   Dow       not %eof
002600140914     c                   Eval      f1 = mdopt
002700140914     c     f1            Chain     menuoptl
002800140914     c                   If        %found and F2 <> *blanks
002900140914     c                   Eval      mdopt = f2
003000140914     c                   Update    mnudtlmr
003100140914     c                   Endif
003200140914     c                   read      mnudtlm
003300140914     c                   Enddo
003400140914      *
003500140914     c                   Eval      *inlr = *on
