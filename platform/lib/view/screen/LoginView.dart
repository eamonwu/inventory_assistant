import 'package:flutter/material.dart';
import 'package:inventor_assistant/controller/screen/LoginController.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/utilities/constants.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final bool _rememberMe = false;
  Widget _buildAccountTF(TextEditingController account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "ACCOUNT".tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
        SizedBox(height: 10),
        Container(
          decoration: kBoxDecorationStyle,
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: account,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              hintText: "Enter your Account".tr,
              hintStyle: CustomThemeDate.wTextStyle.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTF(TextEditingController password) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "PASSWORD".tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
        SizedBox(height: 10),
        Container(
          decoration: kBoxDecorationStyle,
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            obscureText: true,
            controller: password,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Enter your Password".tr,
              hintStyle: CustomThemeDate.wTextStyle.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        // padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?'.tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {},
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(LoginScreenController loginController) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          loginController.login();
        },
        child: Text(
          'LOGIN'.tr,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -'.tr,
          style: CustomThemeDate.wWhiteTextStyle,
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with'.tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
            ),
            child: Icon(
              Icons.wechat,
              color: Colors.green,
              size: 40,
            ),
          ),
          SizedBox(
            width: 22,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
            ),
            child: Icon(
              Icons.facebook,
              color: Colors.blue,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Get.toNamed("/register"),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? '.tr,
              style: CustomThemeDate.wWhiteTextStyle,
            ),
            TextSpan(
              text: 'Sign Up'.tr,
              style: CustomThemeDate.wWhiteTitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVistorLoginBtn(LoginScreenController loginScreenController) {
    return Positioned(
      right: 10,
      top: 40,
      child: GestureDetector(
        onTap: () => loginScreenController.vistorLogin(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Skip".tr,
              style: CustomThemeDate.wWhiteTitleStyle.copyWith(fontSize: 27),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lc = Get.put(LoginScreenController());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // 背景图片
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: 80,
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "FZU CLOUD".tr,
                    style:
                        CustomThemeDate.wWhiteTitleStyle.copyWith(fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  _buildAccountTF(lc.account),
                  SizedBox(height: 20),
                  _buildPasswordTF(lc.password),
                  _buildForgotPasswordBtn(),
                  _buildLoginBtn(lc),
                  _buildSignInWithText(),
                  _buildSocialBtnRow(),
                  _buildSignupBtn(),
                ],
              ),
            ),
          ),
          _buildVistorLoginBtn(lc),
        ],
      ),
    );
  }
}
