yardstick
=========

[![Gem Version](https://badge.fury.io/rb/yard-cov.svg)](http://badge.fury.io/rb/yard-cov)
[![Build Status](https://travis-ci.org/braiden-vasco/yard-cov.svg)](https://travis-ci.org/braiden-vasco/yard-cov)
[![Coverage Status](https://coveralls.io/repos/github/braiden-vasco/yard-cov/badge.svg)](https://coveralls.io/github/braiden-vasco/yard-cov)
[![Inline docs](http://inch-ci.org/github/braiden-vasco/yard-cov.svg?branch=master)](http://inch-ci.org/github/braiden-vasco/yard-cov)

**yard-cov** is [YARD](https://yardoc.org) documentation coverage
measurement tool. It will measure the source and provide feedback
on what is missing from the documentation and what can be improved.



Table of contents
-----------------

* [Overview](#yardstick)
* [Table of contents](#table-of-contents)
* [Usage](#usage)
  * [Command-line tool](#command-line-tool)
  * [Rake task](#rake-task)
  * [Libraries](#libraries)
  * [Configuration](#configuration)
* [TODO](#todo)



Usage
-----

Yardstick may be used three ways:

### Command-line tool

This is the simplest way to run yardstick.  Provide it a list of files
and it will measure all of them and output suggestions for improvement,
eg:

```sh
$ yardstick 'lib/**/*.rb' 'app/**/*.rb' ...etc...
```

### Rake task

Yardstick may be integrated with existing Rakefile and build processes,
and is especially useful when used with a continuous integration system.
You can set thresholds, as well as check that the threshold matches the
actual coverage, forcing you to bump it up if the actual coverage has
increased.  It uses a simple DSL to configure the task eg:

```ruby
# measure coverage

require 'yardstick/rake/measurement'

Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = 'measurement/report.txt'
end


# verify coverage

require 'yardstick/rake/verify'

Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end
```

### Libraries

Yardstick comes with several libraries that will allow you to process
lists of files, or String code fragments, eg:

```ruby
require 'yardstick'

# measure a list of file paths
measurements = Yardstick.measure(paths)

# measure a code fragment
measurements = Yardstick.measure_string <<-RUBY
  # Displays the message provided to stdout
  #
  # @param [#to_str] message
  #   the message to display
  #
  # @return [undefined]
  #
  # @api public
  def display(message)
    puts message.to_str
  end
RUBY
```

### Configuration

Every rule in Yardstick can be turned off globally and locally. All rules are enabled and threshold is set to maximum by default (100%). If your documentation coverage is below or above this threshold then yardstick will exit with a nonzero status and print that fact.

Default configuration:
```yaml
---
threshold: 100
rules:
  ApiTag::Presence:
    enabled: true
    exclude: []
  ApiTag::Inclusion:
    enabled: true
    exclude: []
  ApiTag::ProtectedMethod:
    enabled: true
    exclude: []
  ApiTag::PrivateMethod:
    enabled: true
    exclude: []
  ExampleTag:
    enabled: true
    exclude: []
  ReturnTag:
    enabled: true
    exclude: []
  Summary::Presence:
    enabled: true
    exclude: []
  Summary::Length:
    enabled: true
    exclude: []
  Summary::Delimiter:
    enabled: true
    exclude: []
  Summary::SingleLine:
    enabled: true
    exclude: []
```

To disable a rule for some part of the code use:

```yaml
rules:
  ApiTag::Presence:
    enabled: true
    exclude:
      - Foo::Bar # class or module
      - Foo#bar  # instance method
      - Foo.bar  # class method
```

Rake tasks take these options as a second argument:

```ruby
options = YAML.load_file('config/yardstick.yml')

Yardstick::Rake::Verify.new(:verify_measurements, options)
```



TODO
----

* Add more measurements, especially for @param, @yield and type
  validation
* Update yardstick_measure task to use the Yardstick::CLI library
  underneath.
* Output results as HTML from command line tool and Rake task
* Specify method_missing to allow public, semipublic or private even
  if its visibility is private
* Allow initialize to be public, semipublic or private regardless of
  its visibility. A constructor may not necessarily be public, and may
  not be used externally.
