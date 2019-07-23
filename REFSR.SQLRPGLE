000100171008      /COPY jerrysrc/QCPYLESRC,stdhspec
000200080122      ********************************************************************
000300080122      *
000400080122      *  Program: REFSR
000500080122      *
000600080122      *  Description: Display a list of all reference of a collection of
000700080122      *               items.
000800080122      *
000900080122      *  Programmer: Greg Cannella
001000080122      *
001100080122      *  Date: 1/22/08
001200080122      *
001300080122      ********************************************************************
001400080122      *                   Modification Log
001500080122      *
001600080122      *  Initials  Date      Description
001700080122      *-------------------------------------------------------------------
001800080122      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001900080122      *
002000080122      *
002100080122      *
002200080122      ********************************************************************
002300080122      *                   Indicator Usage
002400080122      *
002500080122      *   Ind.   Description
002600080122      *-------------------------------------------------------------------
002700080122      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002800080122      *
002900080122      *
003000080122      ********************************************************************
003100000000     H DATFMT(*ISO)
003200000000>>>> fRefsD     cf   e             workstn
003300000000     f                                     sfile(SCRNS01:RRN1)
003400000000     f                                     infds(INFDS)
003500000000
003600000000     d SQL             S            200
003700000000     d DSDSPPGMREF   E DS                  extname(DSPPGMREF)
003800000000     d RRN1            S                   like(HDSFLP)
003900000000     d Blanks          c                   const(' ')
004000090316     d atr             S             10
004100090316     d lused           S              7
004200000000
004300000000     d INFDS           DS
004400000000     d  CSRLOC               370    371B 0
004500000000     d  SFLLOC               378    379B 0
004600000000
004700000000     ** GEN8011C parm to hold message data:
004800000000     d DSMDTA          S            500
004900000000
005000000000     d                SDS
005100000000     d  DSPGMN           *PROC
005200000000     d  DSUSER               254    263
005300000000
005400000000     c                   DoW       *inlr = *off
005500000000      * Write screen
005600000000     c                   Write     scrnk01
005700000000     c                   Write     msgctl1
005800000000     c                   ExFmt     scrnc01
005900000000     c                   Move      SFLLOC        HDSFLP
006000000000      * Clear messages:
006100080122     c                   Call      'ERMSG2'
006200080122     c                   Parm                    DSPGMN
006300000000>>>>  * Process command keys:
006400000000     c                   Select
006500000000
006600000000     c                   When      *in03
006700000000     c                   Eval      *inlr = *on
006800000000
006900090316     ** F11 = Alternate View
007000090316     c                   When      *in11
007100090316     c                   ExSr      $AltView
007200000000     ** F21 = Print Report
007300000000     c                   When      *in21
007400000000     c                   ExSr      $PrintRpt
007500000000
007600000000     c                   When      *in60
007700000000     c                   Exsr      $Fill
007800000000
007900000000     c                   EndSl
008000000000     c                   EndDo
008100000000      *****************************************************************
008200000000      * Fill Subfile
008300000000     c     $Fill         Begsr
008400000000
008500000000     c                   Exsr      $ClrSfl
008600000000     c
008700000000     c                   Eval      SQL = 'SELECT * FROM DSPPGMREF +
008800000000     c                                    WHERE (WHFNAM LIKE ? +
008900000000     c                                    OR    WHFNAM LIKE ? +
009000000000     c                                    OR    WHFNAM LIKE ? +
009100000000     c                                    OR    WHFNAM LIKE ? +
009200000000     c                                    OR    WHFNAM LIKE ? ) +
009300000000     c                                    AND   WHFNAM <> '' '' +
009400000000     c                                    ORDER BY WHLIB, WHPNAM'
009500000000     c/EXEC SQL
009600000000     c+ PREPARE HHANDLE from :SQL
009700000000     c/END-EXEC
009800000000
009900000000     c/EXEC SQL
010000000000     c+ DECLARE RefFile CURSOR FOR HHANDLE
010100000000     c/END-EXEC
010200000000     c/EXEC SQL
010300000000     c+ Open RefFile USING :wcobj,:wcobj2,:wcobj3,:wcobj4,:wcobj5
010400000000     c/END-EXEC
010500000000     c/EXEC SQL
010600000000     c+ FETCH Next From RefFile into :DSDSPPGMREF
010700000000     c/END-EXEC
010800000000     c                   DoW       SQLCOD = 0
010900090316     c                   Call      'RTV0001C'
011000090316     c                   Parm                    whpnam
011100090316     c                   Parm                    whlib
011200090316     c                   Parm                    atr
011300090316     c                   Parm                    lused
011400090316     c                   If        WCDFU = 'Y'
011500090316     c                             and atr = 'DFU'
011600090316     c                             or  WCDFU <> 'Y'
011700000000      * Load subfile fields
011800000000     c                   Eval      RRN1 = RRN1 +1
011900000000     c                   MoveL     WHLIB         WSLIB
012000000000     c                   MoveL     WHPNAM        WSPGM
012100000000     c                   MoveL     WHFUSG        WSFILEUSG
012200000000     c                   MoveL     WHTEXT        WSTEXT
012300090316     c                   If        *in40 = *on
012400090316     c                   Eval      WSEND = WHFNAM + ' ' + whlnam
012500090316     c*                  MoveL     WHFNAM        WSOBJREF
012600090316     c*                  MoveL     WHLNAM        WSOBJREFL
012700090316     c                   Else
012800090316     c                   Eval      WSEND = atr + '  ' +
012900090316     c                             %subst(lused:1:1) + '-' +
013000090316     c                             %subst(lused:2:2) + '-' +
013100090316     c                             %subst(lused:4:2) + '-' +
013200090316     c                             %subst(lused:6:2)
013300090316     c                   Endif
013400000000     c                   Write     SCRNS01
013500000000     c                   Move      *on           *in32
013600090316     c                   Endif
013700000000
013800000000     c/EXEC SQL
013900000000     c+ FETCH Next From RefFile into :DSDSPPGMREF
014000000000     c/END-EXEC
014100000000     c                   EndDo
014200000000     c/EXEC SQL
014300000000     c+ CLOSE RefFile
014400000000     c/END-EXEC
014500000000     C                   Eval      HDSFLP = 1
014600000000     c                   Endsr
014700000000      *****************************************************************
014800000000      * Print Report
014900000000     c     $PrintRpt     Begsr
015000000000
015100000000     c                   Call      'REFSPR'
015200000000     c                   Parm                    wcobj
015300000000     c                   Parm                    wcobj2
015400000000     c                   Parm                    wcobj3
015500000000     c                   Parm                    wcobj4
015600000000     c                   Parm                    wcobj5
015700000000
015800080122     c                   MoveL     'GEN0044'     WWMSGI
015900080122     c                   Call      'ERMSG1'      MSGP01
016000000000
016100000000     c                   Endsr
016200000000      *****************************************************************
016300000000      * Clear subfile:
016400000000     c     $ClrSfl       BegSr
016500000000
016600000000     c                   Clear                   RRN1
016700000000
016800000000     ** Clear subfile:
016900000000     c                   If        *in32
017000000000     c                   Move      *off          *in32
017100000000     c                   Move      *on           *in30
017200000000     c                   Write     SCRNC01
017300000000     c                   Move      *off          *in30
017400000000     c                   EndIf
017500000000
017600000000     c                   EndSr
017700090316      * Alternate View
017800090316     c     $AltView      Begsr
017900090316
018000090316      * Set the view indicator
018100090316     c                   If        *in40 = *on
018200090316     c                   Eval      *in40 = *off
018300090316     c                   Else
018400090316     c                   Eval      *in40 = *on
018500090316     c                   Endif
018600090316      * Refill the subfile
018700090316     c                   Exsr      $Fill
018800090316
018900090316     c                   EndSr
019000000000      *****************************************************************
019100000000     c     *Inzsr        BegSr
019200000000
019300000000     ** Message file parm list:
019400000000     c     MSGP01        PList
019500000000     c                   Parm                    WWMSGI            7
019600000000
019700000000     c                   Eval      *in34 = *on
019800090316     c                   Eval      *in40 = *on
019900000000
020000000000     c                   EndSr
