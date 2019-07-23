000100161208--------------------------------------------------------------------------------
000200161208--
000300170522--  Table Name:   DSHSECM
000400161208--
000500170522--  Description:  Dashboard security details.
000600161208--
000700170522--  Programmer:   Greg Cannella
000800161208--
000900161208--------------------------------------------------------------------------------
001000161208--                   Modification Log
001100161208--
001200161208--  Mod   Initials  Date      Description
001300161208--------------------------------------------------------------------------------
001400161208--  xxxx    xxx    xx/xx/xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
001500161208--
001600161208--
001700161208--
001800161208--------------------------------------------------------------------------------
001900161208
002000170813/* RUNSQLSTM SRCFILE(JERRYSRC/QSQLSRC) SRCMBR(DSHSECM) COMMIT(*NONE)*/
002100170813
002200170813SET SCHEMA JERRYMOUSE;
002300170813
002400170813CREATE TABLE DSHSECM (
002500170522DSNAME CHAR (128) NOT NULL,
002600170522DSUSER CHAR (10) NOT NULL
002700000000)
002800170522RCDFMT DSHSECMR;
002900170813LABEL ON TABLE DSHSECM IS 'Dashboard Security Details';
003000170522LABEL ON COLUMN DSHSECM (
003100170522DSNAME IS 'Dashboard Name',
003200170522DSUSER IS 'User/Group'
003300170228);
003400170522LABEL ON COLUMN DSHSECM (
003500170522DSNAME TEXT IS 'Dashboard Name',
003600170522DSUSER TEXT IS 'User/Group'
003700170304);
003800161208
003900170522ALTER TABLE DSHSECM
004000170522  PRIMARY KEY (DSNAME, DSUSER);
