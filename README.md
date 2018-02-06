# Modal As A Confirm (MAAC)

[![License](https://img.shields.io/github/license/igorakaamigo/maac.svg)](https://github.com/igorakaamigo/maac/blob/master/MIT-LICENSE)
[![Build Status](https://img.shields.io/travis/igorakaamigo/maac/master.svg)](https://travis-ci.org/igorakaamigo/maac)
[![Gem](https://img.shields.io/gem/v/maac.svg)](https://rubygems.org/gems/maac)

This gem allows you to replace standard confirm() call for data-confirm'ed page elements,
with a html modal (Bootstrap modal or a custom markup). I.e. instead of calling confirm("Are you sure?") this code will draw
a yes-no popup after clicking the link.

```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            confirm: 'Are you sure?'
        } %>
```

```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            'confirm-title': 'Oh, no!',
            confirm: 'Are you sure?'
        } %>
``` 

There are lots of gems for the similar purposes, but I found nothing appropriate for Rails 5.1
So I've made it for my own purposes. I'll be happy if you find it useful.

## Run-time configuration
You can simply customize titles via link attributes:

- **data-confirm-title** - *dialog title text: default value is "Confirm"*

- **data-confirm-yes** - *yes-button text: default value is "Yes"*

- **data-confirm-no** - *no-button text: default value is "No"*

- **data-confirm-close** - *close cross title: default value is "Close"*

```rhtml
<%= link_to 'A very dangerous action',
        dangerous_action_path,
        data: {
            method: :delete,
            confirm: 'Are you sure?',
            'confirm-title': 'Important!',
            'confirm-yes': 'Proceed',
            'confirm-no': 'Dismiss',
            'confirm-close': 'Never mind'
        } %>
```

## Initialization
If your gemfile includes a gem, which is named with something containing "bootstrap",
the bootstrap modal'll be used by default. Otherwise it will use the following template code:

```html
<div class="maac-popup">
    <div class="maac-popup_inner">
        <div class="maac-popup_header">
            <div class="maac-popup_header_title">%{title}</div>
            <div class="maac-popup_header_buttons">
                <a id="js-maac-close" href="javascript:void(0)" class="maac-popup_header_buttons_button maac-popup_header_buttons_button__close">%{close}</a>
            </div>
        </div>
        <div class="maac-popup_body">%{text}</div>
        <div class="maac-popup_footer">
            <div class="maac-popup_footer_buttons">
                <a id="js-maac-yes" href="javascript:void(0)" class="maac-popup_footer_buttons_button maac-popup_footer_buttons_button__yes">%{yes}</a>
                <a id="js-maac-no" href="javascript:void(0)" class="maac-popup_footer_buttons_button maac-popup_footer_buttons_button__no">%{no}</a>
            </div>
        </div>
    </div>
</div>
```

You can add an initializer, i.e.:
*/config/initializers/maac.rb*:
```ruby
Maac.configure do |config|
  # Strings to be substituted into template
  # (using %{key}). You can define your own set of keys
  config.strings = {
    title: 'A default title value',
    yes:   'A default Yes button text',
    no:    'A default No button text',
    close: 'A default Close button text'
  }

  # A modal' template code
  config.template      = '<div class="my-modal"><span id="js-yes">%{yes}</span><span id="js-no">%{no}</span></div>'

  # A modal' selector – used to remove the modal code and
  # for event bindings 
  config.selector      = '.my-modal'

  # Selector of a yes button 
  config.selector_y    = '#js-yes'

  # Selector of a no button
  config.selector_n    = '#js-no'
  
  # Callback, which is called just after the modal code
  # appended to a page
  config.after_append  = 'function () {}'

  # Async handler, called before code removement.
  # After your code completes the execution call cb()
  config.before_remove = 'function (cb) { cb(); }'
end
```

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

Simply run:

    $ bundle install
    $ rake dummy:dep
    $ rake

And rake will compile the .coffee.erb code and run all tests for you.

### Testing

The project uses automated testing. The RSpec is used.
The /spec directory contents:

- **/spec/features/client_spec.rb** - the main behaviour testing
- **/spec/features/config_spec.rb** - the gem' configuration testing
- **/spec/features/host_application_spec.rb** - dummy application, which uses the maac, testing
 
- **/spec/support/dummy** - dummy applications
- **/spec/support/dummy/vanilla** - a dummy app, which uses neither jQuery nor Bpptstrap
- **/spec/support/dummy/bs3** - a dummy app, which uses both jQuery and Bpptstrap

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
