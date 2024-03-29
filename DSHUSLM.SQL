000100180728/* RUNSQLSTM SRCFILE(JERRYSRC/QSQLSRC) SRCMBR(DSHUSLM) COMMIT(*NONE) */
000200180728 -------------------------------------------------------------------------------
000300180728SET SCHEMA JERRYMOUSE;
000400161208
000500180728CREATE TABLE DSHUSLM (
000600180609UCUSER CHAR (10) NOT NULL,
000700180609UCNAME CHAR (128) NOT NULL,
000800180705UCSEQ  NUMERIC (5,0) NOT NULL,
000900180609UCLUDT NUMERIC (7,0) NOT NULL,
001000180609UCLUTM NUMERIC (6,0) NOT NULL,
001100180609UCLUUS CHAR (10) NOT NULL,
001200180609UCLUPG CHAR (10) NOT NULL
001300000000)
001400180609RCDFMT DSHUSLMR;
001500180609LABEL ON TABLE DSHUSLM IS 'Dashboard component details';
001600180609LABEL ON COLUMN DSHUSLM (
001700180609UCUSER  IS 'User                                                       ',
001800180609UCNAME IS 'Dashboard           Component           Name                ',
001900180705UCSEQ  IS 'Sequence                                                    ',
002000180609UCLUDT IS 'Last                Update              Date                ',
002100180609UCLUTM IS 'Last                Update              Time                ',
002200180609UCLUUS IS 'Last                Update              User                ',
002300180609UCLUPG IS 'Last                Update              Program             ');
002400180609LABEL ON COLUMN DSHUSLM (
002500180609UCUSER  TEXT IS 'User',
002600180609UCNAME TEXT IS 'Dashboard Component Name',
002700180705UCSEQ  TEXT IS 'Sequence',
002800180609UCLUDT TEXT IS 'Last Update Date',
002900180609UCLUTM TEXT IS 'Last Update Time',
003000180609UCLUUS TEXT IS 'Last Update User',
003100180609UCLUPG TEXT IS 'Last Update Program');
003200161208
003300180609ALTER TABLE DSHUSLM
003400180705  PRIMARY KEY (UCUSER,UCNAME);
