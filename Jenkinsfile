pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-mitisha')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t mitisha7174/litecoin:0.18.1 .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push mitisha7174/litecoin:0.18.1'
			}
		}
		
		stage('Deploy') {
       
		    steps {
	                        withKubeConfig([credentialsId: 'kubectl-cred-mitisha', serverUrl: 'https://kubernetes.docker.internal:6443']) {
                                sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
                                sh 'chmod u+x ./kubectl'  
                                sh './kubectl apply -f statefulset.yaml'
                         }          
               }
		}
      }

	post {
		always {
			sh 'docker logout'
		}
	}

}
