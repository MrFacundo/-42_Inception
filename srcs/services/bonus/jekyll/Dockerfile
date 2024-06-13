FROM alpine:3.20.0

RUN apk add --update --no-cache \
	build-base \
	ruby \
	ruby-bundler \
	ruby-dev \
	git \
	libffi-dev \
	zlib-dev \
	libxml2-dev \
	libxslt-dev \
	readline-dev \
	yaml-dev \
	zlib-dev \
	libffi-dev \
	cmake \
	libxml2-utils \
	ruby-rdoc \
	glib \
	vips-dev \
	imagemagick \
	nodejs \
	npm

WORKDIR /var/www/jekyll

RUN git clone https://github.com/MrFacundo/mrfacundo.github.io.git .

RUN gem install bundler -v 2.4.15

RUN rm Gemfile.lock

RUN bundle install

RUN npm install -g gulp-cli

RUN npm install

RUN chmod -R 777 /var/www/jekyll

EXPOSE 3000

CMD ["npm", "start"]