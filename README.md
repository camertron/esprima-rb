## esprima-rb  [![Build Status](https://secure.travis-ci.org/camertron/esprima-rb.png?branch=master)](http://travis-ci.org/camertron/esprima-rb)

Esprima (esprima.org) is an educational ECMAScript (also popularly known as JavaScript) parsing infrastructure for multipurpose analysis. It is also written in ECMAScript.  This library wraps the Esprima JavaScript library for easy use within Ruby.

At the moment, esprima-rb only supports the Esprima parser / AST generator.  If you'd like to add additional functionality, please send a pull request.

### Installation

Install the gem as you would any other:

```
gem install esprima
```

Then, require it in your project:

```ruby
require 'esprima'
```

### Parsing JavaScript

Generate an AST [abstract syntax tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree) by using the `Esprima::Parser` class.

```ruby
parser = Esprima::Parser.new
parser.parse("14 + 6;")
```

Here's the output for the example above:

```
{
  :type => "Program",
  :body => [{
    :type => "ExpressionStatement",
    :expression => {
      :type => "BinaryExpression",
      :operator => "+",
      :left => {
        :type => "Literal",
        :value => 14
      },
      :right => {
        :type => "Literal",
        :value => 6
      }
    }
  }]
}
```

## Requirements

No external requirements.

## Running Tests

Run `bundle exec rake` or `bundle exec rspec`.

## Authors

* Cameron C. Dutro: https://github.com/camertron
* The Esprima team including Ariya Hidayat: https://github.com/ariya

## Links
* esprima [https://github.com/ariya/esprima](https://github.com/ariya/esprima)

## License

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0