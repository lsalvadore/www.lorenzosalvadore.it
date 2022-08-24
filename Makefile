DESTDIR?=	/var/www
LANGUAGES?=	it en fr

CSSDIR=			${DESTDIR}/css
DESTDIR_LANGUAGES=	${LANGUAGES:S;^;${DESTDIR}/;}

FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/index.html;}
FILES_LANGUAGES+=	${DESTDIR_LANGUAGES:S;$;/development.html;}

all:	${DESTDIR}/index.html \
	${DESTDIR}/css/main.css \
	${FILES_LANGUAGES}

${DESTDIR}/index.html:
	cp index.html ${DESTDIR}/index.html

${DESTDIR} ${CSSDIR} ${DESTDIR_LANGUAGES}:
	mkdir -p $@

${DESTDIR}/css/main.css: ${CSSDIR} css/main.css
	cp css/main.css $@

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

clean:
	rm -Rf ${DESTDIR}/*
