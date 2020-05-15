
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed PIC X(40).
       01 Player1.
           05 Player1Position.
               10 Player1Num PIC 999 VALUE 20.
               10 Player1Pixels PIC X(3) VALUE z"px".
           05 Player1Score PIC 99 VALUE 0.
       01 Player2.
           05 Player2Position.
               10 Player2Num PIC 999 VALUE 0.
               10 Player2Pixels PIC X(3) VALUE z"px".
           05 Player2Score PIC 99 VALUE 0.
       01 Ball.
           05 BallPosition.
               10 BallPositionX.
                   15 BallPositionXNum PIC 999 VALUE 0.
                   15 BallPositionXPixels PIC X(3) VALUE z"px".
               10 BallPositionY.
                   15 BallPositionYNum PIC 999 VALUE 0.
                   15 BallPositionYPixels PIC X(3) VALUE z"px".
           05 BallVelocity.
               10 BallVelocityX PIC S99 VALUE 2.
               10 BallVelocityY PIC S99 VALUE 1.
           05 BallWidth PIC 99 VALUE 20.
               
       01 GameHeight PIC 999 VALUE 500.
       01 GameWidth PIC 999 VALUE 800.
       01 PaddleWidth PIC 999 VALUE 10.
       01 PaddleHeight.
           05 PaddleHeightNum PIC 999 VALUE 75.
           05 PaddleHeightPixels PIC X(3) VALUE z"px".
       01 Started PIC 9 VALUE 0.
       01 Done PIC 9 VALUE 0.
       01 PaddleSpeed PIC 99 VALUE 5.
       01 Iteration PIC 99 VALUE 0.
       PROCEDURE DIVISION.
       Main.
           CALL "startup" RETURNING OMITTED
           CALL "setElementProperty" using ".loading-message" "innerHTML" "Press Any Key To Start".
           Perform Check-Game-Start UNTIL Started=1
           Perform Initialise-UI.
           CALL "setElementProperty" using ".score" "style.display" "block".
           CALL "setElementProperty" using ".loading-message" "style.display" "None".

           Perform Main-Loop UNTIL Done=1
           CALL "setElementProperty" using ".loading-message" "style.display" "block".
           CALL "setElementProperty" using ".loading-message" "innerHTML" "GAME OVER".
           STOP RUN.
    
       Initialise-UI.
           CALL "setElementProperty" using ".paddle-1" "style.height" PaddleHeight.
           CALL "setElementProperty" using ".paddle-2" "style.height" PaddleHeight.
           CALL "setElementProperty" using ".ball" "style.display" "block".
           Perform Reset-Game
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
       
       ADD BallVelocityX to BallPositionXNum
       ADD BallVelocityY to BallPositionYNum

       IF BallPositionYNum EQUALS 0 OR BallPositionYNum EQUALS GameHeight - BallWidth
           Multiply -1 BY BallVelocityY
       END-IF

       IF BallPositionXNum EQUALS PaddleWidth
           IF Player1Num - BallWidth < (BallPositionYNum) AND BallPositionYNum < (Player1Num + PaddleHeightNum + BallWidth)
               MULTIPLY -1 BY BallVelocityX
           END-IF
        END-IF

       IF BallPositionXNum EQUALS (GameWidth - BallWidth - PaddleWidth)
           IF Player2Num - BallWidth < (BallPositionYNum) AND BallPositionYNum < (Player2Num + PaddleHeightNum + BallWidth)
               MULTIPLY -1 BY BallVelocityX
           END-IF
        END-IF

       IF BallPositionXNum EQUALS 0
           MULTIPLY -1 BY BallVelocityX
           ADD 1 to Player2Score
           Perform Reset-Game.
               

       IF BallPositionXNum EQUALS (GameWidth - BallWidth)
           MULTIPLY -1 BY BallVelocityX
           ADD 1 to Player1Score
           Perform Reset-Game.

       Perform Handle-Keypress TEST AFTER UNTIL LastPressed EQUALS SPACE.
       Perform Rerender.

       Handle-KeyPress.
       ACCEPT LastPressed.
       EVALUATE LastPressed
           WHEN "KeyA"
               IF Player1Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player1Num
           WHEN "KeyD"
               IF Player1Num IS LESS THAN GameHeight - PaddleHeightNum
                   ADD PaddleSpeed TO Player1Num
           WHEN "KeyL"
               IF Player2Num IS GREATER THAN OR EQUAL TO PaddleSpeed
                   SUBTRACT PaddleSpeed FROM Player2Num
           WHEN "KeyJ"
               IF Player2Num IS LESS THAN GameHeight - PaddleHeightNum
                   ADD PaddleSpeed TO Player2Num
           WHEN "Escape"
               MOVE 1 TO DONE.

       Reset-Game.
           COMPUTE BallPositionXNum = GameWidth / 2 - BallWidth / 2
           COMPUTE BallPositionYNum = GameHeight / 2 - BallWidth / 2
           PERFORM Rerender.
           CALL "emscripten_sleep" using by value 1000 RETURNING OMITTED
       .


       Rerender.
       Perform Update-Positions.
       Perform Update-Scores.

       Update-Positions.
       CALL "setElementProperty" using ".ball" "style.left" BallPositionX.
       CALL "setElementProperty" using ".ball" "style.top" BallPositionY.
       CALL "setElementProperty" using ".paddle-1" "style.top" Player1Position.
       CALL "setElementProperty" using ".paddle-2" "style.top" Player2.
       CALL "emscripten_sleep" using by value 5 RETURNING OMITTED.
      
       Update-Scores.
       CALL "setElementProperty" using ".player-1-score" "innerHTML" Player1Score.
       CALL "setElementProperty" using ".player-2-score" "innerHTML" Player2Score.

       END PROGRAM MainProgram.

