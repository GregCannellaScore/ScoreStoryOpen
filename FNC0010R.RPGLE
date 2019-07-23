000100160522       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200160522       //****************************************************************
000300160522       //                                                               *
000400160522       // Program ID...... FNC0010R                                     *
000500160522       // Program Desc.... Create a hyperlink                            *
000600160522       //                                                               *
000700160522       // Written By...... Greg Cannella                                *
000800160522       // Date Written....  5/22/16                                     *
000900160522       //                                                               *
001000160522       // Comments........                                              *
001100160522       //                                                               *
001200160522       //                                                               *
001300160522       //****************************************************************
001400160522       // Compile Options:                                              *
001500160522       // Create this as a module.                                      *
001600160522       // CRTSRVPGM SRVPGM(GREGC/FNC0010R) EXPORT(*ALL)                 *
001700160522       // Then start SQL and run the following SQL command.             *
001800160522       // create function link (pmlink char(128),                       *
001900160522       //                 pmtext char(128),
002000160522       //                 pmtarget char(20),
002100160522       //                 pmimage char(128),
002200160522       //                 pmalttext char(128),
002300160522       //                 pmstyle char(300),
002400160522       //                 pmid char(60))
002500160522       //                 returns char(2000)                            *
002600160522       //                 language rpgle                                *
002700160522       //                 deterministic                                 *
002800160522       //                 no sql                                        *
002900160522       //                 external name 'GREGC/FNC0010R(LINK)'          *
003000160522       //                 parameter style general                       *
003100160522       //                 program type sub                              *
003200160522       //                                                               *
003300160522       //                                                               *
003400160522       //****************************************************************
003500160522       // Modifications:                                                *
003600160522       // Req#  By   Date      Modification                             *
003700160522       // 1234  xxx  xx/xx/xx                                           *
003800160522       //                                                               *
003900160522       //****************************************************************
004000160522       //------------------------------------------------
004100160522       //--Entry Prototype
004200160522
004300160522       dcl-pr Link char(2000);
004400160522         pmlink char(128);
004500160522         pmtext char(128);
004600160522         pmtarget char(20);
004700160522         pmimage char(128);
004800160522         pmalttext char(128);
004900160522         pmstyle char(300);
005000160522         pmid char(60);
005100160522       end-pr;
005200160522
005300160522       dcl-proc Link export ;
005400160522
005500160522       dcl-pi Link char(2000);
005600160522         pmlink char(128);
005700160522         pmtext char(128);
005800160522         pmtarget char(20);
005900160522         pmimage char(128);
006000160522         pmalttext char(128);
006100160522         pmstyle char(300);
006200160522         pmid char(60);
006300160522       end-pi;
006400160522
006500160522       //-- Field declarations
006600160522
006700160522       dcl-s wilink char(2000);
006800160522
006900160522       //-- Main process.  Build the link
007000160522        wilink = '<a href="' + %trim(pmlink) + '"';
007100160522       //-- Set target if entered
007200160522        If pmtarget <>' ';
007300160522          wilink = %trimr(wilink) + ' target="' + %trim(pmtarget) + '"';
007400160522        Endif;
007500160522        //-- Set image if entered
007600160522        If pmimage <> ' ';
007700160522          wilink = %trimr(wilink) + '"><img src="' + %trim(pmimage) +
007800160522                   '" alt="' + %trim(pmalttext) + '"';
007900160522          If pmstyle <> ' ';
008000160522            wilink = %trimr(wilink) + ' style="' + %trim(pmstyle) + '"';
008100160522          Endif;
008200160522          wilink = %trimr(wilink) + '></a>';
008300160522        Else;
008400160522        //-- No image
008500160522          wilink = %trimr(wilink) + '>' + %trim(pmtext) + '</a>';
008600160522        Endif;
008700160522
008800160522       return wilink;
008900160522
009000160522       end-proc;
