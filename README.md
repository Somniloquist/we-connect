# railsbook
A mock social media appliction. Final project of [The Odin Project](https://www.theodinproject.com/lessons/final-project). Sign up for an account, customize your profile, create posts, upload photos, add friends, like and comments on other user's posts/comments.

![home page preview](https://github.com/Somniloquist/railsbook/blob/master/public/home.png)
![user page preview](https://github.com/Somniloquist/railsbook/blob/master/public/user.png)

## Try it out on Heroku
[Try the live version on Heroku here.](https://railsbook-00001.herokuapp.com/)

Use the test user account below to login if you wish to skip the signup process
```
email: testuser@example.com
password: password
```

## Installation
### Prerequisites
- ruby 2.6.4
- rails 5.2.4

1. Install the neccessary gems
```
bundle install --without production
```
2. Start the postgresql database server
```
sudo service postgresql start
```
3. Create the postgresql database
```
rails db:create:all
```
4. Run the migrations and seed with test data
```
rails db:migrate
rails db:seed
```
5. Start the rails server
```
rails server
```

If you run into any database errors follow the database configuration below. This app runs on a PostgreSQL database, you must have the server installed and running to install this app.

## Database configuration
 1. Install PostgreSQL
 ```
 sudo apt-get update
 sudo apt-get install postgresql postgresql-contrib libpq-dev
 ```
 2. Start the postgresql database server
 ```
 sudo service postgresql start
 ```
 3. Login to the postgresql server as postgres superuser
 ```
 sudo -u postgres psql
 ```
 4. Create a new role for your user (must be the same name as your currently logged in user)
 ```
 postgres=# CREATE ROLE [username] WITH CREATEDB LOGIN;
 ```

---
_This project is part of [The Odin Project](https://www.theodinproject.com/) curriculum. [View project description](https://www.theodinproject.com/lessons/final-project)._
