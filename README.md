Diffr
======

A simple diff utility written in Ruby. It works with single or
multi-line strings and returns an array of hashes that indicates
the line number affected and change: added, deleted, or same.

Overview
--------

```ruby

old = "This line of document stays the same.
The dokument should be spelled correctly.
This line should be deleted."

new = "The new document has a line break!

This line of document stays the same.
The document should be spelled correctly.
Finally, a brand new line."

Diff.diffs(old, new).each do |diff|
  puts diff
end

# Produces:

# {:line => 1, :change => :add,    :string => "The new document has a line break!"}
# {:line => 2, :change => :add,    :string => ""}
# {:line => 1, :change => :same,   :string => "This line of document stays the same."}
# {:line => 2, :change => :delete, :string => "The dokument should be spelled correctly."}
# {:line => 3, :change => :delete, :string => "This line should be deleted."}
# {:line => 4, :change => :add,    :string => "The document should be spelled correctly."}
# {:line => 5, :change => :add,    :string => "Finally, a brand new line."}

# With a little formatting, we can produce something very similar to Unix's diff (unified format):

SYMBOLS = {:add => '+', :delete => '-', :same => ' '}

Diff.diffs(old, new).each do |diff|
  puts SYMBOLS[diff[:change]] + diff[:string]
end

# Produces:

# +The new document has a line break!
# +
#  This line of document stays the same.
# -The dokument should be spelled correctly.
# -This line should be deleted.
# +The document should be spelled correctly.
# +Finally, a brand new line.

```

Installing Diffr
----------------

### In a Ruby app, as a gem

First install the gem.

    $ gem install diffr

Next include it in your application.

```ruby

require 'diffr'

```
