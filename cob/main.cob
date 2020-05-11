
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 SharedItem     PIC X(40) IS GLOBAL.
       PROCEDURE DIVISION.
       Begin.
           CALL "InsertData"
           MOVE "Main can also use the shared data" TO SharedItem
           CALL "DisplayData"
           STOP RUN.
       
              IDENTIFICATION DIVISION.
              PROGRAM-ID. InsertData.
              PROCEDURE DIVISION.
              Begin.
                  MOVE "Shared area works" TO SharedItem
                  CALL "DisplayData"
                  EXIT PROGRAM.
              END PROGRAM InsertData.
       
              IDENTIFICATION DIVISION.
              PROGRAM-ID. DisplayData IS COMMON PROGRAM.
              PROCEDURE DIVISION.
              Begin.
                  DISPLAY SharedItem.
                  EXIT PROGRAM.
              END PROGRAM DisplayData.
       
       END PROGRAM MainProgram.
