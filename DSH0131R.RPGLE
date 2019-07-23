000100170527       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200170527       //****************************************************************
000300170527       //                                                               *
000400190324       // Program ID...... DSH0131R                                     *
000500190324       // Program Desc.... Create external link function                *
000600170527       //                                                               *
000700170527       // Written By...... Greg Cannella                                *
000800190324       // Date Written....  3/24/19                                     *
000900170527       //                                                               *
001000170527       // Comments........                                              *
001100170527       //                                                               *
001200170527       //                                                               *
001300170527       //****************************************************************
001400170527       // Compile Options:                                              *
001500170527       // Create this as a module.                                      *
001600190527       // CRTSRVPGM SRVPGM(JERRYMOUSE/DSH0131R) EXPORT(*ALL)            *
001700170527       // Then start SQL and run the following SQL command.             *
001800190324       // create function createxlink (wiurl char(128),                 *
001900170527       //                 wiimage char(100),                            *
002000170527       //                 witext char(100),                             *
002100170527       //                 wiParm1 char(20) DEFAULT '',                  *
002200170527       //                 wiValue1 char(100) DEFAULT '',                *
002300170527       //                 wiParm2 char(20) DEFAULT '',                  *
002400170527       //                 wiValue2 char(100) DEFAULT '',                *
002500170527       //                 wiParm3 char(20) DEFAULT '',                  *
002600170527       //                 wiValue3 char(100) DEFAULT '',                *
002700170527       //                 wiParm4 char(20) DEFAULT '',                  *
002800170527       //                 wiValue4 char(100) DEFAULT '',                *
002900170527       //                 wiParm5 char(20) DEFAULT '',                  *
003000170527       //                 wiValue5 char(100) DEFAULT '')                *
003100170527       //                 returns char(2000)                            *
003200190324       //                 language rpgle deterministic no sql           *
003300190527       //             external name 'JERRYMOUSE/DSH0131R(CREATEXLINK)'  *
003400170527       //                 parameter style general                       *
003500190324       //                                                               *
003600170527       //                                                               *
003700170527       //                                                               *
003800170527       //****************************************************************
003900170527       // Modifications:                                                *
004000170527       // Req#  By   Date      Modification                             *
004100170527       // 1234  xxx  xx/xx/xx                                           *
004200170527       //                                                               *
004300170527       //****************************************************************
004400170527       //------------------------------------------------
004500170527       //--Entry Prototype
004600170527
004700190324       dcl-pr CREATEXLINK  char(2000);
004800190324         wiurl char(128);
004900170527         wiimage char(100);
005000170527         witext char(100);
005100170527         wiParm1 char(20);
005200170527         wiValue1 char(100);
005300170527         wiParm2 char(20);
005400170527         wiValue2 char(100);
005500170527         wiParm3 char(20);
005600170527         wiValue3 char(100);
005700170527         wiParm4 char(20);
005800170527         wiValue4 char(100);
005900170527         wiParm5 char(20);
006000170527         wiValue5 char(100);
006100170527       end-pr;
006200170527
006300190324       dcl-proc CREATEXLINK export ;
006400170527
006500190324       dcl-pi CREATEXLINK  char(2000);
006600190324         wiurl char(128);
006700170527         wiimage char(100);
006800170527         witext char(100);
006900170527         wiParm1 char(20);
007000170527         wiValue1 char(100);
007100170527         wiParm2 char(20);
007200170527         wiValue2 char(100);
007300170527         wiParm3 char(20);
007400170527         wiValue3 char(100);
007500170527         wiParm4 char(20);
007600170527         wiValue4 char(100);
007700170527         wiParm5 char(20);
007800170527         wiValue5 char(100);
007900170527       end-pi;
008000170527
008100170527       //-- Field declarations
008200170527
008300190324       dcl-s wiLink char(2000);
008400170527
008500170527       //-- Main process.
008600170527
008700190324        wiLink = '<a href=' + %trim(wiurl);
008800170527
008900170527       If wiParm1 <> *blanks;
009000190324         wiLink = %trimr(wiLink) + '?' + %trim(wiParm1) + '=' +
009100170527         %trim(wiValue1);
009200170527       ENDIF;
009300170527
009400170527       If wiParm2 <> *blanks;
009500170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm2) + '=' +
009600170527         %trim(wiValue2);
009700170527       ENDIF;
009800170527
009900170527       If wiParm3 <> *blanks;
010000170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm3) + '=' +
010100170527         %trim(wiValue3);
010200170527       ENDIF;
010300170527
010400170527       If wiParm4 <> *blanks;
010500170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm4) + '=' +
010600170527         %trim(wiValue4);
010700170527       ENDIF;
010800170527
010900170527       If wiParm5 <> *blanks;
011000170527         wiLink = %trimr(wiLink) + '&' + %trim(wiParm5) + '=' +
011100170527         %trim(wiValue5);
011200170527       ENDIF;
011300170527
011400170527       WiLink = %trimr(wiLink) + '">';
011500170527
011600170527       If wiImage <> *blanks;
011700170527         wiLink = %trimr(wiLink) + '<img src ="' + %trim(wiParm5) + '" alt="' +
011800170527         %trim(wiText) + '">';
011900170527       Else;
012000170527         wiLink = %trimr(wiLink) + %trim(wiText);
012100170527       ENDIF;
012200170527
012300170527       WiLink = %trimr(wiLink) + '</a>';
012400170527
012500170527       return wiLink;
012600170527
012700170527       end-proc;
