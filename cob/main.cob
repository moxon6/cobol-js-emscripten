
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed     PIC X(40).
       01 XPos     PIC 999 VALUE 500.
       01 SetPositionConst PIC X(100) VALUE "document.querySelector('.test').style.left = '$positionpx'".
       01 SetPosition PIC X(100).
       01 Iteration PIC 999 VALUE 0.
       01 Done PIC 9 VALUE 0.
       PROCEDURE DIVISION.
       Begin.
           CALL "startup".
           Perform Main-Loop UNTIL Done=1.

           STOP RUN.

       Main-Loop.
       ACCEPT LastPressed.
       ADD 1 to Iteration.
       DISPLAY Iteration.
       EVALUATE LastPressed
            WHEN "ArrowLeft" 
                SUBTRACT 25 FROM XPos
            WHEN "ArrowRight"
                ADD 25 TO XPos
            WHEN "ArrowUp"
                ADD 1 TO Done.
       CALL "set_square_pos" using ".test" XPos.
       CALL "em_sleep" using "10"
        .
      
       END PROGRAM MainProgram.

