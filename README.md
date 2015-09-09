# MathTypeToMathML

This gem can be used to convert MathType equations from a binary format (e.g. embedded in Word documents) to an open MathML representation. It achieves that in several stages, first using the [`mathtype`](https://github.com/jure/mathtype) gem to convert from a binary to an XML form of MTEF, and second, using XSLTs to convert XML to MathML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mathtype_to_mathml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mathtype_to_mathml

## Usage

To convert a MathType equation embedded in a Word document (the file is usually named something like `oleObject1.bin`):

```
mathml = MathTypeToMathML::Converter.new(`oleObject1.bin`).convert
```

This will return a MathML string of the MathType equation.

# Testing

Run `bundle exec rspec` to run specs. Additionally, you can create a visual output using `html_output.rb`, like so:

```
bundle exec ruby spec/html_output.rb > test.html
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mathtype_to_mathml/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
