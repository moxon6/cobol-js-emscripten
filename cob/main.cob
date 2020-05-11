
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
           Perform Main-Loop 10000 times.
           STOP RUN.

           Main-Loop.
           ACCEPT LastPressed.

           EVALUATE  LastPressed
           WHEN "ArrowLeft" 
               SUBTRACT 10 from XPos
               Perform Update-Position
           WHEN "ArrowRight" 
               ADD 10 to XPos
               Perform Update-Position 
           .
              


           CALL "em_sleep" using "10"
           .

           Configure-Environment.
           *> Configure JS environment
           CALL "startup". *> Configure Asyncify stack size etc
           CALL "js_run" using "window.lastPressed = 'None'" *> Initialise Key press
           CALL "js_run" using "window.onkeydown = (e) => window.lastPressed = e.code" *> Setup keydown handler
           CALL "js_run" using "window.prompt = () => { if(!window.hasEntered) { window.hasEntered = true; return window.lastPressed } else { window.hasEntered=false; window.lastPressed = 'None' ; return null; } }" *> Patch prompt -> can ACCEPT from lastPressed
           .

           Update-Position.
           MOVE SetPositionConst TO SetPosition.

           CALL "js_run_async" using FUNCTION SUBSTITUTE(SetPosition, "$position", XPos);
           .
       
      
       END PROGRAM MainProgram.

