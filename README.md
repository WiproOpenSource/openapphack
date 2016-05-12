# OpenAppHack

[![Join the chat at https://gitter.im/WiproOpenSourcePractice/openapphack](https://badges.gitter.im/WiproOpenSourcePractice/openapphack.svg)](https://gitter.im/WiproOpenSourcePractice/openapphack?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Openapphack is an opensource application aggregrator.

Openapphack and its subprojects help aggregates ,validate and tests github repositories that derived from  openapphack-vm, openapphack-cluster, openapphack-pi-vm, openapphack-pi-cluster repositories

Openapphack also enables end to end automation of application deployment which can be leveraged for prototyping and distributed deployment of opensource applications . 

Openapphack uses opensource tools for provisioning , code authoring and scaffolding.

Openapphack-vms/clusters leverages vagrant, ansible ,yeoman,virtualbox and docker for automation. 

The goal is to get a collection of fully functional , customizable apps working on the [openapphack-vm](https://github.com/WiproOpenSourcePractice/openapphack-vm) from a set of plain `yaml` files. 

The broader purpose is to provide a simplified path for full stack developers to quickly get started on opensource technologies and experiment freely on opensource applications

### Index

- [What is OpenAppHack Project?](https://github.com/WiproOpenSourcePractice/openapphack#what-is-openapphack-vm-project)
- [Openapphack repositories](https://github.com/WiproOpenSourcePractice/openapphack#openapphack-repositories)
- [Contributing to this project](https://github.com/WiproOpenSourcePractice/openapphack#contributing-to-this-project)
- [How do you start your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-start-your-openapphack-project)
  - [How do you customize your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-customize-your-openapphack-project)
  - [How do you test your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-test-your-openapphack-project)
  - [How do you submit your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-submit-your-openapphack-project)


### What is OpenAppHack VM Project?

An **OpenAppHack VM Project** is a repository forked from the [openapphack-vm](https://github.com/WiproOpenSourcePractice/openapphack-vm) to your github organization or individual namespace.

You need to make use of the openapphack [ansible](http://www.ansible.com/) roles and openapphack [yeoman](http://yeoman.io/) generators and build an impressive fully functional opensource application. 

***

### Openapphack repositories 

The others repositories used by the openapphack project are:

[**Openapphack-vm**](https://github.com/WiproOpenSourcePractice/openapphack-vm) : Main repository which participants have to fork and will submit their pull requests.

[**Openapphack-ansible-roles**](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles) : Repository for ansible roles that can be used by openapphack projects, You can also add your own ansible roles that work on openapphack-vm

[**Openapphack-yeoman-generators**](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators) : Repository for the generators. You can also add your own yeoman generators that work on openapphack-vm, [more info](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators/wiki/Openapphack-Yeoman-Generators) 

***

### Contributing to this project

You can start contributing to this project by starting your own openapphack-vm or openapphack-cluster project as mentioned below.

#### How do you start your openapphack project?

You begin by forking an [openapphack-vm](https://github.com/WiproOpenSourcePractice/openapphack-vm/) and follow the instructions mentioned [here](https://github.com/WiproOpenSourcePractice/openapphack-vm/blob/master/README.md)

#### How do you customize your openapphack-project?

You are free to tweak the vm configurations as long as the base vagrant box and the openapphack vm folder structure is maintained. Any additional customization must be done only in the `yaml` files.

You are also free to add (**only add**) and include your own yeoman generator and ansible roles as long as they work together on the openapphack-vm.

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles/wiki/Openapphack-Ansible-Roles) , on how to add your own openapphack ansible role

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators/wiki/Openapphack-Yeoman-Generators) , on how to add your own openapphack yeoman generator

#### How do you test your openapphack-project?

clone your `openapphack-vm` associated with your githubid or org and run vagrant up , vagrant provision.

You should be able to validate and test your vm.

#### How do you submit your openapphack-project? ###

You will have to submit a pull request to [openapphack repository](https://github.com/WiproOpenSourcePractice/openapphack) to do so.

If you are unsure on how to make a pull request. Please refer [github's guide on creating a pull request](https://help.github.com/articles/creating-a-pull-request/) 

Do mention your github repository url and details of  any ansible or yeoman generators you have included to get your openapphack project working.


Please join the community @ https://groups.google.com/forum/#!forum/openapphack. 

If you have any questions/suggestions please email to [openapphack-queries@googlegroups.com](mailto:openapphack-queries@googlegroups.com) 

#### Interested in going the extra mile : 

If you want to contribute to the development of openapphack main project please do take a look at the [issues](https://github.com/WiproOpenSourcePractice/openapphack/issues)

You can get details on the branching model that will be followed [here] (http://nvie.com/posts/a-successful-git-branching-model/) , 


## License

This project is licensed under the MIT open source license.

## Credits

Still compiling this.. Lot of Folks to thank, we are standing on the shoulders of a lot of excellant programmers and a lot of opensource projects.

here is a [list](https://github.com/WiproOpenSourcePractice/openapphack/wiki/Opensource-Projects-that-got-us-where-we-are-,-and-keeps-us-inspired-to-do-more..).. 

