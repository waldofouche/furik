# Furik

Furik is summary generator for your GitHub activities.

[![ruby gem](https://img.shields.io/gem/v/furik.svg?style=flat-square)][gem]
[![Travis](https://img.shields.io/travis/pepabo/furik.svg?style=flat-square)][travis]

[gem]: https://rubygems.org/gems/furik
[travis]: https://travis-ci.org/pepabo/furik

## Installation

Install it yourself as:

    $ gem install furik

## Usage

You can show GitHub activity while one day.

    $ furik activity

Output example is here:

```
% furik activity
Today's Activities
-

### ruby/rubyspec

- [pull_request](https://github.com/ruby/rubyspec/pull/158): Set Net::FTP.default_passive to false.
- [comment](https://github.com/ruby/rubyspec/pull/158#issuecomment-155703551): :+1: (Set Net::FTP.default_passive t...)

### ruby/ruby

- [pull_request](https://github.com/ruby/ruby/pull/1091): Fix typo, double 'means'
(snip)
```

furik supports to store authentication via NetRC.

Stored to `~/.netrc` by default.

```sh
% cat ~/.netrc
---
machine github.com
login your_login
password your_token

machine api.github.com
login your_login
password your_token
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec furik` to use the gem in this directory, ignoring other installed copies of this gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pepabo/furik.

## LICENSE

The MIT License (MIT)

Copyright (c) 2015- GMO Pepabo, Inc.
