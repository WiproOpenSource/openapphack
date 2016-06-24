# Design principles

- Simplify using a provisioning tool
- Standardize roles for install speed
- Preference will be given to a single OS per role.
- All VM/Cluster will be optimized for RPIs
- Tuned each vm to run with least resource requirement.
- High availability configuration must for clusters.
- Adhere to folder structure of oah-vms, oah-cluster and oah-roles
- Should be easy to get off the island , never get stuck with a framework or provisioning tools

# oah shell

- The oah shell when installed will enable executing the oah command on the shell prompt


## oah shell Commands on host

oah help

oah version

oah install {vm_name/cluster_name}

oah reset

oah remove

oah up

oah down

oah provision

oah status

oah list {roles,vms,cluster}

oah show {roles}


## oah shell Commands on client

oah version

oah help

oah list

oah show {roles}

oah reset

oah validate

## oah shell tools Commands

oah generate-role {role_name}

oah generate-vm {vm_name}

oah generate-cluster {cluster_name}

oah generate-launcher-plugin {plugin_name}

### oah config Commands

oah config set-oah-engine {ansible| any_other_oah_engine_name}

oah config set-oah-playbook-executor {ansible-playbook| any_other_playbook_executor_name}

oah config set-oah-roles-downloader {ansible-galaxy | any_other_roles_downloader_name}

oah config set-oah-generator { yo | any_other_code_generator_name }

# OAH role Specifications

Layout :

Files :

Default Configurations:

# VM Specifications


Layout for oah-vms:

openapphack-xxxx-vm // root folder of VM
 - README.md
 - oah-config.yml
 - provisioning // folder with all playbook
  - oah-main.yml    // default playbook
  - oah-install.yml
  - oah-reset.yml
  - oah-remove.yml
  - oah-requirements.yml   
 - host // folder to run the vm on host
  - vagrant // provisioner is set to vagrant
   - vagrantfile
  - docker // provisioner is set to docker
   - dockerfile
  - runc // provisioner is set to runc
   - runcfile

Files :


Default Configurations :

- oah-config.yml

# Cluster Specifications

Layout for oah-clusters:

Files :

Default Configurations :
