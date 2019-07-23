000100170411     /*-                                                                            +
000101170411      * Copyright (c) 2002-2006 Scott C. Klement                                    +
000102170411      * All rights reserved.                                                        +
000103170411      *                                                                             +
000104170411      * Redistribution and use in source and binary forms, with or without          +
000105170411      * modification, are permitted provided that the following conditions          +
000106170411      * are met:                                                                    +
000107170411      * 1. Redistributions of source code must retain the above copyright           +
000108170411      *    notice, this list of conditions and the following disclaimer.            +
000109170411      * 2. Redistributions in binary form must reproduce the above copyright        +
000110170411      *    notice, this list of conditions and the following disclaimer in the      +
000111170411      *    documentation and/or other materials provided with the distribution.     +
000112170411      *                                                                             +
000113170411      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
000114170411      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
000115170411      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
000116170411      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
000117170411      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
000118170411      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
000119170411      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
000120170411      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
000121170411      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
000122170411      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
000123170411      * SUCH DAMAGE.                                                                +
000124170411      *                                                                             +
000125170411      */                                                                            +
000126170411     D/if defined(IFSIO_H)
000127170411     D/eof
000128170411     D/endif
000129170411
000130170411     D/define IFSIO_H
000131170411
000132170411      **********************************************************************
000133170411      * Some CCSID definitions that I've found useful
000134170411      **********************************************************************
000135170411     D CP_MSDOS        C                   437
000136170411     D CP_ISO8859_1    C                   819
000137170411     D CP_WINDOWS      C                   1252
000138170411     D CP_UTF8         C                   1208
000139170411     D CP_UCS2         C                   1200
000140170411     D CP_CURJOB       C                   0
000141170411
000142170411      **********************************************************************
000143170411      *  Flags for use in open()
000144170411      *
000145170411      * More than one can be used -- add them together.
000146170411      **********************************************************************
000147170411      *  00000000000000000000000000000001          Reading Only
000148170411     D O_RDONLY        C                   1
000149170411      *  00000000000000000000000000000010          Writing Only
000150170411     D O_WRONLY        C                   2
000151170411      *  00000000000000000000000000000100          Reading & Writing
000152170411     D O_RDWR          C                   4
000153170411      *  00000000000000000000000000001000          Create File if needed
000154170411     D O_CREAT         C                   8
000155170411      *  00000000000000000000000000010000          Exclusively create --
000156170411      *                                              open will fail if it
000157170411      *                                              already exists.
000158170411     D O_EXCL          C                   16
000159170411      *  00000000000000000000000000100000          Assign a CCSID to new
000160170411      *                                            file.
000161170411     D O_CCSID         C                   32
000162170411      *  00000000000000000000000001000000          Truncate file to 0 bytes
000163170411     D O_TRUNC         C                   64
000164170411      *  00000000000000000000000100000000          Append to file
000165170411      *                                            (write data at end only)
000166170411     D O_APPEND        C                   256
000167170411      *  00000000000000000000010000000000          Synchronous write
000168170411     D O_SYNC          C                   1024
000169170411      *  00000000000000000000100000000000          Sync write, data only
000170170411     D O_DSYNC         C                   2048
000171170411      *  00000000000000000001000000000000          Sync read
000172170411     D O_RSYNC         C                   4096
000173170411      *  00000000000000001000000000000000          No controlling terminal
000174170411     D O_NOCTTY        C                   32768
000175170411      *  00000000000000010000000000000000          Share with readers only
000176170411     D O_SHARE_RDONLY  C                   65536
000177170411      *  00000000000000100000000000000000          Share with writers only
000178170411     D O_SHARE_WRONLY  C                   131072
000179170411      *  00000000000001000000000000000000          Share with read & write
000180170411     D O_SHARE_RDWR    C                   262144
000181170411      *  00000000000010000000000000000000          Share with nobody.
000182170411     D O_SHARE_NONE    C                   524288
000183170411      *  00000000100000000000000000000000          Assign a code page
000184170411     D O_CODEPAGE      C                   8388608
000185170411      *  00000001000000000000000000000000          Open in text-mode
000186170411     D O_TEXTDATA      C                   16777216
000187170411      /if defined(*V5R2M0)
000188170411      *  00000010000000000000000000000000          Allow text translation
000189170411      *                                            on newly created file.
000190170411      * Note: O_TEXT_CREAT requires all of the following flags to work:
000191170411      *           O_CREAT+O_TEXTDATA+(O_CODEPAGE or O_CCSID)
000192170411     D O_TEXT_CREAT    C                   33554432
000193170411      /endif
000194170411      *  00001000000000000000000000000000          Inherit mode from dir
000195170411     D O_INHERITMODE   C                   134217728
000196170411      *  00100000000000000000000000000000          Large file access
000197170411      *                                            (for >2GB files)
000198170411     D O_LARGEFILE     C                   536870912
000199170411
000200170411      **********************************************************************
000201170411      * Access mode flags for access() and accessx()
000202170411      *
000203170411      *   F_OK = File Exists
000204170411      *   R_OK = Read Access
000205170411      *   W_OK = Write Access
000206170411      *   X_OK = Execute or Search
000207170411      **********************************************************************
000208170411     D F_OK            C                   0
000209170411     D R_OK            C                   4
000210170411     D W_OK            C                   2
000211170411     D X_OK            C                   1
000212170411
000213170411      **********************************************************************
000214170411      * class of users flags for accessx()
000215170411      *
000216170411      *   ACC_SELF = Check access based on effective uid/gid
000217170411      *   ACC_INVOKER = Check access based on real uid/gid
000218170411      *                 ( this is equvalent to calling access() )
000219170411      *   ACC_OTHERS = Check access of someone not the owner
000220170411      *   ACC_ALL = Check access of all users
000221170411      **********************************************************************
000222170411     D ACC_SELF        C                   0
000223170411     D ACC_INVOKER     C                   1
000224170411     D ACC_OTHERS      C                   8
000225170411     D ACC_ALL         C                   32
000226170411
000227170411      **********************************************************************
000228170411      *      Mode Flags.
000229170411      *         basically, the mode parm of open(), creat(), chmod(),etc
000230170411      *         uses 9 least significant bits to determine the
000231170411      *         file's mode. (peoples access rights to the file)
000232170411      *
000233170411      *           user:       owner    group    other
000234170411      *           access:     R W X    R W X    R W X
000235170411      *           bit:        8 7 6    5 4 3    2 1 0
000236170411      *
000237170411      * (This is accomplished by adding the flags below to get the mode)
000238170411      **********************************************************************
000239170411      *                                         owner authority
000240170411     D S_IRUSR         C                   256
000241170411     D S_IWUSR         C                   128
000242170411     D S_IXUSR         C                   64
000243170411     D S_IRWXU         C                   448
000244170411      *                                         group authority
000245170411     D S_IRGRP         C                   32
000246170411     D S_IWGRP         C                   16
000247170411     D S_IXGRP         C                   8
000248170411     D S_IRWXG         C                   56
000249170411      *                                         other people
000250170411     D S_IROTH         C                   4
000251170411     D S_IWOTH         C                   2
000252170411     D S_IXOTH         C                   1
000253170411     D S_IRWXO         C                   7
000254170411      *                                         special modes:
000255170411      *                                         restrict rename/unlink
000256170411     D S_ISVTX         C                    512
000257170411      *                                         Set effective GID
000258170411     D S_ISGID         C                   1024
000259170411      *                                         Set effective UID
000260170411     D S_ISUID         C                   2048
000261170411
000262170411      **********************************************************************
000263170411      * My own special MODE shortcuts for open() (instead of those above)
000264170411      **********************************************************************
000265170411     D M_RDONLY        C                   const(292)
000266170411     D M_RDWR          C                   const(438)
000267170411     D M_RWX           C                   const(511)
000268170411
000269170411      **********************************************************************
000270170411      * "whence" constants for use with seek(), lseek() and others
000271170411      **********************************************************************
000272170411      /if not defined(SEEK_WHENCE_VALUES)
000273170411     D SEEK_SET        C                   CONST(0)
000274170411     D SEEK_CUR        C                   CONST(1)
000275170411     D SEEK_END        C                   CONST(2)
000276170411      /define SEEK_WHENCE_VALUES
000277170411      /endif
000278170411
000279170411      **********************************************************************
000280170411      * flags specified in the f_flags element of the ds_statvfs
000281170411      *   data structure used by the statvfs() API
000282170411      **********************************************************************
000283170411     D ST_RDONLY...
000284170411     D                 C                   CONST(1)
000285170411     D ST_NOSUID...
000286170411     D                 C                   CONST(2)
000287170411     D ST_CASE_SENSITITIVE...
000288170411     D                 C                   CONST(4)
000289170411     D ST_CHOWN_RESTRICTED...
000290170411     D                 C                   CONST(8)
000291170411     D ST_THREAD_SAFE...
000292170411     D                 C                   CONST(16)
000293170411     D ST_DYNAMIC_MOUNT...
000294170411     D                 C                   CONST(32)
000295170411     D ST_NO_MOUNT_OVER...
000296170411     D                 C                   CONST(64)
000297170411     D ST_NO_EXPORTS...
000298170411     D                 C                   CONST(128)
000299170411     D ST_SYNCHRONOUS...
000300170411     D                 C                   CONST(256)
000301170411
000302170411      **********************************************************************
000303170411      * Constants used by pathconf() API
000304170411      **********************************************************************
000305170411     D PC_CHOWN_RESTRICTED...
000306170411     D                 C                   0
000307170411     D PC_LINK_MAX...
000308170411     D                 C                   1
000309170411     D PC_MAX_CANON...
000310170411     D                 C                   2
000311170411     D PC_MAX_INPUT...
000312170411     D                 C                   3
000313170411     D PC_NAME_MAX...
000314170411     D                 C                   4
000315170411     D PC_NO_TRUNC...
000316170411     D                 C                   5
000317170411     D PC_PATH_MAX...
000318170411     D                 C                   6
000319170411     D PC_PIPE_BUF...
000320170411     D                 C                   7
000321170411     D PC_VDISABLE...
000322170411     D                 C                   8
000323170411     D PC_THREAD_SAFE...
000324170411     D                 C                   9
000325170411
000326170411      **********************************************************************
000327170411      * Constants used by sysconf() API
000328170411      **********************************************************************
000329170411     D SC_CLK_TCK...
000330170411     D                 C                   2
000331170411     D SC_NGROUPS_MAX...
000332170411     D                 C                   3
000333170411     D SC_OPEN_MAX...
000334170411     D                 C                   4
000335170411     D SC_STREAM_MAX...
000336170411     D                 C                   5
000337170411     D SC_CCSID...
000338170411     D                 C                   10
000339170411     D SC_PAGE_SIZE...
000340170411     D                 C                   11
000341170411     D SC_PAGESIZE...
000342170411     D                 C                   12
000343170411
000344170411      **********************************************************************
000345170411      * File Information Structure (stat)
000346170411      *   struct stat {
000347170411      *     mode_t         st_mode;       /* File mode                       */
000348170411      *     ino_t          st_ino;        /* File serial number              */
000349170411      *     nlink_t        st_nlink;      /* Number of links                 */
000350170411      *     unsigned short st_reserved2;  /* Reserved                    @B4A*/
000351170411      *     uid_t          st_uid;        /* User ID of the owner of file    */
000352170411      *     gid_t          st_gid;        /* Group ID of the group of file   */
000353170411      *     off_t          st_size;       /* For regular files, the file
000354170411      *                                      size in bytes                   */
000355170411      *     time_t         st_atime;      /* Time of last access             */
000356170411      *     time_t         st_mtime;      /* Time of last data modification  */
000357170411      *     time_t         st_ctime;      /* Time of last file status change */
000358170411      *     dev_t          st_dev;        /* ID of device containing file    */
000359170411      *     size_t         st_blksize;    /* Size of a block of the file     */
000360170411      *     unsigned long  st_allocsize;  /* Allocation size of the file     */
000361170411      *     qp0l_objtype_t st_objtype;    /* AS/400 object type              */
000362170411      *     char           st_reserved3;  /* Reserved                    @B4A*/
000363170411      *     unsigned short st_codepage;   /* Object data codepage            */
000364170411      *     unsigned short st_ccsid;      /* Object data ccsid           @AAA*/
000365170411      *     dev_t          st_rdev;       /* Device ID (if character special */
000366170411      *                                   /* or block special file)      @B4A*/
000367170411      *     nlink32_t      st_nlink32;    /* Number of links-32 bit      @B5C*/
000368170411      *     dev64_t        st_rdev64;     /* Device ID - 64 bit form     @B4A*/
000369170411      *     dev64_t        st_dev64;      /* ID of device containing file -  */
000370170411      *                                   /* 64 bit form.                @B4A*/
000371170411      *     char           st_reserved1[36]; /* Reserved                 @B4A*/
000372170411      *     unsigned int   st_ino_gen_id; /* File serial number generation id
000373170411      *  };
000374170411      *                                                                  @A2A*/
000375170411      **********************************************************************
000376170411     D statds          DS                  qualified
000377170411     D                                     BASED(Template)
000378170411     D  st_mode                      10U 0
000379170411     D  st_ino                       10U 0
000380170411     D  st_nlink                      5U 0
000381170411     D  st_reserved2                  5U 0
000382170411     D  st_uid                       10U 0
000383170411     D  st_gid                       10U 0
000384170411     D  st_size                      10I 0
000385170411     D  st_atime                     10I 0
000386170411     D  st_mtime                     10I 0
000387170411     D  st_ctime                     10I 0
000388170411     D  st_dev                       10U 0
000389170411     D  st_blksize                   10U 0
000390170411     D  st_allocsize                 10U 0
000391170411     D  st_objtype                   11A
000392170411     D  st_reserved3                  1A
000393170411     D  st_codepage                   5U 0
000394170411     D  st_ccsid                      5U 0
000395170411     D  st_rdev                      10U 0
000396170411     D  st_nlink32                   10U 0
000397170411     D  st_rdev64                    20U 0
000398170411     D  st_dev64                     20U 0
000399170411     D  st_reserved1                 36A
000400170411     D  st_ino_gen_id                10U 0
000401170411
000402170411
000403170411      **********************************************************************
000404170411      * File Information Structure, Large File Enabled (stat64)
000405170411      *   struct stat64 {                                                    */
000406170411      *     mode_t         st_mode;       /* File mode                       */
000407170411      *     ino_t          st_ino;        /* File serial number              */
000408170411      *     uid_t          st_uid;        /* User ID of the owner of file    */
000409170411      *     gid_t          st_gid;        /* Group ID of the group of fileA2A*/
000410170411      *     off64_t        st_size;       /* For regular files, the file     */
000411170411      *                                      size in bytes                   */
000412170411      *     time_t         st_atime;      /* Time of last access             */
000413170411      *     time_t         st_mtime;      /* Time of last data modification2A*/
000414170411      *     time_t         st_ctime;      /* Time of last file status changeA*/
000415170411      *     dev_t          st_dev;        /* ID of device containing file    */
000416170411      *     size_t         st_blksize;    /* Size of a block of the file     */
000417170411      *     nlink_t        st_nlink;      /* Number of links                 */
000418170411      *     unsigned short st_codepage;   /* Object data codepage            */
000419170411      *     unsigned long long st_allocsize; /* Allocation size of the file2A*/
000420170411      *     unsigned int   st_ino_gen_id; /* File serial number generationAid*/
000421170411      *                                                                      */
000422170411      *     qp0l_objtype_t st_objtype;    /* AS/400 object type              */
000423170411      *     char           st_reserved2[5]; /* Reserved                  @B4A*/
000424170411      *     dev_t          st_rdev;       /* Device ID (if character specialA*/
000425170411      *                                   /* or block special file)      @B4A*/
000426170411      *     dev64_t        st_rdev64;     /* Device ID - 64 bit form     @B4A*/
000427170411      *     dev64_t        st_dev64;      /* ID of device containing file@-2A*/
000428170411      *                                   /* 64 bit form.                @B4A*/
000429170411      *     nlink32_t      st_nlink32;    /* Number of links-32 bit      @B5A*/
000430170411      *     char           st_reserved1[26]; /* Reserved            @B4A @B5C*/
000431170411      *     unsigned short st_ccsid;      /* Object data ccsid           @AAA*/
000432170411      *  };                                                                  */
000433170411      *
000434170411      **********************************************************************
000435170411     D statds64        DS                  qualified
000436170411     D                                     BASED(Template)
000437170411     D  st_mode                      10U 0
000438170411     D  st_ino                       10U 0
000439170411     D  st_uid                       10U 0
000440170411     D  st_gid                       10U 0
000441170411     D  st_size                      20I 0
000442170411     D  st_atime                     10I 0
000443170411     D  st_mtime                     10I 0
000444170411     D  st_ctime                     10I 0
000445170411     D  st_dev                       10U 0
000446170411     D  st_blksize                   10U 0
000447170411     D  st_nlink                      5U 0
000448170411     D  st_codepage                   5U 0
000449170411     D  st_allocsize                 20U 0
000450170411     D  st_ino_gen_id                10U 0
000451170411     D  st_objtype                   11A
000452170411     D  st_reserved2                  5A
000453170411     D  st_rdev                      10U 0
000454170411     D  st_rdev64                    20U 0
000455170411     D  st_dev64                     20U 0
000456170411     D  st_nlink32                   10U 0
000457170411     D  st_reserved1                 26A
000458170411     D  st_ccsid                      5U 0
000459170411
000460170411      **********************************************************************
000461170411      * ds_statvfs - data structure to receive file system info
000462170411      *
000463170411      *   f_bsize   = file system block size (in bytes)
000464170411      *   f_frsize  = fundamental block size in bytes.
000465170411      *                if this is zero, f_blocks, f_bfree and f_bavail
000466170411      *                are undefined.
000467170411      *   f_blocks  = total number of blocks (in f_frsize)
000468170411      *   f_bfree   = total free blocks in filesystem (in f_frsize)
000469170411      *   f_bavail  = total blocks available to users (in f_frsize)
000470170411      *   f_files   = total number of file serial numbers
000471170411      *   f_ffree   = total number of unused file serial numbers
000472170411      *   f_favail  = number of available file serial numbers to users
000473170411      *   f_fsid    = filesystem ID.  This will be 4294967295 if it's
000474170411      *                too large for a 10U 0 field. (see f_fsid64)
000475170411      *   f_flag    = file system flags (see below)
000476170411      *   f_namemax = max filename length.  May be 4294967295 to
000477170411      *                indicate that there is no maximum.
000478170411      *   f_pathmax = max pathname legnth.  May be 4294967295 to
000479170411      *                indicate that there is no maximum.
000480170411      *   f_objlinkmax = maximum number of hard-links for objects
000481170411      *                other than directories
000482170411      *   f_dirlinkmax = maximum number of hard-links for directories
000483170411      *   f_fsid64  = filesystem id (in a 64-bit integer)
000484170411      *   f_basetype = null-terminated string containing the file
000485170411      *                  system type name.  For example, this might
000486170411      *                  be "root" or "Network File System (NFS)"
000487170411      *
000488170411      *  Since f_basetype is null-terminated, you should read it
000489170411      *  in ILE RPG with:
000490170411      *       myString = %str(%addr(ds_statvfs.f_basetype))
000491170411      **********************************************************************
000492170411     D ds_statvfs      DS                  qualified
000493170411     D                                     BASED(Template)
000494170411     D  f_bsize                      10U 0
000495170411     D  f_frsize                     10U 0
000496170411     D  f_blocks                     20U 0
000497170411     D  f_bfree                      20U 0
000498170411     D  f_bavail                     20U 0
000499170411     D  f_files                      10U 0
000500170411     D  f_ffree                      10U 0
000501170411     D  f_favail                     10U 0
000502170411     D  f_fsid                       10U 0
000503170411     D  f_flag                       10U 0
000504170411     D  f_namemax                    10U 0
000505170411     D  f_pathmax                    10U 0
000506170411     D  f_objlinkmax                 10I 0
000507170411     D  f_dirlinkmax                 10I 0
000508170411     D  f_reserved1                   4A
000509170411     D  f_fsid64                     20U 0
000510170411     D  f_basetype                   80A
000511170411
000512170411
000513170411      **********************************************************************
000514170411      * Group Information Structure (group)
000515170411      *
000516170411      *  struct group {
000517170411      *        char    *gr_name;        /* Group name.                      */
000518170411      *        gid_t   gr_gid;          /* Group id.                        */
000519170411      *        char    **gr_mem;        /* A null-terminated list of pointers
000520170411      *                                    to the individual member names.  */
000521170411      *  };
000522170411      *
000523170411      **********************************************************************
000524170411     D group           DS                  qualified
000525170411     D                                     BASED(Template)
000526170411     D   gr_name                       *
000527170411     D   gr_gid                      10U 0
000528170411     D   gr_mem                        *   DIM(256)
000529170411
000530170411
000531170411      **********************************************************************
000532170411      * User Information Structure (passwd)
000533170411      *
000534170411      * (Don't let the name fool you, this structure does not contain
000535170411      *  any password information.  Its named after the UNIX file that
000536170411      *  contains all of the user info.  That file is "passwd")
000537170411      *
000538170411      *   struct passwd {
000539170411      *        char    *pw_name;            /* User name.                   */
000540170411      *        uid_t   pw_uid;              /* User ID number.              */
000541170411      *        gid_t   pw_gid;              /* Group ID number.             */
000542170411      *        char    *pw_dir;             /* Initial working directory.   */
000543170411      *        char    *pw_shell;           /* Initial user program.        */
000544170411      *   };
000545170411      *
000546170411      **********************************************************************
000547170411     D passwd          DS                  qualified
000548170411     D                                     BASED(Template)
000549170411     D  pw_name                        *
000550170411     D  pw_uid                       10U 0
000551170411     D  pw_gid                       10U 0
000552170411     D  pw_dir                         *
000553170411     D  pw_shell                       *
000554170411
000555170411
000556170411      **********************************************************************
000557170411      * File Time Structure (utimbuf)
000558170411      *
000559170411      * struct utimbuf {
000560170411      *    time_t     actime;           /*  access time       */
000561170411      *    time_t     modtime;          /*  modification time */
000562170411      * };
000563170411      *
000564170411      **********************************************************************
000565170411     D utimbuf         DS                  qualified
000566170411     D                                     BASED(Template)
000567170411     D   actime                      10I 0
000568170411     D   modtime                     10I 0
000569170411
000570170411
000571170411      **********************************************************************
000572170411      * Directory Entry Structure (dirent)
000573170411      *
000574170411      * struct dirent {
000575170411      *   char           d_reserved1[16];  /* Reserved                       */
000576170411      *   unsigned int   d_fileno_gen_id   /* File number generation ID  @A1C*/
000577170411      *   ino_t          d_fileno;         /* The file number of the file    */
000578170411      *   unsigned int   d_reclen;         /* Length of this directory entry
000579170411      *                                     * in bytes                       */
000580170411      *   int            d_reserved3;      /* Reserved                       */
000581170411      *   char           d_reserved4[8];   /* Reserved                       */
000582170411      *   qlg_nls_t      d_nlsinfo;        /* National Language Information
000583170411      *                                     * about d_name                   */
000584170411      *   unsigned int   d_namelen;        /* Length of the name, in bytes
000585170411      *                                     * excluding NULL terminator      */
000586170411      *   char           d_name[_QP0L_DIR_NAME]; /* Name...null terminated   */
000587170411      *
000588170411      * };
000589170411      **********************************************************************
000590170411     D dirent          ds                  qualified
000591170411     D                                     BASED(Template)
000592170411     D   d_reserv1                   16A
000593170411     D   d_fileno_gen_id...
000594170411     D                               10U 0
000595170411     D   d_fileno                    10U 0
000596170411     D   d_reclen                    10U 0
000597170411     D   d_reserv3                   10I 0
000598170411     D   d_reserv4                    8A
000599170411     D   d_nlsinfo                   12A
000600170411     D    d_nls_ccsid                10I 0 OVERLAY(d_nlsinfo:1)
000601170411     D    d_nls_cntry                 2A   OVERLAY(d_nlsinfo:5)
000602170411     D    d_nls_lang                  3A   OVERLAY(d_nlsinfo:7)
000603170411     D   d_namelen                   10U 0
000604170411     D   d_name                     640A
000605170411
000606170411      **********************************************************************
000607170411      * I/O Vector Structure
000608170411      *
000609170411      *     struct iovec {
000610170411      *        void    *iov_base;
000611170411      *        size_t  iov_len;
000612170411      *     }
000613170411      **********************************************************************
000614170411      /if not defined(IOVEC_DS_DEFINED)
000615170411     D iovec           DS                  qualified
000616170411     D                                     BASED(p_iovec)
000617170411     D  iov_base                       *
000618170411     D  iov_len                      10U 0
000619170411      /define IOVEC_DS_DEFINED
000620170411      /endif
000621170411
000622170411      *--------------------------------------------------------------------
000623170411      * Determine file accessibility
000624170411      *
000625170411      * int access(const char *path, int amode)
000626170411      *
000627170411      *--------------------------------------------------------------------
000628170411     D access          PR            10I 0 ExtProc('access')
000629170411     D   Path                          *   Value Options(*string)
000630170411     D   amode                       10I 0 Value
000631170411
000632170411
000633170411      *--------------------------------------------------------------------
000634170411      * Determine file accessibility for a class of users
000635170411      *
000636170411      * int accessx(const char *path, int amode, int who);
000637170411      *
000638170411      *--------------------------------------------------------------------
000639170411      /if defined(*V5R2M0)
000640170411     D accessx         PR            10I 0 ExtProc('accessx')
000641170411     D   Path                          *   Value Options(*string)
000642170411     D   amode                       10I 0 Value
000643170411     D   who                         10I 0 value
000644170411      /endif
000645170411
000646170411      *--------------------------------------------------------------------
000647170411      * Change Directory
000648170411      *
000649170411      * int chdir(const char *path)
000650170411      *--------------------------------------------------------------------
000651170411     D chdir           PR            10I 0 ExtProc('chdir')
000652170411     D   path                          *   Value Options(*string)
000653170411
000654170411      *--------------------------------------------------------------------
000655170411      * Change file authorizations
000656170411      *
000657170411      * int chmod(const char *path, mode_t mode)
000658170411      *--------------------------------------------------------------------
000659170411     D chmod           PR            10I 0 ExtProc('chmod')
000660170411     D   path                          *   Value options(*string)
000661170411     D   mode                        10U 0 Value
000662170411
000663170411      *--------------------------------------------------------------------
000664170411      * Change Owner/Group of File
000665170411      *
000666170411      * int chown(const char *path, uid_t owner, gid_t group)
000667170411      *--------------------------------------------------------------------
000668170411     D chown           PR            10I 0 ExtProc('chown')
000669170411     D   path                          *   Value options(*string)
000670170411     D   owner                       10U 0 Value
000671170411     D   group                       10U 0 Value
000672170411
000673170411      *--------------------------------------------------------------------
000674170411      * Close a file
000675170411      *
000676170411      * int close(int fildes)
000677170411      *
000678170411      * Note:  Because the same close() API is used for IFS, sockets,
000679170411      *        and pipes, it's conditionally defined here.  If it's
000680170411      *        done the same in the sockets & pipe /copy members,
000681170411      *        there will be no conflict.
000682170411      *--------------------------------------------------------------------
000683170411     D/if not defined(CLOSE_PROTOTYPE)
000684170411     D close           PR            10I 0 ExtProc('close')
000685170411     D  fildes                       10I 0 value
000686170411     D/define CLOSE_PROTOTYPE
000687170411     D/endif
000688170411
000689170411      *--------------------------------------------------------------------
000690170411      * Close a directory
000691170411      *
000692170411      * int closedir(DIR *dirp)
000693170411      *--------------------------------------------------------------------
000694170411     D closedir        PR            10I 0 EXTPROC('closedir')
000695170411     D  dirp                           *   VALUE
000696170411
000697170411      *--------------------------------------------------------------------
000698170411      * Create or Rewrite File
000699170411      *
000700170411      * int creat(const char *path, mode_t mode)
000701170411      *
000702170411      * DEPRECATED:  Use open() instead.
000703170411      *--------------------------------------------------------------------
000704170411     D creat           PR            10I 0 ExtProc('creat')
000705170411     D   path                          *   Value options(*string)
000706170411     D   mode                        10U 0 Value
000707170411
000708170411      *--------------------------------------------------------------------
000709170411      * Duplicate open file descriptor
000710170411      *
000711170411      * int dup(int fildes)
000712170411      *--------------------------------------------------------------------
000713170411     D dup             PR            10I 0 ExtProc('dup')
000714170411     D   fildes                      10I 0 Value
000715170411
000716170411      *--------------------------------------------------------------------
000717170411      * Duplicate open file descriptor to another descriptor
000718170411      *
000719170411      * int dup2(int fildes, int fildes2)
000720170411      *--------------------------------------------------------------------
000721170411     D dup2            PR            10I 0 ExtProc('dup2')
000722170411     D   fildes                      10I 0 Value
000723170411     D   fildes2                     10I 0 Value
000724170411
000725170411      *--------------------------------------------------------------------
000726170411      * Determine file accessibility for a class of users by descriptor
000727170411      *
000728170411      * int faccessx(int filedes, int amode, int who)
000729170411      *--------------------------------------------------------------------
000730170411      /if defined(*V5R2M0)
000731170411     D faccessx        PR            10I 0 ExtProc('faccessx')
000732170411     D   fildes                      10I 0 Value
000733170411     D   amode                       10I 0 Value
000734170411     D   who                         10I 0 Value
000735170411      /endif
000736170411
000737170411      *--------------------------------------------------------------------
000738170411      * Change Current Directory by Descriptor
000739170411      *
000740170411      * int fchdir(int fildes)
000741170411      *--------------------------------------------------------------------
000742170411      /if defined(*V5R2M0)
000743170411     D fchdir          PR            10I 0 ExtProc('fchdir')
000744170411     D   fildes                      10I 0 value
000745170411      /endif
000746170411
000747170411      *--------------------------------------------------------------------
000748170411      * Change file authorizations by descriptor
000749170411      *
000750170411      * int fchmod(int fildes, mode_t mode)
000751170411      *--------------------------------------------------------------------
000752170411     D fchmod          PR            10I 0 ExtProc('fchmod')
000753170411     D   fildes                      10I 0 Value
000754170411     D   mode                        10U 0 Value
000755170411
000756170411      *--------------------------------------------------------------------
000757170411      * Change Owner and Group of File by Descriptor
000758170411      *
000759170411      * int fchown(int fildes, uid_t owner, gid_t group)
000760170411      *--------------------------------------------------------------------
000761170411     D fchown          PR            10I 0 ExtProc('fchown')
000762170411     D   fildes                      10I 0 Value
000763170411     D   owner                       10U 0 Value
000764170411     D   group                       10U 0 Value
000765170411
000766170411      *--------------------------------------------------------------------
000767170411      * Perform File Control
000768170411      *
000769170411      * int fcntl(int fildes, int cmd, . . .)
000770170411      *
000771170411      * Note:  Because the same fcntl() API is used for IFS and sockets,
000772170411      *        it's conditionally defined here.  If it's defined with
000773170411      *        the same conditions in the sockets /copy member, there
000774170411      *        will be no conflict.
000775170411      *--------------------------------------------------------------------
000776170411     D/if not defined(FCNTL_PROTOTYPE)
000777170411     D fcntl           PR            10I 0 ExtProc('fcntl')
000778170411     D   fildes                      10I 0 Value
000779170411     D   cmd                         10I 0 Value
000780170411     D   arg                         10I 0 Value options(*nopass)
000781170411     D/define FCNTL_PROTOTYPE
000782170411     D/endif
000783170411
000784170411      *--------------------------------------------------------------------
000785170411      * Get configurable path name variables by descriptor
000786170411      *
000787170411      * long fpathconf(int fildes, int name)
000788170411      *--------------------------------------------------------------------
000789170411     D fpathconf       PR            10I 0 ExtProc('fpathconf')
000790170411     D   fildes                      10I 0 Value
000791170411     D   name                        10I 0 Value
000792170411
000793170411      *--------------------------------------------------------------------
000794170411      * Get File Information by Descriptor
000795170411      *
000796170411      * int fstat(int fildes, struct stat *buf)
000797170411      *--------------------------------------------------------------------
000798170411     D fstat           PR            10I 0 ExtProc('fstat')
000799170411     D   fildes                      10I 0 Value
000800170411     D   buf                               likeds(statds)
000801170411
000802170411      *--------------------------------------------------------------------
000803170411      * Get File Information by Descriptor, Large File Enabled
000804170411      *
000805170411      * int fstat64(int fildes, struct stat *buf)
000806170411      *--------------------------------------------------------------------
000807170411     D fstat64         PR            10I 0 ExtProc('fstat64')
000808170411     D   fildes                      10I 0 Value
000809170411     D   buf                               likeds(statds64)
000810170411
000811170411      *--------------------------------------------------------------------
000812170411      * fstatvfs() -- Get file system status by descriptor
000813170411      *
000814170411      *  fildes = (input) file descriptor to use to locate file system
000815170411      *     buf = (output) data structure containing file system info
000816170411      *
000817170411      * Returns 0 if successful, -1 upon error.
000818170411      * (error information is returned via the "errno" variable)
000819170411      *--------------------------------------------------------------------
000820170411     D fstatvfs        PR            10I 0 ExtProc('fstatvfs64')
000821170411     D   fildes                      10I 0 value
000822170411     D   buf                               like(ds_statvfs)
000823170411
000824170411      *--------------------------------------------------------------------
000825170411      * Synchronize Changes to file
000826170411      *
000827170411      * int fsync(int fildes)
000828170411      *--------------------------------------------------------------------
000829170411     D fsync           PR            10I 0 ExtProc('fsync')
000830170411     D   fildes                      10I 0 Value
000831170411
000832170411      *--------------------------------------------------------------------
000833170411      * Truncate file
000834170411      *
000835170411      * int ftruncate(int fildes, off_t length)
000836170411      *--------------------------------------------------------------------
000837170411     D ftruncate       PR            10I 0 ExtProc('ftruncate')
000838170411     D   fildes                      10I 0 Value
000839170411     D   length                      10I 0 Value
000840170411
000841170411      *--------------------------------------------------------------------
000842170411      * Truncate file, large file enabled
000843170411      *
000844170411      * int ftruncate64(int fildes, off64_t length)
000845170411      *--------------------------------------------------------------------
000846170411     D ftruncate64     PR            10I 0 ExtProc('ftruncate64')
000847170411     D   fildes                      10I 0 Value
000848170411     D   length                      20I 0 Value
000849170411
000850170411      *--------------------------------------------------------------------
000851170411      * Get current working directory
000852170411      *
000853170411      * char *getcwd(char *buf, size_t size)
000854170411      *--------------------------------------------------------------------
000855170411     D getcwd          PR              *   ExtProc('getcwd')
000856170411     D   buf                           *   Value
000857170411     D   size                        10U 0 Value
000858170411
000859170411      *--------------------------------------------------------------------
000860170411      * Get effective group ID
000861170411      *
000862170411      * gid_t getegid(void)
000863170411      *--------------------------------------------------------------------
000864170411     D getegid         PR            10U 0 ExtProc('getegid')
000865170411
000866170411      *--------------------------------------------------------------------
000867170411      * Get effective user ID
000868170411      *
000869170411      * uid_t geteuid(void)
000870170411      *--------------------------------------------------------------------
000871170411     D geteuid         PR            10U 0 ExtProc('geteuid')
000872170411
000873170411      *--------------------------------------------------------------------
000874170411      * Get Real Group ID
000875170411      *
000876170411      * gid_t getgid(void)
000877170411      *--------------------------------------------------------------------
000878170411     D getgid          PR            10U 0 ExtProc('getgid')
000879170411
000880170411      *--------------------------------------------------------------------
000881170411      * Get group information from group ID
000882170411      *
000883170411      * struct group *getgrgid(gid_t gid)
000884170411      *--------------------------------------------------------------------
000885170411     D getgrgid        PR              *   ExtProc('getgrgid')
000886170411     D   gid                         10U 0 VALUE
000887170411
000888170411      *--------------------------------------------------------------------
000889170411      * Get group info using group name
000890170411      *
000891170411      * struct group  *getgrnam(const char *name)
000892170411      *--------------------------------------------------------------------
000893170411     D getgrnam        PR              *   ExtProc('getgrnam')
000894170411     D   name                          *   VALUE
000895170411
000896170411      *--------------------------------------------------------------------
000897170411      * Get group IDs
000898170411      *
000899170411      * int getgroups(int gidsetsize, gid_t grouplist[])
000900170411      *--------------------------------------------------------------------
000901170411     D getgroups       PR              *   ExtProc('getgroups')
000902170411     D   gidsetsize                  10I 0 value
000903170411     D   grouplist                   10U 0 dim(256) options(*varsize)
000904170411
000905170411      *--------------------------------------------------------------------
000906170411      * Get user information by user-name
000907170411      *
000908170411      * (Don't let the name mislead you, this does not return the password,
000909170411      *  the user info database on unix systems is called "passwd",
000910170411      *  therefore, getting the user info is called "getpw")
000911170411      *
000912170411      * struct passwd *getpwnam(const char *name)
000913170411      *--------------------------------------------------------------------
000914170411     D getpwnam        PR              *   ExtProc('getpwnam')
000915170411     D   name                          *   Value options(*string)
000916170411
000917170411      *--------------------------------------------------------------------
000918170411      * Get user information by user-id number
000919170411      *
000920170411      * (Don't let the name mislead you, this does not return the password,
000921170411      *  the user info database on unix systems is called "passwd",
000922170411      *  therefore, getting the user info is called "getpw")
000923170411      *
000924170411      * struct passwd *getpwuid(uid_t uid)
000925170411      *--------------------------------------------------------------------
000926170411     D getpwuid        PR              *   extproc('getpwuid')
000927170411     D   uid                         10U 0 Value
000928170411
000929170411      *--------------------------------------------------------------------
000930170411      * Get Real User-ID
000931170411      *
000932170411      * uid_t getuid(void)
000933170411      *--------------------------------------------------------------------
000934170411     D getuid          PR            10U 0 ExtProc('getuid')
000935170411
000936170411      *--------------------------------------------------------------------
000937170411      * Perform I/O Control Request
000938170411      *
000939170411      * int ioctl(int fildes, unsigned long req, ...)
000940170411      *--------------------------------------------------------------------
000941170411     D ioctl           PR            10I 0 ExtProc('ioctl')
000942170411     D   fildes                      10I 0 Value
000943170411     D   req                         10U 0 Value
000944170411     D   arg                           *   Value
000945170411
000946170411      *--------------------------------------------------------------------
000947170411      * Change Owner/Group of symbolic link
000948170411      *
000949170411      * int lchown(const char *path, uid_t owner, gid_t group)
000950170411      *
000951170411      * NOTE: for non-symlinks, this behaves identically to chown().
000952170411      *       for symlinks, this changes ownership of the link, whereas
000953170411      *       chown() changes ownership of the file the link points to.
000954170411      *--------------------------------------------------------------------
000955170411     D lchown          PR            10I 0 ExtProc('lchown')
000956170411     D   path                          *   Value options(*string)
000957170411     D   owner                       10U 0 Value
000958170411     D   group                       10U 0 Value
000959170411
000960170411      *--------------------------------------------------------------------
000961170411      * Create Hard Link to File
000962170411      *
000963170411      * int link(const char *existing, const char *new)
000964170411      *--------------------------------------------------------------------
000965170411     D link            PR            10I 0 ExtProc('link')
000966170411     D   existing                      *   Value options(*string)
000967170411     D   new                           *   Value options(*string)
000968170411
000969170411      *--------------------------------------------------------------------
000970170411      * Set File Read/Write Offset
000971170411      *
000972170411      * off_t lseek(int fildes, off_t offset, int whence)
000973170411      *--------------------------------------------------------------------
000974170411     D lseek           PR            10I 0 ExtProc('lseek')
000975170411     D   fildes                      10I 0 value
000976170411     D   offset                      10I 0 value
000977170411     D   whence                      10I 0 value
000978170411
000979170411      *--------------------------------------------------------------------
000980170411      * Set File Read/Write Offset, Large File Enabled
000981170411      *
000982170411      * off64_t lseek64(int fildes, off64_t offset, int whence)
000983170411      *--------------------------------------------------------------------
000984170411     D lseek64         PR            20I 0 ExtProc('lseek64')
000985170411     D   fildes                      10I 0 value
000986170411     D   offset                      20I 0 value
000987170411     D   whence                      10I 0 value
000988170411
000989170411      *--------------------------------------------------------------------
000990170411      * Get File or Link Information
000991170411      *
000992170411      * int lstat(const char *path, struct stat *buf)
000993170411      *
000994170411      * NOTE: for non-symlinks, this behaves identically to stat().
000995170411      *       for symlinks, this gets information about the link, whereas
000996170411      *       stat() gets information about the file the link points to.
000997170411      *--------------------------------------------------------------------
000998170411     D lstat           PR            10I 0 ExtProc('lstat')
000999170411     D   path                          *   Value options(*string)
001000170411     D   buf                               likeds(statds)
001001170411
001002170411      *--------------------------------------------------------------------
001003170411      * Get File or Link Information, Large File Enabled
001004170411      *
001005170411      * int lstat64(const char *path, struct stat64 *buf)
001006170411      *
001007170411      * NOTE: for non-symlinks, this behaves identically to stat().
001008170411      *       for symlinks, this gets information about the link, whereas
001009170411      *       stat() gets information about the file the link points to.
001010170411      *--------------------------------------------------------------------
001011170411     D lstat64         PR            10I 0 ExtProc('lstat64')
001012170411     D   path                          *   Value options(*string)
001013170411     D   buf                               likeds(statds64)
001014170411
001015170411      *--------------------------------------------------------------------
001016170411      * Make Directory
001017170411      *
001018170411      * int mkdir(const char *path, mode_t mode)
001019170411      *--------------------------------------------------------------------
001020170411     D mkdir           PR            10I 0 ExtProc('mkdir')
001021170411     D   path                          *   Value options(*string)
001022170411     D   mode                        10U 0 Value
001023170411
001024170411      *--------------------------------------------------------------------
001025170411      * Make FIFO Special File
001026170411      *
001027170411      * int mkfifo(const char *path, mode_t mode)
001028170411      *--------------------------------------------------------------------
001029170411      /if defined(*V5R1M0)
001030170411     D mkfifo          PR            10I 0 ExtProc('mkfifo')
001031170411     D   path                          *   Value options(*string)
001032170411     D   mode                        10U 0 Value
001033170411      /endif
001034170411
001035170411      *--------------------------------------------------------------------
001036170411      * Open a File
001037170411      *
001038170411      * int open(const char *path, int oflag, . . .);
001039170411      *--------------------------------------------------------------------
001040170411     D open            PR            10I 0 ExtProc('open')
001041170411     D  path                           *   value options(*string)
001042170411     D  openflags                    10I 0 value
001043170411     D  mode                         10U 0 value options(*nopass)
001044170411     D  ccsid                        10U 0 value options(*nopass)
001045170411     D/if defined(*V5R2M0)
001046170411     D  txtcreatid                   10U 0 value options(*nopass)
001047170411     D/endif
001048170411
001049170411      *--------------------------------------------------------------------
001050170411      * Open a File, Large File Enabled
001051170411      *
001052170411      * int open64(const char *path, int oflag, . . .);
001053170411      *
001054170411      * NOTE: This is identical to calling open(), except that the
001055170411      *       O_LARGEFILE flag is automatically supplied.
001056170411      *--------------------------------------------------------------------
001057170411     D open64          PR            10I 0 ExtProc('open64')
001058170411     D  filename                       *   value options(*string)
001059170411     D  openflags                    10I 0 value
001060170411     D  mode                         10U 0 value options(*nopass)
001061170411     D  codepage                     10U 0 value options(*nopass)
001062170411     D/if defined(*V5R2M0)
001063170411     D  txtcreatid                   10U 0 value options(*nopass)
001064170411     D/endif
001065170411
001066170411      *--------------------------------------------------------------------
001067170411      * Open a Directory
001068170411      *
001069170411      * DIR *opendir(const char *dirname)
001070170411      *--------------------------------------------------------------------
001071170411     D opendir         PR              *   EXTPROC('opendir')
001072170411     D  dirname                        *   VALUE options(*string)
001073170411
001074170411      *--------------------------------------------------------------------
001075170411      * Get configurable path name variables
001076170411      *
001077170411      * long pathconf(const char *path, int name)
001078170411      *--------------------------------------------------------------------
001079170411     D pathconf        PR            10I 0 ExtProc('pathconf')
001080170411     D   path                          *   Value options(*string)
001081170411     D   name                        10I 0 Value
001082170411
001083170411      *--------------------------------------------------------------------
001084170411      * Create interprocess channel
001085170411      *
001086170411      * int pipe(int fildes[2]);
001087170411      *--------------------------------------------------------------------
001088170411      /if not defined(PIPE_PROTOTYPE)
001089170411     D pipe            PR            10I 0 ExtProc('pipe')
001090170411     D   fildes                      10I 0 dim(2)
001091170411      /define PIPE_PROTOTYPE
001092170411      /endif
001093170411
001094170411      *--------------------------------------------------------------------
001095170411      * Read from Descriptor with Offset
001096170411      *
001097170411      * ssize_t pread(int filedes, void *buf, size_t nbyte, off_t offset);
001098170411      *--------------------------------------------------------------------
001099170411      /if defined(*V5R2M0)
001100170411     D pread           PR            10I 0 ExtProc('pread')
001101170411     D   fildes                      10I 0 value
001102170411     D   buf                           *   value
001103170411     D   nbyte                       10U 0 value
001104170411     D   offset                      10I 0 value
001105170411      /endif
001106170411
001107170411      *--------------------------------------------------------------------
001108170411      * Read from Descriptor with Offset, Large File Enabled
001109170411      *
001110170411      * ssize_t pread64(int filedes, void *buf, size_t nbyte,
001111170411      *                 size_t nbyte, off64_t offset);
001112170411      *--------------------------------------------------------------------
001113170411      /if defined(*V5R2M0)
001114170411     D pread64         PR            10I 0 ExtProc('pread64')
001115170411     D   fildes                      10I 0 value
001116170411     D   buf                           *   value
001117170411     D   nbyte                       10U 0 value
001118170411     D   offset                      20I 0 value
001119170411      /endif
001120170411
001121170411      *--------------------------------------------------------------------
001122170411      * Write to Descriptor with Offset
001123170411      *
001124170411      * ssize_t pwrite(int filedes, const void *buf,
001125170411      *                size_t nbyte, off_t offset);
001126170411      *--------------------------------------------------------------------
001127170411      /if defined(*V5R2M0)
001128170411     D pwrite          PR            10I 0 ExtProc('pwrite')
001129170411     D   fildes                      10I 0 value
001130170411     D   buf                           *   value
001131170411     D   nbyte                       10U 0 value
001132170411     D   offset                      10I 0 value
001133170411      /endif
001134170411
001135170411      *--------------------------------------------------------------------
001136170411      * Write to Descriptor with Offset, Large File Enabled
001137170411      *
001138170411      * ssize_t pwrite64(int filedes, const void *buf,
001139170411      *                  size_t nbyte, off64_t offset);
001140170411      *--------------------------------------------------------------------
001141170411      /if defined(*V5R2M0)
001142170411     D pwrite64        PR            10I 0 ExtProc('pwrite64')
001143170411     D   fildes                      10I 0 value
001144170411     D   buf                           *   value
001145170411     D   nbyte                       10U 0 value
001146170411     D   offset                      20I 0 value
001147170411      /endif
001148170411
001149170411      *--------------------------------------------------------------------
001150170411      * Perform Miscellaneous file system functions
001151170411      *--------------------------------------------------------------------
001152170411     D QP0FPTOS        PR                  ExtPgm('QP0FPTOS')
001153170411     D   Function                    32A   const
001154170411     D   Exten1                       6A   const options(*nopass)
001155170411     D   Exten2                       3A   const options(*nopass)
001156170411
001157170411      *--------------------------------------------------------------------
001158170411      * Read From a File
001159170411      *
001160170411      * ssize_t read(int fildes, void *buffer, size_t bytes);
001161170411      *--------------------------------------------------------------------
001162170411     D read            PR            10I 0 ExtProc('read')
001163170411     D  fildes                       10i 0 value
001164170411     D  buf                            *   value
001165170411     D  bytes                        10U 0 value
001166170411
001167170411      *--------------------------------------------------------------------
001168170411      * Read Directory Entry
001169170411      *
001170170411      * struct dirent *readdir(DIR *dirp)
001171170411      *--------------------------------------------------------------------
001172170411     D readdir         PR              *   EXTPROC('readdir')
001173170411     D  dirp                           *   VALUE
001174170411
001175170411      *--------------------------------------------------------------------
001176170411      * Read Value of Symbolic Link
001177170411      *
001178170411      * int readlink(const char *path, char *buf, size_t bufsiz)
001179170411      *--------------------------------------------------------------------
001180170411     D readlink        PR            10I 0 ExtProc('readlink')
001181170411     D   path                          *   value options(*string)
001182170411     D   buf                           *   value
001183170411     D   bufsiz                      10U 0 value
001184170411
001185170411      *--------------------------------------------------------------------
001186170411      * Read From Descriptor using Multiple Buffers
001187170411      *
001188170411      * int readv(int fildes, struct iovec *io_vector[], int vector_len);
001189170411      *--------------------------------------------------------------------
001190170411     D readv           PR            10I 0 ExtProc('readv')
001191170411     D  fildes                       10i 0 value
001192170411     D  io_vector                          like(iovec)
001193170411     D                                     dim(256) options(*varsize)
001194170411     D  vector_len                   10I 0 value
001195170411
001196170411      *--------------------------------------------------------------------
001197170411      * Rename File or Directory
001198170411      *
001199170411      * int rename(const char *old, const char *new)
001200170411      *
001201170411      *  Note: By defailt, if a file with the new name already exists,
001202170411      *        rename will fail with an error.  If you define
001203170411      *        RENAMEUNLINK and a file with the new name already exists
001204170411      *        it will be unlinked prior to renaming.
001205170411      *--------------------------------------------------------------------
001206170411      /if defined(RENAMEUNLINK)
001207170411     D rename          PR            10I 0 ExtProc('Qp0lRenameUnlink')
001208170411     D   old                           *   Value options(*string)
001209170411     D   new                           *   Value options(*string)
001210170411      /else
001211170411     D rename          PR            10I 0 ExtProc('Qp0lRenameKeep')
001212170411     D   old                           *   Value options(*string)
001213170411     D   new                           *   Value options(*string)
001214170411      /endif
001215170411
001216170411      *--------------------------------------------------------------------
001217170411      * Reset Directory Stream to Beginning
001218170411      *
001219170411      * void rewinddir(DIR *dirp)
001220170411      *--------------------------------------------------------------------
001221170411     D rewinddir       PR                  ExtProc('rewinddir')
001222170411     D   dirp                          *   value
001223170411
001224170411
001225170411      *--------------------------------------------------------------------
001226170411      * Remove Directory
001227170411      *
001228170411      * int rmdir(const char *path)
001229170411      *--------------------------------------------------------------------
001230170411     D rmdir           PR            10I 0 ExtProc('rmdir')
001231170411     D   path                          *   value options(*string)
001232170411
001233170411      *--------------------------------------------------------------------
001234170411      * Get File Information
001235170411      *
001236170411      * int stat(const char *path, struct stat *buf)
001237170411      *--------------------------------------------------------------------
001238170411     D stat            PR            10I 0 ExtProc('stat')
001239170411     D   path                          *   value options(*string)
001240170411     D   buf                               likeds(statds)
001241170411
001242170411
001243170411      *--------------------------------------------------------------------
001244170411      * Get File Information, Large File Enabled
001245170411      *
001246170411      * int stat(const char *path, struct stat64 *buf)
001247170411      *--------------------------------------------------------------------
001248170411     D stat64          PR            10I 0 ExtProc('stat64')
001249170411     D   path                          *   value options(*string)
001250170411     D   buf                               likeds(statds64)
001251170411
001252170411
001253170411      *--------------------------------------------------------------------
001254170411      * statvfs() -- Get file system status
001255170411      *
001256170411      *    path = (input) pathname of a link ("file") in the IFS.
001257170411      *     buf = (output) data structure containing file system info
001258170411      *
001259170411      * Returns 0 if successful, -1 upon error.
001260170411      * (error information is returned via the "errno" variable)
001261170411      *--------------------------------------------------------------------
001262170411     D statvfs         PR            10I 0 ExtProc('statvfs64')
001263170411     D   path                          *   value options(*string)
001264170411     D   buf                               like(ds_statvfs)
001265170411
001266170411      *--------------------------------------------------------------------
001267170411      * Make Symbolic Link
001268170411      *
001269170411      * int symlink(const char *pname, const char *slink)
001270170411      *--------------------------------------------------------------------
001271170411     D symlink         PR            10I 0 ExtProc('symlink')
001272170411     D   pname                         *   value options(*string)
001273170411     D   slink                         *   value options(*string)
001274170411
001275170411      *--------------------------------------------------------------------
001276170411      * Get system configuration variables
001277170411      *
001278170411      * long sysconf(int name)
001279170411      *--------------------------------------------------------------------
001280170411     D sysconf         PR            10I 0 ExtProc('sysconf')
001281170411     D   name                        10I 0 Value
001282170411
001283170411      *--------------------------------------------------------------------
001284170411      * Set Authorization Mask for Job
001285170411      *
001286170411      * mode_t umask(mode_t cmask)
001287170411      *--------------------------------------------------------------------
001288170411     D umask           PR            10U 0 ExtProc('umask')
001289170411     D   cmask                       10U 0 Value
001290170411
001291170411      *--------------------------------------------------------------------
001292170411      * Remove Link to File.  (Deletes Directory Entry for File, and if
001293170411      *    this was the last link to the file data, the file itself is
001294170411      *    also deleted)
001295170411      *
001296170411      * int unlink(const char *path)
001297170411      *--------------------------------------------------------------------
001298170411     D unlink          PR            10I 0 ExtProc('unlink')
001299170411     D   path                          *   Value options(*string)
001300170411
001301170411      *--------------------------------------------------------------------
001302170411      * Set File Access & Modification Times
001303170411      *
001304170411      * int utime(const char *path, const struct utimbuf *times)
001305170411      *--------------------------------------------------------------------
001306170411     D utime           PR            10I 0 ExtProc('utime')
001307170411     D   path                          *   value options(*string)
001308170411     D   times                             likeds(utimbuf) options(*omit)
001309170411
001310170411      *--------------------------------------------------------------------
001311170411      * Write to a file
001312170411      *
001313170411      * ssize_t write(int fildes, const void *buf, size_t bytes)
001314170411      *--------------------------------------------------------------------
001315170411     D write           PR            10I 0 ExtProc('write')
001316170411     D  fildes                       10i 0 value
001317170411     D  buf                            *   value
001318170411     D  bytes                        10U 0 value
001319170411
001320170411      *--------------------------------------------------------------------
001321170411      * Write to a file using (with type A field in prototype)
001322170411      *
001323170411      * ssize_t write(int fildes, const void *buf, size_t bytes)
001324170411      *--------------------------------------------------------------------
001325170411     D writeA          PR            10I 0 ExtProc('write')
001326170411     D  fildes                       10i 0 value
001327170411     D  buf                       65535A   const options(*varsize)
001328170411     D  bytes                        10U 0 value
001329170411
001330170411      *--------------------------------------------------------------------
001331170411      * Write to descriptor using multiple buffers
001332170411      *
001333170411      * int writev(int fildes, struct iovec *iovector[], int vector_len);
001334170411      *--------------------------------------------------------------------
001335170411     D writev          PR            10I 0 ExtProc('writev')
001336170411     D  fildes                       10i 0 value
001337170411     D  io_vector                          like(iovec)
001338170411     D                                     dim(256) options(*varsize)
001339170411     D  vector_len                   10I 0 value
