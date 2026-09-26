pipeline {
	agent any

	stages {
		stage ('1. Auditoria codigo (Linting)' {
		steps {
			echo 'Validando sintaxis de Terraform y Ansible...'
			dir('Terraform') {sh 'terraform validate'}
			dir('ansible') { sh 'ansible-playbook -- syntax-check playbook.yml '}
			}
		}
		stage('2. Planificacion (Terraform plan)'){
			steps {
				dir('terraform') {
				sh 'terraform init'
				sh 'terraform plan'
				}
			}
		}

	stage('3. Aprovacion Manual (Gatekeeper)') {
		steps {
			input message: 'El terraform plan se ve correcto? Aprovar infraestructura', ok: 'Aprobar y desp'
			}
		}
	stage('4. Aprovisionamiento (Terraform Apply )') {
		steps {
			dir('terraform') { sh 'terraform apply -auto-approve' 
			}
		}
	stage('5.Configuracion Ansible') {
		steps {
			dir('ansible') {
				echo 'Esperando 5 seg a que la red del servidor se estabilice'
				sleep 5
				sh 'ansible-playbook -i hosts.ini playbok.yml
				}
			}
		}
	}
}
