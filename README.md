# PipeDrive Ruby Wrapper
ruby wrapper of pipe drive api

### Install
##### Gem

```ruby
gem install pipe_drive_ruby_wrapper
```
##### Gemfile

```ruby
gem 'pipe_drive_ruby_wrapper'
```

### Configure

*You must call below instruction before you start to use this gem*

```ruby
PipeDrive.setup do |config|
  config.api_token = [Your API Token obtain from pipedrive website]
end
```

### Usage
*You should require first*

```ruby
require 'pipe_drive_ruby_wrapper'
```

use person resource as example

* list all resource

```ruby
PipeDrive::Person.list
```

* find by id

```ruby
PipeDrive::Person.find_by_id(1)
```

* find by other field (only return one resource)
	* strict (only the same can be found) 

	```ruby
	PipeDrive::Person.find_by(:name, {name: 'Test'}, PipeDrive::STRICT)
	```

	* not strict (can be found if similar)

	```ruby
	PipeDrive::Person.find_by(:name, {name: 'Test'})
	```

* search for specific field (return array of resources, can be found if similar)

```ruby
PipeDrive::Person.search(:name, {name: 'Test'})
```

* update resource

```ruby
PipeDrive::Person.update(1, {name: 'new name'})
```

* delete resource

```ruby
PipeDrive::Person.delete(1)
```