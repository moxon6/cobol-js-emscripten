
       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       ENVIRONMENT DIVISION.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 HELLO PIC X(6) VALUE "Hello ".
       01 WORLD PIC X(6).

       PROCEDURE DIVISION.
       DISPLAY "Enter Value for 'world'".
       CALL "updateDOM".     
       CALL "jsrun" USING "alert('hi')".

       DISPLAY "Potato potato"
       STOP RUN.