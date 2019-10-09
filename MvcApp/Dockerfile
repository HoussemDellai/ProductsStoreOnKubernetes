FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY "MvcApp.csproj" .
RUN dotnet restore "MvcApp.csproj"
COPY . .
# WORKDIR "/src/MvcApp"
RUN ls
RUN dotnet build . -c Release -o /app/build
# "MvcApp.csproj" -c Release 
# -o /app/build

FROM build AS publish
RUN dotnet publish "MvcApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MvcApp.dll"]


# FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
# # FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
# # FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
# WORKDIR /app
# EXPOSE 3317
# EXPOSE 80

# FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
# # FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
# # FROM microsoft/dotnet:2.2-sdk AS build
# WORKDIR /src
# COPY "/MvcApp.csproj" "MvcApp/"
# RUN dotnet restore "MvcApp/MvcApp.csproj"
# COPY . .
# WORKDIR "/src"
# RUN dotnet build "MvcApp.csproj" -c Release -o /app

# FROM build AS publish
# RUN dotnet publish "MvcApp.csproj" -c Release -o /app

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .
# ENTRYPOINT ["dotnet", "MvcApp.dll"]