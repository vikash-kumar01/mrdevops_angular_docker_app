FROM nginx:alpine
COPY /dist/ng-k8s-example /usr/share/nginx/html


# Stage 1: Build an Angular Docker Image
FROM node as build
WORKDIR /app
COPY . . 
RUN npm install
COPY . /app
RUN npm run build --prod

# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/ng-k8s-example /usr/share/nginx/html