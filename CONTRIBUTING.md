Here at RVM we get a high amount of bug reports, and sometimes bugs turn out not to be bugs,
but user generated errors and other times it turns out to be our fault.
Don't get us wrong, we love it when you file bugs but we would also love it if
you were able to give us more information than most people do right off the bat,
so we can maximize our time helping you and minimize our time requesting more information.

# RVM 2.0 work announcement

Work on RVM 2.0 has started, check the plan here:
https://docs.google.com/document/d/1xW9GeEpLOWPcddDg_hOPvK4oeLxJmU3Q5FiCNT7nTAc/edit?usp=sharing

To be able to do the RVM 2.0 work we need to stop working on RVM 1.x -
this means no more feature requests will be accepted.
Development on RVM 1.x will continue to provide bugfixes and
support for new ruby versions as long as RVM 2.0 will not become stable.
RVM is an open source project so any contributions are welcome -
including new features pull requests - as long as they keep compatibility and
do not break anything.

## Check Documentation

We know, you hear this over and over and be rest assured we are working hard to improve the
usability of https://rvm.io but we must always ask that you first please check the documentation
if you are requesting a feature or if you are not sure if you did it right.
If the documentation is not clear, an error message is not clear or you know or
have found out that your problem is not resolved by the documentation then please do file a bug.

## Filing

Documentation: https://github.com/rvm/rvm-site/issues/new<br />
RVM: https://github.com/wayneeseguin/rvm/issues/new

*When in doubt as to whether your issue might relate to another simply file a new bug and
we will mark it as duplicate if it needs to be.  It's always better to file a new ticket and
let us sort it out than to accidentally add noise to another ticket.*

If you wish to file a bug, the only thing we ask is that you
provide a [gist](https://gist.github.com) of the command you used and if you are on stable,
make sure that the case is the same on head too, this way you and us know whether
the issue has been addressed, and always note that if there is a lot of `debug` or `trace` output
you can redirect it to a file with the `>` character like so `rvm [command] > output.txt`.
Further information on how to file can be seen below.
Also, please always make sure to split up each command into it's own fenced codeblock,
this means that each command and it's output should be in it's own code block.

## IRC and Mailing List

If you're joining the #rvm channel on [Freenode](http://freenode.net/) to get help with a problem,
please let us know what's wrong and stick around. Someone will always respond in time.
If you can't stick around, please file a bug on GitHub or email us via the
[google group](https://groups.google.com/forum/?fromgroups#!forum/rubyversionmanager).

## Filing issues

```
rvm get head
rvm reload
rvm --debug [command]
```
Make sure to include all mentioned log files.

## Coding guidelines
https://github.com/wayneeseguin/rvm/blob/master/FORMATTING.md
