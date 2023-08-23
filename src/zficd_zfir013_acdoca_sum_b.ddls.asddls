@AbapCatalog.sqlViewName: 'ZFIVT00006'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for ACDOCA Sum B'
define view zficd_zfir013_acdoca_sum_B
  as select from zficd_zfir013_acdoca as a

{
  key a.rclnt,
  key a.rldnr,
  key a.rbukrs,
  key a.gjahr,

      a.budat,
      //      a.blart,
      a.racct,

      a.racct_desc,

      a.prctr,
      a.rcntr,
      a.objnr,

      //      a.aufnr,
      //      a.autyp,
      a.auart,
      a.auart_desc,

      a.rwcur,

      @Semantics: { amount : {currencyCode: 'rwcur'} }
      sum(a.wsl) as wsl
}
group by
  a.rclnt,
  a.rldnr,
  a.rbukrs,
  a.gjahr,

  a.budat,
  a.racct,
  a.racct_desc,
  a.prctr,
  a.rcntr,

  a.auart,
  a.auart_desc,
  a.objnr,

  a.rwcur
