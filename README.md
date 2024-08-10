# CRM BACKEND

This project has been built as a part of a recruitment process for the Agile Monkeys recruitment team.

It implements a backend system for a CRM, consisting of users and customers, and functionalities for listing, editing and deleting such records.

## Getting Started

This project has originally been developed to run on a local development environment. It has been developed using:

- Ruby 3.2.2
- Rails 7.2
- SQLite 3

Please verify you have the appropriate versions in place (or a compatible one).

To get this project started:

1. Clone the repository
1. Install dependencies running `bundle install`. You might need to install or upgrade the `bundler` gem
1. Create and seed the DB (`rails db:migrate` and `rails db:seed`). This will allow you to set up the server and test the functionalities
1. The included file called `` is a collection of Postman requests that you can use to verify the functionalities. Make sure to first use the `login` request and use the obtained JWT token on the Authorization header for all other requests.

## Functionalities

The following functionalities are available for all users:

- Listing all customers
- Seeing all details for a specific customer
- Creating a customer
- Editing a customer
- Deleting a customer

The following functionalities are avalable for admins only:

- Listing all users
- Creating an user
- Editing an user
- Promoting an user to admin and viceversa
- Deleting a user

## Testing

Tests for this project have been written to use `rspec`. Additionally, the `simplecov` gem has been leveraged to confirm unit test coverage.

## Using Docker

`TBI`

## CI/CD

To contribute:

1. Branch off `main`
1. Make all relevant changes
1. Create a new PR from your branch into `main`

When the PR is approved and the branch has been merged, the changes will be automatically deployed.

