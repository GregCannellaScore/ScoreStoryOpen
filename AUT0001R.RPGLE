000100160329       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200160329       //****************************************************************
000300160329       //                                                               *
000400160329       // Program ID...... AUT0001R                                     *
000500160329       // Program Desc.... Grant authority to a library                  *
000600160329       //                                                               *
000700160329       // Written By...... Greg Cannella                                *
000800160329       // Date Written.... 10/4/15                                      *
000900160329       //                                                               *
001000160329       // Comments........                                              *
001100160329       //                                                               *
001200160329       //                                                               *
001300160329       //****************************************************************
001400160329       // Compile Options:                                              *
001500160329       // Create this as a module.                                      *
001600160329       // CRTSRVPGM SRVPGM(GREGC/AUT0001R) EXPORT(*ALL)                 *
001700160329       // Then start SQL and run the following SQL command.             *
001800160329       // create function grantauth (library char(10))                  *
001900160329       //                 returns char(1)                               *
002000160329       //                 language rpgle                                *
002100160329       //                 not deterministic                             *
002200160329       //                 reads sql data                                *
002300160329       //                 external name 'GREGC/AUT0001R(GRANTAUTH)'     *
002400160329       //                 parameter style general                       *
002500160329       //                 program type sub                              *
002600160329       //                                                               *
002700160329       //                                                               *
002800160329       //****************************************************************
002900160329       // Modifications:                                                *
003000160329       // Req#  By   Date      Modification                             *
003100160329       // 1234  xxx  xx/xx/xx                                           *
003200160329       //                                                               *
003300160329       //****************************************************************
003400160329       //------------------------------------------------
003500160329       //--Entry Prototype
003600160329
003700160329       dcl-pr GrantAuth  char(1);
003800160329         wilib char(10);
003900160329       end-pr;
004000160329
004100160329       dcl-proc GrantAuth export ;
004200160329
004300160329       dcl-pi GrantAuth char(1);
004400160329         wilib char(10);
004500160329       end-pi;
004600160329
004700160329       //--External Prototypes
004800160329
004900160329       dcl-pr AUT0001C  extpgm('AUT0001C');
005000160329         wilib char(10);
005100160329       end-pr;
005200160329
005300160329       aut0001c(wilib);
005400160329       return '1';
005500160329
005600160329       end-proc;
