# Aprovisionamiento del Entorno

## Implementando los recursos de DevCenter

Hay un script ([deploy.sh](deploy.sh)) disponible para implementar:
- Un devcenter con pools, definiciones, catálogo, proyectos, etc.

## Crear devbox en nombre de los usuarios

Este proyecto contiene un script shell para aprovisionar Dev Boxes para una lista de usuarios.

### Archivos

[provision_dev_boxes.sh](provision_dev_boxes.sh): Este es el script principal que crea Dev Boxes para cada usuario en el archivo users.csv.
users.csv: Este archivo contiene una lista de direcciones de correo electrónico de los usuarios para los que se crearán las Dev Boxes.

### Cómo usar

- Asegúrate de tener Azure CLI instalado y configurado en tu máquina.
- Actualiza el archivo users.csv con las direcciones de correo electrónico de los usuarios para los que deseas crear Dev Boxes, así como sus contraseñas.
- Ejecuta el script provision_dev_boxes.sh con el siguiente comando:
El script leerá el archivo users.csv, iniciará sesión en el portal de Azure para cada usuario, generará un nombre único para la Dev Box usando uuidgen y luego creará la Dev Box en el centro de desarrollo especificado.

> **Nota**: El script no bloquea y no verifica si la creación de la Dev Box fue exitosa. Simplemente lanza el comando de creación y pasa al siguiente usuario. 