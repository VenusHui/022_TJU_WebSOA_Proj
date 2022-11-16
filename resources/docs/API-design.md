# API设计文档

> Restful Api设计

## 用户

| 资源                                   | POST             | GET                          | PUT                          | DELETE               |
| -------------------------------------- | ---------------- | ---------------------------- | ---------------------------- | -------------------- |
| /users                                 | 创建新用户       | 检索所有用户                 | 批量更新用户                 | 删除所有用户         |
| /users/user{id}                        | error            | 检索{用户}的详细信息         | 如果{用户}存在则更新         | 删除{用户}           |
| /users/user{id}/<br />orders           | {用户}创建新订单 | 检索{用户}的所有订单         | 批量更新{用户}的订单         | 删除{用户}的所有订单 |
| /users/user{id}/<br />orders/order{id} | error            | 检索{用户}的{订单}的详细信息 | 如果{用户}的{订单}存在则更新 | 删除{用户}的{订单}   |

## 演出信息

| 资源                                       | POST               | GET                          | PUT                  | DELETE               |
| ------------------------------------------ | ------------------ | ---------------------------- | -------------------- | -------------------- |
| /shows                                     | 创建新演出         | 检索所有演出                 | 批量更新演出         | 删除所有演出         |
| /shows/show{id}                            | error              | 检索{演出}的详细信息         | 如果{演出}存在则更新 | 删除{演出}           |
| /shows/show{id}/<br />histrionics          | 创建{演出}的新场次 | 检索{演出}的所有场次         | 批量更新{演出}的场次 | 删除{演出}的所有场次 |
| /shows/show{id}/<br />histrionics/histrionic{id} | error              | 检索{演出}的{场次}的详细信息 | 如果{演出}的{场次}存在则更新                 |删除{演出}的{场次}                      |
| /shows/show{id}/<br />histrionics/histrionic{id}/<br />ticket_stalls | 创建{场次}的新票档 | 检索{演出}的所有票档 | 批量更新{场次}的票档 |删除{场次}的所有票档 |
| /shows/show{id}/<br />histrionics/histrionic{id}/<br />ticket_stalls/ticket_stall{id} | error | 检索{场次}的{票档}的详细信息 | 如果{场次}的{票档}存在则更新 |删除{场次}的{票档} |
| /shows/show{id}/<br />histrionics/histrionic{id}/<br />ticket_stalls/ticket_stall{id}/<br />tickets | 创建{票档}的新门票 | 检索{票档}的所有门票 | 批量更新{票档}的门票 |删除{票档}的所有门票 |
| /shows/show{id}/<br />histrionics/histrionic{id}/<br />ticket_stalls/ticket_stall{id}/<br />tickets/ticket{id} | error | 检索{票档}的{门票}的详细信息 | 如果{票档}的{门票}存在则更新 |删除{票档}的{门票} |

