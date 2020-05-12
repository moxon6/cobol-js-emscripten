
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed     PIC X(40).
       01 XPos     PIC 999 VALUE 500.
       01 Done PIC 9 VALUE 0.
       PROCEDURE DIVISION.
       Main.
           CALL "startup" RETURNING OMITTED
           Perform Main-Loop UNTIL Done=1
           DISPLAY "Game Over"
           STOP RUN.

       Main-Loop.
       ACCEPT LastPressed.
       EVALUATE LastPressed
           WHEN "ArrowLeft" 
                SUBTRACT 25 FROM XPos
           WHEN "ArrowRight"
                ADD 25 TO XPos
           WHEN "Escape"
               MOVE 1 TO DONE
           WHEN SPACE
               CONTINUE
           WHEN OTHER
               DISPLAY LastPressed.
       CALL "set_square_pos" using ".test" XPos
       CALL "emscripten_sleep" using by value 10 RETURNING OMITTED
        .
      
       END PROGRAM MainProgram.

