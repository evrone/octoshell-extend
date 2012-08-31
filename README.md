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

~~~
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

~~~
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

Then add a view file to `app/views/new_script.slim`. [About slim-lang](http://slim-lang.com)

In `new_script.slim` you will have a `@script` variable.

~~~slim
p Free space: #{@script.result}
~~~

### Deploy

~~~
cap deploy
~~~
