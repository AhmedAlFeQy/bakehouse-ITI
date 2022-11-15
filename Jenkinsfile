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
