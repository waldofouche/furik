# Furik

Furik is summary generator for your GitHub activities.

This has been forked from https://github.com/pepabo/furik and is stripped down for my specific use case.

## Installation

Build and install locally:

```shell
$ gem build furik.gemspec
$ gem install --local GENERATED_GEM
```

## Usage

You can show GitHub activity for one day:
```shell
$ furik activity
```

Or `n` days:

```sh
$ furik activity -d 5
```

Or in a range:

```shell
$ furik activity -f 2021-01-01 -t 2021-01-07
```

Furik authenticates to Github via `netrc`, which is stored in `~/.netrc` by default.

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

Bug reports and pull requests are welcome on GitHub at https://github.com/chrisjones120/furik.

## LICENSE

The MIT License (MIT)

Copyright (c) 2015- GMO Pepabo, Inc.
