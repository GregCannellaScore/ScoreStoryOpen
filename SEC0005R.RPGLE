000100080130      /copy qcpylesrc,stdhspec
000200080114      ********************************************************************
000300080114      *
000400090310      *  Program....: SEC0005R
000500080114      *
000600080303      *  Description: Security Retrival Program
000700080114      *
000800141130      *  Programmer.: Greg Cannella
000900080114      *
001000141130      *  Date.......: 11/30/14
001100080114      *
001200080114      ********************************************************************
001300080114      *                   Modification Log
001400080114      *
001500080114      *  Initials  Date      Description
001600080114      *-------------------------------------------------------------------
001700080114      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800080114      *
001900080114      *
002000080114      *
002100080114      ********************************************************************
002200080114      *                   Indicator Usage
002300080114      *
002400080114      *   Ind.   Description
002500080114      *-------------------------------------------------------------------
002600080114      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700080114      *
002800080114      *
002900090310      *-------------------------------------------------------------------
003000090310     fSecDtlm   if   e           k Disk
003100090311      //------------------------------------------------------------------
003200090310     d P#Pgm           s             10a
003300090310     d P#Seq           s              3a
003400090310     d P#Access        s              1a
003500090310     d W#User          s             10a
003600171001     d W#Group         s             10a
003700080303
003800080303      * Program System Data Structure
003900080303     d                SDS
004000080303     d  dspgmn           *PROC
004100080303     d  dsuser               254    263
004200090311      //------------------------------------------------------------------
004300090310     c                   Eval      W#User = dsuser
004400090317     c                   Eval      P#Access = 'N'
004500080303
004600090311      * Check for individual access...
004700090310     c     DtlKey        Chain     SecDtlm
004800090310     c                   If        %found(SecDtlm)
004900090310     c                   Eval      P#Access = 'Y'
005000080303     c                   Else
005100090310
005200090311      * If no individual access is found, check for group access...
005300171001     c                   Call      'DSH0117C'
005400171001     c                   Parm                    W#User
005500171001     c                   Parm                    W#Group
005600171001     c                   Eval      W#User = W#Group
005700090310     c     DtlKey        Chain     SecDtlm
005800090310     c                   If        %found(SecDtlm)
005900090310     c                   Eval      P#Access = 'Y'
006000080303     c                   Endif
006100090310
006200080303     c                   Endif
006300080303      * Return values
006400080303     c                   Eval      *inlr = *on
006500090311      //------------------------------------------------------------------
006600080303     c     *inzsr        Begsr
006700080303
006800080303     c     *entry        Plist
006900090310     c                   Parm                    P#Pgm
007000090310     c                   Parm                    P#Seq
007100090311     c                   Parm                    P#Access
007200080303
007300090310     c     DtlKey        Klist
007400090310     c                   Kfld                    P#Pgm
007500090310     c                   Kfld                    P#Seq
007600090310     c                   Kfld                    W#User
007700080303
007800080303     c                   Endsr
