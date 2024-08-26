# Fase de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Crear el proyecto dentro del contenedor
WORKDIR /src
RUN dotnet new webapi -o MyMicroservice --no-https

# Establecer el directorio de trabajo dentro del proyecto creado
WORKDIR /src/MyMicroservice

# Restaurar las dependencias (esto funciona porque el .csproj ya está en el contenedor)
RUN dotnet restore

# Copiar el archivo Program.cs corregido desde la máquina local al contenedor
COPY Program.cs /src/MyMicroservice/Program.cs

# Copiar el resto de los archivos del proyecto (si los hay)
COPY . .

# Publicar la aplicación
RUN dotnet publish -c Release -o /app

# Fase de producción
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "MyMicroservice.dll"]

