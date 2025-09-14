## Actividades y evidencias
## 1 HTTP: FUNDAMENTOS Y HERRAMIENTAS

    (venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ PORT=8080 MESSAGE="Hola CC3S2" RELEASE="v1" python3 app.py
    * Serving Flask app 'app'
    * Debug mode: off

    ---------------------------------------------------------------------------------------------
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -v http://127.0.0.1:8080/
    *   Trying 127.0.0.1:8080...
    * Connected to 127.0.0.1 (127.0.0.1) port 8080
    > GET / HTTP/1.1
    > Host: 127.0.0.1:8080
    > User-Agent: curl/8.5.0
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Server: Werkzeug/3.1.3 Python/3.12.3
    < Date: Wed, 10 Sep 2025 18:12:28 GMT
    < Content-Type: application/json
    < Content-Length: 66
    < Connection: close
    <
    {"message":"Hola CC3S2","port":8080,"release":"v1","status":"ok"}
    * Closing connection
    --------------------------------------------------------------------------------------
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -i -X POST http://127.0.0.1:8080/
    HTTP/1.1 405 METHOD NOT ALLOWED
    Server: Werkzeug/3.1.3 Python/3.12.3
    Date: Wed, 10 Sep 2025 18:27:07 GMT
    {"message":"Hola CC3S2","port":8080,"release":"v1","status":"ok"}
    * Closing connection
---------------------------------------------------------------------------------------
 Qué campos de respuesta cambian si actualizas MESSAGE/RELEASE sin reiniciar el proceso? Explica por qué.
    Los valores de message y release no cambian de manera dinamica, para ver su cambio es necesario realizar un reinicio de todo el proceso
-------------------------------------------------------------------------------------------
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ ss -ltnp | grep :8080     
    LISTEN 0      128         127.0.0.1:8080      0.0.0.0:*    users:(("python3",pid=3185,fd=3))
    <title>405 Method Not Allowed</title>
    <h1>Method Not Allowed</h1>
    <p>The method is not allowed for the requested URL.</p>
--------------------------------------------------
    {"message":"Hola CC3S2","port":8080,"release":"v1","status":"ok"}

## 2) DNS: nombres, registros y caché

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo nano /etc/hosts      
    [sudo] password for henry:
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ dig +short miapp.local
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ getent hosts miapp.local
    127.0.0.1       miapp.local
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ dig example.com A +ttlunits

    ; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> example.com A +ttlunits
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 43642
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512
    ;; QUESTION SECTION:
    ;example.com.                   IN      A

    ;; ANSWER SECTION:
    example.com.            23s     IN      A       23.192.228.80
    example.com.            23s     IN      A       23.192.228.84
    example.com.            23s     IN      A       23.215.0.136
    example.com.            23s     IN      A       23.215.0.138
    example.com.            23s     IN      A       23.220.75.232
    example.com.            23s     IN      A       23.220.75.245

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512
    ;; QUESTION SECTION:
    ;example.com.                   IN      A

    ;; ANSWER SECTION:

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512
    ;; QUESTION SECTION:
    ;example.com.                   IN      A

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512
    ;; QUESTION SECTION:

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 512
    ;; QUESTION SECTION:
    ;; QUESTION SECTION:
    ;example.com.                   IN      A

    ;; ANSWER SECTION:
    example.com.            23s     IN      A       23.192.228.80

    ;; ANSWER SECTION:
    example.com.            23s     IN      A       23.192.228.80
    ;; ANSWER SECTION:
    example.com.            23s     IN      A       23.192.228.80
    example.com.            23s     IN      A       23.192.228.84
    example.com.            23s     IN      A       23.215.0.136
    example.com.            23s     IN      A       23.215.0.138
    example.com.            23s     IN      A       23.192.228.80
    example.com.            23s     IN      A       23.192.228.84
    example.com.            23s     IN      A       23.215.0.136
    example.com.            23s     IN      A       23.215.0.138
    example.com.            23s     IN      A       23.192.228.84
    example.com.            23s     IN      A       23.215.0.136
    example.com.            23s     IN      A       23.215.0.138
    example.com.            23s     IN      A       23.220.75.232
    example.com.            23s     IN      A       23.215.0.138
    example.com.            23s     IN      A       23.220.75.232
    example.com.            23s     IN      A       23.220.75.232
    example.com.            23s     IN      A       23.220.75.245
    example.com.            23s     IN      A       23.220.75.245

    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; MSG SIZE  rcvd: 136

    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; MSG SIZE  rcvd: 136
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; MSG SIZE  rcvd: 136
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; Query time: 12 msec
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; MSG SIZE  rcvd: 136
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; Query time: 12 msec
    ;; Query time: 12 msec
    ;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
    ;; WHEN: Wed Sep 10 13:40:07 -05 2025
    ;; MSG SIZE  rcvd: 136

    Pregunta guía: ¿Qué diferencia hay entre /etc/hosts y una zona DNS autoritativa? ¿Por qué el hosts sirve para laboratorio? Explica en 3–4 líneas.
    /etc/hosts tiene un archivo local y estatico lo que permite el mapeo de las direcciones ip de manera manual  y a pesar de tener prioridad sobre las consultas DNS  no soporta TTL
    en cambio la zona autoritativa se gestiona desde un servidor DNSy publica registros TTL que pueden ser observados por otros clientes.
    y se utiliza el host porque no es necesario configurar un servidor DNS real.

-----------------------------------------------------------------------------------------

## 3) TLS: seguridad en tránsito con Nginx como reverse proxy

    sudo mkdir -p /etc/nginx/certs
    sudo openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/certs/miapp.key \
    -out /etc/nginx/certs/miapp.crt \
    -subj "/CN=miapp.local"

    ------------------------------------------------------------------------------------
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo nginx -t
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo service nginx restart
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ openssl s_client -connect miapp.local:443 -servername miapp.local -brief
    depth=0 CN = miapp.local
    verify error:num=20:unable to get local issuer certificate
    depth=0 CN = miapp.local
    verify error:num=21:unable to verify the first certificate
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.3
    Ciphersuite: TLS_AES_256_GCM_SHA384
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Server Temp Key: X25519, 253 bits
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Server Temp Key: X25519, 253 bits
    Peer certificate: CN = miapp.local
    Hash used: SHA256
    Signature type: RSA-PSS
    Hash used: SHA256
    Signature type: RSA-PSS
    Signature type: RSA-PSS
    Verification error: unable to verify the first certificate
    Server Temp Key: X25519, 253 bits
    Verification error: unable to verify the first certificate
    Server Temp Key: X25519, 253 bits
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -k https://miapp.locaServer Temp Key: X25519, 253 bits
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ ss -ltnp | grep -E ':(443|8080)'
    LISTEN 0      128         127.0.0.1:8080      0.0.0.0:*    users:(("python3",pid=3185,fd=3))
    LISTEN 0      511           0.0.0.0:443       0.0.0.0:*

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ tail -n 20 /var/log/nginx/error.log
    2025/09/10 12:35:31 [notice] 1525#1525: using inherited sockets from "5;6;"

## 4) 12-Factor App: port binding, configuración y logs

    (venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ PORT=8080 MESSAGE="Hola CC3S2" RELEASE="v1" python3 app.py
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Running on http://127.0.0.1:8080
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=Hola CC3S2 release=v1
    Press CTRL+C to quit
    [INFO] GET /  message=Hola CC3S2 release=v1
    [INFO] GET /  message=Hola CC3S2 release=v1
    127.0.0.1 - - [10/Sep/2025 16:52:01] "GET / HTTP/1.1" 200 -
    ^C(venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1PORT=8080 MESSAGE="127.0.0.1 - - [10/Sep/2025 16:52:01] "GET / HTTP/1.1" 200 -
    ^C(venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1PORT=8080 MESSAGE="Nuevo mensaje" RELEASE="v2" python3 app.py
    * Serving Flask app 'app'
    * Debug mode: off
    ^C(venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1PORT=8080 MESSAGE="Nuevo mensaje" RELEASE="v2" python3 app.py
    * Serving Flask app 'app'
    * Debug mode: off
    Nuevo mensaje" RELEASE="v2" python3 app.py
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=Nuevo mensaje release=v2
    127.0.0.1 - - [10/Sep/2025 16:52:48] "GET / HTTP/1.1" 200 -
    (venv) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1PORT=8080 MESSAGE="Logs demo" RELEASE="v3" python3 app.py > logs.txt 2>&1

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/
    {"message":"Hola CC3S2","port":8080,"release":"v1","status":"ok"}

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/
    {"message":"Nuevo mensaje","port":8080,"release":"v2","status":"ok"}

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/
    {"message":"Logs demo","port":8080,"release":"v3","status":"ok"}
    /
    {"message":"Logs demo","port":8080,"release":"v3","status":"ok"}
    {"message":"Logs demo","port":8080,"release":"v3","status":"ok"}
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ cat logs.txt
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.        
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=Logs demo release=v3
    127.0.0.1 - - [10/Sep/2025 17:01:16] "GET / HTTP/1.1" 200 -

--------------------------------------------------------------------------------------------------
## Preguntas guía

    -HTTP: explica idempotencia de métodos y su impacto en retries/health checks. Da un ejemplo con curl -X PUT vs POST.
    la idempotencia es cuando un metodo puede ejecutarse muchas veces y da el mismo resultado y para lo que es retries/health son seguros ya que no se generan recursos secundarios
    adicionales.
    PUT: curl -X PUT http://127.0.0.1:8080/item/1 → si se repite el recurso final es siempre el mismo.

    POST: curl -X POST http://127.0.0.1:8080/item → cada vez que se repite, crea un nuevo recurso, generando duplicados.
    -DNS: ¿por qué hosts es útil para laboratorio pero no para producción? ¿Cómo influye el TTL en latencia y uso de caché?
    porque host permite que se realicen pruebas de manera inmediata por ejemplo en el caso de miapp.local directamente a una ip 127.0.0.1
    sin la necesidad de un servidor DNS. para el caso de produccion se tendria que editar cada archivo de manera manual lo cual no es optimo por 
    eso es necesario un DNS autoritativo para que se edite de forma automatica. Ahora el TTL va a definir cuanto tiempo una respuesta se va quedar almacendada en el cache
    -TLS: ¿qué rol cumple SNI en el handshake y cómo lo demostraste con openssl s_client?
    el SNI es lo que envia el cliente durante el handshake indicando el dominio al que quiere conectarse y el servidor busca el certificado correspondiente.
    con el openssl s_client -connect miapp.local:443 -servername miapp.local -brief se observo en la salida servername:miapp.local mostrandonos el certificado local.
    -12-Factor: ¿por qué logs a stdout y config por entorno simplifican contenedores y CI/CD?
    porque no se necesita de rutas en el disco y se guia por el principio  de logs como flujo ya que reduce la recoleccion de logs en contenedores ya que se captura de forma automatica
    -Operación: ¿qué muestra ss -ltnp que no ves con curl? ¿Cómo triangulas problemas con journalctl/logs de Nginx?
    ss -ltnp muestra los puertos y los procesos responsables, entonces cuando existe una falla se busca con ss -ltnp si el puerto esta abierto y si esta abierto se busca con journalctl si la configuracion es la correcta


