      // ==========================================================================
      //  iRPGUnit Fixture - SRVPGM with two exports.
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================

     H NoMain Option(*SrcStmt: *NoDebugIo)

     Dproc1            pr
     Dproc2            pr

     Pproc1            b                   export
     Dproc1            pi
     Pproc1            e

     Pproc2            b                   export
     Dproc2            pi
     Pproc2            e

