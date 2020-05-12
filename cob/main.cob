
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed     PIC X(40).
       01 XPos     PIC 999 VALUE 500.
       01 SetPositionConst PIC X(100) VALUE "document.querySelector('.test').style.left = '$positionpx'".
       01 SetPosition PIC X(100).
       PROCEDURE DIVISION.
       Begin.
           Perform Configure-Environment.
           CALL "js_run_async" using "document.onmousemove = e => window.lastPressed = e.clientX" *> Setup keydown handler

           Perform Profile-Loop 100000 times.

           STOP RUN.

           Profile-Loop.
           *> CALL "js_run_async" using "document.querySelector('.test').style.left = '5px'"
           CALL "set_square_pos" using ".test" "200"
           CALL "em_sleep" using "0"
           .

           Main-Loop.
           ACCEPT LastPressed.
           MOVE FUNCTION NUMVAL(LastPressed) TO XPos
           DISPLAY XPos.
           Perform Update-Position
           CALL "set_square_pos" using "300px"
           CALL "em_sleep" using "0"
           .

           Configure-Environment.
           *> Configure JS environment
           CALL "startup". *> Configure Asyncify stack size etc
           CALL "js_run_async" using "window.lastPressed = 'None'" *> Initialise Key press
           CALL "js_run_async" using "document.onmousemove = e => window.lastPressed = e.clientX" *> Setup keydown handler
           CALL "js_run_async" using "window.prompt = () => { if(!window.hasEntered) { window.hasEntered = true; return window.lastPressed } else { window.hasEntered=false; return null; } }" *> Patch prompt -> can ACCEPT from lastPressed
           .

           Update-Position.
           MOVE SetPositionConst TO SetPosition.

           CALL "js_run_async" using FUNCTION SUBSTITUTE(SetPosition, "$position", XPos);
           .
       
      
       END PROGRAM MainProgram.

