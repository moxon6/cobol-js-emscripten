
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MainProgram.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LastPressed     PIC X(40) IS GLOBAL.
       PROCEDURE DIVISION.
       Begin.
           Perform Configure-Environment.
           Perform Main-Loop 10000 times.
           STOP RUN.

           Configure-Environment.
           *> Configure JS environment
           CALL "startup". *> Configure Asyncify stack size etc
           CALL "js_run" using "window.lastPressed = 'None'" *> Initialise Key press
           CALL "js_run" using "window.onkeydown = (e) => window.lastPressed = e.code" *> Setup keydown handler
           CALL "js_run" using "window.prompt = () => { if(!window.hasEntered) { window.hasEntered = true; return window.lastPressed } else { window.hasEntered=false; return null; } }" *> Patch prompt -> can ACCEPT from lastPressed
           .
       
           Main-Loop.
           ACCEPT LastPressed.
           Display LastPressed.
           CALL "em_sleep" using "50"
           .
      
       END PROGRAM MainProgram.
