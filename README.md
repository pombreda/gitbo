#GITBO/UNTY

##A Github issues aggregator

Gitbo aggregates public issues from Github and ranks them based on a popularity algorithm so developers can easily find projects to make significant contributions.

You can play with the application at <http://git.bo>

##Contributing
Please see the [Contribution Guidelines](https://github.com/flatiron-school/gitbo/blob/master/CONTRIBUTING.md)

##Setting Up Gitbo
We have included a bootstrap script that sets-up the application, which requires [Memcached](http://memcached.org/) and [Redis](http://redis.io/) to be installed on the system. The script may prompt you to install these programs if you don't already have them installed.

For the bootstrap script to work below we are assuming that you have SQLite installed. If you do not, then you likely want to customize your `database.yml` file before you run the script.

###Easy Set-Up
1. Clone the repo
2. Run `script/bootstrap` in terminal.
3. Set up your Github API keys and secret token in `application.yml` (see directions below).
4. Set up any custom database configuration in `database.yml` (our example is automatically configured for sqlite3, change as desired).

###To Register application for Github OAuth
Go to <https://github.com/settings/applications> and register your application to get the application keys needed for OAuth.

- URL for development environment: `http://localhost:3000`
- Callback: `http://localhost:3000/auth/github/callback`

We have created our application so that you can set up different application credentials for each environment in the `application.yml` file. When creating a new application on Github for your production environment replace the URL and callback settings on Github to your specific production URLs. For example,

- URL : `http://openissu.es/`
- Callback: `http://openissu.es/auth/github/callback`


##Copyright
Created by [Flatiron School](http://flatironschool.com/), [Adam Jonas](https://github.com/ajonas04), [Kevin McNamee](https://github.com/kevinmcnamee), [Josh Rowley](https://github.com/joshrowley), [Jenya Zueva](https://github.com/innatewonderer). See our license (LICENSE.txt) for more details.
