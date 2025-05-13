---
published: true
type: workshop
title: Ingeniería de Plataforma para Desarrolladores - Laboratorio Práctico
short_title: Ingeniería de plataforma para desarrolladores
description: Este taller te guiará sobre cómo iniciar rápidamente tu experiencia de desarrollo, cómo implementar en Azure y cómo detectar posibles problemas con tu código durante la ejecución.
level: beginner # Obligatorio. Puede ser 'beginner', 'intermediate' o 'advanced'
navigation_numbering: false
authors: # Obligatorio. Puedes añadir tantos autores como sea necesario
  - Iheb KHEMISSI
  - François-Xavier KIM
  - Louis-Guillaume MORAND
contacts: # Obligatorio. Debe corresponder al número de autores
  - "@ikhemissi"
  - "@frkim"
  - "@lgmorand"
duration_minutes: 180
tags: azure, devbox, ade, entorno de implementación, azd, azure developer cli, azure functions, azure load testing, application insights
navigation_levels: 3

---

# Ingeniería de Plataforma para Desarrolladores

¡Saludos! Este taller ha sido diseñado para mejorar tu experiencia de desarrollo a través de:

- Utilización de un entorno remoto personalizado para un inicio rápido de proyecto
- Establecimiento de entornos de prueba temporales para evaluar tus modificaciones según las directrices de tu empresa
- Empleo de herramientas que simplifican el proceso de gestión de entornos Azure e implementación de tu software
- Aprovechamiento de pruebas de carga para identificación temprana de posibles problemas
- Solución de problemas en una configuración de carga de trabajo distribuida

Durante este taller, recibirás instrucciones para completar cada etapa. Se recomienda que busques las respuestas en los recursos y enlaces proporcionados antes de mirar las soluciones colocadas bajo el panel '📚 *Alternar solución*'.

<div class="task" data-title="Tarea">

> Encontrarás las instrucciones y configuraciones esperadas para cada etapa del laboratorio en estas cajas amarillas **TAREA**.
> Las entradas y parámetros a seleccionar serán definidos; todo lo demás puede permanecer en las configuraciones predeterminadas, ya que no tienen impacto en el escenario.
>
> Usa las credenciales proporcionadas para iniciar sesión en la suscripción de Azure localmente usando Azure CLI y en el [Portal de Azure][az-portal].
> Se proporcionarán instrucciones y soluciones para `azd`, `Azure CLI` y el portal, pero también puedes optar por usar el Portal de Azure durante todo el taller, si lo prefieres.

</div>

## ¿Qué es la Ingeniería de Plataforma?

Mientras que las personas dan diferentes definiciones para DevOps (un trabajo, automatización de procesos, organización corporativa, mezcla de Dev y Ops), la Ingeniería de Plataforma es la práctica de diseñar y construir cadenas de herramientas y flujos de trabajo que permiten capacidades de autoservicio para organizaciones de ingeniería de software en la era nativa de la nube. Se centra en la creación de una plataforma estandarizada que los desarrolladores pueden usar para construir, implementar y gestionar aplicaciones de forma eficiente. El objetivo es reducir la complejidad, mejorar la productividad de los desarrolladores y garantizar la consistencia a lo largo del ciclo de vida del desarrollo.

#### Aspectos clave de la ingeniería de plataforma incluyen:

- Automatización: Automatizar tareas repetitivas para reducir la intervención manual.
- Estandarización: Crear entornos y flujos de trabajo estandarizados para garantizar la consistencia.
- Autoservicio: Permitir que los desarrolladores aprovisionen y gestionen sus propios entornos y recursos.
- Escalabilidad: Diseñar plataformas que puedan escalar conforme a las necesidades de la organización.
- Seguridad: Garantizar que las mejores prácticas de seguridad estén integradas en la plataforma.

Nota: Este es solo un índice del workshop. Para seguir el taller completo, consulta la versión en inglés o portugués del documento workshop.md.

[az-portal]: https://portal.azure.com
[devbox]: https://learn.microsoft.com/es-es/azure/dev-box/overview-what-is-microsoft-dev-box
[ade]: https://learn.microsoft.com/es-es/azure/deployment-environments/overview-what-is-azure-deployment-environments
[azd]: https://learn.microsoft.com/es-es/azure/developer/azure-developer-cli/overview
[loadtesting]: https://learn.microsoft.com/es-es/azure/load-testing/overview-what-is-azure-load-testing
[appinsights]: https://learn.microsoft.com/es-es/azure/azure-monitor/app/app-insights-overview 