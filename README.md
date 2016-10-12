# create_release_branch

### What is does:

1. Asks for the environment you will be deploying to (ex: QA, Staging, Production).
2. Asks for name of the original release
    * (ex: 20161001-ReleaseV1.1.1)
        * The aforementioned example was made on 2016 October 01.
3. Creates a new branch
    * \<original release name>\<environment>\<current timestamp>
4. Pushes the branch to GitHub
5. Jumps back onto the original branch you were on
6. Deletes the newly created branch
    * This is to reduce the amount of latent branches in the user's local repository

##### Note:
* Uses Los Angeles timezone, so that all developers will apply the same timezone for timestamps

## When Deploying
1. Use the newly created branch in green text
* `bundle exec cap qa deploy BRANCH=<newly created branch>`

### Making an alias for this script

* Put the following into your .bashrc
    * `alias create_release_checkpoint="~/scripts/create_release_checkpoint/create_release_checkpoint.sh"`

### Example Execution on 2016 Nov. 29
![alt tag](http://i.imgur.com/Ac65We4.png)
