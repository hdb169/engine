      SUBROUTINE s_init_physics(ABORT,err)
*--------------------------------------------------------
*-
*-   Purpose and Methods : Initialize constants for s_physics
*-                              
*-
*-   Output: ABORT           - success or failure
*-         : err             - reason for failure, if any
*- 
*-   Created 6-6-94          D. F. Geesaman
* $Log$
* Revision 1.3  1995/05/22 19:45:41  cdaq
* (SAW) Split gen_data_data_structures into gen, hms, sos, and coin parts"
*
* Revision 1.2  1995/05/11  17:07:14  cdaq
* (SAW) Fix SOS to be in plane, beam left
*
* Revision 1.1  1994/06/14  04:09:12  cdaq
* Initial revision
*
*--------------------------------------------------------
      IMPLICIT NONE
      SAVE
*
      character*50 here
      parameter (here= 's_init_physics')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 'gen_data_structures.cmn'
      INCLUDE 'sos_data_structures.cmn'
      INCLUDE 'gen_constants.par'
      INCLUDE 'gen_units.par'
      INCLUDE 'sos_physics_sing.cmn'
*
*     local variables 
*--------------------------------------------------------
*
      ABORT= .FALSE.
      err= ' '
*
*     Fix SOS to be in plane, beam left
*
      SPHI_LAB = TT/2
*
      COSSTHETAS = COS(STHETA_LAB)
      SINSTHETAS = SIN(STHETA_LAB)
*     Constants for elastic kinematics calcultion
      SPHYSICSA = 2.*CEBEAM*TMASS_TARGET - mass_electron**2 - SPARTMASS**2
      SPHYSICSB = 2. * ( TMASS_TARGET - CEBEAM)
      SPHYSICAB2 = SPHYSICSA**2 * SPHYSICSB**2
      SPHYSICSM3B = SPARTMASS**2 * SPHYSICSB**2
      RETURN
      END
