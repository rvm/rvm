# Release procedure

## Preconditions

Add `bitbucket` remote:

```bash
git remote add bitbucket git@bitbucket.org:mpapis/rvm.git
```

## Procedure

1. Merge `master` to `stable`

```bash
git checkout master
git pull
git checkout stable
git pull
git merge master
```

2. Increase [VERSION](../VERSION) number and remove `-next`
3. Update [CHANGELOG](../CHANGELOG.md) with release date and links to changes (do not add new `Next` section yet)
4. Commit changes

```bash
git commit -m "Release 1.29.6"
```

5. Tag stable with version

```bash
git tag 1.29.6
```

6. Merge `stable` to `master`

```bash
git checkout master
git merge stable
```

5. Push to github and bitbucket

```bash
git push origin master stable
git push origin --tags

git push bitbucket master stable
git push bitbucket --tags
```

7. Sign release and upload files to GitHub and BitBucket

```bash
bash ./sign-releases.sh
```

8. Close milestone in github
9. Publish blog entry on http://rvm.io
10. Publish info on twitter
11. Prepare for the next release on `master` branch
    * add `-next` to the [VERSION](../VERSION)
    * add new `Next` section to [CHANGELOG](../CHANGELOG.md)
