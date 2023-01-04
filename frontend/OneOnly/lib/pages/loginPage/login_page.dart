import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oneonly/pages/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../models/api_response.dart';
import '../../models/user.dart';
import 'login_verifycode.dart';
import 'signin_page.dart';

class login_page extends StatefulWidget {
  final String title;
  const login_page({Key? key, required this.title}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
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
            Row(
              children: [
                buildOtherMethod(context), // 其他登录方式
                buildRegisterText(context), // 注册
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget buildRegisterText(context) {
    return TextButton(
      style: ButtonStyle(alignment: Alignment.centerRight),
      child: Text(
        "新用户注册",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => signin_page(
              title: "注册",
            ),
          ),
        );
      },
    );
  }

  Widget buildOtherMethod(context) {
    return TextButton(
      child: Text(
        "短信验证码登录",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => login_verifycode(title: "验证码登录"),
          ),
        );
      },
    );
  }

  Widget buildOtherLoginText() {
    return const Center(
      child: Text(
        '其他账号登录',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

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
          onPressed: () async {
            // 表单校验通过才会继续执行
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              //TODO 执行登录方法
              print('email: $_email, password: $_password');
              var isLogin = await sign(_email, _password);
              if (isLogin) {
                print('登录成功');
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                });
              } else {
                print('登录失败');
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> sign(String emails, String psd) async {
    UserLoginRequestEntity params = UserLoginRequestEntity(
      user_name: emails,
      password: psd,
    );
    Response entity = Response.fromJson(await Api.sign(params: params));
    if (entity.status == 'success') {
      //存储token 存储userId
      save('token', entity.data['token']);
      save('userId', entity.data['userId'].toString());
      return true;
    } else {
      ///登录失败增加提示弹框
      EasyLoading.showError(entity.message!,
          duration: const Duration(milliseconds: 2000));
      return false;
    }
  }

  save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            // Navigator.pop(context);
            print("忘记密码");
          },
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ),
      ),
    );
  }

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
              // if (v!.isEmpty) {
              //   return '请输入密码';
              // }
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: "请输入密码",
                labelStyle:
                    const TextStyle(color: Color.fromRGBO(161, 189, 245, 1)),
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
                          ? const Color.fromRGBO(161, 189, 245, 1)
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
          color: const Color.fromRGBO(217, 217, 217, 0.05),
          border: Border.all(color: const Color.fromRGBO(161, 189, 245, 1)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
              labelText: "请输入用户名",
              labelStyle: TextStyle(color: Color.fromRGBO(161, 189, 245, 1))),
          style: const TextStyle(color: Colors.white),
          validator: (v) {
            // var emailReg = RegExp(
            //     r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
            // if (!emailReg.hasMatch(v!)) {
            //   return '请输入正确的手机号';
            // }
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
