Step 1: Build the JAR File
Package your application into a JAR file using Maven:

sh
Copy code
mvn clean package
This will create a JAR file in the target directory, typically named helloworld-0.0.1-SNAPSHOT.jar.

Step 2: Build the Docker Image
Build a Docker image for your application:

sh
Copy code
docker build -t helloworld:latest .
This command will build the Docker image using the Dockerfile and tag it as helloworld:latest.

Step 3: Run the Docker Container
Run a container from the Docker image you just created:

sh
Copy code
docker run -p 8080:8080 helloworld:latest
This command maps port 8080 on your local machine to port 8080 in the Docker container, allowing you to access the application at http://localhost:8080/hello.

Step 4: Verify the Application
Navigate to http://localhost:8080/hello in your web browser. You should see the styled "Hello, World!" page as before.