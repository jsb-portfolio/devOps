# Use the Debian slim image as the base
FROM mcr.microsoft.com/devcontainers/base:debian

# Set the timezone as environment variable (optional)
ENV TZ=America/Vancouver

# Add apt repositories
# RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update

# Install common dependencies

# Install Terraform
RUN apt-get install -y wget gnupg ca-certificates lsb-release && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform

# Install Azure CLI for login
RUN apt-get install -y curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install Ansible
RUN apt-get install -y software-properties-common && \
    apt-get install -y ansible

# Clean up to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# # Set working directory (optional)
# WORKDIR /workspace