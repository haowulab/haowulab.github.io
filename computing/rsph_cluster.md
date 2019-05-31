---
layout: page
title: Using the RSPH cluster
description: Using the RSPH cluster
---


All following tips are based on using terminal on Mac OS. I believe it will work for any linux system. For Windows, one needs to install some type of Unix-like systems, such as [Cygwin](https://www.cygwin.com).

### Basic information 

Here is the [official RSPH cluster page](http://intranet.sph.emory.edu/docuwiki/doku.php?id=cluster_orientation) provided by the RSPH IT. 

If you want to access the cluster from outside the School of Public Health (this includes using laptop through Emory wifi), you will need connect through the Emory VPN.  


### Login to the RSPH cluster

Address for the RSPH cluster is ``hpc4.sph.emory.edu``. 
Login commmand is 

```
ssh -X userid@hpc4.sph.emory.edu
``` 

Here ``userid`` needs to be replaced by your login. 

I usually create an alias by adding the following line to my ``.bash_profile``:

```
alias cluster="ssh -X hwu30@hpc4.sph.emory.edu"
```

So I can login to the cluster by typing ``cluster`` in the terminal. 

### Password-less logins using SSH

It's annoying to have to type in password every time  login or scp to/from the cluster. Fortunately there is a solution. Follow the steps to setup a password-less login.

1. **Create Public/Private Keys**. First check whether you have ``id_dsa`` and ``id_dsa.pub`` at the ``.ssh`` folder in your home directory. Note it's a hidden directory, and can be seen by typing ``ls -a``. If there exist, skip this step. Otherwise, type``ssh-keygen -t dsa`` in the terminal and those files will be generated.

2. **Set up logins**. First copy your public key (``id_dsa.pub``) to remote host by doing:
```scp .ssh/id_dsa.pub userid@hpc4.sph.emory.edu:~```.
Now login to the cluster and cd to the ``.ssh`` directory. Add the public key from your computer to the end of your ``authorized_keys file and set the correct permissions by typing the following commands at the terminal:

```
cat ../id_dsa.pub >> authorized_keys
chmod 600 authorized_keys
```

### Environment for bioinformatics group members


We have a group `compbio` created for all members in the bioinformatics group. If you belong to this group you'll have access to some data and software. 

Do `groups userid` to check your group membership. For example, I can see my group memberships: 

```
[hwu30@hpc4 ~]$ groups hwu30
hwu30 : RSPH webusers TBRU compbio compute
```

So I belong to following groups: `RSPH webusers TBRU compbio compute`. 
  
* **Disk space**. We currently have a total of 26T space on four different mounts: 
`
/compbio
/biglots
/bioinfo
/compbioscratch2
`.
The disk space is pretty limited and expensive, so all members need to be careful in managing the disk usage. Useful commands for checking disk usage are 

	- `df -h`: report disk space usage
	- `du -h --max-depth=1`: report file space usage

* **R**: 
	- The latest R (version 3.6) is at `/usr/local/R-3.6.0/bin/R`. You'd better setup an alias by adding the following line in your `.bashrc` file: ```alias R='/usr/local/R-3.6.0/bin/R'```.  Then you can just run R by typing `R` in command window. 
	- Note that R cannot run on the head node. You must `qlogin` to a computing node to use R. 
	- It's important to note that the alias seems cannot be passed to computing nodes when submitting jobs. So when one submits R jobs to the cluster, the full path for R needs to be specified. 
	- The R library is installed at `compbio/Rlib_3.6`. You can setup R libraray directory by adding the following line in the `.Rprofile` file: ```.libPaths( c("/compbio/Rlib_3.6",  .libPaths()) )
```

* **Shared resources**.  We have shared software/libraries/data mostly located at `/compbio`. In particular: 
	- `/compbio/bin` has a number of often-used binary software tools for genomic data analysis. 
	- `/compbio/data` has some useful shared data, including index files for alignment, reference genomes, etc. 

