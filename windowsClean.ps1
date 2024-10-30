# Verificar si el script se está ejecutando como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Ejecutando el script como administrador..."

    # Ejecutar script como administrador
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$PSCommandPath" -Verb RunAs
    exit
} else {
    # Lista de programas específicos para eliminar
    $programsToRemove = @(
        "Microsoft.WindowsStore",
        "Microsoft.3DBuilder",
        "Microsoft.Office.OneNote",
        "Microsoft.SkypeApp",
        "Microsoft.XboxApp",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.Messaging",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MixedReality.Portal",
        "Microsoft.MSPaint",
        "Microsoft.OneConnect",
        "Microsoft.People",
        "Microsoft.Print3D",
        "Microsoft.StickyNotes",
        "Microsoft.Wallet",
        "Microsoft.Windows.Photos",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.YourPhone",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.Family",
        "Microsoft.Clipchamp",
        "Microsoft.WindowsSecurity"
    )

    # Desinstalar aplicaciones de Windows
    foreach ($program in $programsToRemove) {
        Write-Host "Intentando desinstalar $program..."
        Get-AppxPackage -Name $program | Remove-AppxPackage -ErrorAction SilentlyContinue
    }

    Write-Host "Proceso de desinstalación completado."
}
