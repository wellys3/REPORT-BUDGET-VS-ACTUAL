*&---------------------------------------------------------------------*
*& Report ZFIR013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Description : Report Budget vs Actual
*&
*& Module      : Financial Accounting
*& Date        : June 27st, 2023
*& Developer   : - Welly Sugiarto (welly.sugiarto@equine.co.id)
*& Functional  : - Aldo (petroza22@gmail.com)
*& FSD Loc.    : - SO2_MIME_REPOSITORY --> SAP --> PUBLIC --> ZFSD
*& FSD         : - 0002.01. MPG-FSD-CO-CR3- Report Budget Vs Actual (Report 1).doc
*&               - 0002.02. FSD REPORT BUDGET VS ACTUAL (REPORT1).xlsx
*& Copyright   : © 2023 PT Equine Global
*&               © 2023 PT Evanindo
*&
*& Transport Request History (Any changes of TR will be updated here future):
*& *  MPDK907981 SUPPORT EG-AB-FI EG-AB-FI: Rep. BudgetvsActual WSU ALD #1
*&    Changelog: #1 Initial Release
*& *  MPDK908028 SUPPORT  EG-AB-FI: 1815 Rep. BudgetvsActual RAN TKE #1
*&    Changelog: #1 Fix shortdump not enough long for where condition
*& *  MPDK908036 SUPPORT EG-AB-FI: 1815 Rep. BudgetvsActual WSU RAN #2
*&    Changelog: #1 Fix shortdump not enough long for where condition
*&---------------------------------------------------------------------*


REPORT zfir013.


*--------------------------------------------------------------------*
* Includes                                                           *
*--------------------------------------------------------------------*
INCLUDE zfir013_top.   "Types, Data, Constant Declaration & Selection-Screen.
INCLUDE zfir013_f00.   "Other Function for whole this program
INCLUDE zfir013_f01.   "Get Data
INCLUDE zfir013_f02.   "Process Data
INCLUDE zfir013_f03.   "Display Data
*--------------------------------------------------------------------*
* End - Includes                                                     *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* Initialization                                                     *
*--------------------------------------------------------------------*
INITIALIZATION.
  PERFORM f_initialization.
*--------------------------------------------------------------------*
* End - Initialization                                               *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* Start-of-Selection                                                 *
*--------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM f_debug.

  CLEAR gd_subrc.
  PERFORM f_pre_execute CHANGING gd_subrc.
  CHECK gd_subrc EQ 0.

  "*--------------------------------------------------------------------*

  PERFORM f_execute.

END-OF-SELECTION.
*--------------------------------------------------------------------*
* End - Start-of-Selection                                           *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* At-Selection-Screen                                                *
*--------------------------------------------------------------------*
AT SELECTION-SCREEN.
  PERFORM f_download_template.
  PERFORM f_mandatory_validation.

AT SELECTION-SCREEN OUTPUT.
  PERFORM f_modify_screen.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_get_file_dir CHANGING p_file.
*--------------------------------------------------------------------*
* End - At-Selection-Screen                                          *
*--------------------------------------------------------------------*
