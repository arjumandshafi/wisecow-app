# Wisecow DevOps Practical Assessment

This repository contains the source code, Dockerfile, Kubernetes manifests, and CI/CD workflow for the Wisecow application deployed on Kubernetes with TLS-secured ingress.

## 1️⃣ Clone Repository

git clone https://github.com/arjumandshafi/wisecow-app.git

cd wisecow-app

2️⃣ Docker commands:

Build Docker Image:

docker build -t arjumandshafi/wisecow:latest .

Run Docker Container Locally:

docker run -p 4499:4499 arjumandshafi/wisecow:latest

Push Image to Docker Hub:

docker push arjumandshafi/wisecow:latest

3️⃣ Kubernetes & Minikube:

Start Minikube:

minikube start

Verify Cluster:

kubectl cluster-info

kubectl get nodes

Deploy Application:

kubectl apply -f k8s/deployment.yaml

kubectl apply -f k8s/service.yaml

kubectl apply -f k8s/ingress.yaml

Check Pods and Services:

kubectl get pods

kubectl get svc

Access the Application:

minikube service wisecow-service

4️⃣ TLS Setup

Generate Self-Signed Certificate:

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=wisecow.local"

Create Kubernetes TLS Secret:

kubectl create secret tls wisecow-tls --cert=tls.crt --key=tls.key

5️⃣ GitHub Actions CI/CD

Setup GitHub Secrets:

Add the following secrets in your GitHub repository settings:

DOCKER_USERNAME

DOCKER_PASSWORD

KUBECONFIG_DATA 

Push Workflow File to github:

git add .github/workflows/ci-cd.yaml

git commit -m "Add CI/CD workflow"

git push origin main

The GitHub Actions workflow will automatically:

Build Docker image

Push to Docker Hub

Deploy to Kubernetes cluster

6️⃣ Optional: System & Application Health Scripts

Make scripts executable and run for monitoring:

bash health_checker.sh

bash resource_analyser.sh

bash resource_monitor.sh

7️⃣ # Optional: KubeArmor Policy

# Install kubearmor

kubectl apply -f https://kubearmor.com/deploy/kubearmor.yaml

# Apply zero-trust policy

kubectl apply -f policy/policy-deny-exec.yaml

# Test policy violations kubectl exec -it <wisecow-pod-name> -- /bin/bash

Run blocked commands to verify enforcement

✅ Notes

Replace with your Docker Hub username.

Make sure GitHub secrets are correctly set before pushing workflow.
