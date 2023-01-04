import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';

class signin_page extends StatefulWidget {
  final String title;
  const signin_page({Key? key, required this.title}) : super(key: key);

  @override
  State<signin_page> createState() => _signin_pageState();
}

class _signin_pageState extends State<signin_page> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isObscure = true;
  Color _eyeColor = Color.fromRGBO(161, 189, 245, 0.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(8, 11, 32, 1),
        image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover),
      ),
      child: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  color: Color.fromRGBO(161, 189, 245, 1),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(161, 189, 245, 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            // buildTitle(), // Login
            // buildTitleLine(), // Login下面的下划线
            const SizedBox(height: 270),
            buildEmailTextField(), // 输入邮箱
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            // buildForgetPasswordText(context), // 忘记密码
            const SizedBox(height: 60),
            buildLoginButton(context), // 登录按钮
            const SizedBox(height: 40),
            // buildOtherLoginText(), // 其他账号登录
            // Row(
            //   children: [
            //     buildOtherMethod(context), // 其他登录方式
            //     buildRegisterText(context), // 注册
            //   ],
            // )
          ],
        ),
      ),
    ));
  }

  // Widget buildRegisterText(context) {
  //   return TextButton(
  //     onPressed: null,
  //     style: ButtonStyle(alignment: Alignment.centerRight),
  //     child: Text(
  //       "新用户注册",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  // Widget buildOtherMethod(context) {
  //   return TextButton(
  //     child: Text(
  //       "短信验证码登录",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     onPressed: null,
  //   );
  // }

  Widget buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
              // 设置圆角
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child: Text('GO',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          onPressed: () {
            // 表单校验通过才会继续执行
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              //TODO 执行登录方法
              print('email: $_email, password: $_password');
            }
          },
        ),
      ),
    );
  }

  ///调用接口
  register() async {
    // 从input框中取值
    String userName = '测试用户1';
    String password = '111111';
    String number = '13222222222';
    Response entity =
        Response.fromJson(await Api.register(userName, password, number));
    if (entity.status == 'sucess') {
      print('注册成功');
    } else {
      print('注册失败');
    }
  }

  // Widget buildForgetPasswordText(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8),
  //     child: Align(
  //       alignment: Alignment.centerRight,
  //       child: TextButton(
  //         onPressed: () {
  //           // Navigator.pop(context);
  //           print("忘记密码");
  //         },
  //         child: const Text("忘记密码？",
  //             style: TextStyle(fontSize: 14, color: Colors.grey)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildPasswordTextField(BuildContext context) {
    return Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 0.05),
          border: Border.all(color: Color.fromRGBO(161, 189, 245, 1)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
            obscureText: _isObscure, // 是否显示文字
            onSaved: (v) => _password = v!,
            validator: (v) {
              if (v!.isEmpty) {
                return '请输入密码';
              }
            },
            decoration: InputDecoration(
                labelText: "请输入密码",
                labelStyle: TextStyle(color: Color.fromRGBO(161, 189, 245, 1)),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _eyeColor,
                  ),
                  onPressed: () {
                    // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                    setState(() {
                      _isObscure = !_isObscure;
                      _eyeColor = (_isObscure
                          ? Color.fromRGBO(161, 189, 245, 1)
                          : Theme.of(context).iconTheme.color)!;
                    });
                  },
                ))));
  }

  Widget buildEmailTextField() {
    return Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 0.05),
          border: Border.all(color: Color.fromRGBO(161, 189, 245, 1)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
              labelText: "请输入手机号",
              labelStyle: TextStyle(color: Color.fromRGBO(161, 189, 245, 1))),
          validator: (v) {
            var emailReg = RegExp(
                r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
            if (!emailReg.hasMatch(v!)) {
              return '请输入正确的手机号';
            }
          },
          onSaved: (v) => _email = v!,
        ));
  }

  Widget buildTitleLine() {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.black,
            width: 40,
            height: 2,
          ),
        ));
  }

  Widget buildTitle() {
    return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 42),
        ));
  }
}
