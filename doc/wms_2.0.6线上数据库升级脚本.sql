ALTER TABLE wms_wares ADD wares_model varchar2(50);
ALTER TABLE wms_wares ADD wares_remark varchar2(50);
COMMENT ON COLUMN wms_wares.wares_model
  is '��Ʒ����ͺ�';
COMMENT ON COLUMN wms_wares.wares_remark
  is '��Ʒ��ע';

UPDATE wms_wares SET wares_model=wares_name;

-- Add/modify columns 
alter table WMS_TRANSFER add transfer_sale VARCHAR2(32);
alter table WMS_TRANSFER add transfer_send VARCHAR2(32);
alter table WMS_TRANSFER add transfer_invoice VARCHAR2(32);
alter table WMS_TRANSFER add order_amount number(10,2);
-- Add comments to the columns 
comment on column WMS_TRANSFER.transfer_sale
  is '�۴﷽';
comment on column WMS_TRANSFER.transfer_send
  is '�ʹ﷽';
comment on column WMS_TRANSFER.transfer_invoice
  is '��Ʊ��';
comment on column WMS_TRANSFER.order_amount
  is '�������';

-- Add/modify columns 
alter table WMS_TRANSFER add shipping_time date;
-- Add comments to the columns 
comment on column WMS_TRANSFER.shipping_time
  is '����ʱ��';

-- Create table
create table WMS_TRANSFER_PARTNER
(
  id     VARCHAR2(32) not null,
  name   VARCHAR2(64),
  code   VARCHAR2(32),
  remark VARCHAR2(256)
)
tablespace WMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the columns 
comment on column WMS_TRANSFER_PARTNER.id
  is '����';
comment on column WMS_TRANSFER_PARTNER.name
  is '����';
comment on column WMS_TRANSFER_PARTNER.code
  is '����';
comment on column WMS_TRANSFER_PARTNER.remark
  is '��ע';
-- Create/Recreate indexes 
create unique index UK_PARTNER_CODE on WMS_TRANSFER_PARTNER (CODE)
  tablespace WMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255;
-- Create/Recreate primary, unique and foreign key constraints 
alter table WMS_TRANSFER_PARTNER
  add constraint PK_TRANSFER_PARTNER primary key (ID)
  using index 
  tablespace WMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255;

INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��è�콢��', '100314');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��������֧��', '');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '������������', '100315');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��������ֱ��', '100558');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '�Ա�����', '100316');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, 'ΨƷ�����', '100504');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, 'ΨƷ��ֱ��', '100543');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '����', '100503');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ����', '100519');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ����', '100520');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ�人', '100521');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ����', '100522');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ����', '100523');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '��Ѹ�Ϻ�', '100505');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '����', '100553');
INSERT INTO wms_transfer_partner(ID, NAME, CODE) VALUES(wms_seq_common.nextval, '1�ŵ�', '110538');