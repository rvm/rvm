RVM will automatically use colors when it is possible.

To overwrite use command line parameter --color=no or --color=force.

It is also possible to set it with variable in ~/.rvmrc:

    rvm_pretty_print_flag=[no|auto|force]


To change default colors use following variables in ~/.rvmrc:

    rvm_error_color=red
    rvm_warn_color=yellow
    rvm_debug_color=magenta
    rvm_notify_color=green
    rvm_code_color=blue
    rvm_comment_color=iblack

Available colors are:

    black red green yellow blue magenta cyan white default

You can add emphasis to the color using bold/offbold.

It is also possible to change background color:

    bblack bred bgreen byellow bblue bmagenta bcyan bwhite bdefault

On some terminals like xterm ( echo $TERM ) the bold and background colors give the same effect.

Use commas to put multiple definitions in one color.  You can mix color, bold and background in one definition.
Specifying multiple colors/bold/background definitions will use last defined.

Using bold in one definition requires resetting it in others with offbold.

Using background in one definition requires resetting it in others with bdefault.

Example:

    $ cat ~/.rvmrc
    rvm_error_color=bold,red
    rvm_warn_color=bold,yellow
    rvm_debug_color=offbold,magenta
    rvm_notify_color=offbold,green
