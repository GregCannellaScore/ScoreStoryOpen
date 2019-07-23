000100171008      /COPY jerrysrc/QCPYLESRC,stdhspec
000200080122      ********************************************************************
000300080122      *
000400080122      *  Program: REFSPR
000500080122      *
000600080122      *  Description: Print a list of references.
000700080122      *
000800080122      *  Programmer: Greg Cannella
000900080122      *
001000080122      *  Date: 1/22/08
001100080122      *
001200080122      ********************************************************************
001300080122      *                   Modification Log
001400080122      *
001500080122      *  Initials  Date      Description
001600080122      *-------------------------------------------------------------------
001700080122      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800080122      *
001900080122      *
002000080122      *
002100080122      ********************************************************************
002200080122      *                   Indicator Usage
002300080122      *
002400080122      *   Ind.   Description
002500080122      *-------------------------------------------------------------------
002600080122      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700080122      *
002800080122      *
002900080122      ********************************************************************
003000000000     h DATFMT(*ISO)
003100000000>>>> fQprint    o    f  132        printer oflind(*INOF)
003200000000
003300000000     d SQL             s            200
003400000000     d UTime           s               t
003500000000     d DSDSPPGMREF   e ds                  extname(DSPPGMREF)
003600000000     d First           s              1
003700000000     d pmobj           s             11
003800000000     d pmobj2          s             11
003900000000     d pmobj3          s             11
004000000000     d pmobj4          s             11
004100000000     d pmobj5          s             11
004200000000     d PmPName         s             10
004300000000     d PmAttr          s             10
004400000000
004500000000     d                sds
004600000000     d  DSPGMN           *PROC
004700000000     d  DSUSER               254    263
004800000000
004900000000      *****************************************************************
005000000000      * Setup SQL for report.
005100000000
005200000000     c                   Eval      SQL = 'SELECT * FROM DSPPGMREF +
005300000000     c                                    WHERE (WHFNAM LIKE ? +
005400000000     c                                    OR    WHFNAM LIKE ? +
005500000000     c                                    OR    WHFNAM LIKE ? +
005600000000     c                                    OR    WHFNAM LIKE ? +
005700000000     c                                    OR    WHFNAM LIKE ? ) +
005800000000     c                                    AND   WHFNAM <> '' '' +
005900000000     c                                    ORDER BY WHLIB, WHPNAM'
006000000000
006100000000      * A handle needs to be created to point to the dynamic SQL statement.
006200000000     c/EXEC SQL
006300000000     c+ PREPARE HHANDLE from :SQL
006400000000     c/END-EXEC
006500000000
006600000000      * Setup the file to use the SQL
006700000000     c/EXEC SQL
006800000000     c+ DECLARE RefFile CURSOR FOR HHANDLE
006900000000     c/END-EXEC
007000000000
007100000000      * Open the SQL file.
007200000000      * Notice all the field following the USING clause.  These must match
007300000000      * the SQL.  There needs to be the same number of fields as there are
007400000000      * question marks in the SQL.  They also need to match the order and
007500000000      * attributes of the counterparts they are going to be compaired.
007600000000     c/EXEC SQL
007700000000     c+ Open RefFile USING :pmobj,:pmobj2,:pmobj3,:pmobj4,:pmobj5
007800000000     c/END-EXEC
007900000000
008000000000      * Initial read
008100000000     c/EXEC SQL
008200000000     c+ FETCH Next From RefFile into :DSDSPPGMREF
008300000000     c/END-EXEC
008400000000
008500000000      * Loop through all records returned from the SQL.
008600000000     c                   DoW       SQLCOD = 0
008700000000      * Check for overflow
008800000000     c                   Exsr      $Head
008900000000      * Get program attribute
009000000000     c                   Movel     WHPNAM        PmPname
009100000000     c                   Move      *BLANKS       PMAttr
009200000000     c                   Call      'REFSC'
009300000000     c                   Parm                    PmPname
009400000000     c                   Parm                    PmAttr
009500000000      * Write detail record
009600000000     c                   Except    Detail
009700000000
009800000000      * Read the next record
009900000000     c/EXEC SQL
010000000000     c+ FETCH Next From RefFile into :DSDSPPGMREF
010100000000     c/END-EXEC
010200000000     c                   EndDo
010300000000
010400000000      * Close the SQL File
010500000000     c/EXEC SQL
010600000000     c+ CLOSE RefFile
010700000000     c/END-EXEC
010800000000     c                   Eval      *INLR = *ON
010900000000     c                   If        First = 'N'
011000000000     c                   Except    EOR
011100000000     c                   EndIf
011200000000
011300000000      *******************************************************************
011400000000     c     $Head         Begsr
011500000000
011600000000     c                   If        *INOF or First = *blanks
011700000000     c                   Eval      First = 'N'
011800000000     c                   Except    Head
011900000000     c                   EndIf
012000000000     c
012100000000     c                   EndSr
012200000000      *******************************************************************
012300000000     c     *Inzsr        Begsr
012400000000
012500000000     c     *Entry        Plist
012600000000     c                   Parm                    pmobj
012700000000     c                   Parm                    pmobj2
012800000000     c                   Parm                    pmobj3
012900000000     c                   Parm                    pmobj4
013000000000     c                   Parm                    pmobj5
013100000000
013200000000     c                   Time                    UTime
013300000000
013400000000     c                   EndSr
013500000000     oQprint    e            Head           2  2
013600000000     o                       UDate         y     10
013700000000     o                       UTime               20
013800000000     o                                           50 'References'
013900000000     o                                          125 'Page'
014000000000     o                       Page          z    130
014100000000     o          e            Head           2
014200000000     o                                           75 '1=I,2=O,3=I/O,4=U,5=I/U,+
014300000000     o                                              6=O/U,7=I/O/U,8=N/S,0=N/A'
014400000000     o          e            Head           2
014500000000     o                                           22 'Selection Criteria:'
014600000000     o                       pmobj               34
014700000000     o                       pmobj2              46
014800000000     o                       pmobj3              58
014900000000     o                       pmobj4              70
015000000000     o                       pmobj5              82
015100000000     o          e            Head           1
015200000000     o                                           28 'File'
015300000000     o                                           87 'Object'
015400000000     o          e            Head           2
015500000000     o                                            7 'Library'
015600000000     o                                           19 'Program'
015700000000     o                                           29 'Usage'
015800000000     o                                           34 'Text'
015900000000     o                                           91 'Referenced'
016000000000     o                                          100 'Library'
016100000000     o                                          113 'Attribute'
016200000000     o          e            Detail         1
016300000000     o                       WHLIB               10
016400000000     o                       WHPNAM              22
016500000000     o                       WHFUSG        z     27
016600000000     o                       WHTEXT              80
016700000000     o                       WHFNAM              92
016800000000     o                       WHLNAM             104
016900000000     o                       PmAttr             116
017000000000     o          e            EOR         1  1
017100000000     o                                           28 '* * * End of Report * * *'
