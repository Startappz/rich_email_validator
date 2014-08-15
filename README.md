# RichEmailValidator

A set of helpers to validate emails:

- [x] Validate an email
- [x] Filter a list of emails
- [x] Filter a list of emails from file
- [x] Filter a list of emails from file and output to file

It works as follows:

- Checks the availability of the mx records of the email's domain. This is done via a DNS lookup.
- Checks the format of the email via a regular expression that can be configured. **This is done for performance only**.
- Use a configurable number of threads to check thousands of emails in minutes.

## Installation

Add this line to your application's Gemfile:

    gem 'rich_email_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rich_email_validator

## Usage

### Validate an email

```ruby
require 'rich_email_validator'
RichEmailValidator.valid_email?('khellls@gmail.com') # => true
RichEmailValidator.valid_email?('khellls@g.com') # => false because DNS lookup check
```
### Set a predfined Regexp

It's only used for **performace reasons** to filter the format of an email before doing a DNS lookup check.

The current value is:

```ruby
/\A[\w!#$%&'*+\/=?`{|}~^-]+(?:\.[\w!#$%&'*+\/=?`{|}~^-]+)*@(?:[A-Z0-9-]+\.)+[A-Z]{2,6}\Z/i

```

You can change it:
```ruby
# Customized email regular expression
RichEmailValidator.email_regexp = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 

```

### Filter a list of emails

```ruby
list = ['khellls@g.com', 'khellls@gmail.com']
RichEmailValidator.filter_list(list) #=> ["khellls@gmail.com"]

# You have a fine grained control, so you can control threads count
# Default is 20
RichEmailValidator.filter_list(list, threads_count: 15)

```

### Filter a list of emails from file

```ruby
file_path = '/path/to/emails_list'
File.readlines(file_path).size #=> 15 
RichEmailValidator.filter_file(file_path).size #=> 10 

# You have a fine grained control, so you can control threads count
# Default is 20
RichEmailValidator.filter_file(file_path, threads_count: 15)

```

### Filter a list of emails from file and output to file

```ruby
file_path = '/path/to/emails_list'
output_path = '/path/to/output'
File.readlines(file_path).size # => 15 
RichEmailValidator.export_valid_list(file_path, output_path)
File.readlines('output.txt').size #=> 10 

# You have a fine grained control, so you can control threads count
# Default is 20
RichEmailValidator.export_valid_list(file_path, output_path, threads_count: 15)

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rich_email_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
