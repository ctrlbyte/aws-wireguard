## Streamlining Wireguard Deployment on AWS with DevOps Practices

These are going to be a bunch of quick (and messy) notes on what I'm doing.

Goal here is to quickly deploy a WireGuard (WG) server on an EC2 instance using Terraform for infrastructure provisioning and Ansible for configuration management. 

Ansible playbook will return the WG .conf(s) and PNGs for access. The number of peers specified can be set in the `docker-compose` file under the ansible directory.

### AWS:
#### Requirements

- Terraform v1.1.x
- Ansible (+ ansible-playbook) 2.11.X
- Wireguard
- AWS Account (key pair generated in AWS should be called `aws-wireguard` and download the generated PEM file)

#### Steps

**Terraform**

1) Clone the repo.
2) In infra/, create `terraform.tfvars` filled out accordingly from variables listed in `terraform.tfvars.tmpl`
3) In infra/, run `terraform init` to initialize terraform project
4) Run `terraform apply` to run terraform plan. Resources should be displayed on AWS console. Additionally, note the IP address output by terraform.
5) Once provisioned, you should be able to run `ssh ubuntu@<IP> -i /path/to/PEM`
6) When done, run `terraform destroy` to destroy resources.

**Ansible**
1) Run `ansible-galaxy install geerlingguy.security` and `ansible-galaxy install geerlingguy.ntp`
1) Run `ansible-playbook setup.yml`
2) Wait for the playbook to finish executing. When complete, peer configs copied to `peers/` directory.

**Wireguard**
1) To test wireguard connection, see docs.
2) Quicktest on linux: `sudo wg-quick up ansible/peers/<PEER_X>.conf`
3) Test ping: `ping 10.6.0.1`. Response back indicates successful connection.
4) To disconnect: `sudo wg-quick down ansible/peers/<PEER_X>.conf`
5) Alternative test: Download wireguard mobile application. Scan png in peer directory. 

