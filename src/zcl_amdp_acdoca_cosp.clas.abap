CLASS zcl_amdp_acdoca_cosp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES : if_amdp_marker_hdb.

    CLASS-METHODS : get_data IMPORTING "value(im_mandt) type string
                    "value(im_rbukrs) TYPE string
                    "value(im_saknr) TYPE string
                    "value(im_budat) TYPE string
                    "value(im_rcntr) TYPE string
                    "value(im_rcntr2) TYPE string
                                       "value(im_prctr) TYPE string
                                       VALUE(iv_where)        TYPE string
                                       VALUE(iv_where_setnum) TYPE string
                             EXPORTING VALUE(et_data)         TYPE ztt_acdoca_aufk.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_acdoca_cosp IMPLEMENTATION.

  METHOD get_data BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS
                     READ-ONLY USING acdoca skat aufk t003p.

    et_data_temp =    select DISTINCT a.rclnt, a.rbukrs, a.gjahr, a.racct, b.txt50 as racct_desc, a.belnr, a.docln,
                                      a.prctr, a.rcntr, c.auart, d.txt as auart_desc, a.objnr, a.budat,
                                      a.rwcur  , wsl
                       from acdoca a left outer join skat b on b.spras = 'E' and
                                                     a.racct = b.saknr
                                     left outer join aufk c on a.aufnr = c.aufnr
                                     left outer join t003p d on d.spras = 'E' and
                                                                c.auart = d.auart
                       where a.rclnt = session_context( 'CLIENT') and
                             a.rldnr = '0L';

    et_data_temp = apply_filter (:et_data_temp, :iv_where);

    if :iv_where_setnum <> '' then
        et_data_temp = apply_filter (:et_data_temp, :iv_where_setnum);
    end if;

    et_data = select rclnt, rbukrs, gjahr, racct, racct_desc, prctr, rcntr, auart, auart_desc,
                     objnr, rwcur, sum(wsl) as wsl

              from :et_data_temp group by rclnt, rbukrs, gjahr, racct, racct_desc, prctr, rcntr, auart,
                                     auart_desc, objnr, rwcur;


  ENDMETHOD.

ENDCLASS.
