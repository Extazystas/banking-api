## This is Server side API. Part of Test assignment for fetching banking data (daily currencies) from NBRB.

- `Device` used for user managment and **JWT authentication is used for API authentication**.
- API has POST `/api/authenticate` endpoint for JWT authentication.
- API has GET `/api/v1/currencies.json` endpoint available after authentication.
It takes `day` param if you want to fetch currencies for a specific day.
By default it will return all available in DB currencies. At some point pagination and caching should be added.
- **Currency** is a list of daily currencies. Is has json `daily_rates` list and `valid_at` timestamp.
Fetched daily by `cron job`.
Also can be populated by running rake task `rake currencies:generate_for_a_month_before_today`.

- Units specs written with `Rspec`.

- Banking info is fetched from official National Belarussian Bank website with `savon` SOAP client.

- **Rubocop** is used for a good code style. Run example: `rubocop app/ spec/`

## Tech info:
* Rails v 6.0.3 using webpack and bootstrap
* Ruby version 2.6.3
* Database PostgreSQL with json column types support, 10+ recommended.

## Setup
```
rails db:create db:migrate db:seed
bin/bundle rails s
```
To execute rake task for `Currencies` populating for a previous month run:
`bin/bundle exec rake currencies:generate_for_a_month_before_today`.

## API JWT authentication url:
To receive JWT token make `POST /api/authenticate` with `email` and `password`
for example:
```
curl -H "Content-Type: application/json" -X POST -d '{"email":"admin@mail.com","password":"password123"}' http://localhost:3000/api/authenticate
=> {"auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE1OTI3Njk2ODR9.Q-pjqnOXHRdTLC88g6WS_s_vbocToib7zbtWMUviZ0o"}
```
