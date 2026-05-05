# �������϶Ա����޸�����һ�׶Σ�

## �������/Ŀ��

- ���ڡ��������϶Ա������������ļƻ����������������С�����бջ���
  - ���������
  - ������Ŀ�µ�
  - ������ѯ/ȡ��/�˿�
  - �˵���ѯ/֧��
  - �������ҳ������ʵ���ݽӿ�
- ͬ���޸�ԤԼ�������������״̬������ڣ����ͺ�����·���߷��ա�

## �Ա����ģ��-��·-״̬��

- ��������ˣ���ռλ��Ϊ��ʵ�󶨣�����������+Ԥ���ֻ���ƥ����Ժ���ˣ� -> �ѱջ�
- ������Ŀ�б�/���飺���� `/member/orders/project/page` �� `/member/orders/project/{id}` -> �ѱջ�
- ���񶩵���������ʵ�����洢��״̬��ת����֧��/����Լ/ȡ��/�˿ -> �ѱջ�
- �˵�֧������������ͬ�������˵���֧����д�˵��붩��״̬ -> �ѱջ�
- ԤԼ�������ƣ��������ݿ�����������ֹͬʱ��β������� -> �ѱջ�
- ԤԼ����״̬�������� `reservationJob.expirePendingReservations` ������� -> �ѱջ�
- ����˿��壺���� `/serve/dashboard/summary` ����������ͨǰ����ҳ -> �ѱջ�
- ����˴�����������ǳɹ����Ϊ��ʽ��ʾ�� reject����������Ĭʧ�ܡ� -> �ѱջ�
- �豸�澯/IoT����Ϣ֪ͨ����Ϊռλ�ӿ� -> ȱģ�飨�����׶Σ�
- �˿���ˡ�֧�����ػص�����Լ�깤�Զ�������ǰΪ������״̬��ת -> ��ջ��������׶Σ�

## ����ļ��嵥

- �������
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/ServeDashboardController.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/FamilyElderBindRequestDto.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/FamilyElderBinding.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/MemberServiceOrder.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/constant/MemberOrderConstants.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/mapper/FamilyElderBindingMapper.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/mapper/MemberServiceOrderMapper.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IFamilyElderBindingService.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IMemberServiceOrderService.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/FamilyElderBindingServiceImpl.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/MemberServiceOrderServiceImpl.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/task/ReservationJob.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/FamilyElderBindingMapper.xml`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/MemberServiceOrderMapper.xml`
  - `YiSmartCloud-background/sql/other/2026-05-05_member_chain_patch.sql`
- ����޸�
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberProgramStubController.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/MemberOrderCreateDto.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/mapper/ReservationMapper.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/ReservationServiceImpl.java`
  - `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/ReservationMapper.xml`
  - `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/interceptor/MyMetaObjectHandler.java`
  - `YiSmartCloud-background/YiSmartCloud-common/src/main/java/org/FlyingSparrow/YiSmartCloud/common/utils/SecurityUtils.java`
- ǰ���޸�
  - `YiSmartCloud-member-uniapp/utils/request.js`
  - `YiSmartCloud-member-uniapp/pages/service/details.vue`

## �ؼ��Ķ�˵��

- ����ʵ������滻 `MemberProgramStubController` �а󶨡��������˵����ռλ�ӿڡ�
- �����󶨹�ϵ���붩����ĳ־û�ģ�ͼ� Mapper��ʵ�֡�����-����-��Ŀ-����-�˵���������
- ��������ʱ�Զ������˵����˵�֧������������״̬���γ���С֧���ջ���
- �������ҳ���뿴��ۺ� API ���������������� `ServeDashboardServiceImpl`��
- ԤԼ�����������ݿ���������`GET_LOCK`�������ٲ���������ڡ�
- ����ԤԼ���������֧࣬����������������ֱ������ִ�з�����
- ������ȡ��Ĭ���û� `1` ���ˣ��������ݹ�����Ⱦ��
- �����������Ϊ������ʾ�� `reject`�����⡰���б�ٳɹ�����

## Ӱ�췶Χ

- �ӿ�
  - ����/��ͨ��`/serve/dashboard/summary`��`/member/orders/project/*`��`/member/orders/*`��`/member/bill/*`��`/member/user/add`��`/member/user/list-by-page`��`/member/user/my`
- ���ݿ�
  - �������`family_elder_binding`��`member_service_order`
  - ����������`reservation` Ψһ�� `uk_reservation_mobile_time`
- ǰ��
  - ����˷����µ��������� `elderId`��������ʷ�ֶμ��ݣ�
  - �����������Դӡ�resolve �ǳɹ��롱����Ϊ��toast + reject��
- ������
  - ���� `/user/add`��`/user/my` ����ʷ·������

## ��֤��ʽ

- ��ִ��
  - IDE lints ��飺��������/�޸��ļ������� lint ����
- δִ��
  - ���� Maven ����δͨ����ʧ��ԭ��Ϊ�ֿ��м����ļ��������⣨�� `Reservation.java`��`DashboardSliceVo.java` �ȳ��� UTF-8 ����ӳ���ַ������Ǳ��������߼���������ͳһ��ʷ�ļ����������ȫ������
  - δ�������ع飨�����ݿ�ִ�б��� SQL ��������֤��
