#Unifica todos os arquivos *.csv que estão em $csv_files.
#Sanva um arquivo na mesma pasta com o nome "relatorio-20201201-16-15-50.csv"


$csv_files  = "F:\Usuarios\teste_csv\*"
$relatorio = "F:\Usuarios\teste_csv\relatorio"+'-'+(Get-Date -Format yyyyMMdd-HH.mm.ss) +".csv"

#OBS.: CSV separa por "
Get-Content $csv_files| Select-Object -Unique | Set-Content -Encoding Ascii $relatorio