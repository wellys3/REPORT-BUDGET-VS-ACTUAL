@AbapCatalog.sqlViewName: 'ZFIVT00005'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for COSP'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZFICD_ZFIR013_COSP
  as select from cosp as a
{
  key a.mandt,
  key a.gjahr,
  key a.objnr,
  key a.kstar,
  key a.twaer,
  key a.wrttp,
 
      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg001,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg002,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg003,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg004,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg005,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg006,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg007,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg008,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg009,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg010,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg011,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      a.wtg012,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      ( a.wtg001 + a.wtg002 + a.wtg003 + a.wtg004 + a.wtg005 + a.wtg006 +
      a.wtg007 + a.wtg008 + a.wtg009 + a.wtg010 + a.wtg011 + a.wtg012 ) as wtg_sum
}
where
  wrttp = '01'
