@cds.persistence.exists
@cds.persistence.calcview
entity SAP_HANA_DEMOCONTENT_EPM_MODELS_SALES_ORDER_DYNAMIC_TIME_PERIOD(IP_STARTDATE : Date, IP_ENDDATE : Date, IP_PERIODTYPE : String(20)) {
  key PARTNERID             : String(10)       @title: 'PARTNERID';
      PARTNERROLE           : String(3)        @title: 'PARTNERROLE';
      EMAILADDRESS          : String(255)      @title: 'EMAILADDRESS';
      COMPANYNAME           : String(80)       @title: 'COMPANYNAME';
      LEGALFORM             : String(10)       @title: 'LEGALFORM';
      CITY                  : hana.VARCHAR(40) @title: 'CITY';
      POSTALCODE            : String(10)       @title: 'POSTALCODE';
      BUILDING              : String(10)       @title: 'BUILDING';
      STREET                : String(60)       @title: 'STREET';
      COUNTRY               : String(3)        @title: 'COUNTRY';
      REGION                : String(4)        @title: 'REGION';
  key PRODUCTID             : String(10)       @title: 'PRODUCTID';
      PRODUCT_TYPECODE      : String(2)        @title: 'PRODUCT_TYPECODE';
      PRODUCT_CATEGORY      : hana.VARCHAR(40) @title: 'PRODUCT_CATEGORY';
      PRODUCT_CURRENCY      : String(5)        @title: 'PRODUCT_CURRENCY';
      PRODUCT_WEIGHTUNIT    : String(3)        @title: 'PRODUCT_WEIGHTUNIT';
      PRODUCT_WEIGHTMEASURE : Decimal(13, 3)   @title: 'PRODUCT_WEIGHTMEASURE';
      PRODUCT_PRICE         : Decimal(15, 2)   @title: 'PRODUCT_PRICE';
      PRODUCTPICURL         : String(255)      @title: 'PRODUCTPICURL';
      SUPPLIER_ID           : String(10)       @title: 'SUPPLIER_ID';
      PROD_COMPANYNAME      : String(80)       @title: 'PROD_COMPANYNAME';
      SUPPLIER_CITY         : hana.VARCHAR(40) @title: 'SUPPLIER_CITY';
      SUPPLIER_POSTALCODE   : String(10)       @title: 'SUPPLIER_POSTALCODE';
      SUPPLIER_STREET       : String(60)       @title: 'SUPPLIER_STREET';
      SUPPLIER_BUILDING     : String(10)       @title: 'SUPPLIER_BUILDING';
      SUPPLIER_COUNTRY      : String(3)        @title: 'SUPPLIER_COUNTRY';
      SUPPLIER_REGION       : String(4)        @title: 'SUPPLIER_REGION';
      PRODUCT_NAME          : String(1024)     @title: 'PRODUCT_NAME';
      PRODUCT_DESCRIPTION   : String(1024)     @title: 'PRODUCT_DESCRIPTION';
  key SALESORDERID          : String(10)       @title: 'SALESORDERID';
  key HISTORY_CREATEDAT     : Date             @title: 'History_CREATEDAT';
  key SALESORDERITEM        : String(10)       @title: 'SALESORDERITEM';
  key CA_STARTDATE          : Date             @title: 'CA_StartDate';
  key CA_ENDDATE            : Date             @title: 'CA_EndDate';
      NETAMOUNT             : Decimal(15, 2)   @title: 'NETAMOUNT';
      CM_NETAMOUNT          : Decimal(13, 2)   @title: 'CM_NetAmount';
};
