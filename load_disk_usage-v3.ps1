######################################################################################################################
#
# Verificar %de uso CPU, Memoria e disco. Depois envia CSV para FTP.
#
######################################################################################################################


$hostname = hostname
$filename = "$($hostname)-$($(Get-Date -Format yyyy.MM.dd.HHmmss)).csv"

$counters = @(
"\\$hostname\processador(_total)\% tempo de processador",
"\\$hostname\memória\% bytes confirmados em uso",
"\\$hostname\PhysicalDisk(0 C:)\% tempo de disco" #considerando que só tem um disco (disco 0) e a partição do windows está em "C:"
)
Get-Counter -SampleInterval 5 -Counter $counters | foreach {
$_.CounterSamples | foreach {
[pscustomobject]@{
    TimeStamp = $_.TimeStamp
    Hostname = $hostname
    Path = $_.Path
    Value = $_.CookedValue
        }
    }
} | Export-Csv -Path "C:\Windows\Temp\$filename" -NoTypeInformation


# Prepara upload do arquivo gerado para FTP
$local_file = "C:\Windows\Temp\$filename"
$ftp_file = "ftp://10.0.0.1/Privado/logs/$filename"
$ftp = "ftp://10.0.0.1/Privado/logs/"
$user_ftp = "user_ftp"
$passwd  = "passwd_user_ftp"


# Create FTP Rquest Object
$FTPRequest = [System.Net.FtpWebRequest]::Create("$ftp_file")
$FTPRequest = [System.Net.FtpWebRequest]$FTPRequest
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$FTPRequest.Credentials = new-object System.Net.NetworkCredential($user_ftp, $passwd)
$FTPRequest.UseBinary = $true
$FTPRequest.UsePassive = $true

# Read the File for Upload
$FileContent = gc -en byte $local_file
$FTPRequest.ContentLength = $FileContent.Length

# Get Stream Request by bytes
$Run = $FTPRequest.GetRequestStream()
$Run.Write($FileContent, 0, $FileContent.Length)

# Cleanup
$Run.Close()
$Run.Dispose()



## Cesar Nogarolli
## Carlos Yop Linhares