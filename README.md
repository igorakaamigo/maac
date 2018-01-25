# Modal As A Confirm (MAAC)

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

### Installing dependencies

    $ bundle install

### Testing

    $ rake

TODO: Write other steps

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igorakaamigo/maac.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
