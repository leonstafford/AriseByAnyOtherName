# Arise By Any Other Name

Utility to rewrite the namespace for a PHP package to avoid conflicts in WordPress

Conceived after thinking about it in [this comment](https://github.com/leonstafford/wp2static/issues/716#issuecomment-739647070).

[![CircleCI](https://circleci.com/gh/leonstafford/arisebyanyothername.svg?style=svg)](https://circleci.com/gh/leonstafford/arisebyanyothername)

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

## Pseudocode / TODO list

add a gh action with shellcheck (pilfer from Lokl-go repo)

failing tests:

 - [ ] given an input namespace, output namespace and a directory, it rewrites all instances within the dir matching our pattern.

Pattern to match should work on PHP docs examples, like:

```php
use My\Full\Classname as Another;
use My\Full\NSname;
use ArrayObject;
use function My\Full\functionName;
use function My\Full\functionName as func;
use const My\Full\CONSTANT;
use My\Full\Classname as Another, My\Full\NSname;
```

ie, `$use INPUTNAMESPACE ...;`

I don't expect use statements to break lines, so won't handle that to start.

- [ ] given an input repo user/name, output repo user/name and dir, will do bulk rewrites of that exact match in composer.json

This allows me to publish my rewritten fork to Packagist

 - [ ] given an input local filename, like `./templates/deletions/guzzle` and input dir, will remove all files/dirs from the repo that are specified in my template

Could put more effort in and have these templates contain all the rewriting recipes and pattern match, requiring *only* the target dir as input and it will figure out the rest

That's about all I need for now, I think.

