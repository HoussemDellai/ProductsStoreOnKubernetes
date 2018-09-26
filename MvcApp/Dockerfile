FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 3317
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["/MvcApp.csproj", "MvcApp/"]
RUN dotnet restore "MvcApp/MvcApp.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "MvcApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MvcApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MvcApp.dll"]