# Rails 5 API + Rspec example

> Customer Support Ticketing API.

## Front-end
The front-end for this API is [https://github.com/gazeldx/vue-spa-example](https://github.com/gazeldx/vue-spa-example)
You can run it to see how this API interactive with example SPA Web.

# Installation
## Database
This project I use mysql. You can easily replace MySQL to your favorite database like PostgreSQL. You can do this by editing `Gemfile` and `config/database.yml` 

### Installation Mysql
#### For Mac
```bash
brew install mysql
cd $(brew --prefix mysql)
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql
cd /usr/local/var/mysql
mysql.server start
```

## Ruby and Rails version
We use [rbenv](https://github.com/rbenv/rbenv) and [rbenv-gemset](https://github.com/jf/rbenv-gemset).

So please install `rbenv` and `rbenv-gemset` first.

## Install tickets project
```bash
cd /path/to/tickets
bundle
rails db:create
rails db:migrate
rails db:seed
puma # Then you can go to http://localhost:3000/
```

# Testing
```bash
cd /path/to/tickets
RAILS_ENV=test rails db:migrate
RAILS_ENV=test rails db:seed
rspec
```

# TODOs
* Versioning API. Before releasing our public API into the wild, we should consider implementing some form of versioning. Versioning breaks our API up into multiple version namespaces, such as v1 and v2, so that we can maintain backwards compatibility for existing clients whenever we introduce breaking changes into your API, simply by incrementing your API version.

Then we can GET like this: http://api.mysite.com/v1/users/

# Design
## Tickets
Here are five values for status: New, Open, Pending, Solved, Closed. A ticket's status can be set and updated either manually by an agent or via an action in an automation, macro, or trigger. The status can only be changed to Closed via automations and triggers (not manually).

* New means that the request was received but that it has not been opened and has probably not been assigned to an agent. The New status can indicate that the support team is evaluating it to determine who should be assigned to resolve it.

* Open means that the request has been assigned to an agent who is working to resolve it.

* Pending means that the assigned agent has a follow-up question for the requester. The agent may need more information about the support issue. Requests that are set to Pending typically remain that way until the requester responds and provides the information the agent needs to continue resolving the request.

* Solved means that the agent has resolved the support issue. Solved tickets are closed, typically, a number of days after they have been set to Solved (you can control when your tickets are closed by modifying the automation that is used to close tickets). Until a ticket is closed, the requester can reopen the ticket. For example, the requester may not agree with the agent that the support issue is resolved.

* Closed means that the ticket is complete and can't be reopened. Requesters however can create follow-up requests for closed requests.