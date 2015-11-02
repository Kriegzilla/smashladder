![alt text](/public/SmashLadderLogo.png)

# Introduction

SmashLadder is a leaderboard for Super Smash Bros. Melee, driven by user submitted data. The application was built by Ian Campbell during the Fall 2015 cohort of Launch Academy (http://www.launchacademy.com/).


![Build Status](https://codeship.com/projects/a76708e0-4dc5-0133-9265-524cf6105349/status?branch=master)
[![Code Climate](https://codeclimate.com/github/Kriegzilla/smashladder/badges/gpa.svg)](https://codeclimate.com/github/Kriegzilla/smashladder) ![Coverage Status](https://coveralls.io/repos/kriegzilla/smashladder/badge.png)

# Topics
- [Setup](#setup)
- [Features](#features)
- [Development](#development)
    - [Testing](#testing)
    - [Test Development](#test-development)
- [ER Diagram](#er-diagram)
- [License](#license)

# Initial Setup

If you're cloning this for whatever reason, make sure to run the seeder file! The app WILL NOT WORK if you don't - it contains all the information about stages and characters that will populate the New Game form.


# Features

- The ability to add details and a description of completed games.
- The ability to confirm or delete games you've been added to, before the leaderboard is updated.
- The ability to view a summary of every game played by every user.
- The ability to choose a profile photo using a url.
- A ranking system that automatically updates each user as new games are confirmed and added to the database.
- Data visualization for each user (wins/losses against each other user they've played against, and wins with their most used characters) - (Front end: Javascript/Highcharts, back end: Rails/ActiveRecord queries)

# Development

SmashLadder was developed in Ruby on Rails.  Initial setup was done using the make_it_so gem (https://github.com/LaunchAcademy/make_it_so).  

Other relevant gems:

- Foundation (http://foundation.zurb.com/) was used for css styling.
- Devise (https://github.com/plataformatec/devise) was used for authentication.

## Testing

For development tasks such as running benchmarks or testing, you need to clone the repository and install bundle.  All required gems are listed in the Gemfile.

Install [bundle](http://bundler.io/).

    git clone git@github.com:Kriegzilla/smashladder.git
    cd smashladder
    bundle install

## Test Development

The following gems were used to develop and run unit and feature tests:
- RAKE (http://rake.rubyforge.org/)
- RSpec (http://rspec.info/)
- Capybara (https://github.com/jnicklas/capybara)
- shoulda-matchers (http://matchers.shoulda.io/)
- valid_attributes (https://github.com/bcardarella/valid_attribute)

To prepare for testing, run:

    rake db:test:prepare

To run all test files, run:

    rake

You may specify an individual test file to run using rspec:

    rspec <full test name>

For example:

    rspec spec/features/user_adds_a_game_spec.rb

# ER Diagram

![Entity Relationship Diagram](/app/assets/images/SmashLadder.png)

# License

The MIT License (MIT)

Copyright (c) 2014 Petka Antonov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
