# build environment
FROM node:14.19.0-alpine as build
WORKDIR /app
RUN apk add --no-cache git
ENV PATH /app/node_modules/.bin:$PATH
COPY . ./

# production environment
FROM nginx:stable-alpine
COPY --from=build /app /usr/share/nginx/html
# new
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]