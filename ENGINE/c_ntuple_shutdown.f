      subroutine c_Ntuple_shutdown(ABORT,err)
*----------------------------------------------------------------------
*
*     Final shutdown of the COIN Ntuple
*
*     Purpose : Flushes and closes the COIN Ntuple
*
*     Output: ABORT      - success or failure
*           : err        - reason for failure, if any
*
*     Created: 8-Apr-1994  K.B.Beard, HU: added Ntuples
* $Log$
* Revision 1.4  1998/12/01 15:33:33  saw
* (SAW) Clean out archaic g_build_note stuff
*
* Revision 1.3  1994/06/29 03:24:56  cdaq
* (KBB) Remove HDELET call
*
* Revision 1.2  1994/06/17  03:00:30  cdaq
* (KBB) Upgrade
*
* Revision 1.1  1994/04/12  16:14:33  cdaq
* Initial revision
*
*
*----------------------------------------------------------------------
      implicit none
      save
*
      character*17 here
      parameter (here='c_Ntuple_shutdown')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 'c_ntuple.cmn'
      INCLUDE 'gen_routines.dec'
*
      logical FAIL
      character*80 why,directory,name
      character*1000 msg
      integer io,id,cycle,m
*
      logical HEXIST      !CERNLIB function
*
*--------------------------------------------------------
      err= ' '
      ABORT = .FALSE.
*
      IF(.NOT.c_Ntuple_exists) RETURN       !nothing to do
*
      call HCDIR(directory,'R')                !keep current directory
*
      id= c_Ntuple_ID
      io= c_Ntuple_IOchannel
*
      ABORT= .NOT.HEXIST(id)
      IF(ABORT) THEN
        write(err,'(": Ntuple ID#",i5," does not exist")') id
        call G_add_path(here,err)
        If(io.GT.0) Then
          call G_IO_control(io,'FREE',FAIL,why) !free up
          if(.NOT.FAIL) CLOSE(io)
        EndIf
        c_Ntuple_exists= .FALSE.
        c_Ntuple_ID= 0
        c_Ntuple_name= ' '
        c_Ntuple_IOchannel= 0
        c_Ntuple_file= ' '
        c_Ntuple_title= ' '
        c_Ntuple_directory= ' '
        c_Ntuple_size= 0
        do m=1,CMAX_Ntuple_size
          c_Ntuple_tag(m)= ' '
          c_Ntuple_contents(m)= 0.
        enddo
        RETURN
      ENDIF
*
      id= c_Ntuple_ID
      io= c_Ntuple_IOchannel
      name= c_Ntuple_name
      call HCDIR(c_Ntuple_directory,' ')      !goto Ntuple directory
*
      write(msg,'("closing ID#",i5," IO#",i3," ",a)') id,io,c_ntuple_file
      call G_add_path(here,msg)
      call G_log_message('INFO: '//msg)
*
      cycle= 0                                !dummy for HROUT
      call HROUT(id,cycle,' ')                !flush CERNLIB buffers
      call HREND(name)                        !CERNLIB close file
*      call HDELET(id)                         !CERNLIB delete tuple
      call G_IO_control(io,'FREE',ABORT,err)  !free up IO channel
      CLOSE(io)                               !close channel
*
      call HCDIR(directory,' ')               !return to current directory
*
      c_Ntuple_exists= .FALSE.
      c_Ntuple_ID= 0
      c_Ntuple_name= ' '
      c_Ntuple_IOchannel= 0
      c_Ntuple_file= ' '
      c_Ntuple_title= ' '
      c_Ntuple_directory= ' '
      c_Ntuple_size= 0
      do m=1,CMAX_Ntuple_size
        c_Ntuple_tag(m)= ' '
        c_Ntuple_contents(m)= 0.
      enddo
*
      IF(ABORT) call G_add_path(here,err)
*
      RETURN
      END      
