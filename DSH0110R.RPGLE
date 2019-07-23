000100151024       ctl-opt option(*srcstmt:*nodebugio) nomain ;
000200151024       //****************************************************************
000300151024       //                                                               *
000400151025       // Program ID...... DSH0110R                                     *
000500151025       // Program Desc.... Main dashboard user defined function.         *
000600151024       //                                                               *
000700151024       // Written By...... Greg Cannella                                *
000800151024       // Date Written.... 10/4/15                                      *
000900151024       //                                                               *
001000151024       // Comments........                                              *
001100151024       //                                                               *
001200151024       //                                                               *
001300151024       //****************************************************************
001400151024       // Compile Options:                                              *
001500151226       // Create this as a module.                                      *
001600170813       // CRTSRVPGM SRVPGM(JERRYMOUSE/DSH0110R) EXPORT(*ALL)            *
001700151226       // Then start SQL and run the following SQL command.             *
001800160614       // create function getdashboard (widbname char(128),             *
001900170813       //             widbuser char(10),                                *
002000170813       //             widbparm char(200))                               *
002100180129       //             returns char(500)                                 *
002200170813       //             language rpgle                                    *
002300170813       //             not deterministic                                 *
002400170813       //             reads sql data                                    *
002500170813       //             external name 'JERRYMOUSE/DSH0110R(GETDASHBOARD)' *
002600170813       //             parameter style general                           *
002700170813       //             program type sub                                  *
002800151226       //                                                               *
002900151226       //                                                               *
003000151024       //****************************************************************
003100151024       // Modifications:                                                *
003200151024       // Req#  By   Date      Modification                             *
003300151024       // 1234  xxx  xx/xx/xx                                           *
003400151024       //                                                               *
003500151024       //****************************************************************
003600151024       //------------------------------------------------
003700151024       //--Entry Prototype
003800151024
003900180129       dcl-pr GetDashBoard  char(500);
004000151226         widbname char(128);
004100160614         widbuser char(10);
004200170520         widbparm char(200);
004300151024       end-pr;
004400151024
004500151024       dcl-proc GetDashBoard export ;
004600151024
004700180129       dcl-pi GetDashBoard char(500);
004800151226         widbname char(128);
004900160614         widbuser char(10);
005000170520         widbparm char(200);
005100151024       end-pi;
005200151024
005300151025       //--External Prototypes
005400170924
005500170924       dcl-pr DSH0110C  extpgm('DSH0110C');
005600170924       end-pr;
005700151024
005800151025       dcl-pr DSH0115R  extpgm('DSH0115R');
005900151226         widbname char(128);
006000160614         widbuser char(10);
006100170520         widbparm char(200);
006200180129         widbbody char(500);
006300151024       end-pr;
006400151024
006500151025       //-- Field declarations
006600151025
006700180129       dcl-s widbbody char(500);
006800151025
006900151025       //-- Main process.  Pass the parms to a processing program that
007000151025       //-- will build the body.
007100151025
007200170924          DSH0110C();
007300170520        DSH0115R(widbname:widbuser:widbparm:widbbody) ;
007400151025
007500151024       return widbbody;
007600151024
007700151024       end-proc;
