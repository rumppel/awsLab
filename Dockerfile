FROM nginx:alpine

EXPOSE 80

WORKDIR /usr/share/nginx/html

COPY ./index.html ./index.html
COPY ./styles.css ./styles.css
COPY ./index.js ./index.js