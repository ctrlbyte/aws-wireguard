output "id" {
  description = "EC2 Instance IDs"
  value       = aws_instance.wireguard.id
}

output "public_ip" {
  description = "Public IP address assigned to EC2"
  value       = aws_instance.wireguard.public_ip
}

resource "local_file" "inventory" {
  filename = "../ansible/inventory"
  content = templatefile("inventory.tmpl", {
    wireguard_ip = aws_instance.wireguard.public_ip
    private_key  = var.ssh_private_key_path
  })
}
