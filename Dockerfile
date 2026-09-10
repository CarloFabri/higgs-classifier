# Dockerfile.copy - this is a comment and will# Use Python 3.11 slim as base image
FROM python:3.11-slim

# Build as root
USER root

# Install system dependencies
RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies via pip
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt 
    
# Create unprivileged user
RUN useradd -m docker

# Copy project files
COPY README.md higgs_BDT.ipynb higgs_DNN.ipynb /home/docker/

# Set working directory
WORKDIR /home/docker

# Switch to unprivileged user
USER docker

# Start Jupyter notebook by default
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--notebook-dir=/home/docker"]
