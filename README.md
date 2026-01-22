# Práctica de Python, Flask y Gunicorn
## Instalación de Python PIP
Instalamos **python3-pip**, y luego instalamos con ese paquete **pipenv**
<br>
![Imagen de comandos de instalación](./img/001.png)

### Instalación de python-dotenv y preparación del directorio de la app
Instalamos **python-dotenv** con PIP y preparamos el dirtectorio de la app
<br>
![Imagen de comandos de instalación dotenv y preparación del directorio](./img/002.png)

## Configuración y lanzamiento del entorno virtual
Configuramos el entorno virtual con el archivo .env, que debe quedar así
<br>
![Imagen de configuración de entorno virtual](./img/003.png)

Y lanzamos el entorna virtual con **pipenv shell**
<br>
![Imagen de lanzamiento de entorno virtual](./img/004.png)

## Flask, Gunicorn y archivos de la app
Instalamos **Flask** y **Gunicorn**, y creamos los archivos **application.py** (la app en sí) y **wsgi.py** (para iniciarla y se quede corriendo)
<br>
¡Nota, se ha usado **pipenv run** y **cat** para crear los archivos para provisionarlos sin problemas de permisos y porque vagrant no soporta pipenv shell en la provisión!
<br>
![Imagen de comandos archivos de la app](./img/005.png)

Application.py
<br>
![Imagen de application.py](./img/006.png)

Wsgi.py
<br>
![Imagen de wsgi.py](./img/007.png)

## Comprobación de funcionamiento
¡Nota, vagrant tiene configurado que el puerto del hoster es :8080, tampoco se pueden mantener abiertas (con estos comandos) y son omitidas de la provision!
<br>
Probamos que funciona con:

Flask (con el comando **flask run --host '0.0.0.0'**)
<br>
![Imagen de funciona con Flask](./img/008.png)

Gunicorn (con el comando **gunicorn --workers 4 --bind 0.0.0.0:5000 wsgi:app**)
<br>
![Imagen de funciona con Gunicorn](./img/009.png)