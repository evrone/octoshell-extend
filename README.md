# Bootstrap

## Install PostgreSQL 9 and setup db

~~~
createdb octoshell_developement
createuser octoshell
~~~

## Install rvm and ruby

<https://rvm.io/rvm/install/>

~~~
rvm install 1.9.3
~~~

## Clone Project

~~~
git clone git@github.com:evrone/octoshell-extend.git
~~~

## Install gems

~~~
cd octoshell-extend
bundle
~~~

## Start

### Testing procedures

~~~bash
irb -I.
require 'init'
procedure = AddUser.new(task)
procedure.perform 
~~~

For add new procedure you should add `new_procedure.rb` file to `app/procedures` with the following code:

~~~ruby
class NewProcedure < Procedure
  def perform
    # executed code here
  end
end
~~~

`perform` method should return a boolean result.

### Testing helper scripts

~~~bash
unicorn
open http://0.0.0.0:8080
~~~

For add new helper you should add `new_script.rb` file to `app/scripts` with the following code:

~~~ruby
class NewScript
  attr_reader :result
  
  def run
    # get result
    @result = "255 Tb"
  end
end
~~~

Class should respond to `run` method.

Then add a view file to `app/views/new_script.erb`. [About erb](http://ruby-doc.org/stdlib-1.9.3/libdoc/erb/rdoc/ERB.html)

In `new_script.erb` you will have a `@script` variable.

~~~erb
$("#extend").html("Free space: <%= @script.result %>");
~~~

**Output file will be javascript.**

You can also user partials:

First you should add a new partial to `app/views/partials/your_partial.slim`. [About slim-lang] (http://slim-lang.com)

Slim template will returns underscore template **html** that will be used as **underscore template**. [About underscore.js](http://underscorejs.org/#template)

### Deploy

~~~bash
cap deploy
~~~
