
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed     PIC X(40).
       01 Player1.
           05 Player1_Position.
               10 Player1_Num PIC 999 VALUE 0.
               10 Player1_Pixels PIC X(2) VALUE "px".
       01 Player2.
           05 Player2_Position.
               10 Player2_Num PIC 999 VALUE 0.
               10 Player2_Pixels PIC X(2) VALUE "px".
       01 GameHeight PIC 999 VALUE 500.
       01 PaddleWIdth PIC 999 VALUE 100.
       01 Done PIC 9 VALUE 0.
       01 PaddleSpeed PIC 99 VALUE 25.
       PROCEDURE DIVISION.
       Main.
           CALL "startup" RETURNING OMITTED
           CALL "set_element_property" using ".loading-message" "display" "None".
           Perform Main-Loop UNTIL Done=1
           DISPLAY "Game Over"
           STOP RUN.

       Main-Loop.
       ACCEPT LastPressed.
       EVALUATE LastPressed
           WHEN "KeyA"
               IF Player1_Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player1_Num
           WHEN "KeyS"
               IF Player1_Num IS LESS THAN GameHeight - PaddleWidth
                   ADD PaddleSpeed TO Player1_Num
           WHEN "KeyK"
               IF Player2_Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player2_Num
           WHEN "KeyL"
               IF Player2_Num IS LESS THAN GameHeight - PaddleWidth
                   ADD PaddleSpeed TO Player2_Num
           WHEN "Escape"
               MOVE 1 TO DONE
           WHEN SPACE
               CONTINUE
           WHEN OTHER
               DISPLAY LastPressed.
       CALL "set_element_property" using ".paddle-1" "top" Player1_Position
       CALL "set_element_property" using ".paddle-2" "top" Player2
       CALL "emscripten_sleep" using by value 10 RETURNING OMITTED
       .
      
       END PROGRAM MainProgram.

