
       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       ENVIRONMENT DIVISION.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 HELLO PIC X(6) VALUE "Hello ".
       01 WORLD PIC X(6).
       01 A PIC 999.
       
       01 UpdateColor PIC X(60) VALUE z"document.body.style.backgroundColor = 'rgb(120,0,0)'".

       PROCEDURE DIVISION.

       PERFORM UPDATE-COLOR.

       
       DISPLAY HELLO WORLD.
       STOP RUN.

       UPDATE-COLOR. 
       CALL "jsrun" USING UpdateColor
       CALL "domSleep".
