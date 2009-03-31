      subroutine gep_keep_results(ABORT,err)
      
      implicit none
      save

c      include 'gen_event_info.cmn'
      include 'gep_data_structures.cmn'
      include 'hms_data_structures.cmn'
      include 'hms_physics_sing.cmn'
      include 'bigcal_data_structures.cmn'
      INCLUDE 'bigcal_bypass_switches.cmn'

      character*14 here
      parameter(here='b_keep_results')

      logical abort
      character*(*) err

      abort=.false.
      err=' '

      if(HSNUM_FPTRACK.gt.0 .and. bigcal_all_nclust_good .gt. 0 .and. 
     $     b_passed_cointime_cut.and.h_passed_cointime_cut) then
c         gep_evid = gen_event_id_number
         if(gep_use_ntuple_cuts.eq.0.or.(
     $        abs(hsxp_tar).lt.hprune_xp.and.
     $        abs(hsyp_tar).lt.hprune_yp.and.
     $        abs(hsdelta).lt.hprune_delta.and.
     $        abs(hsy_tar).lt.hprune_ytar
     $        )) then
            call gep_ntuple_keep(abort,err)
         endif
         call gep_fill_hist(abort,err)
      endif
      if(abort) then
         call G_add_path(here,err)
         return
      else
         err=' '
      endif
      
      return
      end
