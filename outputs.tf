output "tags" {
  description = "List of tags of instances"
  value       = ["${aws_instance.instance.*.tags}"]
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_instance.instance.*.public_ip}"]
}
