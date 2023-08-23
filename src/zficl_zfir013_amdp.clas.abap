CLASS zficl_zfir013_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.

    CLASS-METHODS:

      get_acdoca_tf FOR TABLE FUNCTION zficd_zfir013_tf_acdoca,

      get_acdoca_cosp IMPORTING
                        VALUE(im_where1)      TYPE sxmsbody
                        VALUE(im_where2)      TYPE sxmsbody
                      EXPORTING
                        VALUE(et_acdoca_cosp) TYPE ztt_acdoca_cosp
                      RAISING
                        cx_amdp_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zficl_zfir013_amdp IMPLEMENTATION.

  METHOD get_acdoca_tf BY DATABASE FUNCTION FOR HDB
                    LANGUAGE SQLSCRIPT
                    OPTIONS READ-ONLY
                    USING acdoca skat aufk t003p.
*                    USING acdoca skat.

    lit_acdoca = select DISTINCT
             a.rclnt  ,
             a.rldnr  ,
             a.rbukrs ,
             a.gjahr  ,
             a.belnr  ,
             a.docln  ,
             a.budat  ,
             a.blart  ,
             a.racct  ,

             b.txt50 as racct_desc ,
*'' as racct_desc,

             a.prctr  ,
             a.rcntr  ,
             a.objnr  ,
             a.aufnr  ,
             a.autyp  ,

             c.auart,
*'' as auart,

             d.txt as auart_desc,
*             '' auart_desc,

             a.rwcur  ,
             a.wsl

             from acdoca a
               left outer join skat b on
*                         b.ktopl = 'MCOA' and
                         b.spras = 'E' and
                         a.racct = b.saknr

               left outer join aufk c on
                         a.aufnr = c.aufnr

               left outer join t003p d on
                         d.spras = 'E' and
                         c.auart = d.auart

                 where
                       a.rclnt = :im_mandt and
*                  a.rbukrs = :im_rbukrs and
                       a.rldnr = '0L';

    IF :im_rbukrs <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_rbukrs);
    END if;

    IF :im_saknr <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_saknr);
    END if;

    IF :im_budat <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_budat);
    END if;

    IF :im_rcntr <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_rcntr);
    END if;

    IF :im_rcntr2 <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_rcntr2);
    END if;

    IF :im_prctr <> '' then
        lit_acdoca = apply_filter (:lit_acdoca, :im_prctr);
    END if;

         RETURN SELECT
                 a.rclnt  ,
                 a.rldnr  ,
                 a.rbukrs ,
                 a.gjahr  ,
                 a.belnr  ,
                 a.docln  ,
                 a.budat  ,
                 a.blart  ,
                 a.racct  ,
                 a.racct_desc ,
                 a.prctr  ,
                 a.rcntr  ,
                 a.objnr  ,
                 a.aufnr  ,
                 a.autyp  ,
                 a.auart,
                 a.auart_desc,
                 a.rwcur  ,
                 a.wsl
             from :lit_acdoca as a;

  endmethod.

  METHOD get_acdoca_cosp  BY DATABASE PROCEDURE FOR HDB
                           LANGUAGE SQLSCRIPT
                           OPTIONS READ-ONLY
                           USING zfivt00006 zfivt00003.

    et_acdoca_cosp_temp = APPLY_FILTER (ZFIVT00006, :im_where1);

    et_acdoca_cosp_temp = APPLY_FILTER (:et_acdoca_cosp_temp, :im_where2);

*    et_acdoca_cosp_temp2 = select
**    et_acdoca_cosp =      select
*
*                          a.rclnt,
*                          a.rbukrs,
*                          a.gjahr,
*                          a.racct,
*                          a.racct_desc,
*                          a.prctr,
*                          a.rcntr,
*                          a.auart,
*                          a.auart_desc,
*                          a.objnr,
*                          a.rwcur,
*                          a.wsl,
*
*                          b.wtg001,
*                          b.wtg002,
*                          b.wtg003,
*                          b.wtg004,
*                          b.wtg005,
*                          b.wtg006,
*                          b.wtg007,
*                          b.wtg008,
*                          b.wtg009,
*                          b.wtg010,
*                          b.wtg011,
*                          b.wtg012,
*                          b.wtg_sum
*
*                          from :et_acdoca_cosp_temp as a
*                          left outer join ZFIVT00003 as b on a.gjahr = b.gjahr and
*                                                        a.objnr = b.objnr and
*                                                        a.racct = b.kstar and
*                                                        a.rwcur = b.twaer;

**    et_acdoca_cosp_temp2 = select
*    et_acdoca_cosp =      select
*
*                          a.rclnt,
*                          a.rbukrs,
*                          a.gjahr,
*                          a.racct,
*                          a.racct_desc,
*                          a.prctr,
*                          a.rcntr,
*                          a.auart,
*                          a.auart_desc,
*                          a.objnr,
*                          a.rwcur,
*                          a.wsl,
*
*                          sum(a.wtg001) as wtg001,
*                          sum(a.wtg002) as wtg002,
*                          sum(a.wtg003) as wtg003,
*                          sum(a.wtg004) as wtg004,
*                          sum(a.wtg005) as wtg005,
*                          sum(a.wtg006) as wtg006,
*                          sum(a.wtg007) as wtg007,
*                          sum(a.wtg008) as wtg008,
*                          sum(a.wtg009) as wtg009,
*                          sum(a.wtg010) as wtg010,
*                          sum(a.wtg011) as wtg011,
*                          sum(a.wtg012) as wtg012,
*                          sum(a.wtg_sum) as wtg_sum
*
*                          from :et_acdoca_cosp_temp2 as a
*
*                          group by
*                          a.rclnt,
*                          a.rbukrs,
*                          a.gjahr,
*                          a.racct,
*                          a.racct_desc,
*                          a.prctr,
*                          a.rcntr,
*                          a.auart,
*                          a.auart_desc,
*                          a.objnr,
*                          a.rwcur,
*                          a.wsl;


*    et_acdoca_cosp_temp2 = select
    et_acdoca_cosp_temp2 =      select

                          a.rclnt,
                          a.rbukrs,
                          a.gjahr,
                          a.racct,
                          a.racct_desc,
                          a.prctr,
                          a.rcntr,
                          a.auart,
                          a.auart_desc,
                          a.objnr,
                          a.rwcur,
                          sum(a.wsl) as wsl

                          from :et_acdoca_cosp_temp as a

                          group by
                          a.rclnt,
                          a.rbukrs,
                          a.gjahr,
                          a.racct,
                          a.racct_desc,
                          a.prctr,
                          a.rcntr,
                          a.auart,
                          a.auart_desc,
                          a.objnr,
                          a.rwcur;

    et_acdoca_cosp =      select

                          a.rclnt,
                          a.rbukrs,
                          a.gjahr,
                          a.racct,
                          a.racct_desc,
                          a.prctr,
                          a.rcntr,
                          a.auart,
                          a.auart_desc,
                          a.objnr,
                          a.rwcur,
                          a.wsl,

                          b.wtg001,
                          b.wtg002,
                          b.wtg003,
                          b.wtg004,
                          b.wtg005,
                          b.wtg006,
                          b.wtg007,
                          b.wtg008,
                          b.wtg009,
                          b.wtg010,
                          b.wtg011,
                          b.wtg012,
                          b.wtg_sum

                          from :et_acdoca_cosp_temp2 as a
                          left outer join ZFIVT00003 as b on a.gjahr = b.gjahr and
                                                        a.objnr = b.objnr and
                                                        a.racct = b.kstar and
                                                        a.rwcur = b.twaer;

  ENDMETHOD.

ENDCLASS.
