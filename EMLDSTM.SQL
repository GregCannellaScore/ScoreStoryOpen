000100161208--------------------------------------------------------------------------------
000200161208--
000300161208--  Table Name:   EMLDSTM
000400161208--
000500161208--  Description:
000600161208--
000700170813--  Programmer:   Greg Cannella
000800161208--
000900161208--  Date:
001000161208--
001100161208--------------------------------------------------------------------------------
001200161208--                   Modification Log
001300161208--
001400161208--  Mod   Initials  Date      Description
001500161208--------------------------------------------------------------------------------
001600161208--  xxxx    xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001700161208--
001800161208--
001900161208--
002000161208--------------------------------------------------------------------------------
002100170813
002200170813/* RUNSQLSTM SRCFILE(JERRYSRC/QSQLSRC) SRCMBR(EMLDSTM) COMMIT(*NONE)*/
002300161208
002400170813SET SCHEMA JERRYMOUSE;
002500170813
002600170813CREATE table EMLDSTM (
002700000000EDFILENAME CHAR (10) NOT NULL,
002800000000EDEMAIL CHAR (52) NOT NULL
002900000000)
003000000000RCDFMT EMLDSTR;
003100161208LABEL ON TABLE EMLDSTM IS 'Email Distribution for DL';
003200161208LABEL ON COLUMN EMLDSTM (
003300000000EDFILENAME IS 'File                Name                                    ',
003400000000EDEMAIL IS 'Email Address                                               ');
003500161208LABEL ON COLUMN EMLDSTM (
003600000000EDFILENAME TEXT IS 'File Name',
003700000000EDEMAIL TEXT IS 'Eamil Address');
003800161208
003900161208ALTER TABLE EMLDSTM
004000161208  PRIMARY KEY (EDFILENAME, EDEMAIL);
