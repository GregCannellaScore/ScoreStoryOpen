000100170527       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200170527       //****************************************************************
000300170527       //                                                               *
000400170527       // Program ID...... DSH0130R                                     *
000500170527       // Program Desc.... Create link functions                        *
000600170527       //                                                               *
000700170527       // Written By...... Greg Cannella                                *
000800170527       // Date Written....  5/27/17                                     *
000900170527       //                                                               *
001000170527       // Comments........                                              *
001100170527       //                                                               *
001200170527       //                                                               *
001300170527       //****************************************************************
001400170527       // Compile Options:                                              *
001500170527       // Create this as a module.                                      *
001600170813       // CRTSRVPGM SRVPGM(JERRYMOUSE/DSH0130R) EXPORT(*ALL)            *
001700170527       // Then start SQL and run the following SQL command.             *
001800170527       // create function createlink (widbname char(128),               *
001900170813       //               wiimage char(100),                              *
002000170813       //               witext char(100),                               *
002100170813       //               wiParm1 char(20) DEFAULT '',                    *
002200170813       //               wiValue1 char(100) DEFAULT '',                  *
002300170813       //               wiParm2 char(20) DEFAULT '',                    *
002400170813       //               wiValue2 char(100) DEFAULT '',                  *
002500170813       //               wiParm3 char(20) DEFAULT '',                    *
002600170813       //               wiValue3 char(100) DEFAULT '',                  *
002700170813       //               wiParm4 char(20) DEFAULT '',                    *
002800170813       //               wiValue4 char(100) DEFAULT '',                  *
002900170813       //               wiParm5 char(20) DEFAULT '',                    *
003000170813       //               wiValue5 char(100) DEFAULT '')                  *
003100171010       //               returns char(200) language rpgle                *
003200171010       //               deterministic  no sql                           *
003300170813       //               external name 'JERRYMOUSE/DSH0130R(CREATELINK)' *
003400171010       //               parameter style general program type sub        *
003500170527       //                                                               *
003600170527       //                                                               *
003700170527       //****************************************************************
003800170527       // Modifications:                                                *
003900170527       // Req#  By   Date      Modification                             *
004000170527       // 1234  xxx  xx/xx/xx                                           *
004100170527       //                                                               *
004200170527       //****************************************************************
004300170527       //------------------------------------------------
004400170527       //--Entry Prototype
004500170527
004600170527       dcl-pr CREATELINK  char(200);
004700170527         widbname char(128);
004800170527         wiimage char(100);
004900170527         witext char(100);
005000170527         wiParm1 char(20);
005100170527         wiValue1 char(100);
005200170527         wiParm2 char(20);
005300170527         wiValue2 char(100);
005400170527         wiParm3 char(20);
005500170527         wiValue3 char(100);
005600170527         wiParm4 char(20);
005700170527         wiValue4 char(100);
005800170527         wiParm5 char(20);
005900170527         wiValue5 char(100);
006000170527       end-pr;
006100170527
006200170527       dcl-proc CREATELINK export ;
006300170527
006400170527       dcl-pi CREATELINK  char(200);
006500170527         widbname char(128);
006600170527         wiimage char(100);
006700170527         witext char(100);
006800170527         wiParm1 char(20);
006900170527         wiValue1 char(100);
007000170527         wiParm2 char(20);
007100170527         wiValue2 char(100);
007200170527         wiParm3 char(20);
007300170527         wiValue3 char(100);
007400170527         wiParm4 char(20);
007500170527         wiValue4 char(100);
007600170527         wiParm5 char(20);
007700170527         wiValue5 char(100);
007800170527       end-pi;
007900170527
008000170527       //-- Field declarations
008100170527
008200170527       dcl-s wiLink char(200);
008300170527
008400170527       //-- Main process.
008500170527
008600170527        wiLink = '<a href="showdashboard.php?DB=' + %trim(widbname);
008700170527
008800170527       If wiParm1 <> *blanks;
008900170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm1) + '=' +
009000170527         %trim(wiValue1);
009100170527       ENDIF;
009200170527
009300170527       If wiParm2 <> *blanks;
009400170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm2) + '=' +
009500170527         %trim(wiValue2);
009600170527       ENDIF;
009700170527
009800170527       If wiParm3 <> *blanks;
009900170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm3) + '=' +
010000170527         %trim(wiValue3);
010100170527       ENDIF;
010200170527
010300170527       If wiParm4 <> *blanks;
010400170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm4) + '=' +
010500170527         %trim(wiValue4);
010600170527       ENDIF;
010700170527
010800170527       If wiParm5 <> *blanks;
010900170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm5) + '=' +
011000170527         %trim(wiValue5);
011100170527       ENDIF;
011200170527
011300170527       WiLink = %trimr(wiLink) + '">';
011400170527
011500170527       If wiImage <> *blanks;
011600170527         wiLink = %trimr(wiLink) + '<img src ="' + %trim(wiParm5) + '" alt="' +
011700170527         %trim(wiText) + '">';
011800170527       Else;
011900170527         wiLink = %trimr(wiLink) + %trim(wiText);
012000170527       ENDIF;
012100170527
012200170527       WiLink = %trimr(wiLink) + '</a>';
012300170527
012400170527       return wiLink;
012500170527
012600170527       end-proc;
