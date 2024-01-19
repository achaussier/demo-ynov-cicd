FROM node:21.6.0-alpine3.19 AS build

# Create application folder
RUN mkdir -p /app
WORKDIR /app

# Manage app dependecies
COPY package*.json ./
RUN npm install

# Copy application
COPY ./src ./src
COPY ./public ./public

# Build application
RUN npm run build

FROM nginx:1.21.6-alpine

COPY --from=build /app/build /usr/share/nginx/html
