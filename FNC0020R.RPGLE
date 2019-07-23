000100160522       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200160522       //****************************************************************
000300160522       //                                                               *
000400160605       // Program ID...... FNC0020R                                     *
000500160605       // Program Desc.... Create an update button                       *
000600160522       //                                                               *
000700160522       // Written By...... Greg Cannella                                *
000800160605       // Date Written....  6/05/16                                     *
000900160522       //                                                               *
001000160522       // Comments........                                              *
001100160522       //                                                               *
001200160522       //                                                               *
001300160522       //****************************************************************
001400160522       // Compile Options:                                              *
001500160522       // Create this as a module.                                      *
001600160605       // CRTSRVPGM SRVPGM(GREGC/FNC0020R) EXPORT(*ALL)                 *
001700160522       // Then start SQL and run the following SQL command.             *
001800160605       // create function updatebutton (pmlink char(2000),
001900160605       //                 pmuser char(128),
002000160605       //                 pmfile char(128),
002100160605       //                 pmfields char(500),
002200160605       //                 pmtarget char(20))
002300160522       //                 returns char(2000)                            *
002400160522       //                 language rpgle                                *
002500160522       //                 deterministic                                 *
002600160522       //                 no sql                                        *
002700160605       //                 external name 'GREGC/FNC0020R(UPDATEBUTTON)'  *
002800160522       //                 parameter style general                       *
002900160522       //                 program type sub                              *
003000160522       //                                                               *
003100160522       //                                                               *
003200160522       //****************************************************************
003300160522       // Modifications:                                                *
003400160522       // Req#  By   Date      Modification                             *
003500160522       // 1234  xxx  xx/xx/xx                                           *
003600160522       //                                                               *
003700160522       //****************************************************************
003800160522       //------------------------------------------------
003900160522       //--Entry Prototype
004000160522
004100160522       dcl-pr Link char(2000);
004200160605         pmuser char(128);
004300160605         pmfile char(128);
004400160605         pmfields char(128);
004500160522         pmtarget char(20);
004600160522       end-pr;
004700160522
004800160522       dcl-proc Link export ;
004900160522
005000160522       dcl-pi Link char(2000);
005100160605         pmuser char(128);
005200160605         pmfile char(128);
005300160605         pmfields char(128);
005400160605         pmtarget char(20);
005500160522       end-pi;
005600160522
005700160522       //-- Field declarations
005800160522
005900160522       dcl-s wilink char(2000);
006000160605       dcl-s uplink char(2000);
006100160522
006200160605       //-- Create link
006300160605        uplink = 'http://www.scorestory.com/ss/update.php?file='
006400160605            + %trim(pmuser) + '/' + %trim(pmfile);
006500160522       //-- Main process.  Build the link
006600160605        wilink = '<a href="' + %trim(uplink) + '"';
006700160522       //-- Set target if entered
006800160522        If pmtarget <>' ';
006900160522          wilink = %trimr(wilink) + ' target="' + %trim(pmtarget) + '"';
007000160522        Endif;
007100160522        //-- Set image if entered
007200160605          wilink = %trimr(wilink) + '"><img src="/ss/images/maintenance.'
007300160605                 + 'jpeg" alt="Update"';
007400160605            wilink = %trimr(wilink) + ' style="' +
007500160605                 'width:20px;height:20px;border:0;"';
007600160522          wilink = %trimr(wilink) + '></a>';
007700160522
007800160522       return wilink;
007900160522
008000160522       end-proc;
