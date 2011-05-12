Feature: Integrate with application

  Background:
    When I successfully run `rails new testapp`
     And I cd to "testapp"
     And I remove the file "public/index.html"
     And I add the "simple-auth" gem
     And I add the "cucumber-rails" gem
     And I run `bundle install --local`
     And I successfully run `rails generate cucumber:install`

     And I successfully run `rails generate simpleauth:features`

  Scenario: Should pass the generates tests

    When I successfully run `rails generate simpleauth:install`
     And I successfully run `rake db:migrate`
     And I successfully run `rake cucumber`

    Then the output should contain "passed"
     And the output should not contain "failed"
     And the output should not contain "Could not find generator"
