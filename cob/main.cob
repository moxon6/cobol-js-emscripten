
       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       ENVIRONMENT DIVISION.
       DATA DIVISION.

       WORKING-STORAGE SECTION.       
       01 UpdateColor PIC X(60) VALUE z"document.body.style.backgroundColor = 'rgb(120,0,0)'".
       
       PROCEDURE DIVISION.
       PERFORM UPDATE-COLOR.
       
       STOP RUN.
       
       UPDATE-COLOR. 
       CALL "jsrun" USING UpdateColor
       CALL "domSleep".
