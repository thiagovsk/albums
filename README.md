# README

## Run the app

You need docker and docker-compose:

```
docker-compose up -d
./scripts/drails db:create db:migrate
```
And visit localhost:3000


To run tests/rubocop

```
./scripts/dbundle exec rspec
./scripts/dbundle exec rubocop
```

