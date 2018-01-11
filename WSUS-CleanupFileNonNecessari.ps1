# Impostazioni File Path
$logFile = $args[0]

(Get-Date).ToString("yyyy-MM-dd HH:mm:ss") + " Cleanup file non necessari" | Out-File $logFile -append

Try
{
  [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
  $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer() 

  $cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope

  # Eliminazione aggiornamenti obsoleti
  $cleanupScope.CleanupObsoleteUpdates = $FALSE 
  # Eliminazione delle revisioni obsolete 
  $cleanupScope.CompressUpdates = $FALSE
  # Eliminazione Computer obsoleti 
  $cleanupScope.CleanupObsoleteComputers = $FALSE
  # Eliminazione file di aggiornamento non necessari 
  $cleanupScope.CleanupUnneededContentFiles = $TRUE
  # Rifiuto aggiornamenti scaduti 
  $cleanupScope.DeclineExpiredUpdates = $FALSE
  # Rifiuto aggiornamenti sostituiti 
  $cleanupScope.DeclineSupersededUpdates = $FALSE

  $cleanupManager = $wsus.GetCleanupManager() 
  $cleanupManager.PerformCleanup($cleanupScope) | Out-File $logFile -append
}
Catch
{
  $_.Exception.Message | Out-File $logFile -append
}