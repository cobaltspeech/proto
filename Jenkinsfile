#!groovy
// Copyright (2022--present) Cobalt Speech and Language Inc.

// Keep limited builds on Jenkins
properties([
	buildDiscarder(logRotator(
		artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3'))
])

// commit.setBuildStatus is defined in cobalt's shared jenkins library

if (!env.CHANGE_ID && env.BRANCH_NAME != "master") {
	echo 'nothing to build'
	return
}

if (env.CHANGE_ID) {
	// building a PR, run checks

	node ('nix') {
		checkout scm

		stage('fmt-check') {
			commit.setBuildStatus("fmt-check", "PENDING", "")
			try {
				sh "./bin/fmt-check.sh"
				commit.setBuildStatus("fmt-check", "SUCCESS", "All files correctly formatted")
			} catch(err) {
				commit.setBuildStatus("fmt-check", "ERROR", "Some files not correctly formatted")
				throw err
			}

		}

		stage('breaking-check') {
			commit.setBuildStatus("breaking-check", "PENDING", "")
			try {
				sh "nix develop -c buf breaking --against .git#branch=origin/$CHANGE_TARGET,subdir=proto proto"
				commit.setBuildStatus("breaking-check", "SUCCESS", "No breaking API changes detected.")
			} catch(err) {
				commit.setBuildStatus("breaking-check", "ERROR", "Breaking API changes detected.")
				throw err
			}

		}

		stage('lint-check') {
			commit.setBuildStatus("lint-check", "PENDING", "")
			try {
				sh "./bin/lint-check.sh"
				commit.setBuildStatus("lint-check", "SUCCESS", "All files OK")
			} catch(err) {
				commit.setBuildStatus("lint-check", "ERROR", "Some files have linter errors")
				throw err
			}
		}
	}
}

if (env.BRANCH_NAME == "master") {
	// Allow the pipeline access to the jenkins ssh key for github.
	sshagent(credentials: ['jenkins-ssh-key']) {

		// Trust the github ssh public keys (should match https://api.github.com/meta)
		sh '''
			[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
			curl https://api.github.com/meta | jq  -r '.ssh_keys | "github.com " + .[]' > ~/.ssh/known_hosts
		'''

		stage ('gen-and-publish') {
			commit.setBuildStatus("publish", "PENDING", "")
			try {
				sh "./bin/generate-and-publish.sh"
				commit.setBuildStatus("publish", "SUCCESS","Changes published")
			} catch(err) {
				commit.setBuildStatus("publish", "ERROR", "Changes not published")
				throw err
			}
		}
	}
}


// Emacs configuration
// Local Variables:
// tab-width: 4
// indent-tabs-mode: t
// End:
