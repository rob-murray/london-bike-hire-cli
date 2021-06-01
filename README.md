## London Bike Hire CLI

#### A simple command line interface to London's Bike Hire API.

[![Gem Version](https://badge.fury.io/rb/london-bike-hire-cli.svg)](http://badge.fury.io/rb/london-bike-hire-cli)

### Description

This gem provides a command line interface to find information about London's Bike Hire stations, it allows you to find stations by name or their ID or a location and retrieve information about the status of a station.

I got fed up digging through [the official map](https://web.barclayscyclehire.tfl.gov.uk/maps) to see which bike stations were free - everyone knows the command line is way more efficient.

![Boris](boris-on-a-bike_med.jpg?raw=true "Boris Johnson on a bike")

Here's the spec for **London Bike Hire CLI**:

* [Find all stations](#list-all-bike-stations)
* [Find by ID](#find-a-bike-station-by-id)
* [Find nearest station](#find-the-nearest-bike-station)
* [Find by name](#find-all-bike-stations-by-name)
* [Display status of stations](#results)

![Demo commands](bike-cli.gif?raw=true "Some London Bike Hire CLI example commands in terminal")

### Getting started

Using **london-bike-hire-cli** could not be simpler - just install the **london-bike-hire-cli** gem.

```bash
$ gem install london-bike-hire-cli
```


### Usage

You can run **london-bike-hire-cli** from the command line with just the `lbh` command.

#### Command line help

For a list of arguments just use the `-h` switch.

```bash
$ lbh -h
````

#### List all bike stations

List all however-many-hundred bike stations there are. With pagination.

```bash
$ lbh all
````

#### Find the nearest bike station

Find a the nearest bike station to the specified type below. This will return five stations.

Available types:

* `search` - Most search terms; such as placename, postcode
* `id` - An ID of another bike station

```bash
$ lbh near --{type} {search_value}

# Near by search term
$ lbh near --search N19AE
$ lbh near --search 'waterloo station'

# Near another bike station id
$ lbh near --id 123
```

**Note:** Don't forget to wrap search term in quotes if it contains spaces.

#### Find a bike station by id

Find a Bike station by it's Tfl station ID. This will return one station.

```bash
$ lbh find --id {id}
$ lbh find --id 439
````

#### Find all bike stations by name

Search all bike stations' name attribute for the search value. This will return zero or more results.

```bash
$ lbh where --{attribute} {search_value}
$ lbh where --name kings
````

#### Results

```bash
$ lbh find --id 439
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----- Bike station
Id: 439
Name: Killick Street, Kings Cross
Lat: 51.5338
Long: -0.118677
Temporary: false
Bikes: 13
Docks_free: 9
Docks_total: 22
Link to map: https://www.google.co.uk/maps/preview/@51.5338,-0.118677,17z
Updated at: 2015-03-31 20:46:01
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
```

### Contributing

1. Fork it ( https://github.com/rob-murray/london-bike-hire-cli/fork )
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

The above image is copyright 2015 Getty Images - Getty Images for Santander.
