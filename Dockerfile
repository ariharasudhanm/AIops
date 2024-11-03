FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

# Add metadata
LABEL authors="ari"

# Set timezone to prevent interactive prompt
ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies and Python without interactive prompts
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    python3-pip python3-dev python3-opencv tzdata && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .


# Default command to run the inference script
CMD ["python3", "inference.py"]

