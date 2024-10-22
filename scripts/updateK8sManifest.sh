#!/bin/bash

set -x

# Check for required arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <deployment-name> <docker-image-name> <docker-image-tag>"
    exit 1
fi

# Set the repository URL
REPO_URL="https://$GITHUB_TOKEN@github.com/thedevops-mohi/java-app.git"

# Remove existing directory if it exists
if [ -d "/home/jenkins/repo" ]; then
    rm -rf /home/jenkins/repo
fi

# Clone the git repository into the /home/jenkins/repo directory
git clone "$REPO_URL" /home/jenkins/repo

# Navigate into the cloned repository directory
cd /home/jenkins/repo || { echo "Failed to navigate to repository"; exit 1; }

# Check if the deployment file exists
DEPLOYMENT_FILE="k8s-yamls/$1-deployment.yaml"
if [ ! -f "$DEPLOYMENT_FILE" ]; then
    echo "Deployment file $DEPLOYMENT_FILE does not exist."
    exit 1
fi

# Set Git user configuration
git config --global user.email "jenkins@example.com"
git config --global user.name "Jenkins"

# Make changes to the Kubernetes manifest file(s)
echo "Updating image in $DEPLOYMENT_FILE"
sed -i "s|image: .*|image: auwalu5/java_app:$2|g" "$DEPLOYMENT_FILE"

# Check for changes
if ! git diff-index --quiet HEAD --; then
    # Add the modified files
    git add .

    # Commit the changes
    git commit -m "Update Kubernetes manifest"

    # Pull the latest changes before pushing
    git pull --rebase origin main

    # Push the changes back to the repository
    git push -u origin --all 
else
    echo "No changes to commit."
fi

# Cleanup: remove the temporary directory
rm -rf /home/jenkins/repo
