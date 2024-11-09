# Step 1: Build stage
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Install dependencies and build the project
RUN yarn install
RUN yarn build

# Step 2: Serve stage
FROM nginx:1.24

# Copy built files to Nginx HTML directory
COPY --from=build /app/dist/ /usr/share/nginx/html/Subscription-conversion

# Expose port 80 for the application
EXPOSE 80

# Run Nginx in the foreground
CMD [ "nginx", "-g", "daemon off;" ]
