000100000000      /copy qcpylesrc,stdhspec
000200000000     F*****************************************************************
000300000000      *
000400000000      *  Program....: EML0002R
000500000000      *
000600000000      *  Description: Build Data for CSV file
000700000000      *
000800171008      *  Programmer.: Greg Cannella
000900000000      *
001000000000      *  Date.......: 11/26/08
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
003000000000     FEMLCSVW   UF   E           K DISK
003100000000      //----------------------------------------------------------------
003200000000     D I               S              4S 0 INZ
003300150401     D MaxLength       S              4S 0 INZ
003400150401
003500150401     dScanDS           ds
003600150401     d EmData                      5000
003700150401     d EmArray                 1   5000    DIM(5000)
003800000000
003900000000     D SDS            sds
004000000000     DUser                   254    263
004100000000      //----------------------------------------------------------------
004200000000     C                   Read      EMLCSVW
004300000000     C                   Dow       not %eof(EMLCSVW)
004400000000
004500000000        // Replace all , with blanks...
004600000000
004700150429     c                   Eval      MaxLength = %len(%trimr(EMDATA))
004800150429     C                   For       I = 1 by 1 to MaxLength
004900150429     C****               If        %subst(Emdata:I:1) = ','
005000150429     C                   If        EmArray(I) = ','
005100000000     C                   Eval      Emdata =
005200000000     C                             %replace(' ':Emdata:%scan(',':Emdata:I):1)
005300000000     C                   EndIf
005400000000     C                   Endfor
005500000000
005600150401     C                   If              Emdata  <> ' '
005700000000     C                   Eval      Emdata = '='+ %trim(Emdata)
005800000000     C                   EndIf
005900000000
006000000000        // Replace all | delimiters with ,= ...
006100000000
006200150401     c                   Eval      MaxLength = %len(%trimr(EMDATA))
006300150401     C                   For       I = 1 by 1 to MaxLength
006400150401     C****               If        %subst(Emdata:I:1) = '|'
006500150401     C                   If        EmArray(I) = '|'
006600000000     C                   Eval      Emdata =
006700000000     C                             %replace(',=':Emdata:%scan('|':Emdata:I  ):1)
006800000000     C                   Eval      I = I + 1
006900150401     c                   Eval      MaxLength = MaxLength + 1
007000000000     C                   EndIf
007100000000     C                   Endfor
007200000000
007300000000     C                   Update    EMLCSVR
007400000000     C                   Read      EMLCSVW
007500000000     C                   EndDo
007600000000
007700000000     C                   Eval      *inlr = *on
007800000000       //-----------------------------------------------------------------
