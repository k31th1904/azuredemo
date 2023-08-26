resource "local_file" "inventory" {
  filename = "ansible/hosts"
  content  = <<-EOF
    [windows]
    ${join("\n", var.windows_vm_fqdn)}

    [windows:vars]
    ansible_user = ${var.windows_var.user}
    ansible_password = ${var.windows_var.password}
    ansible_connection = winrm
    ansible_port = 5985
    ansible_winrm_transport = ntlm
    ansible_winrm_server_cert_validation = ignore
    ansible_become = True
    
    EOF
}


