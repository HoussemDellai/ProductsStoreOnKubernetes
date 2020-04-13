FROM mcr.microsoft.com/dotnet/core/sdk:3.1.201 AS build
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1.100-preview3 AS build
WORKDIR /app
COPY . .
#RUN dotnet restore
RUN dotnet publish -c Release
RUN ls
#RUN ls output

FROM nginx:alpine
COPY --from=build /app/bin/Release/netstandard2.1/publish/wwwroot /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

#WORKDIR /usr/share/nginx/html
#COPY --from=build /app/bin/Release/netstandard2.1/publish .
##COPY --from=build /app/output .
##COPY --from=build /app/output/BlazorApp/dist .
#COPY nginx.conf /etc/nginx/nginx.conf
RUN nginx -t
EXPOSE 80
#EXPOSE 443
RUN apk add curl