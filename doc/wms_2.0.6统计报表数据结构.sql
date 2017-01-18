-- Add/modify columns 
alter table WMS_TRANSFER_GOODS add unit_price number(12,2);
-- Add comments to the columns 
comment on column WMS_TRANSFER_GOODS.unit_price
  is '����';

-- Create table
create table WMS_SALES_OUT_STAT
(
  id            RAW(16) default sys_guid() not null,
  sku_id        VARCHAR2(32),
  sku_code      VARCHAR2(32),
  sku_name      VARCHAR2(32),
  quantity      NUMBER(8),
  unit_price    NUMBER(12,2),
  indiv_enabled VARCHAR2(2),
  order_id      VARCHAR2(32),
  order_code    VARCHAR2(32),
  pay_no        VARCHAR2(50),
  shipping_time DATE,
  partner_code  VARCHAR2(32),
  partner_name  VARCHAR2(50),
  out_type      VARCHAR2(2) default 0
);
-- Add comments to the columns 
comment on column WMS_SALES_OUT_STAT.sku_id
  is 'sku_id';
comment on column WMS_SALES_OUT_STAT.sku_code
  is 'sku����';
comment on column WMS_SALES_OUT_STAT.sku_name
  is 'sku����';
comment on column WMS_SALES_OUT_STAT.quantity
  is '����';
comment on column WMS_SALES_OUT_STAT.unit_price
  is '����';
comment on column WMS_SALES_OUT_STAT.pay_no
  is '֧����ˮ��';
comment on column WMS_SALES_OUT_STAT.shipping_time
  is '����ʱ��';
comment on column WMS_SALES_OUT_STAT.out_type
  is '��������(0:����, 1:����)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table WMS_SALES_OUT_STAT
  add constraint WMS_SALES_OUT_AMOUNT_PK primary key (ID)
  using index;

-- Create table
create table WMS_SALE_STAT
(
  id            VARCHAR2(32) not null,
  order_type    VARCHAR2(16),
  sale_org      VARCHAR2(16),
  fx_channel    VARCHAR2(16),
  saler         VARCHAR2(16),
  sender        VARCHAR2(16),
  invoicer      VARCHAR2(16),
  shipper       VARCHAR2(16),
  order_reason  VARCHAR2(256),
  material_code VARCHAR2(16),
  order_num     NUMBER,
  purchase_code VARCHAR2(32),
  purchase_date DATE,
  shipping_type VARCHAR2(16),
  invoice_type  VARCHAR2(16),
  use           VARCHAR2(16),
  po_code       VARCHAR2(32),
  po_pro_code   VARCHAR2(32),
  unit_price    NUMBER(8,2),
  posting_date  DATE,
  factory       VARCHAR2(32),
  warehouse     VARCHAR2(32),
  stat_date     DATE,
  create_time   DATE default sysdate
);
-- Add comments to the columns 
comment on column WMS_SALE_STAT.id
  is 'PK';
comment on column WMS_SALE_STAT.order_type
  is '��������';
comment on column WMS_SALE_STAT.sale_org
  is '������֯';
comment on column WMS_SALE_STAT.fx_channel
  is '��������';
comment on column WMS_SALE_STAT.saler
  is '�۴﷽';
comment on column WMS_SALE_STAT.sender
  is '�ʹ﷽';
comment on column WMS_SALE_STAT.invoicer
  is '��Ʊ��';
comment on column WMS_SALE_STAT.shipper
  is '���˷�';
comment on column WMS_SALE_STAT.order_reason
  is '����ԭ��';
comment on column WMS_SALE_STAT.material_code
  is '���ϱ���';
comment on column WMS_SALE_STAT.order_num
  is '��������';
comment on column WMS_SALE_STAT.purchase_code
  is '�ɹ�������';
comment on column WMS_SALE_STAT.purchase_date
  is '�ɹ�����';
comment on column WMS_SALE_STAT.shipping_type
  is '���䷽ʽ';
comment on column WMS_SALE_STAT.invoice_type
  is '��Ʊ����';
comment on column WMS_SALE_STAT.use
  is 'ʹ��';
comment on column WMS_SALE_STAT.po_code
  is 'PO���';
comment on column WMS_SALE_STAT.po_pro_code
  is 'PO��Ŀ���';
comment on column WMS_SALE_STAT.unit_price
  is '����';
comment on column WMS_SALE_STAT.posting_date
  is 'ƾ֤����';
comment on column WMS_SALE_STAT.factory
  is '����';
comment on column WMS_SALE_STAT.warehouse
  is '�ֿ�';
comment on column WMS_SALE_STAT.stat_date
  is 'ͳ������';
comment on column WMS_SALE_STAT.create_time
  is '��������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table WMS_SALE_STAT
  add constraint PK_WMS_SALE_STAT primary key (ID)
  using index;
