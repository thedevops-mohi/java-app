#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://$GITHUB_TOKEN@github.com/thedevops-mohi/java-app.git"

mkdir -p /tmp/temp/
# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp/

# Navigate into the cloned repository directory
cd /tmp/temp/

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: auwalu5/java_app:$2|g" k8s-yamls/$1-deployment.yaml

git status

# Add the modified filess
git add k8s-yamls/$1-deployment.yaml

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push -u origin  --all 

# Cleanup: remove the temporary directory
rm -rf /tmp/temp/