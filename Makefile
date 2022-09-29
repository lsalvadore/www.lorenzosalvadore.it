DESTDIR?=	/var/www
LANGUAGES?=	it en fr

CSSDIR=			${DESTDIR}/css
CTF_CERTIFICATES_DIR=	${DESTDIR}/ctf-certificates

WRITEUPS_DIR=		${DESTDIR}/writeups
WRITEUPS_SUBDIRS+=	${WRITEUPS_DIR}/hackthebox \
			${WRITEUPS_DIR}/hackthebox/machines

DESTDIR_LANGUAGES=	${LANGUAGES:S;^;${DESTDIR}/;}

FILES_CSS+=		${CSSDIR:S;$;/main.css;}
FILES_CSS+=		${CSSDIR:S;$;/data-table.css;}
FILES_CSS+=		${CSSDIR:S;$;/submenu.css;}

FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/index.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/development.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/hacking/index.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/hacking/ctf-certificates.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/hacking/writeups.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/mathematics.html;}

FILES_CTF_CERTIFICATES+=	${CTF_CERTIFICATES_DIR:S;$;/AdventOfCyber2021.png;}
FILES_CTF_CERTIFICATES+=	${CTF_CERTIFICATES_DIR:S;$;/NahamConCtf2022.png;}
FILES_CTF_CERTIFICATES+=	${CTF_CERTIFICATES_DIR:S;$;/CyberApocalypseCTF2022.pdf;}

FILES_WRITEUPS+=	${WRITEUPS_DIR:S;$;/hackthebox/machines/Late.pdf;}
FILES_WRITEUPS+=	${WRITEUPS_DIR:S;$;/hackthebox/machines/Phoenix.pdf;}
FILES_WRITEUPS+=	${WRITEUPS_DIR:S;$;/hackthebox/machines/Undetected.pdf;}

all:	${DESTDIR}/index.html \
	${FILES_CSS} \
	${FILES_LANGUAGES} \
	${FILES_CTF_CERTIFICATES} \
	${FILES_WRITEUPS}

${DESTDIR}/index.html:
	cp index.html ${DESTDIR}/index.html

${DESTDIR} \
${CSSDIR} \
${CTF_CERTIFICATES_DIR} \
${WRITEUPS_DIR} \
${WRITEUPS_SUBDIRS} \
${DESTDIR_LANGUAGES} \
${DESTDIR_LANGUAGES:S;$;/hacking;}:
	mkdir -p $@

${FILES_CSS}:	${CSSDIR} \
		${@:S;^${DESTDIR}/;;}
	cp ${@:S;^${DESTDIR}/;;} $@

${FILES_CTF_CERTIFICATES}:	${CTF_CERTIFICATES_DIR} \
				${@:S;^${DESTDIR}/;;}
	cp ${@:S;^${DESTDIR}/;;} $@

${FILES_WRITEUPS}:	${WRITEUPS_DIR} \
			${WRITEUPS_SUBDIRS} \
			${@:S;^${DESTDIR}/;;}
	cp ${@:S;^${DESTDIR}/;;} $@

${DESTDIR_LANGUAGES:S;$;/index.html;} \
${DESTDIR_LANGUAGES:S;$;/development.html;} \
${DESTDIR_LANGUAGES:S;$;/mathematics.html;}:	${@:S;/${@:T};;} \
					common/head.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/heads/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/languages_menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/titles/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/footer.html
	cat	common/head.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/heads/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/languages_menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/titles/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/footer.html \
		| \
	sed	"s/%%PAGE%%/${@:T}/g" \
		> $@

${DESTDIR_LANGUAGES:S;$;/hacking/index.html;} \
${DESTDIR_LANGUAGES:S;$;/hacking/ctf-certificates.html;} \
${DESTDIR_LANGUAGES:S;$;/hacking/writeups.html;}:	${@:S;/${@:T};;} \
					common/head.html \
					${@:C;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/heads/hacking/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/languages_menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/titles/hacking/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/submenu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/footer.html
	cat	common/head.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/heads/hacking/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/languages_menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/titles/hacking/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/submenu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/footer.html \
		| \
	sed	"s;%%PAGE%%;${@:C;^${DESTDIR}/../;;};g" \
		> $@

clean:
	rm -Rf ${DESTDIR}/*
