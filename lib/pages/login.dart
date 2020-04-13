import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/network.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key key, Object arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Container(
      color: tp.primary,
      child: Center(
        child: Container(
          width: S.w(450),
          height: S.h(400),
          // color: Colors.blue,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Mnemonic Music",
                    style: TextStyle(
                      fontSize: S.w(45),
                      fontWeight: FontWeight.w900,
                      color: tp.font
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    _Input(
                      prefixIconData: Icons.supervised_user_circle,
                      hintString: "请输入用户名",
                      controller: _usernameController,
                    ),
                    SizedBox(height: S.h(30),),
                    _Input(
                      prefixIconData: Icons.work,
                      hintString: "请输入密码",
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    SizedBox(height: S.h(30),),
                    RaisedButton(
                      onPressed: (){
                        Network.post("http://127.0.0.1:53927/login", <String, dynamic>{
                          "username": _usernameController.text,
                          "password": _passwordController.text
                        });
                      }, 
                      color: tp.btnBg,
                      child: Text(
                        "登录",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: tp.btnText
                        ),
                      )
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {

  final IconData prefixIconData;
  final String hintString;
  final bool isPassword;
  final TextEditingController controller;

  const _Input({Key key, @required this.prefixIconData, @required this.controller,
    @required this.hintString, this.isPassword = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return TextField(
      obscureText: isPassword,
      cursorColor: tp.font,
      controller: controller,
      style: TextStyle(
        color: tp.font
      ),
      decoration: InputDecoration(
        focusColor: tp.font,
        hintText: hintString,
        contentPadding: EdgeInsets.fromLTRB(S.w(10), 0, 0, 0),
        hintStyle: TextStyle(
          fontSize: S.h(20),
          color: tp.font
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(1),
          borderSide: BorderSide(
            color: tp.font, //边线颜色为白色
            width: 1, //边线宽度为1
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(1),
          borderSide: BorderSide(
            color: tp.font, //边线颜色为白色
            width: 1, //边线宽度为1
          ),
        ),
      ),
    );
  }
}