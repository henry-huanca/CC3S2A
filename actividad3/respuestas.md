## Parte teórica

    Introducción a DevOps: ¿Qué es y qué no es? Explica DevOps desde el código hasta la producción, diferenciándolo de waterfall. Discute "you build it, you run it" en el laboratorio, y separa mitos (ej. solo herramientas) vs realidades (CALMS, feedback, métricas, gates).
        
    DevOps sirve para realizar trabajos de manera simultanea y poder subir diferentes avances mediante los commits, los cuales en la siguiente area se va a ir evaluando en busca de diversos errores para su completa correccion sin perder grandes cantidades de tiempo como ocurre en cascada que necesita que toda una etapa este completada para poder realizar la evaluacion dificultando de esta manera la correccion de errores y toma amyor tiempo.

    Marco CALMS en acción: Describe cada pilar y su integración en el laboratorio (ej. Automation con Makefile, Measurement con endpoints de salud). Propón extender Sharing con runbooks/postmortems en equipo.
    
    cultura: busca fomentar el apoyo y la colaboracion entre los diferentes equipos de trabajo para lograr un objetivo en comun.

    automatizacion: permite automatizar los despliegues, tests, etc suprimiendo de esta manera el trabajo manual que es repetitivo. Lo vemos en la parte de makefile del laboratorio.

    lean: se busca optimizar los procesos de desarrollo y la entrega del software para reducir las ineficiencias y el tiempo de entrega. lo encontramos en logs y en el journalctl

    medicion: sirve para evaluar el tiempo en que se produce alguna alerta o cuanto tiempo pasa de la implementacion de algun requerimiento. Por ejemplo se observa en la check_tls.sh o el curl

    sharing: se busca documentar los incidentes y los procedimientos que se realizan. se encuentran en los postmortem.md o el runbook.md

    Visión cultural de DevOps y paso a DevSecOps: Analiza colaboración para evitar silos, y evolución a DevSecOps (integrar seguridad como cabeceras TLS, escaneo dependencias en CI/CD). Propón escenario retador: fallo certificado y mitigación cultural. Señala 3 controles de seguridad sin contenedores y su lugar en CI/CD.
    
    primero se busca que los despliegues sean seguros para lo cual a traves del makefile se busca la automatizacion y el systemmd para monitorizar los logs y los procesos sin conflictos. añadiento los runbooks para documentar los incidentes. luego añadimos la seguridad con TLS certificados de seguridad etc.

    Para los controles de seguridad

    HSTS garantiza que solo se utilice el https para lo cual se comprueba con curl -I https://miapp.local

    Escaneo de dependencias: se realiza un script de pipeline para verificar si hay vulnerabilidades en las librerias de python

    tls minimo v1.3 busca el tls y si falla bloquea la promocion en CI/CD

    Metodología 12-Factor App: Elige 4 factores (incluye config por entorno, port binding, logs como flujos) y explica implementación en laboratorio. Reto: manejar la ausencia de estado (statelessness) con servicios de apoyo (backing services).
    
    configuracion por entorno: no se debe tener de forma hardcodeada las credenciales por ejemplo en esta parte PORT = int(os.environ.get("PORT", "8080"))
    MESSAGE = os.environ.get("MESSAGE", "Hola")
    RELEASE = os.environ.get("RELEASE", "v0")
    se observa que se tiene en el app.py estas credenciales cuando no deberian estar.

    port binding: la aplicacion deberia usar los servicios haciendo uso de un puerto sin tener la ayuda de un servicio externo. aca se observa que flask hace uso de   app.run(host="127.0.0.1", port=PORT)

    logs como flujos: no se deberia manejar los archivos de logs sino utilizar stdout un error se observa en     print(f"[INFO] GET /  message={MESSAGE} release={RELEASE}", file=sys.stdout, flush=True) que esta en app.py

## Parte practica

## 1 Automatización reproducible con Make y Bash (Automation en CALMS). Ejecuta Makefile para preparar, hosts-setup y correr la app. Agrega un target para verificar idempotencia HTTP (reintentos con curl). Explica cómo Lean minimiza fallos. Haz una tabla de rastreo de objetivos con esta cabeceras, "objetivo -> prepara/verifica -> evidencia" de Instrucciones.md.

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ source bdd/bin/activate
    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ make hosts-setup
    Agregando miapp.local a /etc/hosts
    [sudo] password for henry: 
    127.0.0.1 miapp.local
    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ make run
    Iniciando la aplicación en http://127.0.0.1:8080 ...
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ make cleanup
    Deteniendo servicio systemd (si existe)...
    Eliminando sitio Nginx (si existe)...
    Limpieza completada. Certificados conservados en certs/.

## 2 Del código a producción con 12-Factor (Build/Release/Run). Modifica variables de entorno (PORT, MESSAGE, RELEASE) sin tocar código. Crea un artefacto inmutable con git archive y verifica paridad dev-prod. Documenta en tabla "variable -> efecto observable". Simula un fallo de backing service (puerto equivocado) y resuélvelo con disposability. Relaciona con logs y port binding.

    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ port=5001 MESSAGE="message modificado" RELEASE="v1.2.3" make run
    Iniciando la aplicación en http://127.0.0.1:8080 ...
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=message modificado release=v1.2.3
    127.0.0.1 - - [14/Sep/2025 12:04:57] "GET / HTTP/1.1" 200 -

    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ git archive --format=tar --output=release-v1.2.3.tar main

    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ mkdir ../deploy-test && cd ../deploy-test
    tar -xf ../labs/Laboratorio1/release-v1.2.3.tar
    make run
    mkdir: cannot create directory ‘../deploy-test’: File exists
    tar: ../labs/Laboratorio1/release-v1.2.3.tar: Cannot open: No such file or directory
    tar: Error is not recoverable: exiting now
    Iniciando la aplicación en http://127.0.0.1:8080 ...
    * Serving Flask app 'app'
    * Debug mode: off
    WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=Hola release=v0
    127.0.0.1 - - [14/Sep/2025 12:05:58] "GET / HTTP/1.1" 200 -

    Variable                       |     Efecto observable
    PORT=5001                      |     la aplicacion se ejecuta en el puerto 5001 y no en el 8080
    Message="message modificado"   |     el enpoint va a responder con el message modificado
    RELEASE="v1.2.3"               |     el log de inicio va a incluir el release v1.2.3

    simular fallo de backing service
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/service
    {"error":"[Errno 111] Connection refused","port":9999,"status":"error"}

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/service
    {"port":9999,"status":"ok"}

## 3 HTTP como contrato observable. Inspecciona cabeceras como ETag o HSTS. Define qué operaciones son seguras para reintentos. Implementa readiness y liveness simples, y mide latencias con curl. Documenta contrato mínimo (campos respuesta, trazabilidad en logs). Explica cómo definirías un SLO.

        resp.headers["Cache-Control"] = "no-cache"
        resp.headers["ETag"] = "v1.0"
        resp.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains"

        Las operaciones seguras son get, put, head, delete. La operacion post no se recomienda que sea idempotente.
        
        @app.route("/healthz/live")
        def liveness():
        return jsonify(status="alive")

        @app.route("/healthz/ready")
        def readiness():
        return jsonify(status="ready")

        henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -s -o /dev/null -w "Tiempo total: %{time_total}s\n" http://127.0.0.1:8080/
        Tiempo total: 0.007199s
        henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -I http://127.0.0.1:8080/
        HTTP/1.1 200 OK
        Server: Werkzeug/3.1.3 Python/3.12.3
        Date: Sun, 14 Sep 2025 17:25:41 GMT
        Content-Type: application/json
        Content-Length: 60
        Connection: close

        Content-Type: application/json
        Content-Length: 60
        Connection: close
        Content-Type: application/json
        Content-Length: 60
        Content-Type: application/json
        Content-Type: application/json
        Content-Length: 60
        Connection: close
        Content-Type: application/json
        Content-Length: 60
        Content-Type: application/json
        Content-Type: application/json
        Content-Length: 60
        Connection: close

        henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -s --retry 3 http://127.0.0.1:8080/
        {"message":"Hola","port":8080,"release":"v0","status":"ok"}

        Documentacion minima del contrato HTTP
        /healthz/live es de tipo get y verifica el proceso por ejemplo ve si esta en un bucle o no
        /healthz/ready es de tipo get y verifica si los servicios estan listos para utilizarse

        Un SLO es la cantidad de tiempo que el servicio necesita para cumplir con el contrato HTTP por ejemplo en el caso de la idempotencia permite que un servicio sea utilizado de manera mas rapida

## 4 DNS y caché en operación. Configura IP estática en Netplan. Usa dig para observar TTL decreciente y getent local para resolución de miapp.local. Explica cómo opera sin zona pública, el camino stub/recursor/autoritativos y overrides locales. Diferencia respuestas cacheadas y autoritativas.

    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ ping -c 1 miapp.local
    getent hosts miapp.local
    PING miapp.local (192.168.56.101) 56(84) bytes of data.


    --- miapp.local ping statistics ---
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

    192.168.56.101  miapp.local


    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ dig @1.1.1.1 miapp.local
    dig @1.1.1.1 miapp.local

    ; <<>> DiG 9.18.39-0ubuntu0.24.04.1-Ubuntu <<>> @1.1.1.1 miapp.local
    ; (1 server found)
    ;; global options: +cmd
    ;; Got answer:
    ;; WARNING: .local is reserved for Multicast DNS
    ;; You are currently testing what happens when an mDNS query is leaked to DNS
    ;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 1854
    ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;miapp.local.                   IN      A

    ;; AUTHORITY SECTION:
    .                       86400   IN      SOA     a.root-servers.net. nstld.verisign-grs.com. 2025091400 1800 900 604800 86400

    ;; Query time: 454 msec
    ;; SERVER: 1.1.1.1#53(1.1.1.1) (UDP)
    ;; WHEN: Sun Sep 14 12:47:48 -05 2025
    ;; MSG SIZE  rcvd: 115


    ; <<>> DiG 9.18.39-0ubuntu0.24.04.1-Ubuntu <<>> @1.1.1.1 miapp.local
    ; (1 server found)
    ;; global options: +cmd
    ;; Got answer:
    ;; WARNING: .local is reserved for Multicast DNS
    ;; You are currently testing what happens when an mDNS query is leaked to DNS
    ;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 51512
    ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;miapp.local.                   IN      A

    ;; AUTHORITY SECTION:
    .                       86400   IN      SOA     a.root-servers.net. nstld.verisign-grs.com. 2025091400 1800 900 604800 86400

    ;; Query time: 122 msec
    ;; SERVER: 1.1.1.1#53(1.1.1.1) (UDP)
    ;; WHEN: Sun Sep 14 12:47:48 -05 2025
    ;; MSG SIZE  rcvd: 115

    -En la primera consulta se observa que se tiene un TTL inicial al cual se le da 454 msec y en la segunda se observa que el tiempo disminuyo a 122 msec.

    -la aplicacion no se conecta a una dns publica sino lo hace de manera local que se utiliza en el archivo /etc/hosts.

    -La respuesta cacheada recuerda la inforamcion del TTL y ante una nueva consulta se observa que es la misma, en cambio la autoritativa busca una respuesta directa de la zona.

## 5 TLS y seguridad en DevSecOps (Reverse Proxy). Un gate (puerta/umbral de calidad) es una verificación automática no negociable en el flujo de CI/CD que bloquea el avance de un cambio si no se cumplen criterios objetivos. Sirve para cumplir políticas (seguridad, rendimiento, estilo, compatibilidad) antes de promover un artefacto a la siguiente etapa.

    (bdd) henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ make tls-cert
    ......+........+......+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+....+..+.............+......+...........+.......+..+.+..+......+.+......+..+.......+.....+.+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+.....+....+...+.....+.......+.................+...............+...+......+.+......+..+.+..+....+.....+.+........+......+...+..................+...+.+...+........+........................+......+....+...+...........+.+.....+.+..+......+.........+.+......+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ...+....+..+.......+...+..............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+..+...+.+.....+.........+.+...+...........+......+....+......+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+.....+.+..+..........+...+...+..............+...+...................+.........+.....+......+.+.................+......+....+............+...+..+....+.....+............+.......+.....+...+.......+...+..+.+.....+......+.+........+.........+..........+..+.+.........+.....+.+........+......+....+...............+..............+......+....+...+..+............+.+..+.............+..+............+................+.....+.......+......+.....+.........+.+.....+......+...............+.+..+...+....+..............+....+......+...........+...+.+.........+..+......+...+.+...+.....+......+......+...............+................+...............+...+.....+..........+..+.............+......+.........+..+....+...+.....+.......+.....+...+.......+...........+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    -----
    Certificado creado en certs/


    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ openssl s_client -connect miapp.local:443 -servername miapp.local
    CONNECTED(00000003)
    depth=0 CN = miapp.local
    verify error:num=20:unable to get local issuer certificate
    verify return:1
    depth=0 CN = miapp.local
    verify error:num=21:unable to verify the first certificate
    verify return:1
    depth=0 CN = miapp.local
    verify return:1
    ---
    Certificate chain
    0 s:CN = miapp.local
    i:CN = The original certificate provided by the server is untrusted
    a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
    v:NotBefore: Sep 10 20:51:37 2025 GMT; NotAfter: Sep 10 20:51:37 2026 GMT
    ---
    Server certificate
    -----BEGIN CERTIFICATE-----
    MIIDRzCCAi+gAwIBAgIQW61wreIYdt0uHLldDvRmIzANBgkqhkiG9w0BAQsFADBH
    MUUwQwYDVQQDDDxUaGUgb3JpZ2luYWwgY2VydGlmaWNhdGUgcHJvdmlkZWQgYnkg
    dGhlIHNlcnZlciBpcyB1bnRydXN0ZWQwHhcNMjUwOTEwMjA1MTM3WhcNMjYwOTEw
    MjA1MTM3WjAWMRQwEgYDVQQDDAttaWFwcC5sb2NhbDCCASIwDQYJKoZIhvcNAQEB
    BQADggEPADCCAQoCggEBAJ1eCGlogLhPwks48AfwaWCjVqng1LCA+CaOkjFbhVmz
    gTiJuzxX6jKdtVeYpnQ9yZmEWxEPjDkH3nS+409M3Fw6JGUlDHmcDgjpBf4v3rpr
    OYZ+tmcEk2m8uLn3xMjgLDI7uiiJYC67Qxgu+f9ZubmwaeHT9RNsmysNU/il5wh/
    k9N6AlL2/5zYNXVmIzni/Pxg4y8Zs4Zq6LPNb7EqJoMaJ5MhPuK0Lv+hMjc/gqth
    kVRIf/kmfgwiEgN33eTBw9gA9Le7I8PKv3+Qk0pmy/7PHic2j72VkJ3dbJROWXNR
    FhiiXPnRIke1zfsnYzAfMCCtq8BEDlhQdegJwMiShssCAwEAAaNgMF4wCwYDVR0P
    BAQDAgWgMB0GA1UdDgQWBBRq9tfwhK0KgU0TWL6fyQCE0CQ8+jAfBgNVHSMEGDAW
    gBRq9tfwhK0KgU0TWL6fyQCE0CQ8+jAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
    DQEBCwUAA4IBAQCIQQr9XczHNYvPVX8jyXFsY56VUzDHS/ZHWkpCaRiMbYR0DtV2
    fEOhn+woqB5UEGJQ/715lRzyOwMna56/ZMxq8cZcp+Uqs1Kd5ApJo+T0ttcwGHM5
    037eudqbq8gLdIplH3jdjPSy4jM5YYAZP0LwomfIPOFOZYPCFF3lvBfdpVAeIiNr
    MY13cTjI9zGSvwz/Q9x0wmI4PQkd23CXh735HjocIqvp/i79HG+XKQlLyOQouNSM
    WfdJh2RnRt77OXaxwZSymO75gjOms2Zsl/qjUevMHjyLR1EKUIwwkEiPyYcmDBbN
    ocPtBx5ljFAmG5IM/uuRAnwNt4Fojkq1mG1x
    -----END CERTIFICATE-----
    subject=CN = miapp.local
    issuer=CN = The original certificate provided by the server is untrusted
    ---
    No client certificate CA names sent
    Peer signing digest: SHA256
    Peer signature type: RSA-PSS
    Server Temp Key: X25519, 253 bits
    ---
    SSL handshake has read 1399 bytes and written 393 bytes
    Verification error: unable to verify the first certificate
    ---
    New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
    Server public key is 2048 bit
    Secure Renegotiation IS NOT supported
    Compression: NONE
    Expansion: NONE
    No ALPN negotiated
    Early data was not sent
    Verify return code: 21 (unable to verify the first certificate)
    ---
    ---
    Post-Handshake New Session Ticket arrived:
    SSL-Session:
        Protocol  : TLSv1.3
        Cipher    : TLS_AES_256_GCM_SHA384
        Session-ID: 818476ED9BE850B5F0DE0205853C266BEFAFF2B8C6885420AA851CE6DED01675
        Session-ID-ctx:
        Resumption PSK: AAA5F2CC57087157CA987EDDC36A89412446F8DC4330F15AE8B93AB23A8F63A9F2E7476F2AD62C7D41B22957F8649D74
        PSK identity: None
        PSK identity hint: None
        SRP username: None
        TLS session ticket lifetime hint: 7200 (seconds)
        TLS session ticket:
        0000 - f7 3f 9c d1 c2 fb 2e c8-58 d5 f7 f9 1e c7 7c f1   .?......X.....|.
        0010 - cc 1b 99 af bc f3 1f 7f-d6 2b 1d 25 d5 89 40 51   .........+.%..@Q
        0020 - ce 1a 0b 90 4e c1 0b 10-73 3e e5 9d 37 1d 07 26   ....N...s>..7..&
        0030 - ec 8a 5e c7 7b 36 d7 dd-83 e6 64 16 77 3b 67 5e   ..^.{6....d.w;g^
        0040 - ec eb 0a 8c 84 cd a4 09-29 b2 ee b6 b0 25 6d 7c   ........)....%m|
        0050 - f4 ae 5f e8 1e 59 57 08-bd 46 b8 6f 3b 7b 66 ee   .._..YW..F.o;{f.
        0060 - f2 f3 fb 3e cd f5 93 5f-78 74 8a c9 d4 25 0d 2b   ...>..._xt...%.+
        0070 - 42 12 e4 15 c5 95 ca 2f-97 ce 1b 31 c2 61 0b bc   B....../...1.a..
        0080 - 73 fe 94 d1 36 ed de 47-47 b1 a8 0c 53 81 01 4d   s...6..GG...S..M
        0090 - 4e ba 3f 4c 09 a4 82 a7-74 f3 5f 68 5f 8c 9f 12   N.?L....t._h_...
        00a0 - 54 81 db 08 cf da 23 63-46 56 5a de da 5f de 92   T.....#cFVZ.._..
        00b0 - 95 49 8c 30 fc ec c6 a8-fe 1e aa 11 43 1b 4a b1   .I.0........C.J.
        00c0 - ae 81 25 c4 75 d6 52 38-15 84 c0 f4 f0 0a ee 90   ..%.u.R8........

        Start Time: 1757897697
        Timeout   : 7200 (sec)
        Verify return code: 21 (unable to verify the first certificate)
        Extended master secret: no
        Max Early Data: 0
    ---
    read R BLOCK
    ---
    Post-Handshake New Session Ticket arrived:
    SSL-Session:
        Protocol  : TLSv1.3
        Cipher    : TLS_AES_256_GCM_SHA384
        Session-ID: D6EBCB675C0E2F66029042946E0C610F320862806AB0AD7079A846F81C357913
        Session-ID-ctx:
        Resumption PSK: E241EEEA70442662ED1189E9C33766FBAC963EDEF6FF42BD810291205E0DD4A4C443937BD4B2ECEC184B2C744769A5BC
        PSK identity: None
        PSK identity hint: None
        SRP username: None
        TLS session ticket lifetime hint: 7200 (seconds)
        TLS session ticket:
        0000 - f7 3f 9c d1 c2 fb 2e c8-58 d5 f7 f9 1e c7 7c f1   .?......X.....|.
        0010 - 81 fa 0b 11 01 8a e5 81-a8 82 73 76 23 c1 d9 5c   ..........sv#..\
        0020 - 6f 1f 2b bf 4a 1c 6e 6b-e7 d0 92 6b 21 db 42 6d   o.+.J.nk...k!.Bm
        0030 - b7 d8 3a f2 ed a7 c0 a1-fd 5f 36 3d 9c 59 75 84   ..:......_6=.Yu.
        0040 - 35 9c 2d 5d 1f dd f7 9f-25 56 95 ce 4d 33 66 df   5.-]....%V..M3f.
        0050 - 2b ed 45 74 43 1c eb 5f-4f 32 3c a3 1b 86 da 4b   +.EtC.._O2<....K
        0060 - fb 82 e0 83 20 00 bb db-e0 66 41 38 6a c9 af d0   .... ....fA8j...
        0070 - c1 00 5d 78 bf 97 4d 19-fe 6b 41 24 e4 21 64 5c   ..]x..M..kA$.!d\
        0080 - 7f 7e 95 31 55 9a 80 8f-87 6b a8 35 fb 06 52 2d   .~.1U....k.5..R-
        0090 - a4 2a 60 a5 8c 11 d1 50-c2 12 de df 4b 83 fa 7d   .*`....P....K..}
        00a0 - 56 0f 13 0c f8 ac a7 0c-d1 30 19 33 ef 34 02 bb   V........0.3.4..
        00b0 - bc c0 7e 38 37 61 62 d9-a6 06 d8 39 f1 79 8d 60   ..~87ab....9.y.`
        00c0 - 99 07 71 97 30 5f d4 db-60 f5 80 ac 41 6b 57 70   ..q.0_..`...AkWp

        Start Time: 1757897697
        Timeout   : 7200 (sec)
        Verify return code: 21 (unable to verify the first certificate)
        Extended master secret: no
        Max Early Data: 0

        henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl -k -I https://miapp.local
    HTTP/1.1 200 OK
    Server: nginx/1.24.0 (Ubuntu)
    Date: Sun, 14 Sep 2025 18:07:52 GMT
    Content-Type: application/json
    Content-Length: 60
    Connection: keep-alive

    Diferencias entre el laboratorio y produccion
    -En produccion los certificados son reales y no autofirmados como en el laboratorio
    -En produccion el TLS se permite solo uno y no varios como puede pasar en laboratorio

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ chmod +x check_tls.sh
    ./check_tls.sh
    TLS detectado: TLSv1.3
    TLSv1.3


## 6 Puertos, procesos y firewall. Usa ss/lsof para listar puertos/procesos de app y Nginx. Diferencia loopback de expuestos públicamente. Presenta una "foto" de conexiones activas y analiza patrones. Explica cómo restringirías el acceso al backend y qué test harías para confirmarlo. Integra systemd: instala el servicio, ajusta entorno seguro y prueba parada. Simula incidente (mata proceso) y revisa logs con journalctl.

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo ss -lntp
    [sudo] password for henry: 
    State         Recv-Q        Send-Q                Local Address:Port                 Peer Address:Port        Process
    LISTEN        0             1000                 10.255.255.254:53                        0.0.0.0:*           

    LISTEN        0             4096                  127.0.0.53%lo:53                        0.0.0.0:*           
    users:(("systemd-resolve",pid=132,fd=15))
    LISTEN        0             200                       127.0.0.1:5432                      0.0.0.0:*           
    users:(("postgres",pid=274,fd=6))
    LISTEN        0             511                         0.0.0.0:443                       0.0.0.0:*           
    users:(("nginx",pid=916,fd=7),("nginx",pid=915,fd=7),("nginx",pid=914,fd=7),("nginx",pid=913,fd=7),("nginx",pid=912,fd=7),("nginx",pid=911,fd=7),("nginx",pid=910,fd=7),("nginx",pid=909,fd=7),("nginx",pid=908,fd=7),("nginx",pid=907,fd=7),("nginx",pid=906,fd=7),("nginx",pid=905,fd=7),("nginx",pid=904,fd=7),("nginx",pid=903,fd=7),("nginx",pid=902,fd=7),("nginx",pid=901,fd=7),("nginx",pid=223,fd=7))
    LISTEN        0             511                         0.0.0.0:80                        0.0.0.0:*           
    users:(("nginx",pid=916,fd=5),("nginx",pid=915,fd=5),("nginx",pid=914,fd=5),("nginx",pid=913,fd=5),("nginx",pid=912,fd=5),("nginx",pid=911,fd=5),("nginx",pid=910,fd=5),("nginx",pid=909,fd=5),("nginx",pid=908,fd=5),("nginx",pid=907,fd=5),("nginx",pid=906,fd=5),("nginx",pid=905,fd=5),("nginx",pid=904,fd=5),("nginx",pid=903,fd=5),("nginx",pid=902,fd=5),("nginx",pid=901,fd=5),("nginx",pid=223,fd=5))
    LISTEN        0             4096                     127.0.0.54:53                        0.0.0.0:*           
    users:(("systemd-resolve",pid=132,fd=17))
    LISTEN        0             128                       127.0.0.1:8080                      0.0.0.0:*           
    users:(("python",pid=2589,fd=3))
    LISTEN        0             511                            [::]:80                           [::]:*           
    users:(("nginx",pid=916,fd=6),("nginx",pid=915,fd=6),("nginx",pid=914,fd=6),("nginx",pid=913,fd=6),("nginx",pid=912,fd=6),("nginx",pid=911,fd=6),("nginx",pid=910,fd=6),("nginx",pid=909,fd=6),("nginx",pid=908,fd=6),("nginx",pid=907,fd=6),("nginx",pid=906,fd=6),("nginx",pid=905,fd=6),("nginx",pid=904,fd=6),("nginx",pid=903,fd=6),("nginx",pid=902,fd=6),("nginx",pid=901,fd=6),("nginx",pid=223,fd=6))


    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo ss -ntp
    State      Recv-Q       Send-Q             Local Address:Port             Peer Address:Port      Process  

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ sudo ufw deny in to any port 8080
    sudo ufw allow in on lo to any port 8080
    Rules updated
    Rules updated (v6)
    Rules updated
    Rules updated (v6)


    henry@LAPTOP-J58LHNLD:/etc/systemd/system$ sudo touch app.service
    [sudo] password for henry:
    henry@LAPTOP-J58LHNLD:/etc/systemd/system$ sudo nano app.service
    henry@LAPTOP-J58LHNLD:/etc/systemd/system$ sudo systemctl daemon-reload
    sudo systemctl enable --now app.service
    Created symlink /etc/systemd/system/multi-user.target.wants/app.service → /etc/systemd/system/app.service.
    henry@LAPTOP-J58LHNLD:/etc/systemd/system$ journalctl -u app.service -f
    Sep 14 17:18:44 LAPTOP-J58LHNLD systemd[1]: app.service: Main process exited, code=exited, status=203/EXEC
    sudo systemctl enable --now app.service
    Created symlink /etc/systemd/system/multi-user.target.wants/app.service → /etc/systemd/system/app.service. 



## 7 Integración CI/CD Diseña un script Bash que verifique HTTP, DNS, TLS y latencias antes del despliegue. Define umbrales (ej. latencia >0.5s falla). Ejecuta el script antes y después de una modificación (por ejemplo, cambio de puerto) y observa cómo se retroalimenta CALMS.

    
    APP_URL="http://127.0.0.1:8080"      
    TLS_URL="https://miapp.local:443"    
    DNS_NAME="miapp.local"
    MAX_LATENCY_MS=500                    
    FAIL=0                               

    echo "=== Pre-deployment checks ==="

    echo -n "HTTP check... "
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)
    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo " OK ($HTTP_STATUS)"
    else
        echo " FALLA ($HTTP_STATUS)"
        FAIL=1
    fi

    echo -n "DNS resolution check... "
    RESOLVED_IP=$(getent hosts $DNS_NAME | awk '{print $1}')
    if [ -n "$RESOLVED_IP" ]; then
        echo " $DNS_NAME -> $RESOLVED_IP"
    else
        echo " no resuelve"
        FAIL=1
    fi

    echo -n "Latency check... "
    LATENCY_MS=$(curl -o /dev/null -s -w "%{time_total}\n" $APP_URL | awk '{printf "%.0f\n",$1*1000}')
    echo "$LATENCY_MS ms"
    if [ "$LATENCY_MS" -gt "$MAX_LATENCY_MS" ]; then
        echo " Latencia > ${MAX_LATENCY_MS}ms"
        FAIL=1
    fi

    echo -n "TLS version check... "
    TLS_VERSION=$(openssl s_client -connect $(echo $TLS_URL | sed 's|https://||'):443 -servername $DNS_NAME 2>/dev/null | \
                awk '/Protocol  :/ {print $3}')
    if [[ "$TLS_VERSION" == "TLSv1.3" ]]; then
        echo " $TLS_VERSION"
    else
        echo " $TLS_VERSION (mínimo TLSv1.3 requerido)"
        FAIL=1
    fi

    # 5 Resumen y salida
    if [ "$FAIL" -eq 0 ]; then
        echo "All checks passed "
        exit 0
    else
        echo "Some checks failed "
        exit 1
    fi

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ chmod +x check_predeploy.sh
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ ./check_predeploy.sh
    === Pre-deployment checks ===
    HTTP check...  OK (200)
    DNS resolution check...  miapp.local -> 127.0.0.1
    Latency check... 6 ms
    TLS version check...   (mínimo TLSv1.3 requerido)
    Some checks failed

## 8 Escenario integrado y mapeo 12-Factor. En este ejercicio deberás trabajar con un endpoint de la aplicación (por ejemplo, GET /) y modificarlo conceptualmente para introducir un fallo no idempotente, es decir, que al repetir la misma solicitud se altere el estado o la respuesta. La evidencia debe mostrar cómo dos peticiones idénticas generan resultados distintos y por qué esto rompe la idempotencia, afectando reintentos, cachés y balanceadores.

    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/
    {"counter":1,"message":"Hola","port":8080,"release":"v0","status":"ok"}
    henry@LAPTOP-J58LHNLD:/mnt/c/Users/IanAleksandr/Desktop/ing software/Curso-CC3S2/labs/Laboratorio1$ curl http://127.0.0.1:8080/
    {"counter":2,"message":"Hola","port":8080,"release":"v0","status":"ok"}

