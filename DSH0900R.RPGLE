000100151024       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200151024       //****************************************************************
000300151024       //                                                               *
000400160126       // Program ID...... DSH0900R                                     *
000500160126       // Program Desc.... Test SQL function.                           *
000600151024       //                                                               *
000700151024       // Written By...... Greg Cannella                                *
000800160126       // Date Written.... 1/26/16                                      *
000900151024       //                                                               *
001000151024       // Comments........                                              *
001100151024       //                                                               *
001200151024       //                                                               *
001300151024       //****************************************************************
001400151024       // Compile Options:                                              *
001500151226       // Create this as a module.                                      *
001600160126       // CRTSRVPGM SRVPGM(QGPL/DSH0900R) EXPORT(*ALL)                  *
001700151226       // Then start SQL and run the following SQL command.             *
001800160126       // create function testfunc (dbname char(128))                   *
001900160126       //                 returns char(10)                              *
002000151226       //                 language rpgle                                *
002100151226       //                 not deterministic                             *
002200151226       //                 reads sql data                                *
002300160126       //                 external name 'GREGC/DSH0900R(TESTFUNC)'      *
002400151226       //                 parameter style general                       *
002500151226       //                 program type sub                              *
002600151226       //                                                               *
002700151226       //                                                               *
002800151024       //****************************************************************
002900151024       // Modifications:                                                *
003000151024       // Req#  By   Date      Modification                             *
003100151024       // 1234  xxx  xx/xx/xx                                           *
003200151024       //                                                               *
003300151024       //****************************************************************
003400151024       //------------------------------------------------
003500151024       //--Entry Prototype
003600151024
003700160126       dcl-pr TestFunc  char(10);
003800151226         widbname char(128);
003900151024       end-pr;
004000151024
004100160126       dcl-proc TestFunc export ;
004200151024
004300160126       dcl-pi TestFunc char(10);
004400151226         widbname char(128);
004500151024       end-pi;
004600151024
004700151024
004800151025       //-- Field declarations
004900151025
005000160126       dcl-s widbbody char(10);
005100151025
005200151025       //-- Main process.  Pass the parms to a processing program that
005300151025       //-- will build the body.
005400160126        widbbody = 'Test';
005500151025
005600151024       return widbbody;
005700151024
005800151024       end-proc;
