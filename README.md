# ScoreStoryOpen
ScoreStory Open Source
This is the future home of the ScoreStory open source version. This software was created to provide a low cost alternative for creating queries and and dashboards over data that resides on an IBMi.
In order to compile this project, you will need an IBMi with an RPG compiler.  You will also need Zend Server loaded on your machine.

Compile steps:
1. Create a source file QCPYLESRC
2. Put the STDHSPEC.RPGLE file in this source file.
3. Create source files in what ever manner you are accustomed.
4. Copy all DDS, SQL, RPG, CL and commands to the source files you just created.
5. Compile all objects in the following order.  Compile all objects into a library called JERRYMOUSE.
    Physical Files
    Logical Files
    SQL Tables
    SQL Indexes
    Display Files
    RPG
    CL
    Commands
6. Create a folder name JerryMouse in the root of the HTTP server documents folder.
    Example if you have Zend server running PHP6: /www/zendzvr6/htdocs/JerryMouse
    Example if you have Zend server running PHP7: /www/zendphp7/htdocs/JerryMouse
7. Copy the contents of the zip file into this folder.
8. There are a bunch of programs that require special compiles. These are SQL functions.  You will see the compile instructions at the top of those programs.

