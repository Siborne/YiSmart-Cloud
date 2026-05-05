<#
.SYNOPSIS
  ��ָ���ļ��� UTF-8���� BOM������д�룬����ͳһ���롣
.DESCRIPTION
  Ĭ�ϰ� UTF-8 ��ȡ������ʧ�ܿ���� -Encoding ָ��Դ�������תΪ UTF-8��
  ������ Java/ǰ��Դ���� SQL�����ϲֿ� UTF-8 Լ����
.EXAMPLE
  .\scripts\ensure-utf8-nobom.ps1 -Paths @(
    'YiSmartCloud-background\YiSmartCloud-nursing-platform\src\main\java\...\Foo.java'
  )
#>
param(
  [Parameter(Mandatory = $true)]
  [string[]] $Paths,
  [string] $SourceEncoding = 'UTF-8'
)

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$enc = [System.Text.Encoding]::GetEncoding($SourceEncoding)

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

foreach ($rel in $Paths) {
  $fullPath = Join-Path $repoRoot ($rel -replace '/', '\')
  if (-not (Test-Path -LiteralPath $fullPath)) {
    Write-Error "File not found: $fullPath"
    continue
  }
  $full = Get-Item -LiteralPath $fullPath
  $bytes = [System.IO.File]::ReadAllBytes($full.FullName)
  $text = $enc.GetString($bytes)
  [System.IO.File]::WriteAllText($full.FullName, $text, $utf8NoBom)
  Write-Host "OK UTF-8 (no BOM):" $full.FullName
}
