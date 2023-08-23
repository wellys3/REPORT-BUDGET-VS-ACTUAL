@AbapCatalog.sqlViewName: 'ZFIVT00004'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for ACDOCA Sum'
define view ZFICD_ZFIR013_ACDOCA_COSP
  with parameters

//    @Environment.systemField: #CLIENT
    im_mandt  : abap.clnt,
    im_rbukrs : abap.char( 1333 ),
    im_saknr  : abap.char( 1333 ),
    im_budat  : abap.char( 1333 ),
    im_rcntr  : abap.char( 1333 ),
    im_rcntr2  : abap.char( 1333 ),
    im_prctr  : abap.char( 1333 )

  as select from    zficd_zfir013_acdoca_sum //ZFIVT00002
                 (
                    im_mandt : $parameters.im_mandt,
                    im_rbukrs: $parameters.im_rbukrs,
                    im_saknr : $parameters.im_saknr,
                    im_budat : $parameters.im_budat,
                    im_rcntr : $parameters.im_rcntr,
                    im_rcntr2 : $parameters.im_rcntr2,
                    im_prctr : $parameters.im_prctr
                    )          
                    as a
    left outer join zfivt00003 as b on  a.gjahr = b.gjahr
                                    and a.objnr = b.objnr
                                    and a.racct = b.kstar
                                    and a.rwcur = b.twaer
{
  key      a.rclnt,
  key      a.rbukrs,
  key      a.gjahr,
  key      a.racct,
  key      a.racct_desc,
  key      a.prctr,
  key      a.rcntr,
  key      a.auart,
  key      a.auart_desc,
  key      a.objnr,
  key      a.rwcur,

           @Semantics: { amount : {currencyCode: 'rwcur'} }
           a.wsl,

           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg001,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg002,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg003,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg004,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg005,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg006,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg007,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg008,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg009,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg010,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg011,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg012,
           @Semantics: { amount : {currencyCode: 'rwcur'} }
           b.wtg_sum

}
