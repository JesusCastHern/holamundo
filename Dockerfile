# Fase de construcción
FROM eclipse-temurin:17-jdk-alpine as builder

WORKDIR /app

# Instala dependencias críticas para Alpine
RUN apk add --no-cache bash git openssh

# Copia solo los archivos necesarios para resolver dependencias primero
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Descarga dependencias y plugins (etapa separada para caché)
RUN chmod +x mvnw && \
    ./mvnw -B dependency:resolve-plugins dependency:go-offline

# Copia el código fuente
COPY src src

# Construye el proyecto
RUN ./mvnw -B -DskipTests clean package

# Fase de producción
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
