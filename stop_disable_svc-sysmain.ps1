# Verifica se os serviços SuperFetch ou SysMain estão rodando. Caso esteja, ele para o serviço e desativa a inicialização automatica.
# Util quando se tem problemas de alto tempo de uso do HD que tenha uma razão para tal. Recomenda-se só executar se necessário.

$servico = "SuperFetch","SysMain"
Get-Service -Name $servico -ErrorAction Ignore |
    Where-Object {$_.Status -eq "Running"} |
        Stop-Service |
            Set-Service -StartupType Disabled