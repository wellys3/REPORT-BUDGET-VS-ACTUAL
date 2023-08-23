@AbapCatalog.sqlViewName: 'ZFIVT00002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for ACDOCA Sum'
define view zficd_zfir013_acdoca_sum
  with parameters
    //@Environment.systemField: #CLIENT
    im_mandt  : abap.clnt,
    im_rbukrs : abap.char( 1333 ),
    im_saknr  : abap.char( 1333 ),
    im_budat  : abap.char( 1333 ),
    im_rcntr  : abap.char( 1333 ),
    im_rcntr2 : abap.char( 1333 ),
    im_prctr  : abap.char( 1333 )
  as select from ZFICD_ZFIR013_TF_ACDOCA
                 (
                 im_mandt : $parameters.im_mandt,
                 im_rbukrs: $parameters.im_rbukrs,
                 im_saknr : $parameters.im_saknr,
                 im_budat : $parameters.im_budat,
                 im_rcntr : $parameters.im_rcntr,
                 im_rcntr2 : $parameters.im_rcntr2,
                 im_prctr : $parameters.im_prctr
                 ) as a
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
           sum(a.wsl) as wsl
}
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

  a.rwcur
