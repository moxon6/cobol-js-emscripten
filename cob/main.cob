
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed PIC X(40).
       01 Player1.
           05 Player1_Position.
               10 Player1_Num PIC 999 VALUE 20.
               10 Player1_Pixels PIC X(3) VALUE z"px".
           05 Player1_Score PIC 99 VALUE 0.
       01 Player2.
           05 Player2_Position.
               10 Player2_Num PIC 999 VALUE 0.
               10 Player2_Pixels PIC X(3) VALUE z"px".
           05 Player2_Score PIC 99 VALUE 0.
       01 Ball.
           05 Ball_Position.
               10 Ball_Position_X.
                   15 Ball_Position_X_Num PIC 999 VALUE 240.
                   15 Ball_Position_X_Pixels PIC X(3) VALUE z"px".
               10 Ball_Position_Y.
                   15 Ball_Position_Y_Num PIC 999 VALUE 240.
                   15 Ball_Position_Y_Pixels PIC X(3) VALUE z"px".
           05 Ball_Velocity.
               10 Ball_Velocity_X PIC S99 VALUE 1.
               10 Ball_Velocity_Y PIC S99 VALUE 0.
           05 Ball_Width PIC 99 VALUE 20.
               
       01 GameHeight PIC 999 VALUE 500.
       01 GameWidth PIC 999 VALUE 500.
       01 PaddleWidth PIC 999 VALUE 10.
       01 PaddleHeight PIC 999 VALUE 100.
       01 Done PIC 9 VALUE 0.
       01 PaddleSpeed PIC 99 VALUE 5.
       01 Iteration PIC 99 VALUE 0.
       PROCEDURE DIVISION.
       Main.
           CALL "startup" RETURNING OMITTED
           CALL "set_element_property" using ".loading-message" "style.display" "None".
           CALL "set_element_property" using ".score" "style.display" "block".
           Perform Main-Loop UNTIL Done=1
           DISPLAY "Game Over"
           STOP RUN.

       Main-Loop.
       ADD 1 to Iteration.
       DISPLAY Ball_Position_X.

       ADD Ball_Velocity_X to Ball_Position_X_Num.
       IF Ball_Position_X_Num EQUALS (GameWidth - PaddleWidth - Ball_Width) OR Ball_Position_X_Num EQUALS PaddleWidth
           MULTIPLY -1 BY Ball_Velocity_X
           ADD 1 to Player1_Score.
           
       Perform Handle-Keypress TEST AFTER UNTIL LastPressed EQUALS SPACE.
       Perform Rerender.

       Handle-KeyPress.
       ACCEPT LastPressed.
       EVALUATE LastPressed
           WHEN "KeyA"
               IF Player1_Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player1_Num
           WHEN "KeyD"
               IF Player1_Num IS LESS THAN GameHeight - PaddleHeight
                   ADD PaddleSpeed TO Player1_Num
           WHEN "KeyJ"
               IF Player2_Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player2_Num
           WHEN "KeyL"
               IF Player2_Num IS LESS THAN GameHeight - PaddleHeight
                   ADD PaddleSpeed TO Player2_Num
           WHEN "Escape"
               MOVE 1 TO DONE.

       Rerender.
       Perform Update-Positions.
       Perform Update-Scores.

       Update-Positions.
       CALL "set_element_property" using ".ball" "style.left" Ball_Position_X.
       CALL "set_element_property" using ".paddle-1" "style.top" Player1_Position.
       CALL "set_element_property" using ".paddle-2" "style.top" Player2.
       CALL "emscripten_sleep" using by value 5 RETURNING OMITTED.
      
       Update-Scores.
       CALL "set_element_property" using ".player-1-score" "innerHTML" Player1_Score.
       CALL "set_element_property" using ".player-2-score" "innerHTML" Player2_Score.

       END PROGRAM MainProgram.

