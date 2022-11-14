## MySQL

- 124.220.158.211:3306
- user: root
- password: root
- database: ticket

## Entity

- **user**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| user_id       | int               | no         | primary key  |
| user_name     | varchar(255)      | no         |              |
| user_type     | tinyint(1)        | no         |              |
| password      | varchar(255)      | no         |              |
| phone_number  | varchar(11)       | no         | unique key   |
| register      | datetime          | no         |              |
| city          | varchar(255)      | no         |              |


- **real_viewer**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| user_id       | int               | no         | primary key<br>foreign key |
|identity_number| varchar(18)       | no         | primary key  |
| phone_number  | varchar(11)       | no         |              |

- **show**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| show_id       | int               | no         | primary key  |
| title         | varchar(255)      | no         |              |
| description   | varchar(255)      | yes        |              |
| image_url     | varchar(255)      | yes        |              |


- **histrionics**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| histrionics_id| int               | no         | primary key  |
| show_id       | int               | no         | foreign key  |
| description   | varchar(255)      | yes        |              |
| detail_url    | varchar(255)      | yes        |              |
| start_time    | datetime          | no         |              |
| duration      | time              | no         |              |
| location_id   | int               | no         | foreign key  |
| seats_id      | int               | no         | foreign key  |

- **ticket_stall**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
|ticket_stall_id| int               | no         | primary key  |
| histrionics_id| int               | no         | foreign key  |
| description   | varchar(255)      | yes        |              |
| price         | price(10,2)       | no         |              |
| capacity      | int               | no         |              |
| remaining     | int               | no         |              |
| sold          | int               | no         |              |
| position      | varchar(255)      | yes        |              |


- **ticket**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| ticket_id     | int               | no         | primary key  |
|ticket_stall_id| int               | no         | foreign key  |
|identity_number| varchar(18)       | no         | foreign key  |
| position      | varchar(255)      | yes        |              |
| status        | tinyint(1)        | no         |              |

- **location**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| location_id   | int               | no         | primary key  |
| name          | varchar(255)      | no         |              |
| location_type | varchar(255)      | no         |              |
| lat           | demical(10,6)     | no         |              |
| lng           | demical(10,6)     | no         |              |

_*经纬度通常使用demical(10,6)存储，可在JAVA中映射为double类型_

- **seats**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| seats_id      | int               | no         | primary key  |
| location_id   | int               | no         | foreign key  |
| seat_map      | varchar(255)      | no         |              |


- **resale**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| resale_id     | int               | no         | primary key  |
| seller_id     | int               | no         | foreign key  |
| buyer_id      | int               | yes        | foreign key  |
| price         | demical(10,2)     | no         |              |
| publish_date  | datetime          | no         |              |
| order_id      | int               | no         | foreign key  |
| status        | tinyint(1)        | no         |              |
| validity      | tinyint(1)        | no         |              |

- **sharing**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| sharing_id    | int               | no         | primary key  |
| user_id       | int               | no         | foreign key  |
| histrionics_id| int               | no         | foreign key  |
| context       | varchar(255)      | yes        |              |
| image_url     | varchar(255)      | no         |              |
| stars         | int               | no         |              |
| likes         | int               | no         |              |


- **comment**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| comment_id    | int               | no         | primary key  |
| sharing_id    | int               | no         | foreign key  |
| user_id       | int               | no         | foreign key  |
| context       | varchar(255)      | no         |              |
| likes         | int               | no         |              |


- **order**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| order_id      | int               | no         | primary key  |
| user_id       | int               | no         | foreign key  |
| order_time    | datetime          | no         |              |
| pay_time      | datetime          | yes        |              |
| status        | tinyint(1)        | no         |              |


## Relation

- **purchase**

| **Attribute** | **Variable Type** | **isNull** | **Key Type** | 
| --------------| ----------------- | ---------- | ------------ |
| order_id      | int               | no         | primary key<br>foreign key |
| ticket_id     | int               | no         | primary key<br>foreign key  |

