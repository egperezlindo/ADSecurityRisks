<#
.SYNOPSIS
    Auditoría Básica de Seguridad de Usuarios en Active Directory.
.DESCRIPTION
    Este script escanea el AD buscando cuentas que representan un riesgo de seguridad:
    1. Cuentas con "Password Never Expires" (Riesgo de acceso perpetuo).
    2. Cuentas inactivas (+90 días) (Riesgo de cuentas fantasma).
    3. Cuentas bloqueadas (Problema de disponibilidad inmediato).
.AUTHOR
    Ezequiel Perezlindo
.DATE
    Diciembre 2025
#>

Clear-Host
Write-Host "--- INICIANDO AUDITORÍA DE SEGURIDAD AD ---" -ForegroundColor Cyan
Write-Host "Analizando cuentas de usuario..." -ForegroundColor Yellow

# 1. Buscar usuarios con Password que nunca expira (Riesgo de Seguridad)
$riskUsers = Get-ADUser -Filter {PasswordNeverExpires -eq $true -and Enabled -eq $true} -Properties PasswordNeverExpires
$countRisk = $riskUsers.Count

if ($countRisk -gt 0) {
    Write-Host "`n[ALERTA] Se encontraron $countRisk usuarios con 'Password Never Expires':" -ForegroundColor Red
    $riskUsers | Select-Object Name, SamAccountName | Format-Table -AutoSize
} else {
    Write-Host "`n[OK] No hay usuarios con contraseñas eternas." -ForegroundColor Green
}

# 2. Buscar usuarios inactivos (+90 días)
$dateCutoff = (Get-Date).AddDays(-90)
$inactiveUsers = Get-ADUser -Filter {LastLogonDate -lt $dateCutoff -and Enabled -eq $true} -Properties LastLogonDate

if ($inactiveUsers.Count -gt 0) {
    Write-Host "`n[MANTENIMIENTO] Usuarios inactivos (+90 días):" -ForegroundColor Magenta
    $inactiveUsers | Select-Object Name, LastLogonDate | Format-Table -AutoSize
} else {
    Write-Host "`n[OK] No hay usuarios inactivos detectados." -ForegroundColor Green
}

# 3. Buscar usuarios BLOQUEADOS (Esta es la parte que faltaba)
$lockedUsers = Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut

if ($lockedUsers.Count -gt 0) {
    Write-Host "`n[CRÍTICO] Se encontraron $($lockedUsers.Count) usuarios BLOQUEADOS:" -ForegroundColor Red
    $lockedUsers | Select-Object Name, SamAccountName | Format-Table -AutoSize
} else {
    Write-Host "`n[OK] No hay usuarios bloqueados actualmente." -ForegroundColor Green
}

# Cierre
Write-Host "`n--- AUDITORÍA FINALIZADA ---" -ForegroundColor Cyan
Write-Host "Listo para exportar reporte a CSV." -ForegroundColor Gray
