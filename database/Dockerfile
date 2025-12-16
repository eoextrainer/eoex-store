# EOEX Store Database Dockerfile
FROM mysql:8.0
ENV MYSQL_DATABASE=eoex_store
ENV MYSQL_ROOT_PASSWORD=password
COPY schema.sql /docker-entrypoint-initdb.d/
COPY seed.sql /docker-entrypoint-initdb.d/
EXPOSE 3306
