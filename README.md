# OmniAuth::Strategies::Jinshuju

OAuth2 Strategy for [Jinshuju](https://www.jinshuju.net/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-jinshuju'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-jinshuju

## Usage

You need `client_id` & `client_secret`.

Here's an example for adding the middleware to a Rails app in config/initializers/omniauth.rb:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jinshuju, ENV["JINSHUJU_CLIENT_ID"], ENV["JINSHUJU_CLIENT_SECRET"]
end
```

Or If your are using devise add follwing in config/initializers/devise.rb
```ruby
config.omniauth :jinshuju, ENV["JINSHUJU_CLIENT_ID"], ENV["JINSHUJU_CLIENT_SECRET"]
```

Then add the following to 'config/routes.rb' so the callback routes are defined.

```ruby
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
```

Make sure your model is omniauthable. Generally this is "/app/models/user.rb"

## Sample Auth Hash
```ruby
{
  "provider"=>"jinshuju",
  "uid"=>"123456",
  "info"=> {
    "name"=>"xiaojin",
    "email"=>"user@email.com",
  },
  "extra"=> {
    "raw_info"=> {
      "type"=>"user",
      "id"=>"123456",
      "name"=>"xiaojin",
      "login"=>"user@email.com"
    }
  }
}
```

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes along with test cases (`git commit -am 'Add some feature'`)
4. If possible squash your commits to one commit if they all belong to same feature.
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
