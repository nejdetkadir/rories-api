[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/11695464-2633ef74-01cc-41fe-b3fa-47bc82cbfba3?action=collection%2Ffork&collection-url=entityId%3D11695464-2633ef74-01cc-41fe-b3fa-47bc82cbfba3%26entityType%3Dcollection%26workspaceId%3De1df351f-1989-4f99-b41c-314c5d42d143)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/d0a6de7fa889487f9611ee74b8b7d8a7)](https://www.codacy.com/gh/nejdetkadir/rories-api/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nejdetkadir/rories-api&amp;utm_campaign=Badge_Grade)

# RORIES API
Movies API with Ruby on Rails API
![database](docs/database.png)

# Features
- User can sign up / log in / change the password
- User can follow movies / genres / cast(star/director/writer)
- The system should suggest movies based on our follows
- Writed unit test with rspec
- Authentication periods are created with devise and devise-jwt 

# Installation
## Prerequisites
- [Ruby](https://rvm.io/)
- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [PostgreSQL](https://www.postgresql.org/download/)
- [ImageMagick](https://imagemagick.org/) `sudo apt-get install imagemagick libmagickcore-dev libmagickwand-dev`

## For development
### API endpoints for V1
#### Authentication
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /api/v1/users | `POST` | ```{user: {email: "foo@bar.com", password: "mypass", password_confirmation: "mypass"}}``` | Empty | Returns authentication bearer token on header |
| /api/v1/users/sign_in | `POST` | ```{user: {email: "foo@bar.com", password: "mypass"}}``` | Empty | Returns authentication bearer token on header |
| /api/v1/users/sign_out | `DELETE` | Empty  | Authentication: Bearer Token | Returns sign out message |
| /api/v1/users/password | `POST` | ```{user: {email: "foo@bar.com"}}```  | Empty | Returns instructions about resetting password  |
| /api/v1/users/password | `PATCH` | ```{user: {reset_password_token: "token", password: "securepass", password_confirmation: "securepass"}}```  | Empty | Returns status |

#### Feed
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /api/v1/feed | `GET` | Empty | Authentication: Bearer Token | Returns suggested movies based on user's follows (limit 25) |
| /api/v1/feed?page=:page | `GET` | Empty | Authentication: Bearer Token | Returns next suggested movies based on user's follows (limit 25) |


#### Genres
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /api/v1/genres | `GET` | Empty | Authentication: Bearer Token | Returns genres |
| /api/v1/genres/:id | `GET` | Empty | Authentication: Bearer Token | Returns resource with by id |
| /api/v1/genres/:id/follow| `POST` | Empty | Authentication: Bearer Token | Returns id of resource or errors |
| /api/v1/genres/:id/unfollow| `DELETE` | Empty | Authentication: Bearer Token | Returns status |

#### Movies
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /api/v1/movies | `GET` | Empty | Authentication: Bearer Token | Returns movies (limit 25) |
| /api/v1/movies/search | `POST` | ```{ q: { title_cont: "Fast"}}``` | Authentication: Bearer Token | Returns result of searching |
| /api/v1/movies?page=:page | `GET` | Empty | Authentication: Bearer Token | Returns next movies (limit 25) |
| /api/v1/movies/:id| `GET` | Empty | Authentication: Bearer Token | Returns resource with by id |
| /api/v1/movies/:id/follow| `POST` | Empty | Authentication: Bearer Token | Returns id of resource or errors |
| /api/v1/movies/:id/unfollow| `DELETE` | Empty | Authentication: Bearer Token | Returns status |

#### Cast
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /api/v1/cast/:id| `GET` | Empty | Authentication: Bearer Token | Returns resource with by id |
| /api/v1/cast/:id/follow| `POST` | Empty | Authentication: Bearer Token | Returns id of resource or errors |
| /api/v1/cast/:id/unfollow| `DELETE` | Empty | Authentication: Bearer Token | Returns status |

### Environment variables
Create a file named ".env" in the root directory and fill its contents as follows.
```ruby
DEVISE_JWT_SECRET_KEY=X
MAIL_USERNAME=X
MAIL_PASSWORD=X
MAIL_ADDRESS=X
MAIL_PORT=X
MAIL_DOMAIN=X
RESET_PASSWORD_URL=X
AWS_ACCESS_KEY=X
AWS_SECRET_KEY=X
AWS_REGION=X
AWS_BUCKET=X
```

## For Running
- Install GEM dependencies:

  ```bash
  bundle install
  ```

- Create database, migrate tables and run the seed data:

  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```

- If you are setting up again, when you already have previous databases:

  ```bash
  rails db:reset
  ```
- For dropping database
  ```bash
  rails db:drop
  ``` 

# LICENSE
```
GNU GENERAL PUBLIC LICENSE Version 3
```
