# 1. Base Image
FROM python:3.10-slim

# 2. Install Dependencies
# We need gcc/make to *build* the C program.
# We need nginx/openssl to *run* the server.
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    nginx \
    openssl \
  && rm -rf /var/lib/apt/lists/*

# 3. Set up working directory
WORKDIR /opt/fractal-engine

# 4. Copy project files
# Copy C source and Makefile first to leverage Docker cache
COPY c_src/ /opt/fractal-engine/c_src/

# Copy the rest of the app
COPY app/ /opt/fractal-engine/app/
COPY config/ /opt/fractal-engine/config/
COPY entrypoint.sh /opt/fractal-engine/

# 5. Compile the C utility
# This runs the 'all' target in the Makefile
RUN cd /opt/fractal-engine/c_src && make

# 6. Install Python dependencies
# We just need Flask (for the app) and Gunicorn (as the server)
RUN pip install flask gunicorn

# 7. Expose ports (443 for Nginx)
EXPOSE 443

# 8. Make entrypoint executable
RUN chmod +x /opt/fractal-engine/entrypoint.sh

# 9. Run the entrypoint script
ENTRYPOINT ["/opt/fractal-engine/entrypoint.sh"]







