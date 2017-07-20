# qpidd Cookbook

[![Build Status](https://travis-ci.org/liudasbk/qpidd-cookbook.svg?branch=master)](https://travis-ci.org/liudasbk/qpidd-cookbook) [![Cookbook Version](https://img.shields.io/cookbook/v/qpidd.svg)](https://supermarket.chef.io/cookbooks/qpidd)

Provides a custom resources for installing instances of Apache Qpid.

## Requirements

### Platforms

- Debian 7
- RHEL and derivatives (verions 6 and 7)
- Fedora

### Chef

- Chef 12.5+

## Custom Resources

### service

Adds or removes an instance of Apache Qpid.

#### Actions

- `:create` - Installs and configures an instance of Qpid.
- `:start` - Starts an instance of Qpid.
- `:stop` - Stops an instance of Qpid.
- `:delete` - Removes an instance of Qpid (configuration and directories). NOT IMPLEMENTED.

#### Properties

- `:port` - TCP port to listen on. Default: 5672.
- `:interface` - Interface to bind on (does nothing on Debian). Default: `0.0.0.0`.
- `:variables` - Hash of additional parameters to put in Qpid config. Please see qpid man page for more. Default: `{}`.

#### Examples

Create a new Qpid instance named `default`:

```ruby
qpid_service 'default' do
  action :create
end
```

Create and start a new Qpid instance on port 5673:

```ruby
qpid_service 'custom' do
  port 5673
  action [:create, :start]
end
```

Create a new Qpid instance with custom configuration:

```ruby
qpid_service 'custom' do
  variables({ 'tcp-nodelay' => true, 'auth' => true, 'max-connections' => 100 })
  action [:create, :start]
end
```

## License & Authors
```
# The MIT License (MIT)
#
# Copyright:: 2017, Liudas Baksys
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
```
