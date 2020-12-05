# Trabalhando com impressoras:



###
# 1- Install Driver

 #adiciona o drive em C: \ Windows \ System32 \ DriverStore
pnputil.exe /a "\\Servidor-FTP\HPPrinter\*.inf"
 
 #Instala o Driver. O valor do argumento -Name se obtem ao abrir o arquivo inf. Dentro estão os nomes que funcionam."
Add-PrinterDriver -Name "HP OfficeJet 5200 series PCL-3" -InfPath "C:\Windows\System32\DriverStore\FileRepository\hpygid24_v4.inf_amd64_f312bf16a5228084\hpygid24_v4.inf"



###
# 2- Install Port

 #Instalar porta. Argumento -Name não precisa ser IP, mas é uma boa prática
Add-PrinterPort -Name "192.168.0.25" -PrinterHostAddress "192.168.0.25"


###
# 3- Install Print = Driver + Port

 #Finalizando
Add-Printer -DriverName "HP OfficeJet 5200 series PCL-3" -Name "HP OfficeJet 5200 - Lab Quimica" -PortName "192.168.0.25"




#  https://www.pdq.com/blog/using-powershell-to-install-printers/
#  https://www.pdq.com/blog/how-to-add-printers-with-powershell/