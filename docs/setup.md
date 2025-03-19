# Application Setup

In order to be able to run this application locally, you are required to make the following installation.

## Table of Contents

- Requirements
    - Install rbenv
    - Install Ruby
    - Install Bundler
    - Install Postgres
    - Install Node.js
- Database configuration
    - database.yml

# Requirements

### Install rbenv

rbenv is a version manager tool for the Ruby programming language on Unix-like systems. It is useful for switching between multiple Ruby versions on the same machine and for ensuring that each project you are working on always runs on the correct Ruby version.

In order to install rbenv on your MacOS computer follow these commands.
We're going to make use of the default package manager of MacOS, brew, so please ensure you have it installed and up-to-date.

```bash
    brew doctor
    brew update

    # install rbenv
    brew install rbenv
    
    # initilize rbenv
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    source ~/.zshrc

```

### Install Ruby

Thanks to rbenv, we can have multiple Ruby versions in our computers, so depending on the project needs we are able to switch from one to another witout any compatibilty issue.

In order to install ruby versions follow these commands.

```bash
    # You can list the available Ruby versions
    rbenv install -l

    # To install a specific version use this command
    rbenv install 3.4.2

    # To ensure you have ruby install run this
    ruby --version

    # To make that version global (default)
    rbenv global 3.4.2

    
    
    rbenv global 3.1.2   # set the default Ruby version for this machine
    # or:
    rbenv local 3.1.2    # set the Ruby version for this directory
```

### Install Bundler

Bundler is the way we manage our application Rubygem dependencies.

```bash
    gem install bundler
```

### Install Postgres

[Homebrew](https://brew.sh/) is the default package manager of MacOS, so we are going to make use of it to install our PostgreSQL client.

```bash
    brew doctor
    brew update

    # install postgres 14
    brew install postgresql@14

    # Start the service
    brew services start postgresql
```

Get access to the postgres console.
```bash
    psql postgres
```

To establish connection to the database, PostgreSQL requires us to create a role with *user* and *password*.

Create a role with name and password.
```postgresql
    # CREATE ROLE role_name WITH LOGIN PASSWORD password_for_user;
```

Add the attribute `Create DB` by altering the role.
```postgresql
    # ALTER ROLE role_name CREATEDB;
```


Later on, we're going to make use of the gem `pg`, which is the Ruby interface to PostgreSQL.
It seems like it assumes we install postgres the other way (by downloading it manually), which uses other paths.
The thing is that there's a specific library (libpq) that gets lost, so we need to tell where to find it due to the Homebrew installation.

We do that by exporting the correct path:

```bash
    # Export the correct libpq path
    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

    # Ensure libpq is linked correctly
    brew link --force --overwrite libpq
```
 

### Install Node.js

in progress ...

## Database configuration

### database.yml


```yml
common: &common
    pool: 30
    host: 127.0.0.1
    adapter: postgresql
    encoding: unicode
    reconnect: false

development:
  <<: *common
  database: insignis_db_development
  username: dev_user
  password: dev_user
  port: 5432

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *common
  database: insignis_db_test
  username: dev_user
  password: dev_user
  port: 5432


# Store production database in the storage/ directory, which by common
# is mounted as a persistent Docker volume in config/deploy.yml.
production:
  <<: *common
  database: insignis_db_production
  username: dev_user
  password: dev_user
  port: 5432
``

```bash
    EDITOR="code --wait" rails credentials:edit --environment production
    EDITOR="code --wait" rails credentials:edit --environment development
    EDITOR="code --wait" rails credentials:edit --environment test
    
    EDITOR="nano" rails credentials:edit --environment production
    EDITOR="nano" rails credentials:edit --environment development
    EDITOR="nano" rails credentials:edit --environment test
```

```bash
    bin/rails db:migrate
```