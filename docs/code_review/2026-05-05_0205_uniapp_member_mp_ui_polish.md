# �����¼�������� UniApp��΢��С����ҳ�� UI ����

## ���� / Ŀ��

ͳһ������Ʒ��ɫ�뿨Ƭʽ���֣������ˡ���������¼��ȫ�ֿ�̬/������ʾ��ҳ��Ӽ�ª��/�б�����Ϊ����ҳ���ҵ�ҳһ�µ��Ӿ���Σ�����ȫ����� token ��ɸ�����ʽ�࣬���ں���������

## ����ļ��嵥

| ·�� | ˵�� |
|------|------|
| `YiSmartCloud-member-uniapp/App.vue` | ��չ CSS ������ȫ�� `button::after` ���á�`.section` ��Ӱ��Բ�ǡ�`.ys-*` �����ࡢ���ض���ռλ |
| `YiSmartCloud-member-uniapp/uni.scss` | Բ�Ǳ���������ɫ������� |
| `YiSmartCloud-member-uniapp/components/EmptyPage/index.vue` | ��/���İ���Ρ���ѡ `hint` |
| `YiSmartCloud-member-uniapp/components/NetFail/index.vue` | ����/˵������ѡ `showRetry` �� `retry` �¼� |
| `YiSmartCloud-member-uniapp/pages/family/index.vue` | ��Ƭ�б�����ͷ����ɫ pill��ȥ�󶨡� |
| `YiSmartCloud-member-uniapp/pages/family/binding.vue` | �����İ�����ǩ+���롢����̬��У�� |
| `YiSmartCloud-member-uniapp/pages/login/index.vue` | Ʒ�Ƹ����⡢������ʽ����/�ΰ�ť |
| `YiSmartCloud-member-uniapp/pages/subPages/order/index.vue` | ������Ƭ��״̬�Ǳꡢ���鰴ť������̬ |
| `YiSmartCloud-member-uniapp/pages/subPages/order/details.vue` | ������Ϣ�����ǿ����ɾ��/�˿ť�� |
| `YiSmartCloud-member-uniapp/pages/subPages/order/cancel.vue` | ֻ������������ԭ������������ť |

## �ؼ��Ķ�˵��

- **ȫ��**��`page` Ĭ�ϱ�����Ϊ `#f3f3f5`���롸�ҵġ�ҳһ�£����� `--ys-bg`��`--ys-text-muted`��`--ys-danger*`��`--ys-success*` �ȱ�����
- **EmptyPage**��������ѡ���� `hint`����������Ϊ��ɰ�һ�¡�
- **NetFail**��Ĭ����Ϊչʾ�ͣ����� `show-retry` ������ `@retry` ����ʾ�����¼��ء���
- **����**���б�������� `statusName` �������Ĺؼ��ʷ�����ɫ���б�չʾ���/����ʱ�䣨�ֶδ���ʱ����

## Ӱ�췶Χ

- **ǰ��**���� `YiSmartCloud-member-uniapp`���޺�������ݿ�����
- **������**������С���������� CSS ������ `??` �ĳ���֧�ְ汾�����輫�Ͱ汾���ٽ���ģ����ʽ��
- **ȫ����ʽ**��`page` ����ɫ�仯��Ӱ��δ�����豳��ɫ��ҳ�棬��ͼ���Ʒ������ͳһ��

## ��֤��ʽ

- **δִ��**������δ���� `npm run build:mp-weixin`���ɰ���ִ�У���
- **����**��΢�ſ����߹��ߴ򿪱��������Ԥ���������б�/�󶨡���¼�������б�/����/ȡ�����ն�������˿��б�չʾ����ʹ�� NetFail ��ҳ�������д��� `show-retry` ��֤��ť���¼���
