      SUBROUTINE S_SCIN_EFF_SHUTDOWN(ABORT,errmsg)
*--------------------------------------------------------
*-
*-   Purpose and Methods : Analyze scintillator information for each track 
*-
*-      Required Input BANKS     SOS_SCIN_TOF
*-                               GEN_DATA_STRUCTURES
*-
*-   Output: ABORT           - success or failure
*-         : err             - reason for failure, if any
*- 
* author: John Arrington
* created: 2/15/95
*
* s_scin_eff calculates efficiencies for the hodoscope.
* s_scin_eff_shutdown does some final manipulation of the numbers.
*
* $Log$
* Revision 1.1  1995/03/13 18:18:07  cdaq
* Initial revision
*
*--------------------------------------------------------
      IMPLICIT NONE
*
      character*50 here
      parameter (here= 'S_SCIN_EFF')
*
      logical ABORT
      character*(*) errmsg
*
      INCLUDE 'gen_data_structures.cmn'
      INCLUDE 'gen_constants.par'
      INCLUDE 'gen_units.par'
      include 'sos_scin_parms.cmn'
      include 'sos_scin_tof.cmn'
      include 'sos_statistics.cmn'

      integer pln,cnt
      real p1,p2,p3,p4         !prob. of having both tubes fire for planes1-4
      real p1234,p123,p124,p134,p234 !prob. of having combos fire
      save

! fill sums over counters
      do pln=1,snum_scin_planes
        sstat_trksum(pln)=0
        sstat_possum(pln)=0
        sstat_negsum(pln)=0
        sstat_andsum(pln)=0
        sstat_orsum(pln)=0
        do cnt=1,snum_scin_counters(pln)
          sstat_trksum(pln)=sstat_trksum(pln)+sstat_trk(pln,cnt)
          sstat_possum(pln)=sstat_possum(pln)+sstat_poshit(pln,cnt)
          sstat_negsum(pln)=sstat_negsum(pln)+sstat_neghit(pln,cnt)
          sstat_andsum(pln)=sstat_andsum(pln)+sstat_andhit(pln,cnt)
          sstat_orsum(pln)=sstat_orsum(pln)+sstat_orhit(pln,cnt)
        enddo
        sstat_poseff(pln)=sstat_possum(pln)/max(.01,float(sstat_trksum(pln)))
        sstat_negeff(pln)=sstat_negsum(pln)/max(.01,float(sstat_trksum(pln)))
        sstat_andeff(pln)=sstat_andsum(pln)/max(.01,float(sstat_trksum(pln)))
        sstat_oreff(pln)=sstat_orsum(pln)/max(.01,float(sstat_trksum(pln)))
      enddo

      p1=sstat_andeff(1)
      p2=sstat_andeff(2)
      p3=sstat_andeff(3)
      p4=sstat_andeff(4)

! probability that ONLY the listed planes had triggers
      p1234= p1*p2*p3*p4
      p123 = p1*p2*p3*(1.-p4)
      p124 = p1*p2*(1.-p3)*p4
      p134 = p1*(1.-p2)*p3*p4
      p234 = (1.-p1)*p2*p3*p4

      seff_s1 = 1. - ((1.-p1)*(1.-p2))
      seff_s2 = 1. - ((1.-p3)*(1.-p4))
      seff_stof=seff_s1 * seff_s2
      seff_3_of_4=p1234+p123+p124+p134+p234
      seff_4_of_4=p1234

      return
      end
