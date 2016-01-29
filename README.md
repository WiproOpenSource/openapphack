# OpenAppHack

Openapphack is an attempt to enable end to end automation of Application Development using opensource tools for provisioning , code authoring and scaffolding.

Openapphack leverages vagrant, ansible and yeoman to do this. 

The goal is to get a collection of fully functional , customizable apps working on the openapphack-vm from a set of plain yaml files. 


#### What is OpenAppHack Project?

An **OpenAppHack Project** is a repository forked from the [openapphack-vm](https://github.com/WiproOpenSourcePractice/openapphack-vm) to your github organization or individual namespace.

You need to make use of the openapphack ansible roles and openapphack yoeman generators and build an impressive fully functional opensource application. 

#### Openapphack repositories 

The others repositories used by the openapphack project are:

[**Openapphack-vm**](https://github.com/WiproOpenSourcePractice/openapphack-vm) : Main repository which participants have to fork and will submit their pull requests.

[**Openapphack-ansibleroles**](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles) : Repository for ansible roles that can be used by openapphack projects , You can also add your own ansible roles that work on openapphack-vm

[**Openapphack-yoeman-generators**](https://github.com/WiproOpenSourcePractice/openapphack-yoeman-generators) : Repository for the generators. You can also add your own yoeman generators that work on openapphack-vm, [more info](https://github.com/WiproOpenSourcePractice/openapphack-yoeman-generators/wiki/Openapphack-Yoeman-Generators) 


#### Contributing to this projects

You can start contributing to this project by starting your own openapphack project as mentioned below.

#### How do you start your openapphack-project?

You begin by forking an openapphack-vm and follow the instructions mentioned [here](https://github.com/WiproOpenSourcePractice/openapphack-vm/blob/master/README.md)


#### How do you customize your openapphack-project?

You are free to tweak the vm configurations as long as the base vagrant box and the openapphack vm folder structure is maintained.Any additional customization must be done only in the yaml files.

You are also free to add (**only add**) and include your own yeoman generator and ansbile roles as long as they work together on the openapphack-vm.

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles/wiki/Openapphack-Ansible-Roles) , on how to add your own openapphack ansible role

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-yoeman-generators/wiki/Openapphack-Yoeman-Generators) , on how to add your own openapphack yoeman generator


#### How do you test your openapphack-project?

clone your openapphack-vm associated with your githubid or org and run vagrant up , vagrant provision.

You should be able to validate and test your vm.

#### How do you submit your openapphack-project? ###

You will have to submit a pull request to [openapphack repository](https://github.com/WiproOpenSourcePractice/openapphack) to do so.

Do mention your github repository url and details of  any ansible or yoeman generators you have included to get your openapphack project working.


Please join the community https://groups.google.com/forum/#!forum/openapphack. If you have any questions/suggestions please email to openapphack-queries@googlegroups.com 
