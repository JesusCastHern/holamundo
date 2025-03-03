# Usa una imagen base de OpenJDK 17 slim
FROM openjdk:17-slim

# Instala Maven
RUN apt-get update && apt-get install -y maven

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo Maven Wrapper y el pom.xml
COPY mvnw . 
COPY .mvn .mvn
COPY pom.xml .

# Copia el código fuente
COPY src src

# Asegura que los permisos sean correctos y ejecuta Maven para construir el proyecto
RUN chmod +x mvnw && ./mvnw -X -B -DskipTests clean install

# Expone el puerto en el que corre la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./mvnw", "spring-boot:run"]
