pipeline {
  options { timestamps () }
  agent any
  parameters {
      choice(name: 'choice', choices: ['dev', 'qa'], description: 'Choose any one')
      choice(name: 'BRANCH', choices: ['master', 'test'], description: 'Choose any one')
}
  stages {
    stage('Cloning Git') {
     steps {
          script {
                def scmVars = checkout([$class: 'GitSCM',
                    branches: [[name: "${params.BRANCH}"]],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[$class: 'LocalBranch']],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        credentialsId: 'shaktiug',
                        url: 'https://github.com/shaktiug/shark-app.git'
                        ]]])
                //env.commit = sh(label: 'getCommit', returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        }
      }
   }

    stage('deploy'){
        steps {
            sh "./dev.sh"

          }
    }


}
}
