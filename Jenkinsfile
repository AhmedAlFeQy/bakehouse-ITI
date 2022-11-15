pipeline {
  agent { label "slave"}
  stages {
    stage('build') {
      steps {
        script {
       
            withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'username', passwordVariable: 'password')]) {
              sh """
        
                  docker login -u ${username} -p ${password}
                  docker build -t ahmedalfeqy/vfbakehouse:${BUILD_NUMBER} .
                  docker push ahmedalfeqy/vfbakehouse:${BUILD_NUMBER}
              """
          }
        } 
      }
    }
    stage('deploy') {
    
      steps {
        script {
          
              sh """ 
                 USER ROOT
                 apt-get install apt-transport-https ca-certificates gnupg 
                 echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
                 curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
                 apt-get update -y && apt-get install google-cloud-cli -y 
              
              
                 """          
            withCredentials([file(credentialsId: 'key', variable: 'sa')]) {
              sh """
                  gcloud auth activate-service-account manage-sa@feki-368302.iam.gserviceaccount.com --key-file ${sa}
        
                """
            }
          
          
            withCredentials([file(credentialsId: 'kube', variable: 'KUBECONFIG')]) {
              sh """
           
                  kubectl apply -f Deployment --kubeconfig=${KUBECONFIG}
                """
            }
        }
      }
    }
  }
}
