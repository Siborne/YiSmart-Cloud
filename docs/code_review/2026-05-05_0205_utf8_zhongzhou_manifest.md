# �����¼���׶�һ�嵥 UTF-8 �淶���������İ��޸�

## ���� / Ŀ��

- �� `scripts/zhongzhou-phase1-utf8-manifest.txt` ���в���ִ�� **UTF-8���� BOM��** ͳһд�루`scripts/ensure-utf8-nobom.ps1`����
- �޸���ǰ������д�����ֵ� **`????` ������**��������Ӱ��Դ����� **Java `\uXXXX` Unicode ת��**���ļ���Ϊ ASCII������ʱ��Ϊ���ģ�������� UTF-8 ͨ·����������

## ����ļ��嵥

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../ReservationServiceImpl.java`���쳣�İ�����־����ע�͸�Ϊ `\u` ��ʽ���ġ�
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../MemberProgramStubController.java`��Swagger / JavaDoc / `ServiceException` ���ĸ�Ϊ `\u` ��ʽ��
- `scripts/zhongzhou-phase1-utf8-manifest.txt`������ `ReservationMapper.java`���뱾�� UTF-8 ������һ�£���
- �嵥�������ļ����� `ensure-utf8-nobom.ps1` �淶�������ı����壬������淶������

## �ؼ�˵��

- **Ϊ���� `\u`**���ڵ�ǰ������ֱ��д�� UTF-8 ����ż���˻�Ϊ `?`��`\u` �� javac ���룬��Ϊ�ȶ���
- **�ű��÷�**���ڲֿ��Ŀ¼ִ��  
  `$paths = Get-Content scripts\zhongzhou-phase1-utf8-manifest.txt | Where-Object { $_.Trim() -ne '' }; .\scripts\ensure-utf8-nobom.ps1 -Paths $paths`  
  ������Ƕ�� `powershell -Command`������ `$_.Trim` �����Ե�����

## Ӱ�췶Χ

- **�ӿ�**����Ӧ�е�����ҵ����ʾ���ĵ�ע������������ǰ���һ�£�ԤԼ�������� Stub����
- **������**����Э������

## ��֤

- ��ִ�У�`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`��������ִ��ʱ���Ϊ׼����
- ��ִ�У��������嵥·������ `ensure-utf8-nobom.ps1`��
