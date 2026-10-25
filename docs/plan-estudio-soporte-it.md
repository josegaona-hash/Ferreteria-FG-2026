# Plan de estudio: Soporte y Sistemas IT — de principiante a senior

25 oct 2026 · @Jose Gaona

## Cómo usar este plan

En unos 24 meses, estudiando 1 hora por día, pasás de soporte básico a perfil senior de sistemas. Cada nivel termina con un proyecto práctico que podés mostrar en el trabajo o en entrevistas.

1. Copiá el prompt maestro de abajo en la IA (Gemini, Claude o ChatGPT).
2. Pedí una lección por día y hacé siempre el ejercicio antes de seguir.
3. Cada viernes, pedí un mini examen de la semana.
4. Al terminar cada nivel, hacé su proyecto final y anotalo en tu portfolio.

## Prompt maestro

```text
Sos mi mentor de Soporte Técnico y Sistemas IT. Soy estudiante de 4.º año de Ingeniería Informática en Paraguay, sé Python, Django, SQL básico y Git. Trabajo en una empresa y quiero pasar al área de informática y llegar a nivel senior. Vamos a seguir este plan: [pegá aquí el nivel y módulo actual]. Reglas: 1) Una lección corta por mensaje, con teoría simple, un ejemplo real de empresa y un ejercicio práctico. 2) Esperá mi respuesta y corregime antes de avanzar. 3) Cada 5 lecciones haceme un examen de 10 preguntas. 4) Simulá tickets reales de usuarios para que practique diagnóstico. 5) Explicame en español y con términos técnicos en inglés. Empezá con la lección 1.
```

## Nivel 1 — Principiante (meses 1 a 3)

**Meta:** resolver solo los problemas diarios de usuarios (PC, red, impresoras, correo).

| Mes | Tema | Qué aprendés |
|-----|------|--------------|
| 1 | Redes básicas | IP, máscara, gateway, DNS, DHCP, ping, ipconfig, tracert, cableado, switches, Wi-Fi, puertos comunes |
| 1 | Hardware | Componentes de PC, diagnóstico de fallas, armado, discos SSD/HDD, RAM |
| 2 | Windows para soporte | Instalación, drivers, usuarios locales, Panel de control, Administrador de tareas, Visor de eventos, actualizaciones |
| 2 | Office y correo | Outlook, perfiles, PST, configuración de cuentas, Microsoft 365 básico |
| 3 | Atención a usuarios | Diagnóstico paso a paso, impresoras, acceso remoto (AnyDesk, Escritorio remoto), cómo comunicarte con el usuario |

**Proyecto final:** formateá e instalá una PC desde cero (Windows, drivers, Office, antivirus) y escribí una guía paso a paso del proceso.

- [ ] Proyecto Nivel 1 terminado

## Nivel 2 — Junior (meses 4 a 6)

**Meta:** administrar usuarios, equipos y datos de una empresa pequeña.

| Mes | Tema | Qué aprendés |
|-----|------|--------------|
| 4 | Active Directory | Dominio, usuarios, grupos, OU, permisos, reseteo de contraseñas, unir PCs al dominio, GPO básicas |
| 4 | Carpetas compartidas | Permisos NTFS vs compartidos, unidades de red, impresoras en red |
| 5 | Backups | Regla 3-2-1, completos/incrementales/diferenciales, Veeam o Windows Server Backup, prueba de restauración |
| 5 | SQL Server | Instalación, SSMS, consultas SELECT/JOIN, usuarios y permisos, backup y restore de bases |
| 6 | Gestión de tickets | Mesa de ayuda (GLPI, osTicket), prioridades, SLA, documentar soluciones, ITIL básico |

**Proyecto final:** armá un laboratorio en VirtualBox con un Windows Server (dominio + AD), dos PCs clientes unidas al dominio, una carpeta compartida con permisos por grupo y un backup programado que restaurás con éxito.

- [ ] Proyecto Nivel 2 terminado

## Nivel 3 — Semi-senior (meses 7 a 12)

**Meta:** administrar servidores, asegurar la red y automatizar tareas repetitivas.

| Mes | Tema | Qué aprendés |
|-----|------|--------------|
| 7 | Windows Server avanzado | DNS y DHCP en servidor, GPO avanzadas, WSUS (actualizaciones), roles y servicios |
| 8 | Linux | Comandos, usuarios, permisos, servicios con systemctl, SSH, Ubuntu Server |
| 9 | Virtualización | Hyper-V, VMware/Proxmox, snapshots, recursos de máquinas virtuales |
| 10 | Redes avanzadas | VLAN, subnetting, firewall (pfSense), VPN, configuración básica de switches y routers |
| 11 | Seguridad | Antivirus corporativo, contraseñas y MFA, phishing, parches, principio de mínimo privilegio |
| 12 | Scripting | PowerShell (crear usuarios en masa, reportes de AD) y Python (automatizar backups y alertas) |

**Proyecto final:** un script en PowerShell que cree usuarios de AD desde un Excel/CSV y un script en Python que revise si el backup diario se hizo y mande un aviso por correo.

- [ ] Proyecto Nivel 3 terminado

## Nivel 4 — Senior (año 2 en adelante)

**Meta:** diseñar la infraestructura, tomar decisiones técnicas y guiar a otros.

| Tema | Qué aprendés |
|------|--------------|
| Cloud | Microsoft 365 y Entra ID (Azure AD), Azure o AWS básico, migrar servicios a la nube |
| Automatización avanzada | Ansible, tareas programadas, Infraestructura como Código básica |
| Monitoreo | Zabbix o PRTG, alertas, uptime, análisis de logs |
| Continuidad del negocio | Plan de recuperación ante desastres (DRP), alta disponibilidad, pruebas de restauración |
| Seguridad avanzada | Auditorías, políticas de seguridad, respuesta a incidentes, ISO 27001 básico |
| Gestión y liderazgo | Documentación técnica, inventario, presupuestos de IT, proveedores, capacitar a juniors |

**Proyecto final:** documentá la infraestructura completa de una empresa (real o de tu laboratorio): diagrama de red, inventario, política de backups y plan de recuperación ante desastres.

- [ ] Proyecto Nivel 4 terminado

## Certificaciones y cómo demostrarlo

Las certificaciones validan lo que sabés; los proyectos y la actitud en el trabajo son lo que te hace subir. Verificá precios y vigencia en el sitio oficial de cada una antes de inscribirte.

| Nivel | Certificación sugerida |
|-------|------------------------|
| Principiante | Google IT Support (Coursera), CompTIA A+ |
| Junior | Cisco CCNA o CompTIA Network+, Microsoft 365 Fundamentals |
| Semi-senior | Microsoft Azure Administrator, CompTIA Security+, Linux LPIC-1 |
| Senior | Azure Solutions Architect o AWS Solutions Architect, ITIL 4 Foundation |

## Cómo hacer que te vean como ingeniero informático en la empresa

- Ofrecete a ayudar al área de informática en tareas pequeñas (instalar equipos, inventario).
- Documentá cada problema que resuelvas y compartilo como guía.
- Proponé una mejora concreta para el depósito (control de herramientas, inventario digital) usando lo que ya sabés programar.
- Subí tus laboratorios y scripts a GitHub y ponelos en tu CV y LinkedIn.

## Prompts listos para copiar

Usá estos después del prompt maestro, cambiando el tema entre corchetes.

**Empezar un módulo:**

```text
Empezá el módulo [Active Directory] del nivel [Junior]. Dame primero el temario en 10 lecciones y después la lección 1 con ejercicio.
```

**Laboratorio práctico:**

```text
Guiame paso a paso para armar en VirtualBox un laboratorio de [Windows Server con dominio]. Indicá qué descargar, la configuración de cada máquina y cómo probar que funciona.
```

**Simular tickets:**

```text
Simulá que sos un usuario de la empresa con un problema de [red/impresora/correo]. No me digas la causa; respondé solo lo que te pregunto hasta que lo resuelva. Al final evaluá mi diagnóstico.
```

**Examen:**

```text
Haceme un examen de 10 preguntas sobre [lo visto esta semana], una a la vez, y al final dame mi nota y qué repasar.
```

**Entrevista:**

```text
Simulá una entrevista para [Técnico de soporte / Administrador de sistemas] en una empresa paraguaya. Una pregunta a la vez y corregime cada respuesta.
```

**Repaso rápido:**

```text
Explicame [DNS] como si fuera mi primer día de trabajo, con un ejemplo real y los 3 errores más comunes.
```
