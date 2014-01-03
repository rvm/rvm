
# rvm docs

Generates ri and / or rdoc documentation for the current ruby and gems.


## Usage

    rvm docs {generate,generate-ri,generate-rdoc,generate-gems,rdoc_data}


## Description

If you have the hanna gem installed, rdoc generation should automatically use it.
Alternatively, you can pass the --docs flag to automatically build docs during installation.

For supported rubies (1.8.7, 1.9.2, 1.9.3, JRuby, RBX)
it will skip generation and install the rdoc-data gem.


## Examples

Generates all ri, rdoc and gems documentation for the current ruby:

    rvm docs generate


Generates only ri documentation for the current ruby:

    rvm docs generate-ri


Generates only rdoc documentation for the current ruby:

    rvm docs generate-rdoc

Generates only gems documentation for the current gemset:

    rvm docs generate-gems
