      SUBROUTINE H_reset_event(ABORT,err)
*--------------------------------------------------------
*-       Prototype C analysis routine
*-
*-
*-   Purpose and Methods : Resets all HMS quantities before event is processed.
*-
*- 
*-   Output: ABORT		- success or failure
*-         : err	- reason for failure, if any
*- 
*-   Created  29-Oct-1993   Kevin B. Beard
*-   Modified 20-Nov-1993   KBB for new errors
*-
*- All standards are from "Proposal for Hall C Analysis Software
*- Vade Mecum, Draft 1.0" by D.F.Geesamn and S.Wood, 7 May 1993
*-
*--------------------------------------------------------
      IMPLICIT NONE
      SAVE
*
      character*50 here
      parameter (here= 'H_reset_event')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 'gen_data_structures.cmn'
*
      INTEGER hit,track,block,i,j,plane
*
*--------------------------------------------------------
*
      DO hit= 1,HMAX_DC_HITS
         HDC_RAW_PLANE_NUM(hit)= 0
         HDC_RAW_WIRE_NUM(hit)= 0
         HDC_RAW_TDC(hit)= 0
         HDC_DRIFT_TIME(hit)= 0
         HDC_DRIFT_DIS(hit)= 0
         HDC_WIRE_CENTER(hit)= 0
         HDC_WIRE_COORD(hit)= 0
         HDC_PLANE_NUM(hit)= 0
         HDC_WIRE_NUM(hit)= 0
         HDC_TDC(hit)= 0
      ENDDO
      HDC_TOT_HITS= 0
*
      DO plane= 1,HMAX_NUM_DC_PLANES
         HDC_HITS_PER_PLANE(plane)= 0
      ENDDO
*
      DO hit= 1,HMAX_SCIN_HITS
         HSCIN_SCIN_COORD(hit)= 0
         HSCIN_HIT_COORD(hit)= 0
         HSCIN_COR_ADC(hit)= 0
         HSCIN_COR_TIME(hit)= 0
         HSCIN_PLANE_NUM(hit)= 0
         HSCIN_COUNTER_NUM(hit)= 0
         HSCIN_ADC_POS(hit)= 0
         HSCIN_ADC_NEG(hit)= 0
         HSCIN_TDC_POS(hit)= 0
         HSCIN_TDC_NEG(hit)= 0
      ENDDO
      DO plane= 1,HNUM_SCIN_PLANES
         HSCIN_HITS_PER_PLANE(plane)= 0
      ENDDO
      HSCIN_TOT_HITS= 0
*     
*     HMS CALORIMETER HITS
*
      DO block= 1,HMAX_CAL_BLOCKS
         HCAL_XPOS(block)= 0
         HCAL_YPOS(block)= 0
         HCAL_COR_ADC(block)= 0
         HCAL_ROW(block)= 0
         HCAL_COLUMN(block)= 0
         HCAL_ADC(block)= 0
      ENDDO
      HCAL_TOT_HITS= 0
*     
*     HMS CERENKOV HITS
*
      DO hit= 1,HMAX_CER_HITS
         HCER_TUBE_NUM(hit)= 0
         HCER_ADC(hit)= 0
         HCER_PLANE(hit)= 0
      ENDDO
      HCER_TOT_HITS= 0
*     
*     
*     HMS DETECTOR TRACK QUANTITIES
*     
      DO track= 1,HNTRACKS_MAX
         HX_FP(track)= 0
         HY_FP(track)= 0
         HZ_FP(track)= 0
         HXP_FP(track)= 0
         HYP_FP(track)= 0
         HCHI2_FP(track)= 0
         HDEL_FP(4,4,track)= 0
         HNFREE_FP(track)= 0
         Do hit= 1,HNTRACKHITS_MAX
	    HNTRACK_HITS(track,hit)= 0
         EndDo
      ENDDO
      HNTRACKS_FP= 0
*     
*     HMS TARGET QUANTITIES
*     
      DO track= 1,HNTRACKS_MAX
         HX_TAR(track)= 0
         HY_TAR(track)= 0
         HZ_TAR(track)= 0
         HXP_TAR(track)= 0
         HYP_TAR(track)= 0
         HDELTA_TAR(track)= 0
         HP_TAR(track)= 0
         HCHI2_TAR(track)= 0
         HDEL_TAR(5,5,track)= 0
         HNFREE_TAR(track)= 0
         HLINK_TAR_FP(track)= 0
      ENDDO
      HNTRACKS_TAR= 0
*     
*     
      ABORT= .FALSE.
      err= ' '
      RETURN
      END
