#!/bin/bash
# ============================================================
# deploy.sh — Runs ON AWS EC2 via GitHub Actions SSH
# Purpose  — Pull latest Docker image and restart container
# Called by — .github/workflows/docker.yml (Job 2)
# ============================================================

# set -e = if ANY command fails, stop the script immediately
# set -u = if ANY variable is undefined, stop the script
# Why? — prevents silent bugs where script continues after failure
set -eu

# ────────────────────────────────────────────────────────────
# VARIABLES
# These 3 variables come from docker.yml as environment variables
# docker.yml sets them before calling this script
# ────────────────────────────────────────────────────────────

# Who is logging into Docker Hub
# Value: zubair624 (comes from GitHub Secret DOCKERHUB_USERNAME)
DOCKERHUB_USERNAME=${DOCKERHUB_USERNAME}

# The password/token for Docker Hub login
# Value: your token (comes from GitHub Secret DOCKERHUB_TOKEN)
DOCKERHUB_TOKEN=${DOCKERHUB_TOKEN}

# The full image name to pull from Docker Hub
# Value: zubair624/docker-nodejs-aws-cicd:latest (comes from docker.yml env)
DOCKER_IMAGE=${DOCKER_IMAGE}

# The name of the container running on EC2
# This is fixed — always the same name on your EC2
CONTAINER_NAME="zubair-node-api"

# The port your Node.js app listens on
# Left side  = EC2 port (what the outside world sees)
# Right side = container port (what the app runs on inside)
HOST_PORT=3000
CONTAINER_PORT=3000

# ────────────────────────────────────────────────────────────
# STEP 1 — LOGIN TO DOCKER HUB
# EC2 needs to login before it can download (pull) any image
# echo pipes the token into docker login without showing it on screen
# --password-stdin = read password from echo, not keyboard (safer)
# ────────────────────────────────────────────────────────────
echo "Logging in to Docker Hub..."
echo "${DOCKERHUB_TOKEN}" | docker login \
    --username "${DOCKERHUB_USERNAME}" \
    --password-stdin

# ────────────────────────────────────────────────────────────
# STEP 2 — PULL LATEST IMAGE FROM DOCKER HUB
# Downloads the newest Docker image that GitHub Actions just pushed
# This is the image built from your latest code
# ────────────────────────────────────────────────────────────
echo "Pulling latest image: ${DOCKER_IMAGE}..."
docker pull "${DOCKER_IMAGE}"

# ────────────────────────────────────────────────────────────
# STEP 3 — STOP OLD CONTAINER
# Stops the currently running container
# || true = if no container is running, dont fail — just continue
# Why? — first time deploy, no old container exists yet
# ────────────────────────────────────────────────────────────
echo "Stopping old container..."
docker stop "${CONTAINER_NAME}" || true

# ────────────────────────────────────────────────────────────
# STEP 4 — REMOVE OLD CONTAINER
# Deletes the stopped container so we can create a fresh one
# || true = same reason as above — if nothing to remove, continue
# Note: this removes the container NOT the image
# ────────────────────────────────────────────────────────────
echo "Removing old container..."
docker rm "${CONTAINER_NAME}" || true

# ────────────────────────────────────────────────────────────
# STEP 5 — START NEW CONTAINER
# Creates and starts a brand new container from the new image
#
# -d                    = run in background (detached mode)
#                         terminal stays free, container keeps running
# --name                = give the container a name so we can manage it
# -p HOST:CONTAINER     = map EC2 port 3000 to container port 3000
#                         so browser can reach the app
# --restart unless-stopped = auto restart container if EC2 reboots
#                            only stops if you manually stop it
# "${DOCKER_IMAGE}"     = which image to use for this container
# ────────────────────────────────────────────────────────────
echo "Starting new container..."
docker run -d \
    --name "${CONTAINER_NAME}" \
    -p "${HOST_PORT}":"${CONTAINER_PORT}" \
    --restart unless-stopped \
    "${DOCKER_IMAGE}"

# ────────────────────────────────────────────────────────────
# STEP 6 — CLEANUP OLD IMAGES
# Removes old unused Docker images from EC2 disk
# Every deploy creates a new image — old ones pile up and waste space
# -f = force, dont ask for confirmation
# ────────────────────────────────────────────────────────────
echo "Cleaning up old images..."
docker image prune -f

# ────────────────────────────────────────────────────────────
# STEP 7 — CONFIRM SUCCESS
# curl fetches the EC2 public IP from AWS metadata service
# 169.254.169.254 = special AWS address that only works from inside EC2
# /latest/meta-data/public-ipv4 = returns the public IP of this EC2
# ────────────────────────────────────────────────────────────
echo "Deployment successful!"
echo "App is running at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):${HOST_PORT}"