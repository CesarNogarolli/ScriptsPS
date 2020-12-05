###############################################################################################
#
#Script para criar um .bat com o Script do PS1.
#   Util quando tem informacoes que vc nao quer compartilhar com o usuario
#
###############################################################################################


 # Exemplo, convertando todos os scripts da pasta "F:\Scripts_ps\teste\*.ps1"
function Convert-PowerShellToBatch
{
    param
    (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        [Alias("FullName")]
        $Path
    )
 
    process
    {
        $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
        $newPath = [Io.Path]::ChangeExtension($Path, ".bat")
        "@echo off`npowershell.exe -NoExit -encodedCommand $encoded" | Set-Content -Path $newPath -Encoding Ascii
    }
}

 #codifica um script
Get-ChildItem -Path 'F:\Scripts_ps\teste\' -Filter stop_disable_svc-sysmain.ps1 | Convert-PowerShellToBatch

    #Para codificar todos os arquivos da pasta faça como abaixo:
    #Get-ChildItem -Path F:\Scripts_ps\teste -Filter *.ps1 | Convert-PowerShellToBatch

# FIM




###############################################################################################
#
#Script para DECODIFICAR o bat criado a partir do arquivo *.ps1
#
###############################################################################################


 #Em $MYTEXT insira entre ' ' todo o conteúdo codificado do .bat
$MYTEXT = 'VABoAGkAcwAgAGkAcwAgAG0AeQAgAHMAZQBjAHIAZQB0ACAAdABlAHgAdAA='
$DECODED = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($MYTEXT))
Write-Output $DECODED



 #Basicamente, para criptografar um texto siga como abaixo:
$MYTEXT = 'This is my secret text'
$ENCODED = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($MYTEXT))
Write-Output $ENCODED



#https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-powershell-to-batch
#https://techexpert.tips/pt-br/powershell-pt-br/powershell-codificacao-base64/