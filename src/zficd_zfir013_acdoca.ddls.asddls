@AbapCatalog.sqlViewName: 'ZFIVT00001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for ACDOCA - No Parameters'
define view zficd_zfir013_acdoca
  as select from    acdoca as a
  
    left outer join skat   as b on  b.spras = 'E'
                                and a.racct = b.saknr
                                
    left outer join aufk   as c on a.aufnr = c.aufnr
    
    left outer join t003p  as d on  d.spras = 'E'
                                and c.auart = d.auart

{
  key a.rclnt,
  key a.rldnr,
  key a.rbukrs,
  key a.gjahr,
  key a.belnr,
  key a.docln,
      a.budat,
      a.blart,
      a.racct,

      b.txt50 as racct_desc,

      a.prctr,
      a.rcntr,
      a.objnr,

      a.aufnr,
      a.autyp,
      c.auart,
      d.txt as auart_desc,

      a.rwcur,

      @Semantics: { amount : {currencyCode: 'rwcur'} }
      a.wsl
}
where
  rldnr = '0L';
