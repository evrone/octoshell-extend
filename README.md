# Bootstrap

## Install PostgreSQL 9 and setup db

~~~
createdb octoshell_developement
createuser octoshell
~~~

## Install rvm and ruby 1.9.3

<https://rvm.io/rvm/install/>

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

For test procedures:

~~~
irb -I.
require 'init'
procedure = AddUser.new
procedure.perform 
~~~

For test helpers start application:

~~~
unicorn
open http://0.0.0.0:8080
~~~