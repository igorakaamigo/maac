# Modal As A Confirm (MAAC)

[![License](https://img.shields.io/github/license/igorakaamigo/maac.svg)](https://github.com/igorakaamigo/maac/blob/master/MIT-LICENSE)
[![Build Status](https://img.shields.io/travis/igorakaamigo/maac/master.svg)](https://travis-ci.org/igorakaamigo/maac)
[![Gem](https://img.shields.io/gem/v/maac.svg)](https://rubygems.org/gems/maac)

This gem allows you to replace standard confirm() call for data-confirm'ed page elements,
with a bootstrap modal. I.e. instead of calling confirm("Are you sure?") this code will draw
a bootstrap yes-no modal after clicking the link.
For now, you can customize dialog texts using following attributes:

- **data-confirm-title** - *dialog title text: default value is "Confirm"*

- **data-confirm-yes** - *yes-button text: default value is "Yes"*

- **data-confirm-no** - *no-button text: default value is "No"*

- **data-confirm-close** - *close cross title: default value is "Close"*

```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            confirm: 'Are you sure?'
        } %>
```
There are lots of gems for the same purpose, but I found nothing appropriate for Rails 5.
So I've made it for my purposes. I'll be happy if you find it useful.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'maac'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maac

## Usage

/app/assets/javascripts/application.js:
```javascript
//= require rails-ujs
//= require bootstrap/modal
//= require maac
```

Somewhere in views:
```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            confirm: 'Are you sure?'
        } %>
```

Or:
```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            confirm: 'Are you sure?'
            'confirm-title': 'Danger!',
            'confirm-yes': 'Proceed',
            'confirm-no': 'Cancel',
            'confirm-close': 'Never mind'
        } %>
```

## Development

Most important steps are described below. You can also look at defined rake tasks by typing:

    $ rake -T

### Setup

You must perform a few simple steps to prepare the project for development:

    $ bundle install
    $ rake db:migrate
    $ rake

### Testing

The project uses automated testing. The RSpec is used.
The /spec directory contents:

- **/spec/dummy** - *a simple rails app used for gem testing*
- **/spec/factories** - *factory_bot factory descriptions*
- **/spec/features/maac_features_spec.rb** - *gem specifications*
- **/spec/spec_helper.rb** - *a helper file*

To start automated testing just type:

    $ rake

### Building

To build a gem, type:

    $ rake build

### Releasing

To create a tag, build and push gem to rubygems.org, type:

    $ rake release

### Versioning

A current version is defined in **lib/maac/version.rb** file.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igorakaamigo/maac.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
