# Impostazioni File Path
$logFile = $args[0]

(Get-Date).ToString("yyyy-MM-dd HH:mm:ss") + " Connessione a server WSUS locale" | Out-File $logFile -append

Try
{
  [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
  $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer() 
  "" | Out-File $logFile -append
  "  Server WSUS: " + $wsus.Name | Out-File $logFile -append
  "  Culture di default: " + $wsus.PreferredCulture | Out-File $logFile -append
  "  Porta: " + $wsus.PortNumber  | Out-File $logFile -append
  "  Versione: " + $wsus.Version  | Out-File $logFile -append
  "  Versione protocollo server: " + $wsus.ServerProtocolVersion  | Out-File $logFile -append
  "" | Out-File $logFile -append
}
Catch
{
  $_.Exception.Message | Out-File $logFile -append
}