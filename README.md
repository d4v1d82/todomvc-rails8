# Rails 8 • [TodoMVC](http://todomvc.com)

## Bootstrap Rails

```sh
rails new todo-rails8 --devcontainer
rails g scaffold todo title:string completed:boolean
```

## Setup dev

```sh
bundle install
rails db:migrate
```

## Run dev

```sh
rails dev
```

## Run tests

```sh
rails test:all
```

or

```sh
rails test
rails test:system
```
