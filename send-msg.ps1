#Envia uma caixa de mensagem notificando o usuário.

Add-Type -AssemblyName System.Windows.Forms | Out-Null
[System.Windows.Forms.MessageBox]::Show(
"Favor reiniciar a estação para finalizar atualização do Windows 10.","Dept. de Informatica - Aviso","OK","Exclamation")


###  Melhorias a fazer  ###
# Gerar log quando clicar em Ok.