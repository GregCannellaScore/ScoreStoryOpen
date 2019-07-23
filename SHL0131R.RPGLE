000100000000      /copy qcpylesrc,stdhspec
000200000000      //****************************************************************
000300000000      //                                                               *
000400000000      // Program ID...... SHL0131R                                     *
000500000000      // Program Desc....                                              *
000600000000      // Request Number..                                              *
000700000000      //                                                               *
000800000000      // Written By......                                              *
000900000000      // Date Written....                                              *
001000000000      //                                                               *
001100000000      // Comments........                                              *
001200000000      //                                                               *
001300000000      //                                                               *
001400000000      //****************************************************************
001500000000      // Compile Options:                                              *
001600000000      //                                                               *
001700000000      //****************************************************************
001800000000      // Modifications:                                                *
001900000000      // Req#  By   Date      Modification                             *
002000000000      // 1234  xxx  xx/xx/xx                                           *
002100000000      //                                                               *
002200000000      //****************************************************************
002300000000      // Indicator Usage:                                              *
002400000000      // Ind      Use                                                  *
002500000000      // 01-24    Function keys                                        *
002600000000      // 40-51    Error Indicators                                     *
002700000000      // 90-99    Hit/Miss                                             *
002800000000      //                                                               *
002900000000      //****************************************************************
003000000000      // Field Definitions                                             *
003100000000      //                                                               *
003200000000      // Prefix                                                        *
003300000000      // WW     - Program described work fields                        *
003400000000      // WR     - Display record fields                                *
003500000000      // DS     - Data structure fields                                *
003600000000      // wi     - Parameters for prototyped calls                      *
003700000000      //                                                               *
003800000000      //                                                               *
003900000000      // Display Record Format Definitions                             *
004000000000      //                                                               *
004100000000      // Prefix                                                        *
004200000000      // SCRNK  - Command key                                          *
004300000000      // SCRNR  - Standard display                                     *
004400000000      // MSGCTL - Message subfile control                              *
004500000000      //                                                               *
004600000000      //                                                               *
004700000000      // Called programs                                               *
004800000000      //                                                               *
004900000000      // ERMSG1 - Send program message with message data               *
005000000000      // ERMSG2 - Clear program message queue                          *
005100000000      //                                                               *
005200000000      //****************************************************************
005300000000      //
005400000000     fSHL0130D  CF   E             Workstn
005500000000
005600000000      // Generic Message Handler
005700000000     d ErMsg1          pr                  ExtPgm('ERMSG1')
005800000000     d  wiMsgi                             like(Wwmsgi)
005900000000
006000000000      // Remove messages written by ERMSG1
006100000000     d ErMsg2          pr                  ExtPgm('ERMSG2')
006200000000     d  wiDsPgm                            like(dsPgmn)
006300000000
006400000000      // Program description here
006500000000     d SHL0130C        pr                  extpgm('SHL0130C')
006600000000     d**wiCat                        10a
006700000000     d**wiFrom                        6a
006800000000     d**wiTo                          6a
006900000000
007000000000      // Work Fields
007100000000
007200000000     d Wwerr1          S             10
007300000000     d Wwmsgi          S              7
007400000000     d Wwrcde          S              6
007500000000     d Error           c                   Const('ERROR')
007600000000
007700000000      // Incoming parms:
007800000000
007900000000     d                SDS
008000000000     d  Dspgmn           *PROC
008100000000     d  Dsuser               254    263
008200000000
008300000000      /FREE
008400000000       Exsr $Clear;
008500000000
008600000000       // Clear messages:
008700000000       ErMsg2(DsPgmn);
008800000000
008900000000      // Main loop:
009000000000
009100000000       Dou *inlr = *on;
009200000000
009300000000         // Display screen
009400000000         Write Msgctl1;
009500000000         Write Scrnk01;
009600000000         Exfmt Scrnr01;
009700000000
009800000000         // F3 or F12 = exit program
009900000000         If *In03    = *On
010000000000               or *in12 = *on;
010100000000           *inlr    = *on;
010200000000         Else;
010300000000
010400000000           // Set off error indicators
010500000000           *in41 = *off;
010600000000           //*in42 = *off; (Need to add each indicator to turn off)
010700000000           Clear Wwerr1;
010800000000
010900000000           // Clear messages:
011000000000           ErMsg2(DsPgmn);
011100000000
011200000000           // Error check
011300000000           Exsr $Err01;
011400000000
011500000000           // If no error, update paramters
011600000000           If Wwerr1   <> Error;
011700000000             Exsr $Enter;
011800000000             *inlr    = *on;
011900000000           Endif;
012000000000
012100000000         Endif;
012200000000
012300000000       Enddo;
012400000000
012500000000       //****************************************************************
012600000000       //   $CLEAR - Intialize Program/Database Fields
012700000000       //****************************************************************
012800000000       Begsr $Clear;
012900000000
013000000000         // Initialize screen
013100000000         Clear Scrnr01;
013200000000
013300000000         // Initialize program described fields
013400000000         Wwerr1   = *Blanks;
013500000000
013600000000       Endsr;
013700000000       //****************************************************************
013800000000       //   $ERR01 - Vaildity Checking
013900000000       //****************************************************************
014000000000       Begsr $Err01;
014100000000
014200000000         Clear Wwerr1;
014300000000
014400000000         //  Validate From Date
014500000000         Test(DE) *MDY wrfrom;
014600000000         If %Error;
014700000000           Wwerr1   = Error;
014800000000           *In41    = *On;
014900000000           Wwmsgi   = 'GEN0005';
015000000000           ErMsg1(wwMsgi);
015100000000         EndIf;
015200000000
015300000000         //  Validate To Date
015400000000         Test(DE) *MDY wrto;
015500000000         If %Error;
015600000000           Wwerr1   = Error;
015700000000           *In42    = *On;
015800000000           Wwmsgi   = 'GEN0005';
015900000000           ErMsg1(wwMsgi);
016000000000         EndIf;
016100000000
016200000000       Endsr;
016300000000       //****************************************************************
016400000000       //   $ENTER - Enter Key Pressed
016500000000       //****************************************************************
016600000000       Begsr $Enter;
016700000000
016800000000         // Update parameters
016900000000         //
017000000000         // Wwfrom = Wrfrom
017100000000         // Wwto   = Wrto
017200000000
017300000000         Shl0130c(wwCat :wwFrom :wwTo);
017400000000         *Inlr    = *On;
017500000000         //
017600000000       Endsr;
017700000000      /END-FREE
