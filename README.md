# Práctica de Python, Flask y Gunicorn
¡Importante, es posible que tengas que provisionar varias veces e incluso reiniciar la máquina virtual para que funcione correctamente (por problemas con los comandos 😓 a pesar de que funcione al final)!

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

## Creación y ejecución de un servicio para Gunicorn
¡Nota, en el extremo caso de que alguna ruta de Gunicorn cambie, reemplaza las rutas por la que te dé con el comando **which gunicorn** EN el entorno virtual de **pipenv**!
<br>
Creamos el archivo **flask_app.service** en **/etc/systemd/system**
<br>
![Imagen de flask_app.service](./img/010.png)

Para lanzarlo, primero recargamos los servicios con **sudo systemctl daemon-reload**
<br>
Luego activamos y comprobamos que el servicio funciona correctamente con **sudo service flask_app [action]**
<br>
![Imagen de servicio flask_app lanzado](./img/011.png)

## Configuración de Nginx para ver la app en funcionamiento
Creamos el archivo **app.conf** en **/etc/nginx/sites-available**, hacer el link en **sites-enabled** con **sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled** y tiene que quedar algo así
<br>
![Imagen de configuración de Nginx](./img/012.png)

### App lanzada
¡Nota, se requiere resolver los nombres, en nuestro caso vamos a usar el archivo **C:\Windows\System32\drivers\etc\hosts** (**/etc/hosts** en Linux)!
<br>
![Imagen de archivo hosts](./img/013.png)

La app nos quedará así (si has hecho personalmente la provisión, intenta acceder a [http://app.izv](http://app.izv))
<br>
![Imagen de app final](./img/014.png)

## Tarea
Clonamos [éste](https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart) repositorio, ajustamos los permisos y lo lanzamos con **gunicorn --workers 4 --bind 0.0.0.0:5000 app:app**
<br>
![Imagen de tarea clonado de GitHub](./img/015.png)

Función gráfica
<br>
![Imagen de tarea vista gráfica con Gunicorn](./img/016.png)

### Lanzamiento desde el servicio
flask_app_tarea.service (archivo del servicio)
<br>
![Imagen de tarea archivo del servicio](./img/017.png)

tarea.conf (archivo de configuración de Nginx)
<br>
![Imagen de tarea archivo de Nginx](./img/018.png)

Comandos seguidos
<br>
![Imagen de tarea comandos](./img/019.png)

Prueba gráfica
<br>
![Imagen de tarea comandos](./img/020.png)