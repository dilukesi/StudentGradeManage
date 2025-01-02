# 学生成绩管理系统
本项目使用Springboot+vue3实现功能，运用mybatis以及element-plus中的UI组件。
学生成绩管理系统：
本系统分为学生端、教师端及管理员端，登录页面选择身份进入系统。

项目运行步骤：
1、配置好数据库，导入lab4.sql(位于sql文件夹下)
2、运行SpringbootApplication.java
3、在终端运行npm install
4、运行npm run dev
学生端：
1.学生端可以进行选课功能，并且可以对已选科目进行查询操作。

![](https://github.com/dilukesi/StudentgradeManage/blob/main/display/select.png)

2.学生端有学生成绩页面，此页面可以看到课程成绩，并且给任课老师经行反馈。

![](https://github.com/dilukesi/StudentgradeManage/blob/main/display/myscore.png)

3.有个人信息功能，可以实现上传头像修改、修改密码、用户名等功能。

教师端：

1.教师端可以查看所有学生的选课记录并修改和对该选课进行打分操作

![](https://github.com/dilukesi/StudentgradeManage/blob/main/display/check.png)

2.可以对学生进行打分以及评语操作

![][(https://github.com/dilukesi/StudentgradeManage/blob/main/display/score.png)

3.可以查看所有学生信息以及输入成绩。

![][(https://github.com/dilukesi/StudentgradeManage/blob/main/display/enter.png)

管理员端：

1.管理员端可以查看所有老师开设的课程

![](https://github.com/dilukesi/StudentgradeManage/blob/main/display/techer_course.png)

2.可以查看所有学生分数

![](https://github.com/dilukesi/StudentgradeManage/blob/main/display/all_score.png)

3、可以新增老师及学生。
