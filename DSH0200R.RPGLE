000100171008      /copy qcpylesrc,stdhspec
000200171008      ********************************************************************
000300171008      *
000400171008      *  Program: DSH0200R
000500171008      *
000600171008      *  Description: Create dashboard detail records
000700171008      *
000800171008      *  Programmer: Greg Cannella
000900171008      *
001000171008      *  Date: 10/8/17
001100171008      *
001200171008      ********************************************************************
001300171008      *                   Modification Log
001400171008      *
001500171008      *  Initials  Date      Description
001600171008      *-------------------------------------------------------------------
001700171008      *   xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001800171008      *
001900171008      *
002000171008      *
002100171008      ********************************************************************
002200171008      *                   Indicator Usage
002300171008      *
002400171008      *   Ind.   Description
002500171008      *-------------------------------------------------------------------
002600171008      *   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
002700171008      *
002800171008      *
002900171008      ********************************************************************
003000171008       dcl-f htmlbdm usage(*input) keyed;
003100171008       dcl-f dshdtlm usage(*input:*output) keyed;
003200171008     fqprint    o    f  132        printer
003300171008
003400171008       //--Entry Prototype
003500171008       dcl-pr DSH0200R  extpgm('DSH0200R');
003600171008         widbname char(128);
003700171008         wibodynm char(50);
003800171008       end-pr;
003900171008       dcl-pi DSH0200R;
004000171008         widbname char(128);
004100171008         wibodynm char(50);
004200171008       end-pi;
004300171008
004400171008       //----------------------------------------------------------------
004500171008       // Definitions
004600171008       //----------------------------------------------------------------
004700171008
004800171008       dcl-s SubVal   char(50);
004900171008
005000171008       //----------------------------------------------------------------
005100171008       // Main Code
005200171008       //----------------------------------------------------------------
005300171008       Chain (wibodynm) htmlbdm;
005400171008       except;
005500171008       If %found;
005600171008         SubVal = hxsub1;
005700171008         Exsr $Insert;
005800171008         SubVal = hxsub2;
005900171008         Exsr $Insert;
006000171008         SubVal = hxsub3;
006100171008         Exsr $Insert;
006200171008         SubVal = hxsub4;
006300171008         Exsr $Insert;
006400171008         SubVal = hxsub5;
006500171008         Exsr $Insert;
006600171008         SubVal = hxsub6;
006700171008         Exsr $Insert;
006800171008         SubVal = hxsub7;
006900171008         Exsr $Insert;
007000171008         SubVal = hxsub8;
007100171008         Exsr $Insert;
007200171008         SubVal = hxsub9;
007300171008         Exsr $Insert;
007400171008         SubVal = hxsub10;
007500171008         Exsr $Insert;
007600171008       Endif;
007700171008       *inlr = *on;
007800171008
007900171008       //----------------------------------------------------------------
008000171008       // Check for record.  If it doesn't exist, create it.
008100171008       //----------------------------------------------------------------
008200171008       Begsr $Insert;
008300171008
008400171008       clear dshdtlmr;
008500171008       ddname = widbname;
008600171008       ddsub = SubVal;
008700171008       chain (ddname:ddsub) dshdtlm;
008800171008       if not %found and SubVal <> ' ';
008900171008         ddheading = 'A';
009000171008         DDSQLTYPE = 'N';
009100171008         write dshdtlmr;
009200171008       Endif;
009300171008       Endsr;
009400171008     oqprint    e                           1
009500171008     o                       widbname           128
009600171008     o          e                           1
009700171008     o                       wibodynm            50
