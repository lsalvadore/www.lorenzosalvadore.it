DESTDIR?=	/var/www
LANGUAGES?=	it en fr

CSSDIR=			${DESTDIR}/css
FILES=			index.html
DESTDIR_LANGUAGES=	${LANGUAGES:S;^;${DESTDIR}/;}
FILES_LANGUAGES=	${DESTDIR_LANGUAGES:S;$;/${FILES};}

all:	index.html \
	${DESTDIR}/css/main.css \
	${FILES_LANGUAGES}
	cp index.html ${DESTDIR}/index.html

${DESTDIR} ${CSSDIR} ${DESTDIR_LANGUAGES}:
	mkdir -p $@

${DESTDIR}/css/main.css: ${CSSDIR} css/main.css
	cp css/main.css $@

${DESTDIR_LANGUAGES:S;$;/index.html;}:	${@:S;/index.html;;} \
					common/head.html \
					${@:S;^${DESTDIR}/;;:S;/index.html;;}/head/index.html \
					${@:S;^${DESTDIR}/;;:S;/index.html;;}/menu.html \
					${@:S;^${DESTDIR}/;;:S;/index.html;;}/index.html
	cat	common/head.html \
		${@:S;^${DESTDIR}/;;:S;/index.html;;}/head/index.html \
		${@:S;^${DESTDIR}/;;:S;/index.html;;}/menu.html \
		${@:S;^${DESTDIR}/;;:S;/index.html;;}/index.html \
		> $@
clean:
	rm -Rf ${DESTDIR}/*
