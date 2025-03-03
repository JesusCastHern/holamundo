# Fase de construcción con JDK y Maven
FROM eclipse-temurin:17-jdk-alpine as builder

WORKDIR /app

# Copia solo los archivos necesarios para descargar dependencias
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Instala git y bash (requeridos para Maven Wrapper en Alpine)
RUN apk add --no-cache git bash

# Descarga dependencias y construye el proyecto
RUN chmod +x mvnw && \
    ./mvnw -B dependency:go-offline && \
    ./mvnw -B -DskipTests clean package

# Fase final con JRE mínimo
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copia el JAR desde la fase de construcción
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

# Ejecuta el JAR directamente (mejor para producción)
CMD ["java", "-jar", "app.jar"]
