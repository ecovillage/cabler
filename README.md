# Cabler

Cabler is a Ruby on Rails 6 Web application to document (network?) infrastructure.

It is a prototype/hack/WIP born out of the necessary to document findings while dealing with issues in a mid-size (>5 16-Port switches) network. While the use case is computer networks, the general setup is open enough to be used with other kinds of linked devices (e.g. water? Electricity?).

The own code is released under the AGPLv3+ and copyright 2020 Felix Wolfsteller.

Some german incubative discussion is found at [https://meta-community.org/](https://meta-community.org/t/eigene-netzwerk-infrastruktur-dokumentations-software/387) (a German discourse forum for 'IT' people in intentional communities and like-minded).

## Usage

### Concepts

#### Locations

Locations should help you understand where e.g. cables end or where devices can be found.

#### Devices

Devices like Switches, Converters or patch panels (agreed, this is not a typical "device"). These can have different ports, In the case of a patch panel or a simple converter, a Port should be used twice and the device should be marked as "connector" upon creation.

#### Links

A Connection between a device and a location (or a device and a device or a location and a location), optionally with port assignment and name.

#### The test and examplary data

Find examplary data for tests in [test/fixtures/locations.yml](test/fixtures/locations.yml) etc. You can seed your database with this data using `rails db:fixtures:load`. Note that this will also create [a user (see password inside file)](test/fixtures/users.yml).

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
+-----------------+location: basement+-----+
|    router       Switch         Patchpanel|
|    pfSense      TL-N1           P-B      |
|    +---+        +---+          +---+     |
<----+ 1 |  +---->+ 1 |          | 1 |     |
|    | 2 +--+     | 2 +--+       | 2 |     |
|    | 3 |        | 3 |  +------>+ 3 +-----+----------+
|    +---+        | 4 |          | 4 |     |          |
|              +--+ 5 |          | 5 |     |          |
|              |  +---+          | 6 |     |          |
|              |                 +---+     |          |
|              |                           |          |
+--------------+---------------------------+          |
               |                                      |
               |           +-----+location: office+---+-+
               v           |   Switch      Patchpanel | |
 +--+location: floor+--+   |   TL-N2        P-O       | |
 |                     |   |   +---+       +---+      | |
 +---------------------+   |   | 1 |       | 1 |      | |
                           |   | 2 +<---+  | 2 |      | |
                           |   | 3 |    |  | 3 |      | |
                           |   | 4 |    +--+ 4 +<-----+ |
                           |   +---+       +---+        |
                           |                            |
                           +----------------------------+
```

## Setup

### Prerequisites

We are running a pretty default Ruby on Rails 6 stack, currently using Ruby 2.6.1 .
That means you need have to have

- ruby installed (e.g. with [rvm](rvm.io))
- sqlite3 or any other db engine installed
- graphviz installed (`sudo apt install graphviz` in most cases)
- the nodejs/yarn stuff installed

### Installation

- clone this repository
- run `bundle`
- run `rails db:migrate`
- fire up server (in dev, e.g. with `rails s`)
- create a User manually:

```bash
# Fire up a rails console, and enter relevant User.create! data, exit with CTRL+D
$ rails c                                                                                                                    git:(master|✚15…
Running via Spring preloader in process 14058
Loading development environment (Rails 6.0.2.1)
2.6.1 :001 > User.create! email: 'my@ma.il', password: 'mypassword', password_confirmation: 'mypassword'
   (2.3ms)  SELECT sqlite_version(*)
   (0.1ms)  begin transaction
  User Exists? (0.5ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = ? LIMIT ?  [["email", "my@ma.il"], ["LIMIT", 1]]
  User Create (1.1ms)  INSERT INTO "users" ("email", "encrypted_password", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["email", "my@ma.il"], ["encrypted_password", "$2a$11$hofRgWkBnjiGO6wtzkQVL.O6Jr/19FHuq1NM76focTArHx9IWAWvy"], ["created_at", "2020-02-11 09:03:12.280375"], ["updated_at", "2020-02-11 09:03:12.280375"]]
   (2.3ms)  commit transaction
 => #<User id: 980190964, email: "my@ma.il", created_at: "2020-02-11 09:03:12", updated_at: "2020-02-11 09:03:12">
2.6.1 :002 >
$
```

### Configuration

**Database** Follow the typical rails database configuration ([config/database.yml](config/database.yml)).

**E-Mail** To allow password reset etc. via e-mail (**only in production**), set following environment variables.

```bash
HOST=yourhost.comm
APP_HOST=yourhost.commm # to generate absolute URLs in mails
SENDER_EMAIL="Cabler\ Your\ Community\ <cabler@yourhost.commm>"
SMTP_SERVER=yourhost.commm
SMTP_DOMAIN=yourhost.commm
SMTP_PORT=587
SMTP_PWD=9098asdjlker!
SMTP_USER=iaowur32oalks
```

### Production deployment

See above for email settings

## Development

### Tests

There are very few tests which can be run with `rails t`. Use `rails test -f` for _fast-failing_ mode (abort after first test fail).

System-tests can be run with `rails test:system`.

### Contributing

Own code (mostly `app/` and `test/`) is released under the AGPLv3+ (included as file [LICENSE](LICENSE) in this repository).

Contributions are very welcome. Copyright-transfer of modifications to Felix Wolfsteller is assumed.

For fun, some of the files include comments to be compliant with [(FSFEs) reuse](https://reuse.software/).

## (Developer) Documentation

### Principles and goals

As we are dealing with models in the physical domain, following a resources based UI and API is fine (and Rails is meant to do that, allthough it is not thorrowly used in this project).

Prefer good old stable setup: no hard dependency on Javascript (only progressive enhancements), render on server side.

Use solid and stable standards and conventions if available.

### Included

- minimal `rails test`
- Could not use rails-erd succesfull with Rails 6 (https://github.com/voormedia/rails-erd/issues/322).
- `annotate` gem

### Markdown-rendering of CHANGELOG

The gems `emd` and `redcarpet` help in rendering markdown. The CHANGELOG is exposed via a PageController . The changelog file is symlinked like this:

```bash
cd app/views/pages
ln -s ../../../CHANGELOG.md changelog.md
```

A trick is to use a markdown layout (to wrap the rendered HTML in a bulma .content) that renders the application layout. For that, an `_application.html.haml` layout was symlinked:

```bash
cd app/views/layouts
ln -s application.html.haml _application.html.haml
```

### Stuff used

- [Ruby](https://www.ruby-lang.org/en/) and [Ruby on Rails](https://rubyonrails.org)
- [bulma.io](bulma.io) as CSS framework
- [HAML](http://haml.info/) for a saner way to produce HTML
- [devise](https://github.com/heartcombo/devise) for authentication
- [friendly_id](https://github.com/norman/friendly_id/) for ... friendly ids
- many others ...

### Design decisions

No explicit modeling of "Port"s (think of Ethernet-Switches), instead a very loose polymorphic Link model.
To make up the disadvantages of that choice, implemented classes to deal with ""directed" connections (for analysis):

- [Connection](app/models/connection.rb)
- [ConnectedDevice](app/models/connected_device.rb)

### Sprockets / Webpacker

In commit [#c1f38256350dfce601e8fd76e82efbbc95d3e134](https://github.com/ecovillage/cabler/commit/c1f38256350dfce601e8fd76e82efbbc95d3e134) Rails 6 shiny new webpacker asset pipeline mechanism (using webpack) was removed in favor of old stable sprockets. This makes deployment easier but engaged JavaScript development harder.

#### Problematic design decisions

Using the name "Device" and the gem "Devise" ... :)

#### Releasing

E.g. for version `0.1.0`:\

- Adjust VERSION in `config/application.rb`,
- adjust CHANGELOG,
- `git commit -m '0.1.0'`,
- `git tag -a '0.1.0' -m '0.1.0'`,
- `git push && git push --tags`.
