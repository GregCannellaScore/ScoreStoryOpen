000100081124             CMD        /* CMD SOURCE FOR DOWNLOAD A FILE +
000101081124                          Parameters Enter +
000102081124                          file name and email address(optional) */
000103081124
000301081124             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) MIN(1) +
000302081124                          EXPR(*NO) PROMPT('File Name:')
000400081124             PARM       KWD(EMAIL) TYPE(*CHAR) LEN(52) MIN(0) +
000500081124                          EXPR(*NO) PROMPT('Email Address:')
000600090121             PARM       KWD(MSGBODY) TYPE(*CHAR) LEN(256) MIN(0) +
000700090121                          EXPR(*NO) PROMPT('Email Message:')
000800120504             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(40) MIN(0) +
000900120504                          EXPR(*NO) PROMPT('Subject:')
