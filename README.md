# ADSecurityRisks
Herramienta de PowerShell para auditar riesgos de seguridad en Active Directory (Passwords, Cuentas Inactivas y Bloqueos).

# 🛡️ Active Directory Security Audit Tool

Herramienta de automatización basada en **PowerShell** diseñada para Analistas de Soporte y SysAdmins. Su objetivo es realizar un escaneo rápido del estado de salud y seguridad de las identidades en Active Directory.

## 📋 Descripción General

Este script facilita la **Higiene de Identidades** (Identity Hygiene) al auditar el dominio en busca de riesgos comunes de seguridad y problemas de disponibilidad. Es una herramienta de **"Solo Lectura"** (Read-Only), segura para ejecutar en entornos de producción sin riesgo de modificar datos.

### Funcionalidades Clave
* * Auditoría de Políticas de Contraseña:** Detecta usuarios activos configurados con *"Password Never Expires"* (Riesgo de seguridad y cumplimiento).
* * Detección de Cuentas Fantasma:** Identifica usuarios que no han iniciado sesión en los últimos **90 días** (Oportunidad de limpieza y reducción de superficie de ataque).
* * Monitoreo de Disponibilidad:** Lista las cuentas actualmente **Bloqueadas** (Locked Out) para una acción de soporte inmediata.

## 🚀 


