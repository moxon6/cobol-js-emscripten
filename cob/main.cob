
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
                   15 Ball_Position_X_Num PIC 999 VALUE 0.
                   15 Ball_Position_X_Pixels PIC X(3) VALUE z"px".
               10 Ball_Position_Y.
                   15 Ball_Position_Y_Num PIC 999 VALUE 0.
                   15 Ball_Position_Y_Pixels PIC X(3) VALUE z"px".
           05 Ball_Velocity.
               10 Ball_Velocity_X PIC S99 VALUE 2.
               10 Ball_Velocity_Y PIC S99 VALUE 1.
           05 Ball_Width PIC 99 VALUE 20.
               
       01 GameHeight PIC 999 VALUE 500.
       01 GameWidth PIC 999 VALUE 800.
       01 PaddleWidth PIC 999 VALUE 10.
       01 PaddleHeight.
           05 PaddleHeight_Num PIC 999 VALUE 75.
           05 PaddleHeight_Pixels PIC X(3) VALUE z"px".
       01 Started PIC 9 VALUE 0.
       01 Done PIC 9 VALUE 0.
       01 PaddleSpeed PIC 99 VALUE 5.
       01 Iteration PIC 99 VALUE 0.
       PROCEDURE DIVISION.
       Main.
           CALL "startup" RETURNING OMITTED
           CALL "set_element_property" using ".loading-message" "innerHTML" "Press Any Key To Start".
           CALL "set_element_property" using ".score" "style.display" "block".

           Perform Check-Game-Start UNTIL Started=1
           Perform Initialise-UI.       
           CALL "set_element_property" using ".loading-message" "style.display" "None".

           Perform Main-Loop UNTIL Done=1
           DISPLAY "Game Over"
           STOP RUN.
    
       Initialise-UI.
           CALL "set_element_property" using ".paddle-1" "style.height" PaddleHeight
           CALL "set_element_property" using ".paddle-2" "style.height" PaddleHeight
           CALL "set_element_property" using ".ball" "style.display" "block"
           COMPUTE Ball_Position_X_Num = GameWidth / 2 + Ball_Width / 2
           COMPUTE Ball_Position_Y_Num = GameHeight / 2 + Ball_Width / 2
       .
        
       Check-Game-Start.
           ACCEPT LastPressed.
           IF LastPressed EQUALS SPACE
               CALL "emscripten_sleep" using by value 10 RETURNING OMITTED
           ELSE
               MOVE 1 to Started
           END-IF
       .
           

       Main-Loop.
       ADD 1 to Iteration.
       
       ADD Ball_Velocity_X to Ball_Position_X_Num
       ADD Ball_Velocity_Y to Ball_Position_Y_Num

       IF Ball_Position_Y_Num EQUALS 0 OR Ball_Position_Y_Num EQUALS GameHeight - Ball_Width
           Multiply -1 BY Ball_Velocity_Y
       END-IF

       IF Ball_Position_X_Num EQUALS PaddleWidth
           IF Player1_Num - Ball_Width < (Ball_Position_Y_Num) AND Ball_Position_Y_Num < (Player1_Num + PaddleHeight_Num + Ball_Width)
               MULTIPLY -1 BY Ball_Velocity_X
           END-IF
        END-IF

       IF Ball_Position_X_Num EQUALS (GameWidth - Ball_Width - PaddleWidth)
           IF Player2_Num - Ball_Width < (Ball_Position_Y_Num) AND Ball_Position_Y_Num < (Player2_Num + PaddleHeight_Num + Ball_Width)
               MULTIPLY -1 BY Ball_Velocity_X
           END-IF
        END-IF

       IF Ball_Position_X_Num EQUALS 0
           MULTIPLY -1 BY Ball_Velocity_X
           Perform Reset-Game
           ADD 1 to Player2_Score.
               

       IF Ball_Position_X_Num EQUALS (GameWidth - Ball_Width)
           MULTIPLY -1 BY Ball_Velocity_X
           Perform Reset-Game
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
               IF Player1_Num IS LESS THAN GameHeight - PaddleHeight_Num
                   ADD PaddleSpeed TO Player1_Num
           WHEN "KeyJ"
               IF Player2_Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player2_Num
           WHEN "KeyL"
               IF Player2_Num IS LESS THAN GameHeight - PaddleHeight_Num
                   ADD PaddleSpeed TO Player2_Num
           WHEN "Escape"
               MOVE 1 TO DONE.

       Reset-Game.
           MOVE 240 TO Ball_Position_X_Num.
           MOVE 240 TO Ball_Position_Y_Num.

       Rerender.
       Perform Update-Positions.
       Perform Update-Scores.

       Update-Positions.
       CALL "set_element_property" using ".ball" "style.left" Ball_Position_X.
       CALL "set_element_property" using ".ball" "style.top" Ball_Position_Y.
       CALL "set_element_property" using ".paddle-1" "style.top" Player1_Position.
       CALL "set_element_property" using ".paddle-2" "style.top" Player2.
       CALL "emscripten_sleep" using by value 5 RETURNING OMITTED.
      
       Update-Scores.
       CALL "set_element_property" using ".player-1-score" "innerHTML" Player1_Score.
       CALL "set_element_property" using ".player-2-score" "innerHTML" Player2_Score.

       END PROGRAM MainProgram.

