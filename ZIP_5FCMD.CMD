000100000000/*    *==============================================================*/
000200000000/*    * Following options need to be specified during compile:       */
000300000000/*    * HLPPNLGRP(ZIP) HLPID(*CMD)                                   */
000400000000/*    *==============================================================*/
000500000000
000600000000             CMD        PROMPT('AS/400 JAR Utilities')
000700000000
000800000000             PARM       KWD(ACTIONS) TYPE(*NAME) LEN(10) RSTD(*YES) +
000900000000                          SPCVAL(('--extract') ('--create') +
001000000000                          ('--add') ('--delete')) MIN(1) MAX(1) +
001100000000                          EXPR(*YES) KEYPARM(*YES) PROMPT('Action')
001200000000
001300000000             PARM       KWD(JARFILE) TYPE(*PNAME) LEN(80) MIN(1) +
001400000000                          MAX(1) PROMPT('Jar File Name:')
001500000000
001600000000             PARM       KWD(FILE) TYPE(*PNAME) LEN(80) +
001700000000                          SPCVAL((*NONE)) MIN(0) MAX(1) EXPR(*YES) +
001800000000                          KEYPARM(*YES) PROMPT('File Name')
001900000000
002000000000             PARM       KWD(PATTERN) TYPE(*CHAR) LEN(80) +
002100000000                          SPCVAL((*NONE)) MIN(0) MAX(1) EXPR(*YES) +
002200000000                          KEYPARM(*YES) PROMPT('Pattern')
002300000000
002400000000             DEP        CTL(&FILE *EQ ' ') PARM((&PATTERN *NE ' ')) +
002500000000                          MSGID(CMD0002)
002600000000             DEP        CTL(&FILE *NE ' ') PARM((&PATTERN *EQ ' ')) +
002700000000                          MSGID(CMD0001)
002800000000             DEP        CTL(&PATTERN *EQ ' ') PARM((&FILE *NE ' ')) +
002900000000                          MSGID(CMD0002)
003000000000             DEP        CTL(&PATTERN *NE ' ') PARM((&FILE *EQ ' ')) +
003100000000                          MSGID(CMD0001)
