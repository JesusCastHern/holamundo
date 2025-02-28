# Usa una imagen base de Java
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo Maven Wrapper y el pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Copia el código fuente
COPY src src

# Ejecuta Maven para construir el proyecto
RUN chmod +x ./mvnw && ./mvnw -X -B -DskipTests clean install

# Expone el puerto en el que corre la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./mvnw", "spring-boot:run"]
