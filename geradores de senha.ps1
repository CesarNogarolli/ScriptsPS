###
#Criando senhas Aleatórias


# Cria uma função pré-configurada que gera as senhas.
    #Nesse exemplo, no final basta executar 'Gerar-SenhaAleatoria' que ele exibe a senha gerada conforme a configuração abaixo.
    #Para uma nova senha só executar o 'Gerar-SenhaAleatoria' novamente.
    #Se adicionar '-' no final ele exibe um campo para alterar os parametros na forma de argumentos.

#Criando a função e seus 
function Gerar-SenhaAleatoria {
    param(
        [Parameter()]
        [int]$TamanhoMinimoSenha = 5,
        [Parameter()]
        [int]$TamanhoMaximoSenha = 10,
        [Parameter()]
        [int]$TotalCaractAlfaNumerico = 2,
        [Parameter()]
        [switch]$ConvertToSecureString
    )
    
    Add-Type -AssemblyName 'System.Web'
    $TamanhoSenha = Get-Random -Minimum $TamanhoMinimoSenha -Maximum $TamanhoMaximoSenha
    $Senha = [System.Web.Security.Membership]::GeneratePassword($TamanhoSenha,$TotalCaractAlfaNumerico)
    if ($ConvertToSecureString.IsPresent) {
        ConvertTo-SecureString -String $Senha -AsPlainText -Force
    } else {
        $Senha
    }
}

#Exibindo as Senhas
Gerar-SenhaAleatoria 





###
# Simplicando a geração de senhas sem usar uma função:


$TamanhoSenha = 5
$TotalCaractAlfaNumerico = 0

Add-Type -AssemblyName 'System.Web'
$Senha = [System.Web.Security.Membership]::GeneratePassword($TamanhoSenha,$TotalCaractAlfaNumerico)
Write-Host $Senha





###
# Criando senhas apenas com letras e números:

#Começa a senha:
#Definido para 5 caracteres alfabeticos em minusculo
$Senha = Get-RandomCharacters -length 5 -characters 'abcdefghiklmnoprstuvwxyz'
#Adicionando 1 caractere alfabetico em maiusculo
$Senha += Get-RandomCharacters -length 1 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
#Adicionando 1 caractere numérico
$Senha += Get-RandomCharacters -length 1 -characters '1234567890'
#Se quiser adicionar um caractere especial desabilite a linha abaixo
#$password += Get-RandomCharacters -length 1 -characters '!"§$%&/()=?}][{@#*+'

Write-Host $Senha
