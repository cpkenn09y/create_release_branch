# create_release_branch

### Purpose:
1. Creates a branch that acts as a checkpoint (think Mario) to save the current state of the code
2. Allows this newly created checkpoint branch to be deployed to different environments
3. Allows for version control when promoting code to different environments (ex: from QA to Staging to Production)

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

### Promoting Approved Builds from One Environment to the Other
1. Given the example of code from QA to Staging
    * ssh onto the server
    * cd into the root of your project (ex: /var/www/vhosts/navera.com/webapps/apps/rhino_dba)
    * cat the `revisions.log` file
    * copy the name of the branch currently on QA
      * Note: it should be the bottom of the list
    * open a new terminal tab
      * navigate to the local repo of your project
      * `git fetch origin <name of branch>`
      * `git checkout <name of branch>`
      * execute this script
        * `create_release_checkpoint`
      * deploy the newly created branch to Staging

## When Deploying
1. Use the newly created branch in green text
* `bundle exec cap <environment> deploy BRANCH=<newly created branch>`

### Making an alias for this script

* Put the following into your .bashrc
    * `alias create_release_checkpoint="~/scripts/create_release_checkpoint/create_release_checkpoint.sh"`

### Example Execution on 2016 Nov. 29
![alt tag](http://i.imgur.com/Ac65We4.png)
