pipeline {
    agent { label 'Agent_1' }
    stages {
        stage('build') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "dockerhub" , usernameVariable: 'USER' , passwordVariable: 'PASS')]){
                        sh """
                            docker login -u ${USER} -p ${PASS}
                            docker build -t ahmedalfeqy/helm-bakehouse:${BUILD_NUMBER} .
                            docker push ahmedalfeqy/helm-bakehouse$:${BUILD_NUMBER}
                            echo ${BUILD_NUMBER} > ../build.txt
                           """
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                      withCredentials([file(credentialsId: "kube" , variable: 'CONFIG' )]){
                        sh """
                            export BUILD_NUMBER=\$(cat ../build.txt)
                            cat bakehouse-helm/templates/deploy.yaml | envsubst > bakehouse-helm/templates//deploy.tmp
                            mv bakehouse-helm/templates/deploy.tmp bakehouse-helm/templates/deploy.yaml
                            helm install bakehouse-app ./bakehouse-helm --kubeconfig=${CONFIG}
                           """
                      }
                }
            }
        }
    }
}