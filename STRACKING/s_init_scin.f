      subroutine s_init_scin(ABORT,err)

*-------------------------------------------------------------------
* author: John Arrington
* created: 2/22/94
*
* s_init_scin initializes the corrections and parameters
* for the scintillators.  Corrections are read from data files
* or the database.  Arrays used by the tof fitting routines
* are filled from the CTP variables input from the sos_positions
* parameter file.
*
* modifications:
*       23 March 1993   DFG
*            Remove /nolist from include statement. UNIX doesn't like it.
* $Log$
* Revision 1.3  1994/11/22 21:12:11  cdaq
* (SPB) Recopied from hms file and modified names for SOS
*
* Revision 1.2  1994/06/01  15:37:05  cdaq
* (SAW) Add Abort and err arguments
*
* Revision 1.1  1994/04/13  18:19:01  cdaq
* Initial revision
*
*-------------------------------------------------------------------

      implicit none

      include 'gen_data_structures.cmn'
      include 'sos_scin_parms.cmn'

      logical abort
      character*(*) err
      character*20 here
      parameter (here='s_init_scin')

      integer*4 plane,counter
      save
* 
*
* initialize some position parameters.
      snum_scin_counters(1) = sscin_1x_nr
      snum_scin_counters(2) = sscin_1y_nr
      snum_scin_counters(3) = sscin_2x_nr
      snum_scin_counters(4) = sscin_2y_nr
*
*
* Clear arrays since some some entries left blank (array up to 16, only 10
* elements in some planes
      do plane = 1 , snum_scin_planes
        do counter = 1 , snum_scin_counters(plane)

          if (plane .eq. 1) then
            shodo_width(plane,counter) = sscin_1x_size
            shodo_center_coord(plane,counter) =
     1           (sscin_1x_top(counter) + sscin_1x_size/2.)
          else if (plane .eq. 2) then
            shodo_width(plane,counter) = sscin_1y_size
            shodo_center_coord(plane,counter) =
     1           (sscin_1y_left(counter) - sscin_1y_size/2.)
          else if (plane .eq. 3) then
            shodo_width(plane,counter) = sscin_2x_size
            shodo_center_coord(plane,counter) =
     1           (sscin_2x_top(counter) + sscin_2x_size/2.)
          else if (plane .eq. 4) then
            shodo_width(plane,counter) = sscin_2y_size
            shodo_center_coord(plane,counter) =
     1           (sscin_2y_left(counter) - sscin_2y_size/2.)
          else                          ! Error in plane number
            abort = .true.
            write(err,*) 'Trying to init. sos hodoscope plane',plane
            call g_prepend(here,err)
            return
          endif

        enddo                           !loop over counters
      enddo                             !loop over planes

      return
      end
