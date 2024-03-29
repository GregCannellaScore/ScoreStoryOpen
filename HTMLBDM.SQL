000100160109
000200170813/* RUNSQLSTM SRCFILE(JERRYSRC/QSQLSRC) SRCMBR(HTMLBDM) COMMIT(*NONE)*/
000300160109
000400170813SET SCHEMA JERRYMOUSE;
000500160109
000600170813CREATE TABLE HTMLBDM (
000700170813		HXBODYNAME CHAR(50) CCSID 37 NOT NULL,
000800171008		HXBODY VARCHAR(32000) CCSID 37 NOT NULL,
000900171008  HXSUB1 CHAR(50),
001000171008  HXSUB2 CHAR(50),
001100171008  HXSUB3 CHAR(50),
001200171008  HXSUB4 CHAR(50),
001300171008  HXSUB5 CHAR(50),
001400171008  HXSUB6 CHAR(50),
001500171008  HXSUB7 CHAR(50),
001600171008  HXSUB8 CHAR(50),
001700171008  HXSUB9 CHAR(50),
001800171008  HXSUB10 CHAR(50)
001900170813	) RCDFMT HTMLBDMR;
002000160109
002100170813LABEL ON TABLE HTMLBDM IS
002200160109'HTML Uploaded Body';
002300170813
002400170813LABEL ON COLUMN HTMLBDM (
002500170813HXBODYNAME IS 'Body Name',
002600171008HXBODY IS 'Body',
002700171008HXSUB1 IS 'Substitution Var 1',
002800171008HXSUB2 IS 'Substitution Var 2',
002900171008HXSUB3 IS 'Substitution Var 3',
003000171008HXSUB4 IS 'Substitution Var 4',
003100171008HXSUB5 IS 'Substitution Var 5',
003200171008HXSUB6 IS 'Substitution Var 6',
003300171008HXSUB7 IS 'Substitution Var 7',
003400171008HXSUB8 IS 'Substitution Var 8',
003500171008HXSUB9 IS 'Substitution Var 9',
003600171008HXSUB10 IS 'Substitution Var 10');
003700160109
003800170813LABEL ON COLUMN HTMLBDM (
003900170813HXBODYNAME TEXT IS 'Body Name',
004000171008HXBODY TEXT IS 'Body',
004100171008HXSUB1 TEXT IS 'Substitution Var 1',
004200171008HXSUB2 TEXT IS 'Substitution Var 2',
004300171008HXSUB3 TEXT IS 'Substitution Var 3',
004400171008HXSUB4 TEXT IS 'Substitution Var 4',
004500171008HXSUB5 TEXT IS 'Substitution Var 5',
004600171008HXSUB6 TEXT IS 'Substitution Var 6',
004700171008HXSUB7 TEXT IS 'Substitution Var 7',
004800171008HXSUB8 TEXT IS 'Substitution Var 8',
004900171008HXSUB9 TEXT IS 'Substitution Var 9',
005000171008HXSUB10 TEXT IS 'Substitution Var 10');
005100160109
005200170813ALTER TABLE HTMLBDM
005300170813  PRIMARY KEY (HXBODYNAME);
005400160109
005500160109
