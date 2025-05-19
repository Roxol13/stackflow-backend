# Usa una imagen de Maven para construir el proyecto
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Usa una imagen de Java para ejecutar el jar
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Usa el puerto asignado por Render
ENV PORT=8080
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
