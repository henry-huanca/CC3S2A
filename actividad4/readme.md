## Parte 1
    henry@LAPTOP-J58LHNLD:~/lab-cli$ mkdir -p ~/lab-cli/evidencias && cd ~/lab-cli
    script -q evidencias/sesion.txt
    henry@LAPTOP-J58LHNLD:~/lab-cli$ sed -E \
    -e 's/(password|token|secret)/[REDACTED]/gI' \
    -e 's/\b(pass(word)?|token|secret|api[-_]?key)\b[[:space:]]*[:=][[:space:]]*[^[:space:]]+/\1: [REDACTED]/gI' \
    evidencias/sesion.txt > evidencias/sesion_redactada.txt

    sed -E 's/\b(Authorization:)[[:space:]]+(Basic|Bearer)[[:space:]]+[A-Za-z0-9._~+\/=-]+/\1 \2 [REDACTED]/gI' \
    evidencias/sesion_redactada.txt > evidencias/sesion_redactada.tmp && mv evidencias/sesion_redactada.tmp evidencias/sesion_redactada.txt
    henry@LAPTOP-J58LHNLD:~/lab-cli$ cd /etc; ls -a > ~/etc_lista.txt
    henry@LAPTOP-J58LHNLD:/etc$ find /tmp -maxdepth 1 -type f \( -name '*.txt' -o -name '*.doc' \) | wc -l
    0
    henry@LAPTOP-J58LHNLD:/etc$ cd ..
    henry@LAPTOP-J58LHNLD:/$ cd home
    henry@LAPTOP-J58LHNLD:/home$ cd henry
    henry@LAPTOP-J58LHNLD:~$ cd lab-cli
    henry@LAPTOP-J58LHNLD:~/lab-cli$ printf "Línea1\nLínea2\n" > test.txt
    henry@LAPTOP-J58LHNLD:~/lab-cli$ cat test.txt
    Línea1
    Línea2
    henry@LAPTOP-J58LHNLD:~/lab-cli$ ls noexiste 2>> errores.log
    henry@LAPTOP-J58LHNLD:~/lab-cli$ cat errores.log
    ls: cannot access 'noexiste': No such file or directory
    ls: cannot access 'noexiste': No such file or directory

    se crearon las carpetas, archivos y se redirigio los errores 
## Parte 2
    henry@LAPTOP-J58LHNLD:~/lab-cli$ sudo adduser devsec; sudo addgroup ops; sudo usermod -aG ops devsec; touch secreto.txt; sudo chown devsec:ops secreto.txt; sudo chmod 640 secreto.txt
    [sudo] password for henry:
    info: Adding user `devsec' ...
    info: Selecting UID/GID from range 1000 to 59999 ...
    info: Adding new group `devsec' (1001) ...
    info: Adding new user `devsec' (1001) with group `devsec (1001)' ...
    info: Creating home directory `/home/devsec' ...
    info: Copying files from `/etc/skel' ...
    New password:
    Retype new password:
    passwd: password updated successfully
    Changing the user information for devsec
    Enter the new value, or press ENTER for the default
            Full Name []:
            Room Number []:
            Work Phone []:
            Home Phone []:
            Other []:
    Is the information correct? [Y/n] y
    info: Adding new user `devsec' to supplemental / extra groups `users' ...
    info: Adding user `devsec' to group `users' ...
    fatal: The group `ops' already exists.
    henry@LAPTOP-J58LHNLD:~/lab-cli$ ps aux | grep bash
    henry        532  0.0  0.0   6072  5120 pts/1    S+   20:47   0:00 -bash
    henry        702  0.0  0.0   6072  5248 pts/0    Ss   21:06   0:00 -bash
    henry        778  0.0  0.0   6084  5248 pts/2    Ss   21:57   0:00 bash -i
    henry        859  0.0  0.0   4092  1920 pts/2    S+   22:01   0:00 grep --color=auto bash
    henry@LAPTOP-J58LHNLD:~/lab-cli$ systemctl status systemd-logind
    ● systemd-logind.service - User Login Management
        Loaded: loaded (/usr/lib/systemd/system/systemd-logind.service; static)
        Drop-In: /usr/lib/systemd/system/systemd-logind.service.d
                └─dbus.conf
        Active: active (running) since Sun 2025-09-14 20:47:34 -05; 1h 14min ago
        Docs: man:sd-login(3)
                man:systemd-logind.service(8)
                man:logind.conf(5)
                man:org.freedesktop.login1(5)
    Main PID: 185 (systemd-logind)
        Status: "Processing requests..."
        Tasks: 1 (limit: 9163)
    FD Store: 0 (limit: 512)
        Memory: 1.7M (peak: 2.2M)
            CPU: 136ms
        CGroup: /system.slice/systemd-logind.service
                └─185 /usr/lib/systemd/systemd-logind

    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd[1]: Starting systemd-logind.service - User Login Management...
    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd-logind[185]: New seat seat0.
    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd[1]: Started systemd-logind.service - User Login Management.
    Sep 14 20:47:42 LAPTOP-J58LHNLD systemd-logind[185]: New session 1 of user henry.
    henry@LAPTOP-J58LHNLD:~/lab-cli$ journalctl -u systemd-logind -n 10
    Sep 10 12:28:55 LAPTOP-J58LHNLD systemd[1]: Started systemd-logind.service - User Login Management.
    Sep 10 12:28:56 LAPTOP-J58LHNLD systemd-logind[179]: New session 1 of user henry.
    -- Boot 2cbe287d5d8343bfbb835c1c5b1a01ff --
    Sep 14 11:52:20 LAPTOP-J58LHNLD systemd[1]: Starting systemd-logind.service - User Login Management...
    Sep 14 11:52:20 LAPTOP-J58LHNLD systemd-logind[195]: New seat seat0.
    Sep 14 11:52:20 LAPTOP-J58LHNLD systemd[1]: Started systemd-logind.service - User Login Management.
    Sep 14 11:52:29 LAPTOP-J58LHNLD systemd-logind[195]: New session 1 of user henry.
    -- Boot 24f38cc069db4dd094c7ae094362ee93 --
    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd[1]: Starting systemd-logind.service - User Login Management...
    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd-logind[185]: New seat seat0.
    Sep 14 20:47:34 LAPTOP-J58LHNLD systemd[1]: Started systemd-logind.service - User Login Management.
    Sep 14 20:47:42 LAPTOP-J58LHNLD systemd-logind[185]: New session 1 of user henry.
    henry@LAPTOP-J58LHNLD:~/lab-cli$ sleep 100 $
    sleep: invalid time interval ‘$’
    Try 'sleep --help' for more information.
    henry@LAPTOP-J58LHNLD:~/lab-cli$ sleep 100 &
    [1] 867
    henry@LAPTOP-J58LHNLD:~/lab-cli$ ps aux | grep sleep
    henry        867  0.0  0.0   3128  1664 pts/2    S    22:03   0:00 sleep 100
    henry        869  0.0  0.0   4092  1920 pts/2    S+   22:03   0:00 grep --color=auto sleep
    henry@LAPTOP-J58LHNLD:~/lab-cli$ kill SIGTERM 867
    bash: kill: SIGTERM: arguments must be process or job IDs
    bash: kill: (867) - No such process
    [1]+  Terminated              sleep 100

    se creo un usuario devsec y un grupo ops al cual se le añadio este usuario. esto se hizo con el objetivo de cambiar los permisos a secreto.txt, ademas se creo un proceso en segundo plano que era sleep y luego se detuvo
## Parte 3

    henry@LAPTOP-J58LHNLD:~/lab-cli$ printf "linea1: dato1\nlinea2: dato2\n" > datos.txt
    henry@LAPTOP-J58LHNLD:~/lab-cli$ cat datos.txt
    linea1: dato1
    linea2: dato2
    henry@LAPTOP-J58LHNLD:~/lab-cli$ grep root /etc/passwd
    root:x:0:0:root:/root:/bin/bash
    henry@LAPTOP-J58LHNLD:~/lab-cli$ sed 's/dato1/secreto/' datos.txt > nuevo.txt
    henry@LAPTOP-J58LHNLD:~/lab-cli$ cat nuevo.txt
    linea1: secreto
    linea2: dato2
    henry@LAPTOP-J58LHNLD:~/lab-cli$ wk -F: '{print $1}' /etc/passwd | sort | uniq
    wk: command not found
    henry@LAPTOP-J58LHNLD:~/lab-cli$ awk -F: '{print $1}' /etc/passwd | sort | uniq
    _apt
    backup
    bin
    daemon
    devsec
    dhcpcd
    games
    henry
    irc
    landscape
    list
    lp
    mail
    man
    messagebus
    news
    nobody
    polkitd
    postgres
    proxy
    root
    sync
    sys
    syslog
    systemd-network
    systemd-resolve
    systemd-timesync
    uucp
    uuidd
    www-data
    henry@LAPTOP-J58LHNLD:~/lab-cli$ printf "hola\n" | tr 'a-z' 'A-Z' | tee mayus.txt
    HOLA
    henry@LAPTOP-J58LHNLD:~/lab-cli$ find /tmp -mtime -5 -type f
    find: ‘/tmp/systemd-private-24f38cc069db4dd094c7ae094362ee93-wsl-pro.service-hfpmbt’: Permission denied
    find: ‘/tmp/snap-private-tmp’: Permission denied
    find: ‘/tmp/systemd-private-24f38cc069db4dd094c7ae094362ee93-systemd-resolved.service-Hnlple’: Permission denied
    find: ‘/tmp/systemd-private-24f38cc069db4dd094c7ae094362ee93-systemd-timesyncd.service-HrOxEx’: Permission denied
    find: ‘/tmp/systemd-private-24f38cc069db4dd094c7ae094362ee93-systemd-logind.service-KP6rKo’: Permission denied
    henry@LAPTOP-J58LHNLD:~/lab-cli$ ls /etc | grep conf | sort | tee lista_conf.txt | wc -l
    31
    henry@LAPTOP-J58LHNLD:~/lab-cli$ grep -Ei 'error|fail' evidencias/sesion.txt | tee evidencias/hallazgos.txt
    grep: evidencias/sesion.txt: binary file matches

    en esta parte se creo un archivo de texto en el cual se fue modificando su contenido tanto cambiando lineas como el cambio de minuscula a mayuscula y se extrajeron posibles fallos en la sesion