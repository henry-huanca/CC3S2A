## ejercicios guiados
    A) Evitar (o no) --ff
    Pregunta: ¿Cuando evitarias --ff en un equipo y por que?
    cuando quiero tener un punto de integracion que me sirva como marcador de un PR. cuando se usa el --ff se pierde el contexto de la integracion con lo cual la trazabilidad queda de un lado.

    B) Trabajo en equipo con --no-ff
    ¿Qué ventajas de trazabilidad aporta? ¿Qué problemas surgen con exceso de merges?
    permite que se puedan filtrar los merges con mayor facilidad y cuando existen un exceso de merge dificulta observar el historial y puede llegar a confundir

    C) Squash con muchos commits
    ¿Cuándo conviene? ¿Qué se pierde respecto a merges estándar?
    cuando la rama tiene muchos commits y se necesita mantener al main con commits significativos y lo que se pierde con merges standar es el historial de commits que se realizaron.

## Conflictos reales con no-fast-forward

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "<h1>Proyecto CC3S2</h1>" > index.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/03-squash.log.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/index.html.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "index.html"
    [main 1aab6b1] index.html
    2 files changed, 34 insertions(+)
    create mode 100644 actividad7/evidencias/03-squash.log
    create mode 100644 actividad7/index.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-update
    Switched to a new branch 'feature-update'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-update)
    $ echo "<h1>Proyecto CC3S2 (feature)</h1>" > index.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-update)
    $ git commit -am "feature-update"
    warning: LF will be replaced by CRLF in actividad7/index.html.
    The file will have its original line endings in your working directory
    [feature-update 1e244c0] feature-update
    1 file changed, 1 insertion(+), 1 deletion(-)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-update)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 5 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "<h1>Proyecto CC3S2 (main)</h1>" > index.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "Cambio main"
    On branch main
    Your branch is ahead of 'origin/main' by 5 commits.
    (use "git push" to publish your local commits)

    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   index.html

    no changes added to commit (use "git add" and/or "git commit -a")

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge --no-ff feature-update
    error: Your local changes to the following files would be overwritten by merge:
            actividad7/index.html
    Please commit your changes or stash them before you merge.
    Aborting

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git status
    On branch main
    Your branch is ahead of 'origin/main' by 5 commits.
    (use "git push" to publish your local commits)

    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   index.html

    no changes added to commit (use "git add" and/or "git commit -a")

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git diff
    warning: LF will be replaced by CRLF in actividad7/index.html.
    The file will have its original line endings in your working directory
    diff --git a/actividad7/index.html b/actividad7/index.html
    index 692f180..2a547e2 100644
    --- a/actividad7/index.html
    +++ b/actividad7/index.html
    @@ -1 +1 @@
    -<h1>Proyecto CC3S2</h1>
    +<h1>Proyecto CC3S2 (main)</h1>

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ nano index.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/index.html.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "ejericio conflicto"
    [main ee7d5e2] ejericio conflicto
    1 file changed, 1 insertion(+), 1 deletion(-)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/04-conflicto.log

    
    ¿Qué pasos adicionales hiciste para resolverlo?
    abri el archivo y modifique manualmente para eliminar los errores y lo guarde, luego hice un git add e hice el commit correspondiente
    ¿Qué prácticas (convenciones, PRs pequeñas, tests) lo evitarían?
    realizar PR pequeñas para evitar problemas y mantener la comunicacion sobre sobre los cambios que se producen en un archivo.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all --first-parent > evidencias/05-compare-fastforward.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --merges --decorate > evidencias/06-compare-noff.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/07-compare-squash.log

    
    ¿Cómo se ve el DAG en cada caso?
    para el fast-forward brinda el historial lineal
    para el no-fast forward nos muestra los merges con dos o mas padres
    para el squash aparece un commit unico que no hace referencia a la rama en la que se creo
    ¿Qué método prefieres para: trabajo individual, equipo grande, repos con auditoría estricta?
    para un trabajo individual prefiero el -ff, para un trabajo colaborativo el --no -ff y para auditoria estricta el --no -ff mas la firma del commit

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "<h1>Proyecto CC3S2 (main)</h1>" > index1.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git status
    On branch main
    Your branch is up to date with 'origin/main'.

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            index1.html

    nothing added to commit but untracked files present (use "git add" to track)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/index1.html.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "prueba"
    [main 63464d4] prueba
    1 file changed, 1 insertion(+)
    create mode 100644 actividad7/index1.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git show -s --format=%P HEAD
    c0919c18f43f556e94f748eada74b588a3babb52

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git revert -m 1 HEAD
    Removing actividad7/index1.html
    [main f650dd8] Revert "prueea"
    1 file changed, 1 deletion(-)
    delete mode 100644 actividad7/index1.html

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/08-revert-merge.log


    
    ¿Cuándo usar git revert en vez de git reset?
    se utiliza git revert cuando se trabaja con colaboradores y de esta manera se evita que pueda haber algun problema con los archivos que ellos estan trabajando
    ¿Impacto en un repo compartido con historial público?
    git revert sigue permitiendo la trazabilidad del historial ya que puedes eliminar un commit sin afectar a las demas personas.

## Variantes útiles para DevOps/DevSecOps
    A) Fast-Forward Only (merge seguro)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-ffonly
    Switched to a new branch 'feature-ffonly'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-ffonly)
    $ echo "Linea ffonly" > ffonly.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-ffonly)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/08-revert-merge.log.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/ffonly.txt.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-ffonly)
    $ git commit - "ffonly"
    error: pathspec '-' did not match any file(s) known to git
    error: pathspec 'ffonly' did not match any file(s) known to git

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-ffonly)
    $ git commit -m "ffonly"
    [feature-ffonly 9c78cce] ffonly
    2 files changed, 41 insertions(+)
    create mode 100644 actividad7/evidencias/08-revert-merge.log
    create mode 100644 actividad7/ffonly.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-ffonly)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 2 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge --ff-only feature-ffonly
    Updating f650dd8..9c78cce
    Fast-forward
    actividad7/evidencias/08-revert-merge.log | 40 +++++++++++++++++++++++++++++++
    actividad7/ffonly.txt                     |  1 +
    2 files changed, 41 insertions(+)
    create mode 100644 actividad7/evidencias/08-revert-merge.log
    create mode 100644 actividad7/ffonly.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all --first-parent > evidencias/09-ff-only.log

    B) Rebase + FF (historial lineal con PRs)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-rebase
    Switched to a new branch 'feature-rebase'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rebase)
    $ echo "rebase" > rebase.txt && git add rebase.txt && git commit -m "rebase"    warning: LF will be replaced by CRLF in actividad7/rebase.txt.
    The file will have its original line endings in your working directory
    [feature-rebase 77b2d25] rebase
    1 file changed, 1 insertion(+)
    create mode 100644 actividad7/rebase.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rebase)
    $ echo "rebase2" > rebase.txt && git add rebase.txt && git commit -m "rebase2"
    warning: LF will be replaced by CRLF in actividad7/rebase.txt.
    The file will have its original line endings in your working directory
    [feature-rebase 1a8a80e] rebase2
    1 file changed, 1 insertion(+), 1 deletion(-)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rebase)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 3 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "Cambio en main remoto" > mainremoto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/09-ff-only.log.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/mainremoto.txt.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "cambio el main"
    [main 4e652c0] cambio el main
    2 files changed, 35 insertions(+)
    create mode 100644 actividad7/evidencias/09-ff-only.log
    create mode 100644 actividad7/mainremoto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git push
    Enumerating objects: 19, done.
    Counting objects: 100% (19/19), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (14/14), done.
    Writing objects: 100% (16/16), 2.05 KiB | 700.00 KiB/s, done.
    Total 16 (delta 9), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (9/9), completed with 3 local objects.
    To https://github.com/henry-huanca/CC3S2A.git
    c0919c1..4e652c0  main -> main

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git fetch origin && git rebase origin/main
    Current branch main is up to date.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout feature-rebase
    Switched to branch 'feature-rebase'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rebase)
    $ git rebase origin/main
    Successfully rebased and updated refs/heads/feature-rebase.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rebase)
    $ git checkout main
    Switched to branch 'main'
    Your branch is up to date with 'origin/main'.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge feature-rebase
    Updating 4e652c0..bcda893
    Fast-forward
    actividad7/rebase.txt | 1 +
    1 file changed, 1 insertion(+)
    create mode 100644 actividad7/rebase.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git push
    Enumerating objects: 10, done.
    Counting objects: 100% (10/10), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (8/8), 604 bytes | 302.00 KiB/s, done.
    Total 8 (delta 4), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (4/4), completed with 2 local objects.
    To https://github.com/henry-huanca/CC3S2A.git
    4e652c0..bcda893  main -> main

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all --first-parent > evidencias/10-rebase-ff.log

    C) Merge con validación previa (sin commitear)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-validate
    Switched to a new branch 'feature-validate'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-validate)
    $ echo "feature-validate" > script.sh

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-validate)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/10-rebase-ff.log.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/script.sh.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-validate)
    $ git commit -m "script-sh"
    [feature-validate 8443912] script-sh
    2 files changed, 38 insertions(+)
    create mode 100644 actividad7/evidencias/10-rebase-ff.log
    create mode 100644 actividad7/script.sh

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-validate)
    $ git checkout main
    Switched to branch 'main'
    Your branch is up to date with 'origin/main'.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge --no-commit --no-ff feature-validate
    Automatic merge went well; stopped before committing as requested

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main|MERGING)
    $ bash -n script.sh

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main|MERGING)
    $ make test && make lint
    bash: make: command not found

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main|MERGING)
    $ git status
    On branch main
    Your branch is up to date with 'origin/main'.

    All conflicts fixed but you are still merging.
    (use "git commit" to conclude merge)

    Changes to be committed:
            new file:   evidencias/10-rebase-ff.log
            new file:   script.sh


    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main|MERGING)
    $ git commit -m "feature validate"
    [main e0a3f44] feature validate

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/11-pre-commit-merge.log

    D) Octopus Merge (varias ramas a la vez)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feat-a
    Switched to a new branch 'feat-a'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-a)
    $ echo "feat-a" > a.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-a)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/a.txt.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/evidencias/11-pre-commit-merge.log.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-a)
    $ git commit -m "feata"
    [feat-a 7e85e6e] feata
    2 files changed, 49 insertions(+)
    create mode 100644 actividad7/a.txt
    create mode 100644 actividad7/evidencias/11-pre-commit-merge.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-a)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 2 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feat-b
    Switched to a new branch 'feat-b'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-b)
    $ echo "feat-b" > b.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-b)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/b.txt.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-b)
    $ git commit -m "featb"
    [feat-b 711070f] featb
    1 file changed, 1 insertion(+)
    create mode 100644 actividad7/b.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feat-b)
    $ git checkout main && git merge feat-a feat-b
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 2 commits.
    (use "git push" to publish your local commits)
    Fast-forwarding to: feat-a
    Trying simple merge with feat-b
    Merge made by the 'octopus' strategy.
    actividad7/a.txt                              |  1 +
    actividad7/b.txt                              |  1 +
    actividad7/evidencias/11-pre-commit-merge.log | 48 +++++++++++++++++++++++++++
    3 files changed, 50 insertions(+)
    create mode 100644 actividad7/a.txt
    create mode 100644 actividad7/b.txt
    create mode 100644 actividad7/evidencias/11-pre-commit-merge.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --merges --decorate > evidencias/12-octopus.log

    E) Subtree (integrar subproyecto conservando historial)


    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $ git subtree add --prefix=vendor/demo https://github.com/henry-huanca/repositorio-prueba.git main

    git fetch https://github.com/henry-huanca/repositorio-prueba.git main
    remote: Enumerating objects: 3, done.
    remote: Counting objects: 100% (3/3), done.
    remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    Unpacking objects: 100% (3/3), 864 bytes | 108.00 KiB/s, done.
    From https://github.com/henry-huanca/repositorio-prueba
    * branch            main       -> FETCH_HEAD
    Added dir 'vendor/demo'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $ git log --graph --oneline --decorate --all > evidencias/13-subtree.log
    bash: evidencias/13-subtree.log: No such file or directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $ cd evidencias
    bash: cd: evidencias: No such file or directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $ ls
    README.md    actividad3/  actividad6/  vendor/
    actividad2/  actividad4/  actividad7/

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A (main)
    $ cd actividad7

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ cd evidencias

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7/evidencias (main)
    $ cd ..

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/13-subtree.log

    F) Sesgos de resolución y normalización (algoritmo ORT)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "conflicto" > conflicto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/conflicto.txt.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/evidencias/13-subtree.log.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "conflicto"
    [main 656771b] conflicto
    2 files changed, 58 insertions(+)
    create mode 100644 actividad7/conflicto.txt
    create mode 100644 actividad7/evidencias/13-subtree.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-x
    Switched to a new branch 'feature-x'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-x)
    $ echo "Linea cambiada en feature-x" > conflicto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-x)
    $ git commit -am "Cambio en feature-x"
    warning: LF will be replaced by CRLF in actividad7/conflicto.txt.
    The file will have its original line endings in your working directory
    [feature-x c369469] Cambio en feature-x
    1 file changed, 1 insertion(+), 1 deletion(-)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-x)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 3 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ echo "Linea cambiada en main" > conflicto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -am "Cambio en main"
    warning: LF will be replaced by CRLF in actividad7/conflicto.txt.
    The file will have its original line endings in your working directory
    [main 1d824a4] Cambio en main
    1 file changed, 1 insertion(+), 1 deletion(-)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge -X ours feature-x
    Auto-merging actividad7/conflicto.txt
    Merge made by the 'recursive' strategy.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-rename
    Switched to a new branch 'feature-rename'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git mv conflicto.txt conflicto-renombrado.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git commit -m "Renombrar archivo"
    [feature-rename 8d23df3] Renombrar archivo
    1 file changed, 0 insertions(+), 0 deletions(-)
    rename actividad7/{conflicto.txt => conflicto-renombrado.txt} (100%)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ nano conflicto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git merge -X find-renames=90% feature-rename
    Already up to date.

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git checkout main
    error: The following untracked working tree files would be overwritten by checkout:
            actividad7/conflicto.txt
    Please move or remove them before you switch branches.
    Aborting

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git merge -X renormalize feature-eol
    merge: feature-eol - not something we can merge

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git checkout main
    error: The following untracked working tree files would be overwritten by checkout:
            actividad7/conflicto.txt
    Please move or remove them before you switch branches.
    Aborting

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git commit -m "merge rename"
    On branch feature-rename
    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            conflicto.txt

    nothing added to commit but untracked files present (use "git add" to track)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/conflicto.txt.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git commit -m "merge rename"
    [feature-rename d1ea7f7] merge rename
    1 file changed, 1 insertion(+)
    create mode 100644 actividad7/conflicto.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-rename)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 6 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge -X renormalize feature-eol
    merge: feature-eol - not something we can merge

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --graph --oneline --decorate --all > evidencias/14-x-strategy.log


    G) Firmar merges/commits (auditoría y cumplimiento)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ gpg --full-generate-key
    gpg (GnuPG) 2.2.29-unknown; Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    gpg: directory '/c/Users/IanAleksandr/.gnupg' created
    gpg: keybox '/c/Users/IanAleksandr/.gnupg/pubring.kbx' created
    Please select what kind of key you want:
    (1) RSA and RSA (default)
    (2) DSA and Elgamal
    (3) DSA (sign only)
    (4) RSA (sign only)
    (14) Existing key from card
    Your selection? 1
    RSA keys may be between 1024 and 4096 bits long.
    What keysize do you want? (3072) 4096
    Requested keysize is 4096 bits
    Please specify how long the key should be valid.
            0 = key does not expire
        <n>  = key expires in n days
        <n>w = key expires in n weeks
        <n>m = key expires in n months
        <n>y = key expires in n years
    Key is valid for? (0) <2>
    invalid value
    Key is valid for? (0) 2
    Key expires at Wed Sep 17 01:51:58 2025 HPS
    Is this correct? (y/N) y

    GnuPG needs to construct a user ID to identify your key.

    Real name: henry-huanca
    Email address: hen12huan@gmail.com
    Comment: prueba
    You selected this USER-ID:
        "henry-huanca (prueba) <hen12huan@gmail.com>"

    Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
    We need to generate a lot of random bytes. It is a good idea to perform
    some other action (type on the keyboard, move the mouse, utilize the
    disks) during the prime generation; this gives the random number
    generator a better chance to gain enough entropy.
    We need to generate a lot of random bytes. It is a good idea to perform
    some other action (type on the keyboard, move the mouse, utilize the
    disks) during the prime generation; this gives the random number
    generator a better chance to gain enough entropy.
    gpg: /c/Users/IanAleksandr/.gnupg/trustdb.gpg: trustdb created
    gpg: key 511B5B5F2DCA9812 marked as ultimately trusted
    gpg: directory '/c/Users/IanAleksandr/.gnupg/openpgp-revocs.d' created
    gpg: revocation certificate stored as '/c/Users/IanAleksandr/.gnupg/openpgp-revocs.d/9C7E8174E18581EC1857FCC5511B5B5F2DCA9812.rev'
    public and secret key created and signed.

    pub   rsa4096 2025-09-15 [SC] [expires: 2025-09-17]
        9C7E8174E18581EC1857FCC5511B5B5F2DCA9812
    uid                      henry-huanca (prueba) <hen12huan@gmail.com>
    sub   rsa4096 2025-09-15 [E] [expires: 2025-09-17]


    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ gpg --list-secret-keys --keyid-format LONG
    gpg: checking the trustdb
    gpg: marginals needed: 3  completes needed: 1  trust model: pgp
    gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
    gpg: next trustdb check due at 2025-09-17
    /c/Users/IanAleksandr/.gnupg/pubring.kbx
    ----------------------------------------
    sec   rsa4096/511B5B5F2DCA9812 2025-09-15 [SC] [expires: 2025-09-17]
        9C7E8174E18581EC1857FCC5511B5B5F2DCA9812
    uid                 [ultimate] henry-huanca (prueba) <hen12huan@gmail.com>
    ssb   rsa4096/F217F58BCFE25DB9 2025-09-15 [E] [expires: 2025-09-17]


    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ gpg --list-secret-keys --keyid-format LONG
    /c/Users/IanAleksandr/.gnupg/pubring.kbx
    ----------------------------------------
    sec   rsa4096/511B5B5F2DCA9812 2025-09-15 [SC] [expires: 2025-09-17]
        9C7E8174E18581EC1857FCC5511B5B5F2DCA9812
    uid                 [ultimate] henry-huanca (prueba) <hen12huan@gmail.com>
    ssb   rsa4096/F217F58BCFE25DB9 2025-09-15 [E] [expires: 2025-09-17]


    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git config --global user.signingkey 511B5B5F2DCA9812

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git checkout -b feature-signed
    Switched to a new branch 'feature-signed'

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-signed)
    $ echo "Linea en rama firmada" > signed.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-signed)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/14-x-strategy.log.
    The file will have its original line endings in your working directory
    warning: LF will be replaced by CRLF in actividad7/signed.txt.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-signed)
    $ git commit -m "feature-signed: agrega signed.txt"
    [feature-signed b85a934] feature-signed: agrega signed.txt
    2 files changed, 66 insertions(+)
    create mode 100644 actividad7/evidencias/14-x-strategy.log
    create mode 100644 actividad7/signed.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (feature-signed)
    $ git checkout main
    Switched to branch 'main'
    Your branch is ahead of 'origin/main' by 6 commits.
    (use "git push" to publish your local commits)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git merge --no-ff --gpg-sign feature-signed
    Merge made by the 'recursive' strategy.
    actividad7/evidencias/14-x-strategy.log | 65 +++++++++++++++++++++++++++++++++
    actividad7/signed.txt                   |  1 +
    2 files changed, 66 insertions(+)
    create mode 100644 actividad7/evidencias/14-x-strategy.log
    create mode 100644 actividad7/signed.txt

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git log --show-signature -1 > evidencias/15-signed-merge.log

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git push
    Enumerating objects: 31, done.
    Counting objects: 100% (31/31), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (21/21), done.
    Writing objects: 100% (28/28), 4.47 KiB | 1.12 MiB/s, done.
    Total 28 (delta 14), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (14/14), completed with 3 local objects.
    To https://github.com/henry-huanca/CC3S2A.git
    f9b6b6f..207f5e5  main -> main

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git status
    On branch main
    Your branch is up to date with 'origin/main'.

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            evidencias/15-signed-merge.log

    nothing added to commit but untracked files present (use "git add" to track)

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git add .
    warning: LF will be replaced by CRLF in actividad7/evidencias/15-signed-merge.log.
    The file will have its original line endings in your working directory

    IanAleksandr@LAPTOP-J58LHNLD MINGW64 /d/DESARROLLO SOFTWARE/CC3S2A/actividad7 (main)
    $ git commit -m "signed merge"
    [main f1aa146] signed merge
    1 file changed, 9 insertions(+)
    create mode 100644 actividad7/evidencias/15-signed-merge.log
