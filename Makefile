DESTDIR?=	/var/www
LANGUAGES?=	it en fr

CSSDIR=			${DESTDIR}/css
DESTDIR_LANGUAGES=	${LANGUAGES:S;^;${DESTDIR}/;}

FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/index.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/development.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/hacking/index.html;}

all:	${DESTDIR}/index.html \
	${DESTDIR}/css/main.css \
	${FILES_LANGUAGES}

${DESTDIR}/index.html:
	cp index.html ${DESTDIR}/index.html

${DESTDIR} ${CSSDIR} ${DESTDIR_LANGUAGES} ${DESTDIR_LANGUAGES:S;$;/hacking;}:
	mkdir -p $@

${DESTDIR}/css/main.css \
${DESTDIR}/css/submenu.css:	${CSSDIR} \
				${@:S;^${DESTDIR}/;;}
	cp ${@:S;^${DESTDIR}/;;} $@

${DESTDIR_LANGUAGES:S;$;/index.html;} \
${DESTDIR_LANGUAGES:S;$;/development.html;}:	${@:S;/${@:T};;} \
					common/head.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/heads/${@:T} \
					common/languages_menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/titles/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;}/footer.html
	cat	common/head.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/heads/${@:T} \
		common/languages_menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/titles/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;}/footer.html \
		| \
	sed	"s/%%PAGE%%/${@:T}/g" \
		> $@

${DESTDIR_LANGUAGES:S;$;/hacking/index.html;}:	${@:S;/${@:T};;} \
					${DESTDIR}/css/submenu.css \
					common/head.html \
					${@:C;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/heads/hacking/${@:T} \
					common/languages_menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/titles/hacking/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/menu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/submenu.html \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/${@:T} \
					${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/footer.html
	cat	common/head.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/heads/hacking/${@:T} \
		common/languages_menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/titles/hacking/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/menu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/submenu.html \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/hacking/${@:T} \
		${@:S;^${DESTDIR}/;;:S;/${@:T};;:S;/hacking;;}/footer.html \
		| \
	sed	"s;%%PAGE%%;${@:C;^${DESTDIR}/../;;:S;/${@:T};;};g" \
		> $@

clean:
	rm -Rf ${DESTDIR}/*
