# 一排一座

> 2053300 胡锦晖
>
> 2052220 白珂睿
>
> 2053385 高逸轩
>
> 2053386 高骏骋

## 项目架构

<img src="./SOA-Final.assets/image-20221229184959872.png" alt="image-20221229184959872" style="zoom:50%;" />

- 其中 Nacos 服务，三个微服务以及 MySQ L数据库均在腾讯云服务器采用 Docker 搭建：

<img src="./SOA-Final.assets/image-20221229204824511.png" alt="image-20221229204824511" style="zoom:50%;" />

- MongoDB 数据库采用 MongoDB Atlas 服务器搭建：

<img src="./SOA-Final.assets/image-20221229205237204.png" alt="image-20221229205237204" style="zoom: 67%;" />

## 数据库设计

### MySQL

- 用户系统

<img src="./SOA-Final.assets/image-20221229133025156.png" alt="image-20221229133025156" style="zoom:50%;" />	

- 票务系统

<img src="./SOA-Final.assets/image-20221229133139859.png" alt="image-20221229133139859" style="zoom: 67%;" />

### MongoDB

- 社区系统

<img src="./SOA-Final.assets/image-20221229133421697.png" alt="image-20221229133421697" style="zoom: 80%;" />

## API设计

### Rest & HATEOAS

本项目 API 采用 Rest 风格设计，并引入了 HATEOAS 作为 Rest 风格的补充。

以 `查询指定分享信息` 的 API 为例，在查询指定分享信息的同时返回了相关 `links`

- `self` ：该 API 自身的 URL
- `all comments` ：该分享下所有的评论信息 URL
- `all sharings` ：所有的分享信息 URL

```json
{
    "data": {
        "_id": "63aac0f7af5500002b001ee5",
        "histrionicsId": 1,
        "userId": 1,
        "context": "好看",
        "imageUrl": "https://pic.imgdb.cn/item/6359679816f2c2beb1062a61.jpg",
        "stars": 1,
        "likes": 1,
        "shareDate": "2022-12-27T17:56:39.000+00:00",
        "comments": [
            {
                "user_id": 1,
                "context": "test",
                "likes": 1,
                "comment_time": "2022-12-28T07:07:46.398+00:00"
            }
        ],
        "links": [
            {
                "rel": "self",
                "href": "http://124.220.158.211:8002/sharings/63aac0f7af5500002b001ee5/"
            },
            {
                "rel": "all sharings",
                "href": "http://124.220.158.211:8002/sharings/?filter=all&id=0"
            },
            {
                "rel": "all comments",
                "href": "http://124.220.158.211:8002/sharings/63aac0f7af5500002b001ee5/comments/?filter=all&id=0"
            }
        ]
    },
    "message": "",
    "status": "success"
}
```

### Apifox

[API 文档地址](https://bo6dcd292m.apifox.cn)

采用 Apifox 作为前后端沟通 Api 及相关数据格式，生成 Api 文档的工具，具体使用场景如下：

- 后端测试环境测试 Api 正确性
- 后端发布 Api 供前端调用
- 前端发布 Api 需求，并通过本地 Mock 使用，待后端完善
- 前端正式调用 Api
- 前后联调和自动化测试（尚未用到，后续会根据实际使用场景搭建自动化部署套件进行正确性测试和压力测试）

## 服务治理

通过 `Nacos` 进行服务治理，包括服务注册、服务配置、服务发现

<img src="./SOA-Final.assets/image-20221229203538165.png" alt="image-20221229203538165" style="zoom:67%;" />

## 后端实现

### SpringCloud

通过 SpringCloud 父项目对项目依赖统一进行版本管理。

### SpringBoot

通过 SpringBoot 子项目实现不同服务

- `pojo`：数据层，映射数据库中的表，通过 `lombok` 提供的 `@Data` 、`@NoArgsConstructor`、`@AllArgsConstructor` 注解生成有参/无参构造函数以及 `getters` 、`setters` 方法。
- `mapper` / `repository`
  - `mapper` 通过扩展 `mybatis-plus` 提供的 `BaseMapper<T>` 对 MySQL 数据库进行访问以及持久化，通过 `@Mapper` 注解注入到SpringBoot 中。对于条件查询需要自行构造 `QueryWrapper` 进行条件拼接。
  - `repository` 通过扩展 `spring.data` 下 MongoDB SDK 中的`MongoRepository<T, ID>` 接口对 MongoDB 数据库进行访问，通过 `@Repository` 注解注入到 SpringBoot 中。对于条件查询需要在扩展的接口下声明相应查询方法，实现会根据声明的方法名自动生成。
- `service`：服务层，定义业务逻辑的接口供 `controller` 调用
  - `impl`：对 `service` 定义的接口进行实现，通过 `@Service` 注解注入到 SpringBoot 中。
- `controller`：控制器，调用 `Service` 层中实现的接口，通过 `@RestController` 注解注入到 SpringBoot 中。

### SpringSecurity

通过 SpringSecurity 实现网络安全相关配置

- 用户服务目前只开放了登录以及注册接口供所有用户访问

```java
http.csrf().disable()
                .antMatchers(
                        "/users/",
                        "/users/token/"
                ).permitAll()
```

- 其他接口只能携带 `jwt-token` 才能正常访问，对于不携带 `jwt-token` 的请求会被直接过滤

```java
 http.addFilterBefore(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);
```

- 票务服务以及社区服务由于并不对外开放，只有经过注册的 ip 地址才能访问
  - 后续会通过 `Nacos` 的服务配置编写配置文件动态刷新这里的访问配置以及 ip 配置

```java
http.csrf().disable()
                .antMatchers(
                            "/sharings/",
                            "/sharings/{sharingId}/",
                        	"/sharings/{sharingId}/comments/"
                ).hasIpAddress("124.220.158.211") // Nacos注册服务器的ip
                .antMatchers(HttpMethod.OPTIONS).permitAll()
                .anyRequest().authenticated();
```

### Spring HATEOAS

通过 Spring HATEOAS 对 Rest Api进行扩展

- assembler：通过实现 Spring HATEOAS 提供的 `RepresentationModelAssembler<T, EntityModel<T>>` 接口中的 `toModel` 、`toCollectionModel` 方法，可以为每个实体（`toModel`）或每个实体列表（`toCollectionModel`）

```java
@Component
public class SharingModelAssembler implements RepresentationModelAssembler<Sharing, EntityModel<Sharing>> {
    @Override
    public EntityModel<Sharing> toModel(Sharing sharing) {
        return EntityModel.of(sharing,
                linkTo(methodOn(SharingController.class).getSharing(sharing.get_id())).withSelfRel(),
                linkTo(methodOn(SharingController.class).getSharings("all", 0)).withRel("all sharings"),
                linkTo(methodOn(CommentController.class).getComments(sharing.get_id(), "all", 0)).withRel("all comments"));
    }

    public CollectionModel<EntityModel<Sharing>> toCollectionModel(List<Sharing> sharingList) {
        List<EntityModel<Sharing>> entityModelList = sharingList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
```

## 自动部署策略

由于项目整体通过 GitHub 托管，所以直接通过 GitHub Actions 监听相关文件夹下的 `push` 行为进行自动部署，每个服务都对应一个工作流：

<img src="./SOA-Final.assets/image-20221229202231293.png" alt="image-20221229202231293" style="zoom:80%;" />

每次自动部署都进行 **代码审查**、**打包发布**、**上云部署** 三步：

<img src="./SOA-Final.assets/image-20221229202310641.png" alt="image-20221229202310641" style="zoom: 50%;" />



#### 代码审查

```yaml
check:
    name: Check
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false
```

#### 打包发布

```yaml
publish:
    name: Package And Publish
    needs: [check]
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false
          
      - name: Set up JDK # 安装相关环境
        uses: actions/setup-java@v1
        with:
          java-version: 18

      - name: Build with Maven # Maven 打包
        run: |
          cd backendcloud/backend
          mvn package
      
      - name: Login Docker # 登录 DockerHub
        uses: docker/login-action@f054a8b539a109f9f41c372932f1ae047eff08c9
        with: 
          username: ${{ secrets.DOCKER_USERNAME }} # 相关信息通过GitHub Secrets保存
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Extract metadata for Docker # 获取 tags 等相关信息
        id: meta
        uses: docker/metadata-action@98669ae865ea3cffbcbaa878cf57c20bbf1c6c38
        with:
          images: VenusHui/WebSOA-backend

      - name: Publish Docker Image # 发布到 DockerHub
        uses: docker/build-push-action@ad44023a93711e3deb337508980b4b5e9bcdc5dc
        with: 
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          file: backendcloud/backend/Dockerfile # 通过 DockerFile 打包
```

#### 上云部署

```yaml
deploy:
    name: Deployment
    needs: [publish]
    runs-on: ubuntu-latest
    steps:
      - name: Deploy On Tencent Cloud Server
        uses: appleboy/ssh-action@master # 通过SSH连接服务器，执行服务器中的deploy脚本并输出日志
        with: 
          host: ${{ secrets.TENCENT_CLOUD_IP }} # 相关信息通过GitHub Secrets保存
          username: ${{ secrets.TENCENT_CLOUD_USERNAME }}
          password: ${{ secrets.TENCENT_CLOUD_PASSWORD }}
          script: cd ~/Ticket/backendcloud/backend/ 
          && bash deploy.sh ${{ secrets.DOCKER_USERNAME }} ${{ secrets.DOCKER_PASSWORD }} >> ./deploy.log
```
