000100081124             CMD        /* CMD SOURCE FOR DOWNLOAD A FILE +
000101081124                          Parameters Enter +
000102081124                          file name and email address(optional) */
000103081124
000301081124             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) MIN(1) +
000302081124                          EXPR(*NO) PROMPT('File Name:')
000400150304             PARM       KWD(EMAIL1) TYPE(*CHAR) LEN(52) MIN(0) +
000500081124                          EXPR(*NO) PROMPT('Email Address:')
000501150304             PARM       KWD(EMAIL2) TYPE(*CHAR) LEN(52) MIN(0) +
000502150304                          EXPR(*NO) PROMPT('Email Address:')
000503150304             PARM       KWD(EMAIL3) TYPE(*CHAR) LEN(52) MIN(0) +
000504150304                          EXPR(*NO) PROMPT('Email Address:')
000505150304             PARM       KWD(EMAIL4) TYPE(*CHAR) LEN(52) MIN(0) +
000506150304                          EXPR(*NO) PROMPT('Email Address:')
000507150304             PARM       KWD(EMAIL5) TYPE(*CHAR) LEN(52) MIN(0) +
000508150304                          EXPR(*NO) PROMPT('Email Address:')
000509150306             PARM       KWD(EMAIL6) TYPE(*CHAR) LEN(52) MIN(0) +
000510150306                          EXPR(*NO) PROMPT('Email Address:')
000511150306             PARM       KWD(EMAIL7) TYPE(*CHAR) LEN(52) MIN(0) +
000512150306                          EXPR(*NO) PROMPT('Email Address:')
000513150306             PARM       KWD(EMAIL8) TYPE(*CHAR) LEN(52) MIN(0) +
000514150306                          EXPR(*NO) PROMPT('Email Address:')
000515150306             PARM       KWD(EMAIL9) TYPE(*CHAR) LEN(52) MIN(0) +
000516150306                          EXPR(*NO) PROMPT('Email Address:')
000517150306             PARM       KWD(EMAIL10) TYPE(*CHAR) LEN(52) MIN(0) +
000518150306                          EXPR(*NO) PROMPT('Email Address:')
000519150306             PARM       KWD(EMAIL11) TYPE(*CHAR) LEN(52) MIN(0) +
000520150306                          EXPR(*NO) PROMPT('Email Address:')
000521150306             PARM       KWD(EMAIL12) TYPE(*CHAR) LEN(52) MIN(0) +
000522150306                          EXPR(*NO) PROMPT('Email Address:')
000523150306             PARM       KWD(EMAIL13) TYPE(*CHAR) LEN(52) MIN(0) +
000524150306                          EXPR(*NO) PROMPT('Email Address:')
000525150306             PARM       KWD(EMAIL14) TYPE(*CHAR) LEN(52) MIN(0) +
000526150306                          EXPR(*NO) PROMPT('Email Address:')
000527150306             PARM       KWD(EMAIL15) TYPE(*CHAR) LEN(52) MIN(0) +
000528150306                          EXPR(*NO) PROMPT('Email Address:')
000529150306             PARM       KWD(EMAIL16) TYPE(*CHAR) LEN(52) MIN(0) +
000530150306                          EXPR(*NO) PROMPT('Email Address:')
000531150306             PARM       KWD(EMAIL17) TYPE(*CHAR) LEN(52) MIN(0) +
000532150306                          EXPR(*NO) PROMPT('Email Address:')
000533150306             PARM       KWD(EMAIL18) TYPE(*CHAR) LEN(52) MIN(0) +
000534150306                          EXPR(*NO) PROMPT('Email Address:')
000535150306             PARM       KWD(EMAIL19) TYPE(*CHAR) LEN(52) MIN(0) +
000536150306                          EXPR(*NO) PROMPT('Email Address:')
000537150306             PARM       KWD(EMAIL20) TYPE(*CHAR) LEN(52) MIN(0) +
000538150306                          EXPR(*NO) PROMPT('Email Address:')
000600090121             PARM       KWD(MSGBODY) TYPE(*CHAR) LEN(256) MIN(0) +
000700090121                          EXPR(*NO) PROMPT('Email Message:')
000800120504             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(40) MIN(0) +
000900120504                          EXPR(*NO) PROMPT('Subject:')
