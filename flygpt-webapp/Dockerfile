# Base image
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the React app
RUN npm run build
# Expose the desired port (default is 80)
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]
