# CURSO SQL CON POSTGRES

## Instalar proyecto en local
1.- Clonar repositorio
2.- Iniciar Docker en tu PC
3.- Verificar respuesta de docker
    `docker --version`
4.- Abrir terminal en carpeta e instalar las siguientes imagenes:
    `docker pull postgres:16.3`
    `docker pull dpage/pgadmin4`

## Correr base de datos
1.- Abrir terminal en carpeta y ejecutar:
    `docker compose up -d`

2.- Terminar la base de datos:
    `docker compose down`

**NOTA: Credenciales dentro de docker-compose.yml**