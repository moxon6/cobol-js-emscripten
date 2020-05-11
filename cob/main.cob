
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 SharedItem     PIC X(40) IS GLOBAL.
       PROCEDURE DIVISION.
       Begin.
           CALL "boost_stack_size".
           CALL "InsertData".
           DISPLAY "Point A".
           Perform A-PARA.
           DISPLAY "Point B".
           Perform A-PARA 4 times.
           Perform A-PARA 8 times.
           DISPLAY "After 6".
           
           STOP RUN.

           A-PARA.
           CALL "updateDOM"
           DISPLAY "Testing".

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
