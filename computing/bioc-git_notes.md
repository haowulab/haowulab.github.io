#Using git with Bioconductor

Detailed description is provided [here](https://www.bioconductor.org/developers/how-to/git/). 


## Create a new repository: 

Assuming:

-  I  have GitHub account with username `haowulab`. 
- I have an existing Bioconductor package called `mypkg`.


1. Create a new repo on GitHub with the same name as the package (`mypkg`).


2. Clone the empty repo to my local machine:
```
git clone https://github.com/haowulab/mypkg.git
```
Note after this step, the GitHub repo is the **origin** of my local repo. 

3. Add a remote to the cloned (local) repository (needs to be done in `mypkg` directory):
```
git remote add upstream git@git.bioconductor.org:packages/mypkg.git
```
This makes  `git.bioconductor.org` to be the **upstream** of my local repo. 

4. Fetch content from remote upstream. 
```
git fetch upstream
```

5. Merge upstream with origin’s master branch,
```
git merge upstream/master
```

6. Push changes to your origin master (this updates the content on GitHub): `git push origin master`. 

7. Push changes to the upstream master (updates the content on Bioconductor).  
` git push upstream master`.
In order for this step to be successful, Bioconductor must grant you the access. Need to submit public SSH key [here](https://docs.google.com/forms/d/e/1FAIpQLSdlTbNjsQJDp0BA480vo4tNufs0ziNyNmexegNZgNieIovbAA/viewform). 


## View existing remote 

In the local git repo, do `git remote -v`. I see following: 

```
origin	https://github.com/haowulab/DSS.git (fetch)
origin	https://github.com/haowulab/DSS.git (push)
upstream	git@git.bioconductor.org:packages/DSS.git (fetch)
upstream	git@git.bioconductor.org:packages/DSS.git (push)
```

## Make and commit changes to existing 

- After making changes, run `git commit -a -m "some msg"` to commit all changes at once. 
- `git add` adds a new file to the repo. 
- `git rm` removes an existing file in the repo. 
- After making changes, one needs to push the changes to the **upstream** and **origin**, by doing 

```
git push -u origin master
git push -u upstream master
```

## Resolve conflicts
Sometimes `git push -u upstream master` will fail with a warning message like `failed to push some refs to 'git@git.bioconductor.org:packages/DSS.git'.`. 
`Updates were rejected because the remote contains work that you do
not have locally.` 

This is usually caused by conflicts in files between local and upstream (bioconductor). Most likely, in the `DESCRIPTION` file becasue bioconductor modify the version number in new release. To resolve this, first run 

```
git pull upstream master
```

Then fix the file with confliction (such as `DESCRIPTION`), and commit/push.



