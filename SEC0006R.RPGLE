000100000000      /copy qcpylesrc,stdhspec
000200000000      ********************************************************************
000300000000      *
000400000000      *  Program....: SEC0005R
000500000000      *
000600000000      *  Description: Security Retrival Program
000700000000      *
000800000000      *  Programmer.: Greg Cannella
000900000000      *
001000000000      *  Date.......: 09/10/14
001100000000      *
001200000000      ********************************************************************
001300000000      *                   Modification Log
001400000000      *
001500000000      *  Initials  Date      Description
001600000000      *-------------------------------------------------------------------
001700000000      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800000000      *
001900000000      *
002000000000      *
002100000000      ********************************************************************
002200000000      *                   Indicator Usage
002300000000      *
002400000000      *   Ind.   Description
002500000000      *-------------------------------------------------------------------
002600000000      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700000000      *
002800000000      *
002900000000      *-------------------------------------------------------------------
003000000000     fSecDtlm   if   e           k Disk
003100000000     fUsefile   if   e           k Disk
003200000000      //------------------------------------------------------------------
003300000000     d P#Pgm           s             10a
003400000000     d P#Seq           s              3a
003500000000     d P#Access        s              1a
003600000000     d W#User          s             10a
003700000000     d P#User          s             10a
003800000000
003900000000      * Program System Data Structure
004000000000     d                SDS
004100000000     d  dspgmn           *PROC
004200000000     d  dsuser               254    263
004300000000      //------------------------------------------------------------------
004400000000     c                   Eval      W#User = P#User
004500000000     c                   Eval      P#Access = 'N'
004600000000
004700000000      * Check for individual access...
004800000000     c     DtlKey        Chain     SecDtlm
004900000000     c                   If        %found(SecDtlm)
005000000000     c                   Eval      P#Access = 'Y'
005100000000     c                   Else
005200000000
005300000000      * If no individual access is found, check for group access...
005400000000     c     P#User        Chain     Usefile
005500000000     c                   If        %found(Usefile)
005600000000     c                   Eval      W#User = upgrpf
005700000000     c     DtlKey        Chain     SecDtlm
005800000000     c                   If        %found(SecDtlm)
005900000000     c                   Eval      P#Access = 'Y'
006000000000     c                   Endif
006100000000     c                   Endif
006200000000
006300000000     c                   Endif
006400000000      * Return values
006500000000     c                   Eval      *inlr = *on
006600000000      //------------------------------------------------------------------
006700000000     c     *inzsr        Begsr
006800000000
006900000000     c     *entry        Plist
007000000000     c                   Parm                    P#Pgm
007100000000     c                   Parm                    P#Seq
007200000000     c                   Parm                    P#User
007300000000     c                   Parm                    P#Access
007400000000
007500000000     c     DtlKey        Klist
007600000000     c                   Kfld                    P#Pgm
007700000000     c                   Kfld                    P#Seq
007800000000     c                   Kfld                    W#User
007900000000
008000000000     c                   Endsr
