pipeline {
    agent  { label "worker1" }
    stages {
        stage('Dockerfile') {
            steps {
                sh '''
                echo "Hello world" > index.html
                cat index.html
                
                echo "FROM nginx
                COPY index.html /usr/share/nginx/html" >nginx.Dockerfile
                cat nginx.Dockerfile
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                sudo docker build -t nginx -f nginx.Dockerfile .
                sudo docker images
                '''
            }
        }
        stage('run') {
            steps {
                sh '''
                sudo docker run -p 80:80 -d --name=nginx nginx
                sudo docker ps -a
                '''
            }
        }
    }