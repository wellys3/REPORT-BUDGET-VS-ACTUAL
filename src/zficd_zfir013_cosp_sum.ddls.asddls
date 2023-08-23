@AbapCatalog.sqlViewName: 'ZFIVT00003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for COSP Sum'
define view ZFICD_ZFIR013_COSP_SUM
  as select from ZFICD_ZFIR013_COSP as a //ZFIVT00005
{
  key a.mandt,
  key a.gjahr,
  key a.objnr,
  key a.kstar,
  key a.twaer,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg001) as wtg001,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg002) as wtg002,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg003) as wtg003,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg004) as wtg004,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg005) as wtg005,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg006) as wtg006,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg007) as wtg007,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg008) as wtg008,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg009) as wtg009,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg010) as wtg010,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg011) as wtg011,

      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg012) as wtg012,
      
      @Semantics: { amount : {currencyCode: 'twaer'} }
      sum(a.wtg_sum) as wtg_sum
}
where
  wrttp = '01'
group by
  a.mandt,
  a.gjahr,
  a.objnr,
  a.kstar,
  a.twaer
