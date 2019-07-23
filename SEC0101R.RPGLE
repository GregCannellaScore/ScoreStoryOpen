000100081202      /copy qcpylesrc,stdhspec
000200941228     F*****************************************************************
000300941228     F*                                                               *
000400090205     F* Program ID...... SEC0101R                                     *
000500090205     F* Program Desc.... Test to see if a user is authorized to       *
000501090205     F*                  download programs.                           *
000600081202     F* Request Number..                                              *
000700941228     F*                                                               *
000800081204     F* Written By...... Greg Cannella                                *
000900081208     F* Date Written.... 12/09/08                                     *
001000081208     F*                                                               *
001100081202     F* Comments........                                              *
001200081202     F*                                                               *
001300941228     F*                                                               *
001400950719     F*****************************************************************
001500970418     F* Compile Options:                                              *
001600950719     F*                                                               *
001700951009     F*****************************************************************
001800951009     F* Modifications:                                                *
001900951009     F* Req#  By   Date      Modification                             *
002000960611     F* 1234  xxx  xx/xx/xx                                           *
002100960116     F*                                                               *
002200950608     F*****************************************************************
005200081202      *
005300090205     FSEC0101D  CF   E             Workstn
006501090205     d WISEC           s              5
006502090205     d Program         s             10
006503090205     d Authorized      s              1
007101090205      *
007102090205     c     *entry        Plist
007103090205     c                   Parm                    Program
007104090205     c                   Parm                    Authorized
022000090205      *
022100090205      * Set up security options:
022200090205      *
022201090205     c                   Eval      WRPGM = Program
022202090205     c                   Move      '00000'       wisec
022400090205     c                   CALL      'SEC0100R'
022500090205     c                   PARM                    Program
022600090205     c                   PARM                    WISEC
022601090205     c                   Movea     WISEC         *in(81)
022602090205     c                   If        *in84 = *off
022603090205     C                   Exfmt     Scrnr01
022605090205     c                   Eval      Authorized = 'N'
022606090205     c                   Else
022607090205     c                   Eval      Authorized = 'Y'
022608090205     c                   Endif
022701090205      *
022800090205     c                   Eval      *inlr = *on
