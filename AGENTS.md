# Notes for agents

This repository is public. Anything written here is world readable: pull
request descriptions, review comments, commit messages, code comments and
workflow run logs. Treat all of them as publication.

An agent working here usually has far wider access than this repository —
the GitHub API, the organisation's settings, local clones of private
repositories, credentials in the environment. None of what that access
reveals belongs in anything published here.

## Do not publish

- Internal hostnames, addresses and service names.
- Names of private repositories, or anything that maps out what the
  organisation has.
- How CI is set up: runners and their labels, runner groups, which
  repositories a workflow or credential serves.
- Secrets and credentials, obviously, but also their inventory: which exist,
  where they are configured, what they are named, what they can reach.
- Branch protection, required checks, app installations and permissions —
  including which are absent or permissive, which is the more useful half to
  an attacker.
- Security analysis: findings, the reasoning behind them, and whether a
  weakness is mitigated, accepted or unresolved.

Describe what a change does. Do not narrate the setup around it.

## Where that detail belongs

Give it to the maintainer directly, outside GitHub. Not in an issue, a pull
request, a commit message or a code comment. When a public artefact has to
refer to such a change at all, say that one was made and leave the specifics
out.

## Editing is not retraction

A comment edited afterwards has already gone out by email to everyone
watching, and may persist in caches and mirrors. There is no undo, so get it
right the first time.

## Workflow logs

Run logs are public, and a `run:` step echoes its own script into them.
Report presence rather than values when a job needs to check that something
is configured, and keep configuration details out of step names and echoes.
