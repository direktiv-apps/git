
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:
* def gitPAT = karate.properties['gitPAT']
* def clonePrivate = "git clone https://jensg-st:" + karate.properties['gitPAT'] + "@github.com/jensg-st/private-test.git"
* configure readTimeout = 6000000

Scenario:  simple clone

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"commands": [
		{
			"command": "git clone --depth 1 https://github.com/direktiv/direktiv.git",
			"silent": true,
			"print": false,
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"git": [
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""

Scenario: private
	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"commands": [
		{
			command: #(clonePrivate),
			"silent": true,
			"print": false,
		},
		{
			command: rm -Rf private-test,
			"silent": true,
			"print": false,
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"git": [
	{
		"result": "#notnull",
		"success": true
	},
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""
	
Scenario: ghcli

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""	
	{	
		"pat": "#(gitPAT)",
		"commands": [
			{
			command: gh repo clone jensg-st/private-test,
			"silent": false,
			"print": true,
			continue: true
			},
			{
			command: git -C private-test/ log,
			"silent": false,
			"print": true,
			continue: true
			}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"git": [
	{
		"result": "#notnull",
		"success": true
	},
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""

Scenario: changelog

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""	
	{	
		"pat": "#(gitPAT)",
		"commands": [
			{
			command: github_changelog_generator -u direktiv-apps -p git,
			"silent": false,
			"print": true,
			continue: true
			},
			{
			command: cat CHANGELOG.md
			}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"git": [
	{
		"result": "#notnull",
		"success": true
	},
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""