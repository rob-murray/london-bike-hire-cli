## Barclays Bike London CLI

#### A simple command line interface to London's Barclays Bike API.

[![Build Status](https://travis-ci.org/rob-murray/barclays-bike-london-cli.svg?branch=master)](https://travis-ci.org/rob-murray/barclays-bike-london-cli)
[![Code Climate](https://codeclimate.com/github/rob-murray/barclays-bike-london-cli.png)](https://codeclimate.com/github/rob-murray/barclays-bike-london-cli)
[![Coverage Status](https://coveralls.io/repos/rob-murray/barclays-bike-london-cli/badge.png)](https://coveralls.io/r/rob-murray/barclays-bike-london-cli)
[![Dependency Status](https://gemnasium.com/rob-murray/ferver.svg)](https://gemnasium.com/rob-murray/barclays-bike-london-cli)
[![Gem Version](https://badge.fury.io/rb/barclays-bike-london-cli.svg)](http://badge.fury.io/rb/barclays-bike-london-cli)


### Description

This gem provides a command line interface to find information about London's Barclays Bike stations, it allows you to find stations by name or their ID and pull back information about the status of a station.

Here's the spec for **Barclays Bike London CLI**:

* Find all stations
* Find by ID
* Find by by name
* Display status of stations


### Getting started

Using **barclays-bike-london-cli** could not be simpler - just install the **barclays-bike-london-cli** gem.

```bash
$ gem install barclays-bike-london-cli
```


### Usage

You can run **barclays-bike-london-cli** from the command line as below...

##### Command line help

For a list of arguments just use the `-h` switch.

```bash
$ bbcli -h
````

##### Show status of a bike station by id

Here is what Feature 1 does and how to use it.

```bash
$ bbcli find {id}
````

##### Show status of a bike station by id

Here is what Feature 2 does and how to use it.

```bash
$ bbcli where {options}
$ bbcli where name: {name}
````


### Contributing

1. Fork it ( https://github.com/rob-murray/barclays-bike-london-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


### License

This project is available for use under the MIT software license.
See LICENSE
