FROM node:14 as builder
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build

################

FROM nginx:alpine as production
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
