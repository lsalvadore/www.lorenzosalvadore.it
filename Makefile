DESTDIR?=	/var/www

all:	index.html \
	${DESTDIR} \
	${DESTDIR}/css \
	${DESTDIR}/it \
	${DESTDIR}/en \
	${DESTDIR}/fr
	cp index.html ${DESTDIR}/index.html

${DESTDIR}:
	mkdir -p ${DESTDIR}

${DESTDIR}/css: ${DESTDIR} css/*
	cp -R css ${DESTDIR}/css

${DESTDIR}/it ${DESTDIR}/en ${DESTDIR}/fr: ${DESTDIR} ${@:T}
	cp -R ${@:T} ${DESTDIR}/${@:T}

clean:
	rm -Rf ${DESTDIR}/*
