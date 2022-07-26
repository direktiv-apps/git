
# git 1.0

Git function including Github CLI

---
- #### Categories: build
- #### Image: gcr.io/direktiv/apps/git 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/git/issues
- #### URL: https://github.com/direktiv-apps/git
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About git

This function has Git and the Github CLI installed.  The use of the Github CLI requires the `pat` parameter to be set with a valid personal access token.  The minimum scope for this token is: "repo", "read:org".

To use cloned repositories in later states within the flow they can be written to the out directory, e.g.  git clone https://github.com/direktiv/direktiv.git out/instance/direktiv.tar.gz.

A [Github changelog generator](https://github.com/github-changelog-generator/github-changelog-generator) is available on this image.

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: git
  image: gcr.io/direktiv/apps/git:1.0
  type: knative-workflow
```
   #### Basic
```yaml
- id: git
  type: action
  action:
    function: git
    input: 
      commands:
      - command: git clone --depth 1 https://github.com/direktiv/direktiv.git
```
   #### Store Cloned Repository
```yaml
- id: git
  type: action
  action:
    function: git
    input: 
      commands:
      - command: git clone --depth 1 https://github.com/direktiv/direktiv.git out/instance/direktiv.tar.gz
  transition: readdir
- id: readdir
  type: action
  action:
    function: git
    files:
    - key: direktiv.tar.gz
      scope: instance
      type: tar.gz
      as: direktiv
    input:
      commands:
      - command: git -C direktiv reflog
```
   #### Private Clone Github
```yaml
- id: git
  type: action
  action:
    secrets: ["gitPAT"]
    function: git
    input: 
      pat: jq(.secrets.gitPAT)
      commands:
      - command: gh repo clone jensg-st/private-test
```
   #### Private Clone
```yaml
- id: git
  type: action
  action:
    secrets: ["gitPAT"]
    function: git
    input: 
      commands:
      - command: git clone https://user:jq(.secrets.gitPAT)@github.com/jensg-st/private-test.git
```

   ### Secrets


- **gitPAT**: The personal access token (PAT) for Github CLI.






### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": null,
    "success": true
  }
]
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| git | [][PostOKBodyGitItems](#post-o-k-body-git-items)| `[]*PostOKBodyGitItems` |  | |  |  |


#### <span id="post-o-k-body-git-items"></span> postOKBodyGitItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| commands | [][PostParamsBodyCommandsItems](#post-params-body-commands-items)| `[]*PostParamsBodyCommandsItems` |  | | Array of commands. |  |
| files | [][DirektivFile](#direktiv-file)| `[]apps.DirektivFile` |  | | File to create before running commands. |  |
| pat | string| `string` |  | | Used for Github CLI to authenticate (PAT, Personal Access Token). |  |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run | `git clone https://github.com/direktiv/direktiv.git` |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |

 
