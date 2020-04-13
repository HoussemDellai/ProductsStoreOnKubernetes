FROM mcr.microsoft.com/dotnet/core/sdk:3.1.201 AS build
WORKDIR /app
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o output --no-restore

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/output/BlazorApp/dist .
COPY nginx.conf /etc/nginx/nginx.conf
RUN nginx -t
EXPOSE 80
EXPOSE 443
RUN apk add curl