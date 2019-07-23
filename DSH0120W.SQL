000100161208--------------------------------------------------------------------------------
000200161208--
000300161208--  Table Name:   DSH0120W
000400161208--
000500170813--  Description:  Dashboard chart workfile
000600161208--
000700170813--  Programmer:   Greg Cannella
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
002000170813
002100170813/* RUNSQLSTM SRCFILE(JERRYSRC/QSQLSRC) SRCMBR(DSH0120W) COMMIT(*NONE)*/
002200170813
002300170813SET SCHEMA JERRYMOUSE;
002400170813
002500170813CREATE TABLE DSH0120W (
002600170813CHARTBODY CHAR (32000) NOT NULL
002700000000)
002800000000RCDFMT DSH0120WR;
002900161208LABEL ON TABLE DSH0120W IS 'Dashboard chart work file';
003000161208LABEL ON COLUMN DSH0120W (
003100170813CHARTBODY IS 'Chart               Body          ');
003200161208LABEL ON COLUMN DSH0120W (
003300170813CHARTBODY TEXT IS 'Chart Body');
