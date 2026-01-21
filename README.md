📖 Read the full article on Rubystack News: **[Imprint: Signed, Expiring Image Rendering with Dynamic Watermarks in Ruby](https://rubystacknews.com/2026/01/21/imprint-signed-expiring-image-rendering-with-dynamic-watermarks-in-ruby/)**

# Imprint Image


![](docs/images/main-jp.png)

---

![](docs/images/main.png)

**Signed, expiring image watermark rendering for Ruby**

`imprint-image` is a Ruby library for generating **signed, time-limited image renders** with **dynamic text watermarks**.
It allows you to securely distribute images using **expiring tokens**, preventing unauthorized reuse, hotlinking, or permanent access.

The library is **framework-agnostic** and works as pure Ruby, with **optional Rails integration**.

Image rendering is powered by the **GD graphics library**.

---

## Features

- 🔐 Signed tokens with expiration
- 🖼 Dynamic text watermarks rendered on the fly
- ⏱ Time-limited image access
- 🚫 Prevents hotlinking and unauthorized reuse
- 🧩 Pure Ruby core
- 🚆 Optional Rails integration (no forced dependency)

---

## Installation

### RubyGems

```bash
gem install imprint-image
```

or in your `Gemfile`:

```ruby
gem 'imprint-image'
```

---

## Requirements

- Ruby ≥ 3.3
- GD graphics library (`libgd`)
- The `ruby-libgd` gem (installed automatically)

On Debian / Ubuntu:

```bash
sudo apt install libgd-dev
```

---

## Basic Usage (Pure Ruby)

### Generate a signed token

```ruby
token = Imprint.sign(
  source: '/path/to/image.png',
  watermark: 'CONFIDENTIAL',
  expires_in: 60
)
```

---

### Render an image from a token

```ruby
output_path = Imprint.render_from_token(token)

if output_path
  puts "Rendered image at: #{output_path}"
else
  puts "Token expired or invalid"
end
```

---

## Rails Integration (Optional)

Imprint does **not** force routes or controllers.

### Example Route

```ruby
get '/imprint/:token', to: 'imprint#show'
```

---

### Example Controller

```ruby
class ImprintController < ApplicationController
  def show
    path = Imprint.render_from_token(params[:token])
    return head :not_found unless path
    send_file path, type: 'image/png', disposition: 'inline'
  end
end
```

---

### Example View

```erb
<img src="/imprint/<%= token.split('/').last %>" />
```

---

## Rails View Helper

```erb
<%= imprint_image_tag(token, class: "watermarked") %>
```

---

## Security Model

- Tokens are signed and tamper-proof
- Tokens include an expiration timestamp
- Expired tokens cannot be rendered

---

## Temporary Files

Rendered images are written to `Dir.tmpdir`.
You are responsible for cleaning them if needed.

---

## Development

```bash
bundle install
bundle exec rake
```

---

## License

MIT License.

---

## Author

Germán Giménez Silva  
https://github.com/ggerman
