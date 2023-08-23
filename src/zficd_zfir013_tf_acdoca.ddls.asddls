@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XXL
@EndUserText.label: 'Program ZFIR013 for TF ACDOCA'
define table function ZFICD_ZFIR013_TF_ACDOCA
  with parameters
    @Environment.systemField: #CLIENT
    im_mandt  : abap.clnt,
    im_rbukrs : abap.char( 1333 ),
    im_saknr  : abap.char( 1333 ),
    im_budat  : abap.char( 1333 ),
    im_rcntr  : abap.char( 1333 ),
    im_rcntr2  : abap.char( 1333 ),
    im_prctr  : abap.char( 1333 )
returns
{
  rclnt      : mandt;
  rldnr      : fins_ledger;
  rbukrs     : bukrs;
  gjahr      : gjahr;
  belnr      : belnr_d;
  docln      : docln6;
  budat      : budat;
  blart      : blart;
  racct      : racct;
  racct_desc : text50;
  prctr      : prctr;
  rcntr      : kostl;
  objnr      : j_objnr;
  aufnr      : aufnr_hk;
  autyp      : auftyp;
  auart      : aufart;
  auart_desc : auarttext;
  rwcur      : fins_currw;
  wsl        : fins_vwcur12;
}
implemented by method
  zficl_zfir013_amdp=>GET_acdoca_tf;
