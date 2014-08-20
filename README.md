## Barclays Bike London CLI

#### A simple command line interface to London's Barclays Bike API.

[![Build Status](https://travis-ci.org/rob-murray/barclays-bike-london-cli.svg?branch=master)](https://travis-ci.org/rob-murray/barclays-bike-london-cli)
[![Code Climate](https://codeclimate.com/github/rob-murray/barclays-bike-london-cli.png)](https://codeclimate.com/github/rob-murray/barclays-bike-london-cli)
[![Coverage Status](https://coveralls.io/repos/rob-murray/barclays-bike-london-cli/badge.png)](https://coveralls.io/r/rob-murray/barclays-bike-london-cli)
[![Dependency Status](https://gemnasium.com/rob-murray/ferver.svg)](https://gemnasium.com/rob-murray/barclays-bike-london-cli)
[![Gem Version](https://badge.fury.io/rb/barclays-bike-london-cli.svg)](http://badge.fury.io/rb/barclays-bike-london-cli)
[![Haz Commitz Status](http://haz-commitz.herokuapp.com/repos/rob-murray/barclays-bike-london-cli.svg)](http://haz-commitz.herokuapp.com/repos/rob-murray/barclays-bike-london-cli)


### Description

This gem provides a command line interface to find information about London's Barclays Bike stations, it allows you to find stations by name or their ID and pull back information about the status of a station.

![Boris](boris_with_bike.jpg?raw=true "Boris Johnson on a bike")

Here's the spec for **Barclays Bike London CLI**:

* Find all stations
* Find nearest station (by Postcode)
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

##### List all bike stations

List all however-many-hundred bike stations there are. With pagination.

```bash
$ bbcli all
````

##### Find the nearest bike station

Find a the nearest bike station to the specified type below. This will return ten stations.

Available types:

* Postcode

```bash
$ bbcli near --{type} {search_value}
$ bbcli near --postcode N19AE
````

##### Show status of a bike station by id

Find a Bike station by it's Tfl station ID. This will return one station.

```bash
$ bbcli find --id {id}
$ bbcli find --id 439
````

##### Find all bike stations by name

Search all bike stations' name attribute for the search value. This will return zero or more results.

```bash
$ bbcli where --{attribute} {search_value}
$ bbcli where --name kings
````

##### Results

```bash
$ bbcli find --id 439
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Feed updated: 2014-08-12 08:45:01
>>> Dock
Id: 439
Name: Killick Street, Kings Cross
Lat: 51.5338
Long: -0.118677
Temporary: false
Bikes: 4
Docks_free: 18
Docks_total: 22
Link to map: https://www.google.co.uk/maps/preview/@51.5338,-0.118677,17z
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
```

### Contributing

1. Fork it ( https://github.com/rob-murray/barclays-bike-london-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

#### Development

Install dependancies

```bash
$ bundle install --no-deployment
```

Run test script as entry point to application

```bash
$ ruby test.rb find --id 439
```


### License

This project is available for use under the MIT software license.
See LICENSE

The above image is distributed by [Andrew Parsons/ i-Images](https://www.flickr.com/photos/53797600@N04/6849997220) via a Attribution-NoDerivs 2.0 Generic License.
