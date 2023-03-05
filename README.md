# 022_TJU_WebSOA_Proj
 
## 1 介绍

随着经济的发展与人们生活水平的提高，线下演出，现场体验是越来越受欢迎的娱乐方式。演出作为文化产业的终端输出方式，涉及娱乐、音乐、电影、体育、游戏等创意文化产业。票务是线下演艺行业对消费者的“门面”，是消费者对文化内容消费的第一步，对形成良好的消费体验直观重要。近年来互联网技术的发展，让更多人选择线上购票的方式。我们希望以此为契机，打造一个由票务链接的演艺生态圈，让用户获得更好的票务消费体验，瞄准用户痛点，创造一个更好的互联网票务环境。

本项目包括用户、平台管理员两个个主体。核心功能为平台与用户之间的票务交易，我们引入了与票务产品互相绑定的现场分享功能，既是用户对演出美好瞬间的记录也是对演出的评价与反馈。针对传统购票平台出现的黄牛倒卖导致的购票难、用户个人原因无法参与演出而导致的转卖难等问题，我们做出功能性的优化，充分保障消费者的权益。为了维护良好的社区氛围，我们引入了管理员角色，为演出的举办以及用户发布的分享等信息进行审核，保障一个健康的互联网交流环境。

项目的名称为“一排一座”，指的是剧场中第一排离演员最近的位置，通常是预留给演员们的赠票以邀请对他们而言重要的客人。每一位用户都是我们珍视的对象，我们希望我们的服务能带给我们的用户一排一座的体验。

## 2 整体描述

本项目名为**一排一座**，是基于Flutter和SpringBoot框架开发的移动端应用。项目旨在为移动端的用户提供一个体验良好，灵活性强，交互性好的票务平台。平台专注于解决用户的痛点问题，努力让用户的购票体验后顾无忧。用户可以通过该应用随时购买喜爱演出的票卷，并通过其他相关的功能获得更好的体验。

出于工作周期的考虑，本项目暂以IOS端为开发目标，构建轻量级票务平台。

## 3 自动部署策略

由于项目整体通过 GitHub 托管，所以直接通过 GitHub Actions 监听相关文件夹下的 `push` 行为进行自动部署，每个服务都对应一个工作流：


每次自动部署都进行 **代码审查**、**打包发布**、**上云部署** 三步：


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
