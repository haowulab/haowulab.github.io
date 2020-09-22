---
layout: page
title: Using the new RSPH cluster (September 2020)
description: Using the new RSPH cluster
---


All following tips are based on using terminal on Mac OS. I believe it will work for any linux system. For Windows, one needs to install some type of Unix-like systems, such as [Cygwin](https://www.cygwin.com).

### Basic information 

Here is the [HPC Getting Started Guide](HPCGuide.pdf) provided by the RSPH IT. Read it carefully because the system uses a new job scheduler. 

If you want to access the cluster from outside the School of Public Health (this includes using laptop through Emory wifi), you will need connect through the Emory VPN.  


### Login to the RSPH cluster

Address for the RSPH cluster is ``clogin01.sph.emory.edu``. 
Login commmand is 

```
ssh -X userid@hwu30@clogin01.sph.emory.edu
``` 

Here ``userid`` needs to be replaced by your login (your EmoryID). 

I usually create an alias by adding the following line to my ``.bash_profile``:

```
alias cluster="ssh -X hwu30@clogin01.sph.emory.edu"
```

So I can login to the cluster by typing ``cluster`` in the terminal. 


### Password-less logins using SSH

It's annoying to have to type in password every time  login or scp to/from the cluster. Fortunately there is a solution. Follow the steps to setup a password-less login.

1. **Create Public/Private Keys**. First check whether you have ``id_rsa`` and ``id_rsa.pub`` at the ``.ssh`` folder in your home directory. Note it's a hidden directory, and can be seen by typing ``ls -a``. If there exist, skip this step. Otherwise, type``ssh-keygen -t rsa`` in the terminal and those files will be generated.

2. **Set up logins**. First copy your public key (``id_rsa.pub``) to remote host by doing:
```scp .ssh/id_rsa.pub userid@hpc4.sph.emory.edu:~```.
Now login to the cluster and cd to the ``.ssh`` directory. Add the public key from your computer to the end of your ``authorized_keys file and set the correct permissions by typing the following commands at the terminal:

	```
	cat ../id_rsa.pub >> authorized_keys
	chmod 600 authorized_keys
	```


### Transfer data from the old cluster to the new one

Use the `scp` commands to copy files over. For example, I can use the following commands to copy a whole directory over. If the file sizes are large, you can also submit a job for file transferring. 

```
#!/bin/bash
#SBATCH --partition=day-long-cpu
scp -r hwu30@hpc4.sph.emory.edu:SourceDir TargetDir 
```

In order for this to run succesfully, you also need to setup the password-less login between the new and old cluster (adding the `id_rsa.pub` line in the new cluster to the `authorized_keys` file in the old cluster). Otherwise, the system will prompt for password, and the submitted job cannot run. 

This is also a good opportunity to reorganize your files. 




### The job scheduler on the new cluster

The new clusters uses SLURM as job scheduler, instead of Sun Grid Engine (SGE) on the old clusters. A few basic SGE commands and 
and their corresponding SLURM commands are

- `qsub` -- `sbatch` 
-  `qstat` -- `squeue` 
-  `qdel` -- `scancel`
-  `qlogin` -- `srun --pty bash`

For a more comprehensive list, please see this 
[SGE to SLURM conversion page](https://srcc.stanford.edu/sge-slurm-conversion).


### Environment for bioinformatics group members


We have a group `compbio` created for all members in the bioinformatics group. If you belong to this group you'll have access to some data and software. 

Do `groups userid` to check your group membership. For example, I can see my group memberships: 

```
[hwu30@hpc4 ~]$ groups hwu30
hwu30 : hpcusers compbio
```

So I belong to following groups: `hpcusers compbio`. 
By default, all users in the `compbio` group should be able to see each other's file (have read permission, but not write permission). 
  
#### Disk space
* We currently have around 150T storage, under the `/projects` mount. 
Useful commands for checking disk usage are 

	- `df -h`: report disk space usage
	- `du -h --max-depth=1`: report file space usage


The disk space is not as limited as before, but all members still need to be careful in managing the disk usage. 

#### Setup your working directories

* All group users should setup their own working directory under **`/projects/compbio/users`**. For example, my directory is `/projects/compbio/users/hwu30`. 
* You can create a symbolic link in your home directory by running the following command (in your home directory): 
```
ln -s  /projects/compbio/users/hwu30 projects
```
	
	It creates a directory `project` in my home, which is in fact `/projects/compbio/users/hwu30`. 
* Try to be organized in managing your projects. Create directories and sub-directories. 



#### Shared resources  

We have shared software/libraries/data mostly located at `/projects/compbio`. In particular: 

- `/projects/compbio/bin` has a number of often-used binary software tools for genetic/genomic data analysis. 
You can add following line to your `.bash_profile` (in the home directory), so that the software installed here can be accessed from anywhere. 

	```
	PATH=$PATH:/projects/compbio/bin
	```

- `/projects/compbio/data` has some useful shared data, including index files for alignment, reference genomes, etc. 


#### Using R
- As of September 2020, The latest R (version 4.0) and Bioconductor (version 3.11) are installed. 

- Note that R cannot run on the head node directly. You must first run ``module load R`` to load the R module, and then run R. Read the [HPC Getting Started Guide]("HPC Getting Started Guide.pdf") for details. 

- The R library directory for the group is at `projects/compbio/Rlib`. You need to setup R libraray directory by adding the following line in your `.Rprofile` file. Note: it's a hidden text file in your home directory. If you don't have it, just create one: 

	```.libPaths( c("projects/compbio/Rlib",  .libPaths()) )```

	After this, run `.libPaths()` in R to make sure you have the correct path. 
	
- To submit an R job to the scheduler, you need to create a `.sh` and put in some commands. The description in the guide is not accurate. The shell script should look like (assuming you want to submit `run.R`): 
		
	```
	#!/bin/bash
	#SBATCH --job-name=run.R
	#SBATCH --partition=day-long-cpu
	module purge
	module load R
	srun R CMD BATCH --no-save run.R
	```
  Assume the script is called `runR.sh`, use `sbatch runR.sh` to submit the job. You can use `squeue` to view the job status. 
