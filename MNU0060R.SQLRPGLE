000100101230      /COPY QCPYLESRC,stdhspec
000200101230      ********************************************************************
000300101230      *
000400101230      *  Program: MNU0060R
000500101230      *
000600101230      *  Description: Search the text and command for search text.
000700101230      *
000800101230      *  Programmer: Greg Cannella
000900101230      *
001000101230      *  Date: 12/30/10
001100101230      *
001200101230      ********************************************************************
001300101230      *                   Modification Log
001400101230      *
001500101230      *  Initials  Date      Description
001600101230      *-------------------------------------------------------------------
001700101230      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800101230      *
001900101230      *
002000101230      *
002100101230      ********************************************************************
002200101230      *                   Indicator Usage
002300101230      *
002400101230      *   Ind.   Description
002500101230      *-------------------------------------------------------------------
002600101230      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700101230      *
002800101230      *
002900101230      ********************************************************************
003000101230>>>> fmnu0060d  cf   e             workstn
003100101230     f                                     sfile(SCRNS01:RRN1)
003200101230     f                                     infds(INFDS)
003300101230     fmnudtll2  if   e           k disk
003400101230
003500101230     d SQL             S            200
003600101230     d DSmnuoptm     E DS                  extname(mnuoptm)
003700101230     d RRN1            S                   like(HDSFLP)
003800101230     d Blanks          c                   const(' ')
003900101230     d atr             S             10
004000101230     d lused           S              7
004100101230     d Search1         S             20
004200101230     d Search2         S             64
004300101230     d Search3         S            320
004400101230     d Percents        s            159
004500101230     d FoundOnMenu     s              1
004600101230
004700101230     d INFDS           DS
004800101230     d  CSRLOC               370    371B 0
004900101230     d  SFLLOC               378    379B 0
005000101230
005100101230     d                SDS
005200101230     d  DSPGMN           *PROC
005300101230     d  DSUSER               254    263
005400101230
005500101230     c                   DoW       *inlr = *off
005600101230      * Write screen
005700101230     c                   Write     scrnk01
005800101230     c                   Write     msgctl1
005900101230     c                   ExFmt     scrnc01
006000101230     c                   Move      SFLLOC        HDSFLP
006100101230      * Clear messages:
006200101230     c                   Call      'ERMSG2'
006300101230     c                   Parm                    DSPGMN
006400101230>>>>  * Process command keys:
006500101230     c                   Select
006600101230
006700101230     c                   When      *in03
006800101230     c                             or *in12
006900101230     c                   Eval      *inlr = *on
007000101230
007100101230     c                   When      *in60
007200101230     c                   Exsr      $Fill
007300101230
007400101230     c                   EndSl
007500101230     c                   EndDo
007600101230      *****************************************************************
007700101230      * Fill Subfile
007800101230     c     $Fill         Begsr
007900101230
008000101230     c                   Exsr      $ClrSfl
008100101230     c
008200101230     c                   Eval      SQL = 'SELECT * FROM MNUOPTM +
008300110624     c                                    WHERE (UPPER(MOOPT) LIKE ?  +
008400110624     c                                    OR    UPPER(MODESC) LIKE ? +
008500110624     c                                    OR    UPPER(MOCMD) LIKE ? ) +
008600101230     c                                    ORDER BY MOOPT'
008700101230
008800101230     c                   Eval      Search1='%%%%%%%%%' +
008900101230     c                             %trim(wcsearch) +
009000101230     c                             '%%%%%%%%%'
009100101230     c                   Eval      Search2='%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' +
009200101230     c                             %trim(wcsearch) +
009300101230     c                             '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
009400101230     c                   Eval      Percents = '%%%%%%%%%%%%%%%%%%%%' +
009500101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
009600101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
009700101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
009800101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
009900101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
010000101230     c                             '%%%%%%%%%%%%%%%%%%%%' +
010100101230     c                             '%%%%%%%%%%%%%%%%%%%'
010200101230     c                   Eval      Search3=Percents +
010300101230     c                             %trim(wcsearch) +
010400101230     c                             Percents
010500101230     c/EXEC SQL
010600101230     c+ PREPARE HHANDLE from :SQL
010700101230     c/END-EXEC
010800101230
010900101230     c/EXEC SQL
011000101230     c+ DECLARE MNUSearch CURSOR FOR HHANDLE
011100101230     c/END-EXEC
011200101230     c/EXEC SQL
011300101230     c+ Open MNUSearch USING :search1,:search2,:search3
011400101230     c/END-EXEC
011500101230     c/EXEC SQL
011600101230     c+ FETCH Next From MNUSearch into :DSmnuoptm
011700101230     c/END-EXEC
011800101230     c                   DoW       SQLCOD = 0
011900101230      * Load subfile fields
012000101230     c                   Eval      wsopt = moopt
012100101230     c                   Eval      wsdesc = modesc
012200101230     c                   Eval      FoundOnMenu = 'N'
012300101230     c     moopt         Setll     mnudtll2
012400101230     c     moopt         Reade     mnudtll2
012500101230     c                   Dow       not %eof
012600101230     c                   Eval      FoundOnMenu = 'Y'
012700101230     c                   Eval      wsmname = mdmname
012800101230     c                   Eval      wssel = mdsel
012900101230     c                   Eval      RRN1 = RRN1 +1
013000101230     c                   Write     SCRNS01
013100101230     c                   Move      *on           *in32
013200101230     c     moopt         Reade     mnudtll2
013300101230     c                   Enddo
013400101230     c                   If        FoundOnMenu = 'N'
013500101230     c                   Eval      wsmname = *blanks
013600101230     c                   Eval      wssel = *blanks
013700101230     c                   Eval      RRN1 = RRN1 +1
013800101230     c                   Write     SCRNS01
013900101230     c                   Move      *on           *in32
014000101230     c                   Endif
014100101230
014200101230     c/EXEC SQL
014300101230     c+ FETCH Next From MNUSearch into :DSmnuoptm
014400101230     c/END-EXEC
014500101230     c                   EndDo
014600101230     c/EXEC SQL
014700101230     c+ CLOSE MNUSearch
014800101230     c/END-EXEC
014900101230     C                   Eval      HDSFLP = 1
015000101230     c                   Endsr
015100101230      *****************************************************************
015200101230      * Clear subfile:
015300101230     c     $ClrSfl       BegSr
015400101230
015500101230     c                   Clear                   RRN1
015600101230
015700101230     ** Clear subfile:
015800101230     c                   If        *in32
015900101230     c                   Move      *off          *in32
016000101230     c                   Move      *on           *in30
016100101230     c                   Write     SCRNC01
016200101230     c                   Move      *off          *in30
016300101230     c                   EndIf
016400101230
016500101230     c                   EndSr
016600101230      *****************************************************************
016700101230     c     *Inzsr        BegSr
016800101230
016900101230     ** Message file parm list:
017000101230     c     MSGP01        PList
017100101230     c                   Parm                    WWMSGI            7
017200101230
017300101230     c                   Eval      *in34 = *on
017400101230     c                   Eval      *in40 = *on
017500101230
017600101230     c                   EndSr
