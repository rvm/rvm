
# rvm docs

Generates ri and / or rdoc documentation for the current ruby.


## Usage

    rvm docs {generate,generate-ri,generate-rdoc,rdoc_data}


## Description

If you have the hanna gem installed, rdoc generation should automatically use it.
Alternatively, you can pass the --docs flag to automatically call 'rvm docs generate'
as part of the install process.

For supported rubies (1.8.7, 1.9.2, 1.9.3, JRuby, RBX)
it will skip generation and install the rdoc-data gem.


## Examples

Generates both ri and rdoc documentation for the current ruby:

    rvm docs generate


Generates only ri documentation for the current ruby:

    rvm docs generate-ri


Generates only rdoc documentation for the current ruby:

    rvm docs generate-rdoc
