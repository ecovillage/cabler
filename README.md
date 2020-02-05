# Cabler

Cabler is a Ruby on Rails 6 Web application to document (network?) infrastructure.

It is a prototype/hack/WIP born out of the necessary to document findings while dealing with issues in a mid-size (>5 16-Port switches) network.  While the use case is computer networks, the general setup is open enough to be used with other kinds of linked devices (e.g. water? Electricity?).

The own code is released under the AGPLv3+ and copyright 2020 Felix Wolfsteller.

## Usage

## Setup

Ruby on Rails 6 stack, currently using Ruby 2.6.1 .

  - clone this repository
  - run `bundle`
  - run `rails db:migrate`
  - fire up server (in dev, e.g. with `rails s`)

### Configuration

There is nothing to configure as of yet (and no way besides editing the ruby source files and database config yml files).

## Development

### Tests

There are very few tests which can be run with `rails t`.  Use `rails test -f` for *fast-failing* mode (abort after first test fail).

### Contributing

Own code (mostly `app/` and `test/`) is released under the AGPLv3+ (included as file [LICENSE](LICENSE) in this repository).

Contributions are very welcome.  Copyright-transfer of modifications to Felix Wolfsteller is assumed.

For fun, some of the files include comments to be compliant with [(FSFEs) reuse](https://reuse.software/).

## Documentation

### Stuff used

  - Ruby and Ruby on Rails
  - [bulma.io](bulma.io) as CSS framework
  - HAML for a saner way to produce HTML
  - devise for authentication

### Design desicions

#### Problematic design decisions

