# FractalEngine

**FractalEngine** is a high-performance, containerized web API that uses a C-based backend for heavy computational feature extraction, which is then fed into a Python machine learning model.

This project serves as a showcase for a "polyglot" architecture, combining the strengths of C (raw speed) with Python (ease of use, web frameworks, ML) and wrapping the entire service in a secure, production-ready environment using Nginx and Docker.

## 🚀 Key Features

* **Secure API:** Serves traffic over HTTPS using Nginx with an OpenSSL self-signed certificate.
* **Hybrid Computation:** A Python Flask API handles web requests but delegates heavy numerical computation (Mandelbrot set iteration) to a compiled C program.
* **ML Integration:** The C program's output is used as a real-time feature for a mock ML model.
* **Containerized:** Fully containerized with Docker for consistent, isolated, and portable deployment.
* **Automated Build:** Uses `make` and `gcc` within the Docker build process to compile the C utility.
* **Orchestrated Startup:** A custom Bash script (`entrypoint.sh`) manages certificate generation and service startup.
* **Version Controlled:** Configured for Git, with a `.gitignore` to exclude build artifacts.

## 💻 Technology Stack

* **Containerization:** Docker
* **Web Server / Proxy:** Nginx
* **SSL/TLS:** OpenSSL
* **Application Backend:** Python 3.10 (with Flask & Gunicorn)
* **High-Performance Core:** C (compiled with `gcc` & `make`)
* **Orchestration:** Bash Scripting
* **Version Control:** Git

## 🏃 How to Run

1.  **Initialize Git (Recommended):**
    ```bash
    git init
    git add .
    git commit -m "Initial commit"
    ```

2.  **Build the Docker Image:**
    ```bash
    docker build -t fractal-engine .
    ```

3.  **Run the Docker Container:**
    ```bash
    docker run -d -p 443:443 --name fractal-api fractal-engine
    ```
    * `-d` runs it in detached mode.
    * `-p 443:443` maps your local port 443 to the container's port 443 (for HTTPS).
    * `--name fractal-api` gives your running container a friendly name.

4.  **Check Logs (Optional):**
    To see the startup process (cert generation, Nginx/Gunicorn logs):
    ```bash
    docker logs -f fractal-api
    ```

## 🧪 How to Use

You can now send requests to the secure API. Since we use a self-signed certificate, you must use the `-k` (or `--insecure`) flag with `curl` to skip certificate validation.

### Example 1: A point *in* the set (deep computation)

This point takes 1000 iterations and is classified as "Zone 0".

```bash
curl -k -X POST https://localhost/predict \
     -H "Content-Type: application/json" \
     -d '{"x": 0.1, "y": 0.2}'























