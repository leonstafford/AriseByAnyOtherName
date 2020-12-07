# Arise By Any Other Name

Utility to rewrite the namespace for a PHP package to avoid conflicts in WordPress

Conceived after thinking about it in [this comment](https://github.com/leonstafford/wp2static/issues/716#issuecomment-739647070).

## Example

To avoid conflicts for the Guzzle library, used by WP2Static and countless other PHP packages, when bundled up for use in a WordPress plugin/theme, I prefer the simple option of forking the package in question and rewriting all the namespaces to my own unique one, ie https://github.com/leonstafford/wp2staticguzzle with `WP2StaticGuzzle` vs the original `Guzzle`.

Further simplifying the process, I want to keep my script(s) that do the rewriting and any modification of the package in their own repo. This way, I can always upgrade my custom namespaced package by a hard reset to upstream project.

## Process for forking a package:

If you just do a simple GitHub fork, you'll be stuck with an identical repo name to upstream, which isn't what I want.

 - create a new repo
 - make a new dir with matching name on your machine
 - cd into it
 - `git init`
 - `git remote add origin YOURNEWREPOSGITADDRESS`
 - `git remote add upstream THEORIGINALPACKAGEGITADDRESS`
 - `git checkout -b master`
 - `git pull upstream master`
 - `git reset --hard upstream/master`
 - `git push origin master --force`

From that starting point, you've got an identical fork of upstream, in your uniquely named GitHub (or other VCS host) repo.

Now, draw the rest of the owl by running AriseByAnyOtherName against the package's directory, giving it the original namespace and new namespace as your inputs.

You may also want to do some other modifications, through this tool or manually (keep notes!) to modify things/remove bits you don't need in the repo, like the upstream's CI, README, etc. This repo's contents will get blown away when you upgrade, so don't get attached to it and aim for being able to idempotently run your script against freshly reset upsteam heads from time to time.
