
# Git 1.0

Git and Github CLI for Direktiv

---
- #### Categories: tools, development
- #### Image: gcr.io/direktiv/apps/git 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/git/issues
- #### URL: https://github.com/direktiv-apps/git
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About Git

This function contains Git as well as Github's command line. To use the CLI the value `pat` has to be set.

### Example(s)
  #### Function Configuration
  ```yaml
  functions:
  - id: myservice
    image: gcr.io/direktiv/apps/git:1.0
    type: knative-workflow
  ```
   #### Clone
   ```yaml
   - id: clone
      type: action
      action:
        function: git
        input:
          pat: ghp_mysecretpersonalaccesstoken
          commands:
          - command: gh repo clone myorg/myrepo
          # to store the repo in e.g. workflow scope variable
          - command: gh repo clone myorg/myrepo out/workflow/myrepo
   ```
   #### Clone with Git
   ```yaml
   - id: clone
      type: action
      action:
        function: git
        secrets: ["pat"]
        input:
          commands:
          - command: git clone https://myuser:jq(.secrets.pat)@github.com/jensg-st/devops.git
   ```

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
    "result": "7c5b9cc HEAD@{0}: clone: from https://github.com/myorg/myapp.git",
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
| pat | string| `string` |  | | This is used for Github CLI to authenticate (PAT, Personal Access Token). |  |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run | `terraform version` |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |

 
