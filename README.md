# imprint
Secure, signed image rendering for Rails

## Installation

### System dependencies

```bash
Ubuntu:
sudo apt install libgd-dev
```

macOS:
```bash
brew install gd
```

### Gemfile
```bash
gem 'imprint'
```



## Rails integration

Imprint is framework-agnostic, but integrates cleanly with Rails.

### Routes

Define your own route:

```ruby
# config/routes.rb
get '/imprint/:token', to: 'imprint#show'
```
### Controller

```ruby
class ImprintController < ApplicationController
  def show
    path = Imprint.render_from_token(params[:token])

    return head :not_found unless path

    send_file path, type: 'image/png', disposition: 'inline'
  end
end
```

### Usage

```ruby
token = Imprint.sign(
  source: '/path/to/image.png',
  watermark: 'CONFIDENTIAL',
  expires_in: 5.minutes
)
```
```html
<img src="/imprint/<%= token.split('/').last %>" />
```
