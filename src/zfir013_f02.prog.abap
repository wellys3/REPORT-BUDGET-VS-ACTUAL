*&---------------------------------------------------------------------*
*& Include          ZFIR013_F02
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form F_PROCESS_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_DATA
*&---------------------------------------------------------------------*
FORM f_process_data    USING p_git_mara TYPE gtt_mara
                             p_git_makt TYPE gtt_makt
                    CHANGING p_git_mara_makt TYPE gtt_mara_makt
                             p_git_mara_makt_2 TYPE gtt_mara_makt_2.

  CASE gd_rb.
    WHEN 'RB3'.

      LOOP AT p_git_mara INTO gwa_mara.

        CLEAR gwa_mara_makt.
        gwa_mara_makt-matnr = gwa_mara-matnr.

        READ TABLE p_git_makt INTO gwa_makt WITH KEY matnr = gwa_mara-matnr.
        IF sy-subrc EQ 0.

          gwa_mara_makt-maktx = gwa_makt-maktx.

        ENDIF.

        APPEND gwa_mara_makt TO p_git_mara_makt.

      ENDLOOP.

    WHEN 'RB4'.

      LOOP AT p_git_mara INTO gwa_mara.

        CLEAR gwa_mara_makt_2.
        gwa_mara_makt_2-matnr = gwa_mara-matnr.

        READ TABLE p_git_makt INTO gwa_makt WITH KEY matnr = gwa_mara-matnr.
        IF sy-subrc EQ 0.

          gwa_mara_makt_2-maktx = gwa_makt-maktx.

        ENDIF.

        APPEND gwa_mara_makt_2 TO p_git_mara_makt_2.

      ENDLOOP.

  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_PREPARING_EXCEL_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GIT_EXCEL_RAW
*&      <-- GIT_EXCEL_FIX
*&---------------------------------------------------------------------*
FORM f_preparing_excel_data     USING p_git_excel_raw TYPE gtt_excel_raw
                             CHANGING p_git_excel_fix TYPE gtt_excel_fix.

  LOOP AT p_git_excel_raw INTO gwa_excel_raw.

    CLEAR gwa_excel_fix.
    gwa_excel_fix-bukrs = gwa_excel_raw-col1.
    gwa_excel_fix-belnr = gwa_excel_raw-col2.
    gwa_excel_fix-gjahr = gwa_excel_raw-col3.
    APPEND gwa_excel_fix TO p_git_excel_fix.

  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_EXEC_BUTTON_1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_DATA[]
*&---------------------------------------------------------------------*
FORM f_exec_button_1  CHANGING p_git_mara_makt_2 TYPE gtt_mara_makt_2.

  LOOP AT p_git_mara_makt_2 ASSIGNING FIELD-SYMBOL(<lfs_mara_makt_2>)
    WHERE select EQ 'X'.

    CONCATENATE <lfs_mara_makt_2>-matnr
                <lfs_mara_makt_2>-maktx
     INTO <lfs_mara_makt_2>-matnr_maktx
      SEPARATED BY space.

  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_DATA_2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_ZFIVT00004
*&---------------------------------------------------------------------*
FORM f_get_data_2  CHANGING p_git_zfivt00004 TYPE gtt_zfivt00004.

  PERFORM f_progress_bar_single USING 'Getting data...' 'S' 'S'.

  "*--------------------------------------------------------------------*
  "Company Code

  CLEAR git_named_seltabs[].
  IF s5_bukrs[] IS NOT INITIAL.
    CLEAR gwa_named_seltabs.
    gwa_named_seltabs-name = 'RBUKRS'.
    gwa_named_seltabs-dref = REF #( s5_bukrs[] ).
    APPEND gwa_named_seltabs TO git_named_seltabs.

    TRY.
        CLEAR gd_where.
        gd_where = cl_shdb_seltab=>combine_seltabs(
          EXPORTING it_named_seltabs = git_named_seltabs[]
                    "iv_client_field = 'MANDT'
        ).
      CATCH cx_shdb_exception.
    ENDTRY.

  ENDIF.

  "*--------------------------------------------------------------------*
  "Profit Center

  CLEAR git_named_seltabs[].
  IF s5_prctr[] IS NOT INITIAL.
    CLEAR gwa_named_seltabs.
    gwa_named_seltabs-name = 'PRCTR'.
    gwa_named_seltabs-dref = REF #( s5_prctr[] ).
    APPEND gwa_named_seltabs TO git_named_seltabs.

    TRY.
        CLEAR gd_where2.
        gd_where2 = cl_shdb_seltab=>combine_seltabs(
          EXPORTING it_named_seltabs = git_named_seltabs[]
                    "iv_client_field = 'MANDT'
        ).
      CATCH cx_shdb_exception.
    ENDTRY.

  ENDIF.

  "*--------------------------------------------------------------------*
  "GL Account

  CLEAR git_named_seltabs[].
  IF s5_racct[] IS NOT INITIAL.
    CLEAR gwa_named_seltabs.
    gwa_named_seltabs-name = 'RACCT'.
    gwa_named_seltabs-dref = REF #( s5_racct[] ).
    APPEND gwa_named_seltabs TO git_named_seltabs.

    TRY.
        CLEAR gd_where3.
        gd_where3 = cl_shdb_seltab=>combine_seltabs(
          EXPORTING it_named_seltabs = git_named_seltabs[]
                    "iv_client_field = 'MANDT'
        ).
      CATCH cx_shdb_exception.
    ENDTRY.

  ENDIF.

  "*--------------------------------------------------------------------*
  "Posting Date

  CLEAR git_named_seltabs[].
  IF s5_budat[] IS NOT INITIAL.
    CLEAR gwa_named_seltabs.
    gwa_named_seltabs-name = 'BUDAT'.
    gwa_named_seltabs-dref = REF #( s5_budat[] ).
    APPEND gwa_named_seltabs TO git_named_seltabs.

    TRY.
        CLEAR gd_where4.
        gd_where4 = cl_shdb_seltab=>combine_seltabs(
          EXPORTING it_named_seltabs = git_named_seltabs[]
                    "iv_client_field = 'MANDT'
        ).
      CATCH cx_shdb_exception.
    ENDTRY.

  ENDIF.

  "*--------------------------------------------------------------------*
  "Cost Center

  CLEAR git_named_seltabs[].
  IF s5_rcntr[] IS NOT INITIAL.
    CLEAR gwa_named_seltabs.
    gwa_named_seltabs-name = 'RCNTR'.
    gwa_named_seltabs-dref = REF #( s5_rcntr[] ).
    APPEND gwa_named_seltabs TO git_named_seltabs.

    TRY.
        CLEAR gd_where5.
        gd_where5 = cl_shdb_seltab=>combine_seltabs(
          EXPORTING it_named_seltabs = git_named_seltabs[]
                    "iv_client_field = 'MANDT'
        ).
      CATCH cx_shdb_exception.
    ENDTRY.

  ENDIF.

  "*--------------------------------------------------------------------*
  "Cost Center Group

  IF s5_setnm[] IS NOT INITIAL.

    SELECT * FROM setleaf
      INTO TABLE @DATA(lit_setleaf)
        WHERE setclass EQ '0101' AND
              subclass EQ 'MPCA' AND
*              setname IN 'E500203000'.
              setname IN @s5_setnm.
    IF lit_setleaf[] IS NOT INITIAL.

      CLEAR gra_racct[].
      LOOP AT lit_setleaf INTO DATA(lwa_setleaf).
        f_fill_range: gra_racct lwa_setleaf-valsign lwa_setleaf-valoption lwa_setleaf-valfrom lwa_setleaf-valto.
      ENDLOOP.

      CLEAR git_named_seltabs[].
      IF gra_racct[] IS NOT INITIAL.
        CLEAR gwa_named_seltabs.
        gwa_named_seltabs-name = 'RCNTR'.
        gwa_named_seltabs-dref = REF #( gra_racct[] ).
        APPEND gwa_named_seltabs TO git_named_seltabs.

        TRY.
            CLEAR gd_where6.
            gd_where6 = cl_shdb_seltab=>combine_seltabs(
              EXPORTING it_named_seltabs = git_named_seltabs[]
                        "iv_client_field = 'MANDT'
            ).
          CATCH cx_shdb_exception.
        ENDTRY.

      ENDIF.

    ENDIF.

  ENDIF.

  "*--------------------------------------------------------------------*

  "Add by Tony 16/08/2023
  DATA : lr_mandt TYPE RANGE OF symandt.
  DATA : lt_table       TYPE ztt_acdoca_aufk,
         lt_acdoca_cosp TYPE ztt_acdoca_cosp.

  APPEND INITIAL LINE TO lr_mandt ASSIGNING FIELD-SYMBOL(<fwa_mandt>).
  <fwa_mandt>-sign = 'I'.
  <fwa_mandt>-option = 'EQ'.
  <fwa_mandt>-low = sy-mandt.

  TRY.
      DATA(lv_where_clause) = cl_shdb_seltab=>combine_seltabs(
                       it_named_seltabs = VALUE #(
                          ( name = 'RCLNT' dref = REF #( lr_mandt[] ) )
                          ( name = 'RBUKRS' dref = REF #( s5_bukrs[] ) )
                          ( name = 'PRCTR' dref = REF #( s5_prctr[] ) )
                          ( name = 'RACCT' dref = REF #( s5_racct[] ) )
                          ( name = 'BUDAT' dref = REF #( s5_budat[] ) )
                          ( name = 'RCNTR' dref = REF #( s5_rcntr[] ) )
                          ) ).

      DATA(lv_where_clause2) = cl_shdb_seltab=>combine_seltabs(
                       it_named_seltabs = VALUE #(
                          ( name = 'RCNTR' dref = REF #( gra_racct[] ) )
                          ) ).
    CATCH cx_shdb_exception.
  ENDTRY.

  CALL METHOD zcl_amdp_acdoca_cosp=>get_data(
    EXPORTING
      iv_where        = lv_where_clause
      iv_where_setnum = lv_where_clause2
    IMPORTING
      et_data         = lt_table ).

  SELECT a~rclnt, a~rbukrs, a~gjahr, a~racct, a~racct_desc, a~prctr, a~rcntr, a~auart, a~auart_desc,
         a~objnr, a~rwcur, a~wsl, b~wtg001, b~wtg002, b~wtg003, b~wtg004, b~wtg005, b~wtg006, b~wtg007,
         b~wtg008, b~wtg009, b~wtg010, b~wtg011, b~wtg012, b~wtg_sum
  FROM @lt_table AS a LEFT JOIN zficd_zfir013_cosp_sum AS b
      ON  a~gjahr = b~gjahr AND
          a~objnr = b~objnr AND
          a~racct = b~kstar AND
          a~rwcur = b~twaer
    INTO CORRESPONDING FIELDS OF TABLE @lt_acdoca_cosp
    ##ITAB_KEY_IN_SELECT
    ##DB_FEATURE_MODE[ITABS_IN_FROM_CLAUSE].

  p_git_zfivt00004[] = CORRESPONDING #( lt_acdoca_cosp ).

  "End add by Tony 16/08/2023

  "Remark by Tony 16/08/2023
*  SELECT *
**    FROM zfivt00004( im_budat_from = @sy-datum,
*    FROM zficd_zfir013_acdoca_cosp( im_mandt = @sy-mandt,
*                                    im_rbukrs = @gd_where,
*                                    im_saknr = @gd_where2,
*                                    im_budat = @gd_where3,
*                                    im_rcntr = @gd_where4,
*                                    im_rcntr2 = @gd_where5,
*                                    im_prctr = @gd_where6
**                                    im_budat_from = @sy-datum,
**                                    im_budat_to = @sy-datum
*                                   )
*      INTO CORRESPONDING FIELDS OF TABLE @p_git_zfivt00004
*    ##DB_FEATURE_MODE[AMDP_TABLE_FUNCTION]
  "End remark by Tony 16/08/2023


*        WHERE rbukrs IN @s5_bukrs AND
*              racct IN @s5_racct.
  .

  SORT p_git_zfivt00004 ASCENDING BY rbukrs gjahr racct racct_desc prctr
                                     rcntr auart auart_desc objnr rwcur.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_DATA_2_B
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_ZFIVT00004
*&---------------------------------------------------------------------*
FORM f_get_data_2_b  CHANGING p_git_zfivt00004 TYPE gtt_zfivt00004.

  PERFORM f_progress_bar_single USING 'Getting data...' 'S' 'S'.

  "*--------------------------------------------------------------------*
  "Company Code

*****  CLEAR git_named_seltabs[].
*****  IF s5_bukrs[] IS NOT INITIAL.
*****    CLEAR gwa_named_seltabs.
*****    gwa_named_seltabs-name = 'RBUKRS'.
*****    gwa_named_seltabs-dref = REF #( s5_bukrs[] ).
*****    APPEND gwa_named_seltabs TO git_named_seltabs.
*****
*****    TRY.
*****        CLEAR gd_where.
*****        gd_where = cl_shdb_seltab=>combine_seltabs(
*****          EXPORTING it_named_seltabs = git_named_seltabs[]
*****                    "iv_client_field = 'MANDT'
*****        ).
*****      CATCH cx_shdb_exception.
*****    ENDTRY.
*****
*****  ENDIF.

  "*--------------------------------------------------------------------*
  "Profit Center

*****  CLEAR git_named_seltabs[].
*****  IF s5_prctr[] IS NOT INITIAL.
*****    CLEAR gwa_named_seltabs.
*****    gwa_named_seltabs-name = 'PRCTR'.
*****    gwa_named_seltabs-dref = REF #( s5_prctr[] ).
*****    APPEND gwa_named_seltabs TO git_named_seltabs.
*****
*****    TRY.
*****        CLEAR gd_where2.
*****        gd_where2 = cl_shdb_seltab=>combine_seltabs(
*****          EXPORTING it_named_seltabs = git_named_seltabs[]
*****                    "iv_client_field = 'MANDT'
*****        ).
*****      CATCH cx_shdb_exception.
*****    ENDTRY.
*****
*****  ENDIF.

  "*--------------------------------------------------------------------*
  "GL Account

*****  CLEAR git_named_seltabs[].
*****  IF s5_racct[] IS NOT INITIAL.
*****    CLEAR gwa_named_seltabs.
*****    gwa_named_seltabs-name = 'RACCT'.
*****    gwa_named_seltabs-dref = REF #( s5_racct[] ).
*****    APPEND gwa_named_seltabs TO git_named_seltabs.
*****
*****    TRY.
*****        CLEAR gd_where3.
*****        gd_where3 = cl_shdb_seltab=>combine_seltabs(
*****          EXPORTING it_named_seltabs = git_named_seltabs[]
*****                    "iv_client_field = 'MANDT'
*****        ).
*****      CATCH cx_shdb_exception.
*****    ENDTRY.
*****
*****  ENDIF.

  "*--------------------------------------------------------------------*
  "Posting Date

*****  CLEAR git_named_seltabs[].
*****  IF s5_budat[] IS NOT INITIAL.
*****    CLEAR gwa_named_seltabs.
*****    gwa_named_seltabs-name = 'BUDAT'.
*****    gwa_named_seltabs-dref = REF #( s5_budat[] ).
*****    APPEND gwa_named_seltabs TO git_named_seltabs.
*****
*****    TRY.
*****        CLEAR gd_where4.
*****        gd_where4 = cl_shdb_seltab=>combine_seltabs(
*****          EXPORTING it_named_seltabs = git_named_seltabs[]
*****                    "iv_client_field = 'MANDT'
*****        ).
*****      CATCH cx_shdb_exception.
*****    ENDTRY.
*****
*****  ENDIF.

  "*--------------------------------------------------------------------*
  "Cost Center

*****  CLEAR git_named_seltabs[].
*****  IF s5_rcntr[] IS NOT INITIAL.
*****    CLEAR gwa_named_seltabs.
*****    gwa_named_seltabs-name = 'RCNTR'.
*****    gwa_named_seltabs-dref = REF #( s5_rcntr[] ).
*****    APPEND gwa_named_seltabs TO git_named_seltabs.
*****
*****    TRY.
*****        CLEAR gd_where5.
*****        gd_where5 = cl_shdb_seltab=>combine_seltabs(
*****          EXPORTING it_named_seltabs = git_named_seltabs[]
*****                    "iv_client_field = 'MANDT'
*****        ).
*****      CATCH cx_shdb_exception.
*****    ENDTRY.
*****
*****  ENDIF.

  "*--------------------------------------------------------------------*
  "Cost Center Group

  IF s5_setnm[] IS NOT INITIAL.

    SELECT * FROM setleaf
      INTO TABLE @DATA(lit_setleaf)
        WHERE setclass EQ '0101' AND
              subclass EQ 'MPCA' AND
*              setname IN 'E500203000'.
              setname IN @s5_setnm.
    IF lit_setleaf[] IS NOT INITIAL.

      CLEAR gra_racct[].
      LOOP AT lit_setleaf INTO DATA(lwa_setleaf).
        f_fill_range: gra_racct lwa_setleaf-valsign lwa_setleaf-valoption lwa_setleaf-valfrom lwa_setleaf-valto.
      ENDLOOP.

    ENDIF.

  ENDIF.

  "*--------------------------------------------------------------------*

  "Add by Tony 16/08/2023
  DATA : lr_mandt TYPE RANGE OF symandt.
  DATA : lt_table       TYPE ztt_acdoca_aufk,
         lt_acdoca_cosp TYPE ztt_acdoca_cosp.

  APPEND INITIAL LINE TO lr_mandt ASSIGNING FIELD-SYMBOL(<fwa_mandt>).
  <fwa_mandt>-sign = 'I'.
  <fwa_mandt>-option = 'EQ'.
  <fwa_mandt>-low = sy-mandt.

  TRY.
      DATA(lv_where_clause) = cl_shdb_seltab=>combine_seltabs(
                       it_named_seltabs = VALUE #(
                          ( name = 'RCLNT' dref = REF #( lr_mandt[] ) )
                          ( name = 'RBUKRS' dref = REF #( s5_bukrs[] ) )
                          ( name = 'PRCTR' dref = REF #( s5_prctr[] ) )
                          ( name = 'RACCT' dref = REF #( s5_racct[] ) )
                          ( name = 'BUDAT' dref = REF #( s5_budat[] ) )
                          ( name = 'RCNTR' dref = REF #( s5_rcntr[] ) )
                          ) ).

      DATA(lv_where_clause2) = cl_shdb_seltab=>combine_seltabs(
                       it_named_seltabs = VALUE #(
                          ( name = 'RCNTR' dref = REF #( gra_racct[] ) )
                          ) ).
    CATCH cx_shdb_exception.
  ENDTRY.

*  CALL METHOD zcl_amdp_acdoca_cosp=>get_data(
*    EXPORTING
*      iv_where        = lv_where_clause
*      iv_where_setnum = lv_where_clause2
*    IMPORTING
*      et_data         = lt_table ).
*
*  SELECT a~rclnt, a~rbukrs, a~gjahr, a~racct, a~racct_desc, a~prctr, a~rcntr, a~auart, a~auart_desc,
*         a~objnr, a~rwcur, a~wsl, b~wtg001, b~wtg002, b~wtg003, b~wtg004, b~wtg005, b~wtg006, b~wtg007,
*         b~wtg008, b~wtg009, b~wtg010, b~wtg011, b~wtg012, b~wtg_sum
*  FROM @lt_table AS a LEFT JOIN zficd_zfir013_cosp_sum AS b
*      ON  a~gjahr = b~gjahr AND
*          a~objnr = b~objnr AND
*          a~racct = b~kstar AND
*          a~rwcur = b~twaer
*    INTO CORRESPONDING FIELDS OF TABLE @lt_acdoca_cosp.
*
*  p_git_zfivt00004[] = CORRESPONDING #( lt_acdoca_cosp ).

  "End add by Tony 16/08/2023

  "Remark by Tony 16/08/2023
*  SELECT *
**    FROM zfivt00004( im_budat_from = @sy-datum,
*    FROM zficd_zfir013_acdoca_cosp( im_mandt = @sy-mandt,
*                                    im_rbukrs = @gd_where,
*                                    im_saknr = @gd_where2,
*                                    im_budat = @gd_where3,
*                                    im_rcntr = @gd_where4,
*                                    im_rcntr2 = @gd_where5,
*                                    im_prctr = @gd_where6
**                                    im_budat_from = @sy-datum,
**                                    im_budat_to = @sy-datum
*                                   )
*      INTO CORRESPONDING FIELDS OF TABLE @p_git_zfivt00004
*    ##DB_FEATURE_MODE[AMDP_TABLE_FUNCTION]
  "End remark by Tony 16/08/2023


*        WHERE rbukrs IN @s5_bukrs AND
*              racct IN @s5_racct.
  .

  TRY.
      CLEAR lt_acdoca_cosp[].
      CALL METHOD zficl_zfir013_amdp=>get_acdoca_cosp
        EXPORTING
          im_where1      = lv_where_clause
          im_where2      = lv_where_clause2
        IMPORTING
          et_acdoca_cosp = lt_acdoca_cosp[].
    CATCH cx_amdp_error. " Exceptions when calling AMDP methods
  ENDTRY.

  p_git_zfivt00004[] = CORRESPONDING #( lt_acdoca_cosp ).

  SORT p_git_zfivt00004 ASCENDING BY rbukrs gjahr racct racct_desc prctr
                                     rcntr auart auart_desc objnr rwcur.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_PREPARE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_ZFIVT00004
*&---------------------------------------------------------------------*
FORM f_prepare_data  CHANGING p_git_zfivt00004 TYPE gtt_zfivt00004.

  FIELD-SYMBOLS: <lfs>.

  DATA : ld_wtg_sum    TYPE acdoca-hsl,
         ld_fs(100),
         ld_counter(3) TYPE n,
         ld_period     TYPE pgpl-spmon,
         ld_input      TYPE sy-datum,
         ld_output     TYPE sy-datum.

*--------------------------------------------------------------------*

  PERFORM f_progress_bar_single USING 'Preparing data...' 'S' 'S'.

  "*--------------------------------------------------------------------*

  CLEAR gra_period[].
  IF s5_budat-low IS NOT INITIAL AND s5_budat-high IS NOT INITIAL.
    f_fill_range: gra_period 'I' 'BT' s5_budat-low(6) s5_budat-high(6).
  ELSEIF s5_budat-low IS NOT INITIAL AND s5_budat-high IS INITIAL.
    f_fill_range: gra_period 'I' 'EQ' s5_budat-low(6) ''.
  ELSEIF s5_budat-low IS INITIAL AND s5_budat-high IS NOT INITIAL.
    f_fill_range: gra_period 'I' 'EQ' s5_budat-high(6) ''.
  ENDIF.

  "*--------------------------------------------------------------------*

  CLEAR: gd_percent, gd_lines.
  DESCRIBE TABLE p_git_zfivt00004 LINES gd_lines.

  LOOP AT p_git_zfivt00004 ASSIGNING FIELD-SYMBOL(<lfs_zfivt00004>).

    PERFORM f_progress_bar USING 'Preparing data...'
                                  sy-tabix
                                  gd_lines.

    "*--------------------------------------------------------------------*

    CLEAR: ld_period.
    IF s5_budat-low IS NOT INITIAL AND s5_budat-high IS NOT INITIAL.
      ld_period = s5_budat-low(4) && '01'.
    ELSEIF s5_budat-low IS NOT INITIAL AND s5_budat-high IS INITIAL.
      ld_period = s5_budat-high(4) && '01'.
    ELSEIF s5_budat-low IS INITIAL AND s5_budat-high IS NOT INITIAL.
      ld_period = s5_budat-low(4) && '01'.
    ENDIF.

    "*--------------------------------------------------------------------*

    CLEAR ld_wtg_sum.
    DO 12 TIMES.

      ld_counter = sy-index.

      CONCATENATE '<LFS_ZFIVT00004>' '-' 'WTG' ld_counter INTO ld_fs.
      CONDENSE ld_fs NO-GAPS.
      ASSIGN (ld_fs) TO <lfs>.

      IF ld_period IN gra_period.
        ADD <lfs> TO ld_wtg_sum.
      ENDIF.

      "*--------------------------------------------------------------------*
      "Add counter

      ld_input = ld_period && '01'.

      CLEAR ld_output.
      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
        EXPORTING
          date      = ld_input
          days      = 0
          months    = 1
          signum    = '+'
          years     = 0
        IMPORTING
          calc_date = ld_output.

      ld_period = ld_output(6).

      "*--------------------------------------------------------------------*

    ENDDO.

    <lfs_zfivt00004>-wtg = ld_wtg_sum.

  ENDLOOP.


ENDFORM.
