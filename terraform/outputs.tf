output "flask_server_public_ip" {
  value = aws_instance.flask.public_ip
}

output "master_public_ip" {
  value = aws_instance.master.public_ip
}

output "replica_public_ip" {
  value = aws_instance.replica.public_ip
}

output "master_private_ip" {
  value = aws_instance.master.private_ip
}

output "replica_private_ip" {
  value = aws_instance.replica.private_ip
}