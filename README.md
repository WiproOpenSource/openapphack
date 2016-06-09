# OpenAppHack

[![Join the chat at https://gitter.im/WiproOpenSourcePractice/openapphack](https://badges.gitter.im/WiproOpenSourcePractice/openapphack.svg)](https://gitter.im/WiproOpenSourcePractice/openapphack?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Openapphack is an opensource application aggregrator.

Simplifies experimenting with opensource application . OpenAppHack projects can be used for testing and rapid prototyping of opensource solutions . OpenAppHack projects can also be run on low cost RPI cluster

The broader purpose is to provide a simplified path for full stack developers to quickly get started on opensource technologies and experiment freely on opensource applications

### Index

- [What is OpenAppHack Project?](https://github.com/WiproOpenSourcePractice/openapphack#what-is-openapphack-vm-project)
- [Openapphack repositories](https://github.com/WiproOpenSourcePractice/openapphack#openapphack-repositories)
- [Contributing to this project](https://github.com/WiproOpenSourcePractice/openapphack#contributing-to-this-project)
- [How do you start your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-start-your-openapphack-project)
  - [How do you customize your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-customize-your-openapphack-project)
  - [How do you test your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-test-your-openapphack-project)
  - [How do you submit your openapphack-project?](https://github.com/WiproOpenSourcePractice/openapphack#how-do-you-submit-your-openapphack-project)


### What is OpenAppHack Project?

An openapphack project is a git repository derived from one of the openapphack vm or cluster project templates

Openapphack and its subprojects help aggregate ,validate and test github repositories that derived from  openapphack-vm, openapphack-cluster, openapphack-pi-vm, openapphack-pi-cluster repositories

Openapphack also enables end to end automation of application deployment which can be leveraged for prototyping and distributed deployment of opensource applications . 

Openapphack uses opensource tools for provisioning , code authoring and scaffolding.

The project templates are

- openapphack-vm  : Template used for setting up a single openapphack vm. 
- openapphack-pi-vm :Template used for setting up a single openapphack vm on RPI's.
- openapphack-cluster : Template used for setting up multi or  load balanced/ HA cluster for the application.
- openapphack-pi-cluster : Template used for setting up multi or  load balanced /HA cluster on openapphack RPI cluster.

All openapphack projects github repositories must follows a naming convention and github repository names must end with either an xxx-vm, xxx-pi-vm ,xxx-pi-cluster or xxx-cluster to be picked up by the openapphack for analysis and testing.  

Openapphack-vms/clusters leverages vagrant, ansible ,yeoman,virtualbox and docker for automation. 

***

### Openapphack subprojects and repositories 

**Openapphack core projects**

[**Openapphack-shell(oah)**](https://github.com/WiproOpenSourcePractice/openapphack-shell) : Shell for openapphack.. 

[**OpenAppHack-launcher(oah-app)**](): Openapphack Launcher 

[**Openapphack-stats**](https://github.com/WiproOpenSourcePractice/openapphack-stats) : The repository that will be updated periodically with test results and details from validated openapphack-vm/clusters.. 

**Openapphack Template Projects**

[**Openapphack-vm**](https://github.com/WiproOpenSourcePractice/openapphack-vm) : The repository from which all openapphack-xxx-vm repos are derived. 

[**Openapphack-cluster**](https://github.com/WiproOpenSourcePractice/openapphack-cluster) : The repository from which all openapphack-xxx-cluster repos are derived.. 

[**Openapphack-pi-vm**](https://github.com/WiproOpenSourcePractice/openapphack-pi-vm) : The repository from which all openapphack-xxx-pi-vm repos are derived. 

[**Openapphack-pi-cluster**](https://github.com/WiproOpenSourcePractice/openapphack-pi-cluster) : The repository from which all openapphack-xxx-pi-cluster repos are derived.. 

**Openapphack Extension Projects**

This includes the various git repositories 

- openapphack-XXXX-launcher-plugins(oah-launcher-plugins),
- ansible-role-openapphack-XXXX (oah-ansible-roles),
- openapphack-XXXX-vm (oah-vms),
- openapphack-XXXX-cluster (oah-clusters),
- openapphack-XXXX-recipes (oah-recipes),
- openapphack-XXXX-pi-cluster (oah-pi-clusters),
- openapphack-XXXX-pi-vm (oah-pi-vms)

**Openapphack dev tools projects**

[**Openapphack-ansible-roles**](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles) : Repository used to organize all openapphack ansible roles . These can be used by openapphack projects, You can also add your own ansible roles that work on openapphack-vm

[**Openapphack-yeoman-generators**](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators) : Repository used to organize  all yeoman generators used by openapphack vm/clusters. You can also add your own yeoman generators that work on openapphack-vm, [more info](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators/wiki/Openapphack-Yeoman-Generators) 

[**generator-openapphack**](https://github.com/WiproOpenSourcePractice/generator-openapphack) : Yeoman generator to generate openapphack vms/clusters , would be reorganized under openapphack-tools.. 

***
### Openapphack PI Cluster

An openapphack-pi-cluster can be used to test your openapphack pi-vm/cluster projects



### Contributing to this project

You can start contributing to this project by starting your own openapphack-vm or openapphack-cluster project as mentioned below.

#### How do you start your openapphack project?

You begin by forking an [openapphack-vm](https://github.com/WiproOpenSourcePractice/openapphack-vm/) and follow the instructions mentioned [here](https://github.com/WiproOpenSourcePractice/openapphack-vm/blob/master/README.md)

#### How do you customize your openapphack-project?

You are free to tweak the vm configurations as long as the base vagrant box and the openapphack vm folder structure is maintained. Any additional customization must be done only in the `yaml` files.

You are also free to add (**only add**) and include your own yeoman generator and ansible roles as long as they work together on the openapphack-vm.

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-ansible-roles/wiki/Openapphack-Ansible-Roles) , on how to add your own openapphack ansible role

Please take a look [here](https://github.com/WiproOpenSourcePractice/openapphack-yeoman-generators/wiki/Openapphack-Yeoman-Generators) , on how to add your own openapphack yeoman generator


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

