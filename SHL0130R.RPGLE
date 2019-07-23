000100081202      /copy qcpylesrc,stdhspec
000200941228     F*****************************************************************
000300941228     F*                                                               *
000400090202     F* Program ID...... SHL0130R                                     *
000500090202     F* Program Desc....                                              *
000600081202     F* Request Number..                                              *
000700941228     F*                                                               *
000800090202     F* Written By......                                              *
000900090202     F* Date Written....                                              *
001000081208     F*                                                               *
001100081202     F* Comments........                                              *
001200081202     F*                                                               *
001300941228     F*                                                               *
001400950719     F*****************************************************************
001500970418     F* Compile Options:                                              *
001600950719     F*                                                               *
001700951009     F*****************************************************************
001800951009     F* Modifications:                                                *
001900951009     F* Req#  By   Date      Modification                             *
002000960611     F* 1234  xxx  xx/xx/xx                                           *
002100960116     F*                                                               *
002200950608     F*****************************************************************
002300950608     F* Indicator Usage:                                              *
002400950608     F* Ind      Use                                                  *
002500950607     F* 01-24    Function keys                                        *
002600950802     F* 40-51    Error Indicators                                     *
002700950626     F* 90-99    Hit/Miss                                             *
002800950607     F*                                                               *
002900960626     F*****************************************************************
003000960626     F* Field Definitions                                             *
003100960626     F*                                                               *
003200960626     F* Prefix                                                        *
003300960626     F* WW     - Program described work fields                        *
003400960626     F* WR     - Display record fields                                *
003500960626     F* DS     - Data structure fields                                *
003600960626     F*                                                               *
003700960626     F*                                                               *
003800960626     F* Display Record Format Definitions                             *
003900960626     F*                                                               *
004000960626     F* Prefix                                                        *
004100960626     F* SCRNK  - Command key                                          *
004200960626     F* SCRNR  - Standard display                                     *
004300960626     F* MSGCTL - Message subfile control                              *
004400960626     F*                                                               *
004500960626     F*                                                               *
004600960626     F* Called programs                                               *
004700960626     F*                                                               *
004800081203     F* ERMSG1 - Send program message with message data               *
004900081203     F* ERMSG2 - Clear program message queue                          *
005000960626     F*                                                               *
005100960626     F*****************************************************************
005200081202      *
005300090202     fSHL0130D  CF   E             Workstn
005301090202      *
005302090202      * Work Fields
005303090202      *
005304090202     d Wwerr1          S             10
005305090202     d Wwmsgi          S              7
005306090202     d Wwrcde          S              6
005307100505     d Error           c                   Const('ERROR')
005308090202      *
005309090202      * Incoming parms:
005310090202      *
005311090202     d                SDS
005312090202     d  Dspgmn           *PROC
005313090202     d  Dsuser               254    263
007700081203      *
007800090202     c                   Exsr      $Clear
007900081203      *
008000081203      * Clear messages:
008100081203      *
008200090202     c                   Call      'ERMSG2'
008300090202     c                   Parm                    Dspgmn
008400081202      *
008500081202      * Main loop:
008600081202      *
008700090202     c                   Dou       *inlr = *on
008900081202      *
009000081203      * Display screen
009100081202      *
009200090202     c                   Write     Msgctl1
009300090202     c                   Write     Scrnk01
009400090202     c                   Exfmt     Scrnr01
009500081202      *
009600081203      * F3 or F12 = exit program
009700081202      *
009800090202     c                   If        *In03    = *On
009801090202     c                             or *in12 = *on
009900090202     c                   Eval      *inlr    = *on
009901090416     c                   Else
010300081202      *
010400081203      * Set off error indicators
010500081202      *
010600090202     c                   Movea     '00'          *In(40)
010700081202      *
010800090202     c                   Clear                   Wwerr1
010900081202      *
011000081202      * Clear messages:
011100081202      *
011200090202     c                   Call      'ERMSG2'
011300090202     c                   Parm                    Dspgmn
011400081202      *
011500081203      * Error check
011600081202      *
011700090202     c                   Exsr      $Err01
011800081202      *
011900081203      * If no error, update paramters
012000081202      *
012100090202     c                   If        Wwerr1   <> Error
012200090202     c                   Exsr      $Enter
012201090416     c                   Eval      *inlr    = *on
012400090202     c                   Endif
012500081202      *
012501090416     c                   Endif
012700081202      *
012800090202     c                   Enddo
013500081202      *
013600081202      *****************************************************************
013700081202      *   $CLEAR - Intialize Program/Database Fields
013800081202      *****************************************************************
013900081202     C     $Clear        Begsr
014000081203      *
014100081203      * Initialize screen
014200081203      *
014300081202     C                   Clear                   Scrnr01
014400081203      *
014500081203      * Initialize program described fields
014600081203      *
014700081202     C                   Eval      Wwerr1   = *Blanks
014800081202      *
014900081202     C                   Endsr
015000081202      *****************************************************************
015100081202      *   $ERR01 - Vaildity Checking
015200081202      *****************************************************************
015300081202     C     $Err01        Begsr
015400081202      *
015500081202     C                   Clear                   Wwerr1
015809081208      *
015810081208      *  Validate From Date
015811081208      *
015812081208     c     *MDY          Test(DE)                wrfrom
015900081208     c                   If        %Error
016000081208     c                   Eval      Wwerr1   = Error
016100081208     c                   Eval      *In41    = *On
016200081208     c                   Eval      Wwmsgi   = 'GEN0005'
016300081208     c                   Call      'ERMSG1'
016400081208     c                   Parm                    Wwmsgi
017400081208     c                   EndIf
017401081208      *
017402081208      *  Validate To Date
017403081208      *
017404081208     c     *MDY          Test(DE)                wrto
017405081208     c                   If        %Error
017406081208     C                   Eval      Wwerr1   = Error
017407081208     C                   Eval      *In42    = *On
017408081208     C                   Eval      Wwmsgi   = 'GEN0005'
017409081208     C                   Call      'ERMSG1'
017410081208     C                   Parm                    Wwmsgi
017411081208     C                   EndIf
017500081203      *
020800081203     C                   Endsr
020900081202      *****************************************************************
021000081202      *   $ENTER - Enter Key Pressed
021100081202      *****************************************************************
021200081202     C     $Enter        Begsr
021300081202      *
021400081203      * Update parameters
021500081202      *
021600090202     c*                  Move      Wrfrom        Wwfrom            6
021601090202     c*                  Move      Wrto          Wwto              6
021602090202     c                   Call      'SHL0130C'
021603090202     c*                  Parm                    wrcat
021604090202     c*                  Parm                    wrfrom
021605090202     c*                  Parm                    wrto
021606090202     c                   Eval      *Inlr    = *On
021800081203      *
021900081208     c                   Endsr
