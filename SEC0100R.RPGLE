000100080130      /copy qcpylesrc,stdhspec
000200080114      ********************************************************************
000300080114      *
000400080303      *  Program: SEC0100R
000500080114      *
000600080303      *  Description: Security Retrival Program
000700080114      *
000800080303      *  Programmer: Greg Cannella
000900080114      *
001000171001      *  Date: 10/1/17
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
002900080114      ********************************************************************
003000080303     fpgmsec    if   e           k Disk
003100080303
003200080303     d pmpgm           s             10a
003300080303     d pmgrp           s             10a
003400080303     d pmsec           s              5a
003500080303
003600080303      * Program System Data Structure
003700080303     d                SDS
003800080303     d  dspgmn           *PROC
003900080303     d  dsuser               254    263
004000080303
004100080303      * Check for individual access
004200080324     c                   Eval      psUser = dsuser
004300080303     c                   Eval      psPgm = pmPgm
004400100210     c                   Eval      pmSec = '99999'
004500080303     c     psKey         chain     pgmsec                             90
004600080303     c                   If        *in90 = *off
004700080303     c                   Eval      pmSec=psOpt1+psOpt2+psopt3+psopt4+psopt5
004800080303     c                   Else
004900080303      * If no individual access is found, check for group access.
005000171021     c                   Call      'DSH0117C'
005100171001     c                   Parm                    psUser
005200171021     c                   Parm                    pmGrp
005300171021     c                   Eval      psUser = pmGrp
005400080303     c     psKey         chain     pgmsec                             90
005500080303     c                   If        *in90 = *off
005600080303     c                   Eval      pmSec=psOpt1+psOpt2+psopt3+psopt4+psopt5
005700080303     c                   Endif
005800080303     c                   Endif
005900080303      * Return values
006000080303     c                   Eval      *inlr = *on
006100080303
006200080303      *****************************************************************
006300080303     c     *inzsr        Begsr
006400080303
006500080303     c     *entry        Plist
006600080303     c                   Parm                    pmpgm
006700080303     c                   Parm                    pmsec
006800080303
006900080303     c     psKey         Klist
007000080303     c                   Kfld                    psUser
007100080303     c                   Kfld                    psPgm
007200080303
007300080303     c                   Endsr
