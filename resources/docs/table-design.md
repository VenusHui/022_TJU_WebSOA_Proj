## MySQL

- 124.220.158.211:3306
- user: root
- password: root

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

- ticket_stall
  - ticket_stall_id *
  - histrionics_id
  - description
  - price
  - capacity
  - remaining
  - sold
  - position

- ticket
  - ticket_id *
  - ticket_stall_id
  - identity_number
  - position
  - status

- location
  - location_id *
  - name
  - location_type
  - coordinate

- seats
  - seats_id *
  - location_id
  - seat_map

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

- order
  - user_id
  - order_id
  - order_time
  - pay_time
  - status

## Relation

- purchase
  - order_id
  - ticket_id
