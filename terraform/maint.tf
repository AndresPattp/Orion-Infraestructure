provider "local" {}

#1. Simular creacion de un servidor (como si fuera EC2 AWS)

resource "local_file" "servidor_produccion" {
	content = "Servidor Ubuntu 24.04 -IP: 192.168.1.100"
	filename = "${path.module}/servidor_simulado.txt"
}

#2. Puente de conexion Tfm Asb , crear host.ini para ansible 
resource "local_file" "generar_inventario_ansible"{
	content = <<EOF
[produccion]
localhost ansible_connection=local

[produccion:vars]
entorno=produccion_critica
EOF

	filename = "../ansible/hosts.ini"
#Obligando a terraform a crear el servidor PRIMERO
depends_on =[local_file.servidor_produccion]
} 
