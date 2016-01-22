# OpenAppHack

Openapphack is an attempt to enable end to end automation of Application Development using opensource tools for provisioning , code authoring and scaffolding.

Openapphack leverages ansible and yeoman to do this. 

The goal is to get a collection of fully functional , customizable apps working on the openapphack-vm from a set of plain yaml files. 


#### What is OpenAppHack Project?


An **OpenAppHack** Project is a fork of the openhack-vm repository.

You need to make use of the openapphack ansible roles and openapphack yoeman generators and build an impressive fully functional opensource application. 

You are free to make changes to vm as long as the base vagrant box and the original bundled openapphack ansible roles are present in the finally openapphack project you setup.

This is also the Top level Repository for openapphack Project 

The others repositories used by the project are:

**Openapphack-vm** : Main repository which participants have to fork and will submit their pull requests.

**Openapphack-ansibleroles** : Repository for ansible roles that can be used by openapphack projects 

**Openapphack-yoeman-generators** : Repository for the generators. 


#### How do you start your openapphack-project?

You begin by forking an openapphack-vm and follow the instructions mentioned [here](https://github.com/WiproOpenSourcePractice/openapphack-vm/blob/master/README.md)

#### How do you test your openapphack-project?

clone your openapphack-vm associated with your githubid or org and run vagrant up , vagrant provision.

You should be able to validate and test your vm.

