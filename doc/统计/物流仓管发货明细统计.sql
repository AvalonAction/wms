select t.batch_code as "�������",
       t.order_code as "������",
       t.consignee as "�ջ���",
       t.address as "�ջ���ַ",
       t.mobile as "��ϵ�绰",
       case t.payment_type
         when 1 then
          '����֧��'
         when 2 then
          '��������'
       end as "���ʽ",
       t.shipping_name as "�������",
       t.shipping_no as "�˵���",
       t.order_time as "�µ�ʱ��",
       t.pay_no as "���׺�",
       t.order_amount as "�������",
       t.payable_amount as "Ӧ�����",
       t.order_status as "����״̬",
       t.shipping_time as "����ʱ��",
       t1.sku_name as "SKU����",
       t1.quantity as "����",
       t1.unit_price as "��Ʒ����",
       t1.subtotal_price as "��Ʒ�ܼ�"
  from WMS_SALES_ORDER t
  join wms_sales_order_goods t1
    on t.id = t1.order_id
 where t.shipping_time >
       to_date('2014-05-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
       order by t.shipping_time
