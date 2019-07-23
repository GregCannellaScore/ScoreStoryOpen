000100000000      /Copy Qcpylesrc,Stdhspec
000200000000       //*******************************************************************
000300000000       //
000400000000       //  Program....: EML0005R
000500000000       //
000600000000       //  Description: Send CSV files via Email for a distribution
000700000000       //
000800171008       //  Programmer.: Greg Cannella
000900000000       //
001000160309       //  Date.......: 03/09/2016
001100000000       //
001200000000       //*******************************************************************
001300000000       //                   Modification Log
001400000000       //
001500000000       //  Initials  Date    Description
001600000000       //-------------------------------------------------------------------
001700000000       //
001800000000       //
001900000000       //
002000000000       //*******************************************************************
002100000000
002200000000       //--Define files
002300000000       dcl-f EmlDstM usage(*input) keyed;
002400000000
002500000000       //-------------------------------------------------------------------
002600000000       //--Entry Prototype
002700000000
002800000000       dcl-pr Eml0005r extpgm('EML0005R');
002900000000         wiFileName like(wwFileName);
003000000000         wiEmail like(wwEmail);
003100000000         wiMsgBody like(wwMsgBody);
003200000000         wiMessage like(wwMessage);
003300000000         wiSubject like(wwSubject);
003400000000         wiSubh_Empty like(wwSubh_Empty);
003500000000         wiCsvFile like(wwCsvFile);
003600000000         wiZipFile like(wwZipFile);
003700000000         wiZipFlag like(wwZipFlag);
003800000000       end-pr;
003900000000
004000000000       dcl-pi Eml0005r;
004100000000         wiFileName like(wwFileName);
004200000000         wiEmail like(wwEmail);
004300000000         wiMsgBody like(wwMsgBody);
004400000000         wiMessage like(wwMessage);
004500000000         wiSubject like(wwSubject);
004600000000         wiSubh_Empty like(wwSubh_Empty);
004700000000         wiCsvFile like(wwCsvFile);
004800000000         wiZipFile like(wwZipFile);
004900000000         wiZipFlag like(wwZipFlag);
005000000000       end-pi;
005100000000
005200000000       //-------------------------------------------------------------------
005300000000       // Called programs
005400000000
005500000000       dcl-pr Eml0005c extpgm('EML0005C');
005600000000         wiFileName like(wwFileName);
005700000000         wiEmail like(wwEmail);
005800000000         wiMsgBody like(wwMsgBody);
005900000000         wiMessage like(wwMessage);
006000000000         wiSubject like(wiSubject);
006100000000         wiSubh_Empty like(wiSubh_Empty);
006200000000         wiCsvFile like(wiCsvFile);
006300000000         wiZipFile like(wwZipFile);
006400000000         wiZipFlag like(wwZipFlag);
006500000000       end-pr;
006600000000
006700000000       //-------------------------------------------------------------------
006800000000       // Work Fields
006900000000
007000000000       dcl-s wwFileName char(10);
007100000000       dcl-s wwEmail char(52);
007200000000       dcl-s wwMsgBody char(256);
007300000000       dcl-s wwMessage char(5000);
007400000000       dcl-s wwSubject char(40);
007500000000       dcl-s wwSubh_Empty char(60);
007600000000       dcl-s wwCsvFile char(12);
007700000000       dcl-s wwZipFile char(12);
007800000000       dcl-s wwZipFlag char(12);
007900000000
008000000000       //-------------------------------------------------------------------
008100000000       // Mainline
008200000000       //-------------------------------------------------------------------
008300000000
008400000000       // Work file not journaled in QTEMP
008500000000
008600000000       exsr $ProcessData;
008700000000
008800000000       *inlr = *on;
008900000000
009000000000
009100000000       //-------------------------------------------------------------------
009200000000       // Write data to work file
009300000000       //-------------------------------------------------------------------
009400000000       begsr $ProcessData;
009500000000
009600000000         setll (wiFileName) EmlDstM;
009700000000         reade (wiFileName) EmlDstM;
009800000000
009900000000         dow not %eof(EmlDstM);
010000000000
010100000000           if edEmail <> *blank;
010200000000             wwFileName = wiFileName;
010300000000             wwEmail = edEmail;
010400000000             wwMsgBody = wiMsgBody;
010500000000             wwMessage = wiMessage;
010600000000             wwSubject = wiSubject;
010700000000             wwSubh_Empty = wiSubh_Empty;
010800000000             wwCsvFile = wiCsvFile;
010900000000             wwZipFile = wiZipFile;
011000000000             wwZipFlag = wiZipFlag;
011100000000
011200000000             Eml0005C(wwFileName :wwEmail :wwMsgBody :wwMessage
011300000000                :wwSubject :wwSubh_Empty :wwCsvFile :wwZipFile
011400000000                :wwZipFlag);
011500000000
011600000000           endif;
011700000000
011800000000           reade (wiFileName) EmlDstM;
011900000000         enddo;
012000000000
012100000000       endsr;
012200000000
012300000000
