## Entity

- user
  - user_id *
  - user_type
  - username
  - password
  - phone_number *
  - register_date
  - city

- real_viewer
  - user_id *
  - identity_number *
  - phone_number

- show
  - show_id *
  - title
  - description
  - image_url

- histrionics
  - histrionics_id *
  - show_id 
  - description
  - detail_url
  - start_time
  - duration
  - location_id
  - seats_id

- ticket
  - ticket_id *
  - histrionics_id
  - description
  - price
  - capacity
  - remaining
  - sold
  - position

- location
  - location_id *
  - name
  - location_type
  - coordinate

- seats
  - seats_id *
  - location_id
  - todo

- resale
  - resale_id *
  - seller_id
  - buyer_id
  - price
  - publish_date
  - order_id
  - status
  - validity

- sharing
  - sharing_id *
  - user_id
  - histrionics_id
  - context
  - image_url
  - stars
  - likes

- comment
  - comment_id *
  - sharing_id
  - user_id
  - context
  - likes

## Relation