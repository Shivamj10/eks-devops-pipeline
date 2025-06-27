# -------- STAGE 1: Build and prepare app --------
FROM node:18 AS build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# -------- STAGE 2: Run on a minimal base --------
FROM node:18-slim

WORKDIR /app

# Only copy what's needed
COPY --from=build /app .

EXPOSE 3000
CMD ["npm", "start"]
