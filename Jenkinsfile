#!groovy
// Copyright (2022--present) Cobalt Speech and Language Inc.

// Keep limited builds on Jenkins
properties([
	buildDiscarder(logRotator(
		artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3'))
])

// commit.setBuildStatus is defined in cobalt's shared jenkins library

if (env.CHANGE_ID) {
	// building a PR

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


// Emacs configuration
// Local Variables:
// tab-width: 4
// indent-tabs-mode: t
// End:
