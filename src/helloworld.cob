
IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO-WORLD.

DATA DIVISION.                                                   
WORKING-STORAGE SECTION.                                         
01 Name                       PIC 9(03).                          

PROCEDURE DIVISION.
    ACCEPT Name.
    DISPLAY 'Hello world!' Name.
    STOP RUN.
