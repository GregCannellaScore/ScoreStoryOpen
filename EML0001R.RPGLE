000100000000      /copy qcpylesrc,stdhspec
000200000000     F*****************************************************************
000300000000      *
000400081118      *  Program....: EML0002R
000500000000      *
000600000000      *  Description: Build Header for CSV file
000700000000      *
000800170813      *  Programmer.: Greg Cannella
000900000000      *
001000170813      *  Date.......:
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
002900000000      ********************************************************************
003000000000     FHDRCSVW   IF   E           K DISK
003100000000     FEMLCSVW   O    E           K DISK
003200000000      //----------------------------------------------------------------
003300130402     D w#colhdg        S             60
003400000000     D SDS            sds
003500000000     DUser                   254    263
003600000000      //----------------------------------------------------------------
003700000000     C                   Read      HDRCSVW
003800000000
003900000000     C                   If        not %eof(HDRCSVW)
004000081117     C                   Exsr      $Header
004100081117
004200081117     C                   Clear                   EMLCSVR
004300130402     C                   Eval      w#colhdg = %trim(whchd1) + ' ' +
004400130402     C                                        %trim(whchd2) + ' ' +
004500130402     C                                        %trim(whchd3)
004600130402     C                   Eval      EMDATA = '"' + w#colhdg
004700000000     c                   Eval      EMDATA = %Trim(EMDATA) + '"'
004800000000     C                   EndIf
004900000000
005000000000     C                   Read      HDRCSVW
005100000000     C                   Dow       not %eof(HDRCSVW)
005200130402     C                   Eval      w#colhdg = %trim(whchd1) + ' ' +
005300130402     C                                        %trim(whchd2) + ' ' +
005400130402     C                                        %trim(whchd3)
005500130402     C                   Eval      EMDATA = %Trim(EMDATA) + '|"' + w#colhdg
005600000000     c                   Eval      EMDATA = %Trim(EMDATA) + '"'
005700000000     C                   Read      HDRCSVW
005800000000     C                   EndDo
005900000000
006000000000     C                   Write     EMLCSVR
006100000000
006200000000     C                   Eval      *inlr = *on
006300000000      //------------------------------------------------------------------
006400081117     C     $Header       BEGSR
006500081117      *
006600081117     C                   Eval      EMDATA = '"' + WHFILE
006700081201     C                   Eval      EMDATA = %Trim(EMDATA) + '"|"' + WHTEXT
006800081201     C                   Eval      EMDATA = %Trim(EMDATA) + '"|"' +
006900081118     C                             %subst(WHDTTM:4:2) + '/' +
007000081118     C                             %subst(WHDTTM:6:2) + '/' +
007100081118     C                             %subst(WHDTTM:2:2)
007200081201     C                   Eval      EMDATA = %Trim(EMDATA) + '"|"' +
007300081118     C                             %subst(WHDTTM:8:2) + ':' +
007400081118     C                             %subst(WHDTTM:10:2) + ':' +
007500081118     C                             %subst(WHDTTM:12:2) + '"'
007600081117     C                   Write     EMLCSVR
007700081117     C                   Clear                   EMLCSVR
007800081117     C                   Write     EMLCSVR
007900081117      *
008000081117     C     #Header       ENDSR
