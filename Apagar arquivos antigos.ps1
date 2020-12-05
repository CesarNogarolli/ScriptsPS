#Limpa pasta ...\Publico\
#Apaga arquivos com mais de 90 dias
#   Importante:
#            CreationTime = Data de criação
#            LastWriteTime = Ultima modificação -> esse que o windows se baseia quando usamos o 'dir' ou o 'Get-ChildItem'


 #Variaveis
$dias = (Get-Date).AddDays(-90)
$Pasta = "F:\DadOS\Publico\"

 #Deleta ARQUIVOS com mais de $dias
Get-ChildItem $Pasta -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $dias} | Remove-Item -Force
 #Deleta PASTAS vazias com mais de $dias
Get-ChildItem $Pasta -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse