resource "null_resource" "ansible_provisioner" {

  provisioner "local-exec" {
    command = "cd ansible && sudo ansible-playbook playbook.yml"
  }

}