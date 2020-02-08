# Cabler

Cabler is a Ruby on Rails 6 Web application to document (network?) infrastructure.

It is a prototype/hack/WIP born out of the necessary to document findings while dealing with issues in a mid-size (>5 16-Port switches) network.  While the use case is computer networks, the general setup is open enough to be used with other kinds of linked devices (e.g. water? Electricity?).

The own code is released under the AGPLv3+ and copyright 2020 Felix Wolfsteller.

## Usage

### Concepts

#### Locations

Locations should help you understand where e.g. cables end or where devices can be found.

#### Devices

Devices like Switches, Converters or Patchpanels (agreed, this is not a typical "device").  These can have different "ports" (calles `Slot`s).  In the case of a Patchpanel or a simple converter, a Port should be used twice and the device should be marked as "connector" upon creation.

#### Links

A Connection between a device and a location (or a device and a device or a location and a location), optionally with port assignment and name.

#### The test and examplary data

Find examplary data for tests in [test/fixtures/locations.yml](test/fixtures/locations.yml) etc. You can seed your database with this data using `rails fixtures:load`.

**Locations**
  - Basement
  - Office
  - Floor

**Devices**
  - Switch TL-N1 in the Basement
  - Switch TL-N2 in the Office
  - Patchpanel P-B in the Basement
  - Patchpanel P-O in the Office
  - Router pfSense in the Basement

**Links (Ports in brackets)**
  - Router (2) connected to Switch TL-N1 (1)
  - Switch TL-N1 (2) connected to Patchpanel P-B (3)
  - Patchpanel P-B (3) connected to Patchpanel P-O (7)
  - Switch TL-N2 (1) connected to Patchpanel P-O (7)
  - Switch TL-N1 (3) connected to Floor

```
+-----------------+location: basement+------+
|    router       Switch         Patchpanel|
|    pfSense      TL-N1          P-B       |
|    +-+          +---+          +---+     |
<----+1|  +------>+ 1 |          | 1 |     |
|    |2+--+       | 2 +--+       | 2 |     |
|    |3|          | 3 |  +------>+ 3 +-----+----------+
|    +-+          | 4 |          | 4 |     |          |
|                 | 5 |          | 5 |     |          |
|                 +---+          | 6 |     |          |
|                                +---+     |          |
|                                          |          |
+------------------------------------------+          |
                                                      |
+--+location: floor+--+    +-----+location: office+---+-+
|                     |    |   Switch      Patchpanel | |
+---------------------+    |   TL-N2       P-O        | |
                           |   +---+       +---+      | |
                           |   | 1 |       | 1 |      | |
                           |   | 2 +<---+  | 2 |      | |
                           |   | 3 |    |  | 3 |      | |
                           |   | 4 |    +--+ 4 +<-----+ |
                           |   +---+       +---+        |
                           |                            |
                           +----------------------------+
```

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

### Design decisions

No explicit modeling of "Port", instead a very loose polymorphic Link model.
To make up the disadvantages of that choice, implement Classes to deal with ""directed" connections (for analysis).


#### Problematic design decisions

