# ---------- build stage ----------
FROM node:lts AS build
ENV NODE_ENV=production
WORKDIR /app

# Enable pnpm via corepack
RUN corepack enable

# Install deps using the lockfile only
COPY pnpm-lock.yaml package.json ./
RUN pnpm install --frozen-lockfile

# Copy the rest and build
COPY . .
RUN pnpm run build

# ---------- runtime stage ----------
FROM nginx:alpine AS runtime

# Nginx config
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Static site
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

# Simple healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
