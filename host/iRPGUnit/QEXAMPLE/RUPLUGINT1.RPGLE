      // ==========================================================================
      //  iRPGUnit Dev. of RDP Plugin. OK + Failure
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================
      //    >>PRE-COMPILER<<
      //      >>CRTCMD<<  RUCRTRPG    TSTPGM(&LI/&OB) +
      //                              SRCFILE(&SL/&SF) SRCMBR(&SM);
      //      >>IMPORTANT<<
      //        >>PARM<< COPTION(*SRCSTMT *EVENTF);
      //        >>PARM<< DBGVIEW(*LIST);
      //      >>END-IMPORTANT<<
      //      >>EXECUTE<<
      //    >>END-PRE-COMPILER<<
      // ==========================================================================

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D testAllOK_4...
     D                 pr                  extproc('testAllOK_4')

     D testAllFailure_4...
     D                 pr                  extproc('testAllFailure_4')

     D testOK_1_Failure_2...
     D                 pr                  extproc('testOK_1_Failure_2')

     D testFailInsideMonitorBlock...
     D                 pr                  extproc('testFailInsideMonitorBlock')

     D testNumFailure_noMessage...
     D                 pr                  extproc('testNumFailure_noMessage')

     D procInError...
     D                 pr                  extproc('procInError')
     D  level                        10i 0 value
     D  maxLevel                     10i 0 value

      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /include qinclude,TESTCASE
      /include qinclude,ASSERT
      /include qinclude,TEMPLATES

      //----------------------------------------------------------------------
      //   Test Procedures
      //----------------------------------------------------------------------

     P testAllOK_4...
     P                 b                   export
     D                 pi

     D assertFailEvt_v1...
     D                 ds                  likeds(assertFailEvt_t) inz
     D assertFailEvt_v2...
     D                 ds                  likeds(assertFailEvtLong_t) inz
      /free

        assert(*on : 'OK: 1');
        assert(*on : 'OK: 2');

        aEqual( 'Hello' : 'Hello' );

        // Keine Fehler aufgetreten => OK.
        assertFailEvt_v1 = getAssertFailEvt();
        aEqual( *blank : assertFailEvt_v1.msg );

        assertFailEvt_v2 = getAssertFailEvtLong();
        aEqual( *blank : assertFailEvt_v2.msg );

      /end-free
     P                 e

     P testAllFailure_4...
     P                 b                   export
     D                 pi
     D a1              s             10I 0
     D a2              s             10I 0
      /free

        a1 = a1 / a2;

        callp(E) assert(*off : 'FAILURE: 1'); // continue on error

        callp(E) assert(*off : 'FAILURE: 2'); // continue on error

        a1 = getAssertCalled(); // Number of failed assertions
        callp(E) aEqual( 'HelloWorld' : 'Hello' );
        a2 = getAssertCalled(); // Number of failed assertions

        // Fehler aufgetreten => OK.
        assert(a2 = (a1+1): 'There must be one more assertion!');

      /end-free
     P                 e

     P testOK_1_Failure_2...
     P                 b                   export
     D                 pi
      /free

        callp(E) assert(*off : 'FAILURE: 1');  // continue on error

        assert(*on  : 'OK: 1');
        assert(*off : 'FAILURE: 2');           // break on error

      /end-free
     P                 e

     P testFailInsideMonitorBlock...
     P                 b                   export
     D                 pi
      /free

         monitor;
            fail('Fail from inside a monitor block');
         on-error;
            fail('fail() must not be captured from the monitor block');
         endmon;

      /end-free
     P                 e

     P testNumFailure_noMessage...
     P                 b                   export
     D                 pi

     D level           s             10i 0
      /free

         procInError(level: 6);

      /end-free
     P                 e

     P procInError...
     P                 b                   export
     D                 pi
     D  level                        10i 0 value
     D  maxLevel                     10i 0 value
      /free

         level += 1;
         if (level < maxLevel);
            procInError(level: maxLevel);
         endif;

         iEqual(1: 2); // Failure, no message

      /end-free
     P                 e

