All following tips are based on using terminal on Mac OS. I believe it will work for any linux system. For Windows, one needs to install some type of Unix-like systems, such as [Cygwin](https://www.cygwin.com).

### RSPH cluster

Address for the RSPH cluster is ``hpc4.sph.emory.edu``. 
Login commmand is ``ssh -X userid@hpc4.sph.emory.edu``. ``userid`` needs to be replaced by your login. 

I usually create an alias by adding the following line to my .bash_profile 
``
alias cluster="ssh -X hwu30@hpc4.sph.emory.edu"
``

So I can login to the cluster by typing ``cluster`` in the terminal. 

### Password-less logins using SSH

It's annoying to have to type in password every time  login or scp to/from the cluster. Fortunately there is a solution. Follow the steps to setup a password-less login.

1. **Create Public/Private Keys**. First check whether you have ``id_dsa`` and ``id_dsa.pub`` at the ``.ssh`` folder in your home directory. Note it's a hidden directory, and can be seen by typing ``ls -a``. If there exist, skip this step. Otherwise, type``ssh-keygen -t dsa`` in the terminal and those files will be generated.

2. **Set up logins**. First copy your public key (``id_dsa.pub``) to remote host by doing:
``scp .ssh/id_dsa.pub userid@hpc4.sph.emory.edu:~``.
Now login to the cluster and cd to the ``.ssh`` directory. Add the public key from your computer to the end of your ``authorized_keys file and set the correct permissions by typing the following commands at the terminal:

```
cat ../id_dsa.pub >> authorized_keys
chmod 600 authorized_keys
```
