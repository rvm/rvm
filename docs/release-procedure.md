# Release procedure

1. Merge `master` to `stable`

```bash
git checkout master
git pull
git checkout stable
git pull
git merge master
```

2. Increase [VERSION](https://github.com/rvm/rvm/blob/master/VERSION) number and remove `-next`
3. Update [CHANGELOG](https://github.com/rvm/rvm/blob/master/CHANGELOG.md) with release date and links to changes (do not add new `Next` section yet)
4. Tag stable with version

```bash
git tag 1.29.6
```

6. Merge `stable` to `master`

```bash
git checkout master
git merge stable
```

5. Push to github and gitlab

```bash
git push origin master stable
git push origin --tags

git push gitlab master stable
git push gitlab --tags
```

7. Sign release and upload files to github and bitbucket

```bash
bash ./sign-releases.sh
```

8. Close milestone in github
9. Publish blog entry on http://rvm.io
10. Publish info on twitter
11. Prepare for the next release on `master` branch
    * add `-next` to the [VERSION](https://github.com/rvm/rvm/blob/master/VERSION)
    * add new `Next` section to [CHANGELOG](https://github.com/rvm/rvm/blob/master/CHANGELOG.md)

## Preconditions

Add `gitlab` remote:

```bash
git remote add gitlab git@bitbucket.org:mpapis/rvm.git
```
