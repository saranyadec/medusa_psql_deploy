# medusa_psql_deploy

1.	Created a folder named medusa in my local system.
2.	Nodejs is installed and the version is verified

 

3.	Include the docker-compose file in the main directory with node directory ( install postgresql and node images).
4.	Build the docker image from docker-compose file using docker-compose up -d command Push the docker image to the DockerHub repository.
5.	Created a folder medusa_terraform .
6.	Run this terraform script using terraform init, terraform plan, terraform apply –auto-approve commands.
7.	This will create all the necessary vpc components to place the medusa backend application onto the ECS Fargate.
8.	Copy the ip where the medusa backend is running , paste it on the browser, then medusa login page will appear.
