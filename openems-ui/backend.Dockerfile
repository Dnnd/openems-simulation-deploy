FROM node:11.9.0-alpine as build-stage


RUN apk update && apk add git

RUN git clone --branch '2019.1.0b' https://github.com/Dnnd/openems.git

WORKDIR /openems/ui

RUN npm i -g  @angular/cli
RUN npm install
ADD backend_environment.ts src/environments/environment.ts
RUN ng build --prod -c backend

FROM nginx:1.14.2-alpine
COPY --from=build-stage /openems/ui/target/backend /usr/share/nginx/html
ADD nginx.conf /etc/nginx/conf.d/nginx.conf
