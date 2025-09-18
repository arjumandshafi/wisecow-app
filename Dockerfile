FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y cowsay fortune-mod netcat-traditional dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the script
COPY wisecow.sh .

# Convert to Unix format (important for Windows users!)
RUN dos2unix wisecow.sh && chmod +x wisecow.sh

EXPOSE 4499

CMD ["./wisecow.sh"]
