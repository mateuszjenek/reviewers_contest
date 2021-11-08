FROM nginx:stable

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v
RUN flutter channel master & flutter upgrade & flutter config --enable-web

RUN mkdir /app/
COPY . /app/
WORKDIR /app

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

ENTRYPOINT ["/app/docker/entrypoint.sh"]
