pipeline {
  agent {
    docker { image 'node:16.13.1-alpine' }
  }
  stages {
    stage('checkout repo') {
      steps {
        git(url: 'https://github.com/jidegithub/nuxt-storefront', branch: 'main')
      }
    }
    stage('frontend-unit-test') {
      steps {
        sh 'node --version && npm run test'
      }
    }
  }
}