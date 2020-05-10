
IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO-WORLD.

DATA DIVISION.                                                   
WORKING-STORAGE SECTION.                                         
01 Name                       PIC 9(03).                          

PROCEDURE DIVISION.
    ACCEPT Name.
    CALL "cobol_emscripten_sleep" USING "T".
    DISPLAY 'Hello world!' Name.
    STOP RUN.
