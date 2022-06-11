import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/RegisterScreenController.dart';
import 'package:inventor_assistant/utilities/constants.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
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

  Widget _buildEmailTF(TextEditingController email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "EMAIL".tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
        SizedBox(height: 10),
        Container(
          decoration: kBoxDecorationStyle,
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: email,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Enter your Email".tr,
              hintStyle: CustomThemeDate.wTextStyle.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRegisterBtn(RegisterScreenController controller) {
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
        onPressed: () => controller.register(),
        child: Text(
          'Register'.tr,
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
            controller: password,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.key,
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

  Widget _buildPasswordConfirmTF(TextEditingController passwordConfirm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "COMFIRM PASSWORD".tr,
          style: CustomThemeDate.wWhiteTitleStyle,
        ),
        SizedBox(height: 10),
        Container(
          decoration: kBoxDecorationStyle,
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: passwordConfirm,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.key,
                color: Colors.white,
              ),
              hintText: "Confirm your Password".tr,
              hintStyle: CustomThemeDate.wTextStyle.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? '.tr,
              style: CustomThemeDate.wWhiteTextStyle,
            ),
            TextSpan(
              text: 'Sign in'.tr,
              style: CustomThemeDate.wWhiteTitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoBackBtn() {
    return Positioned(
      left: 10,
      top: 40,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Back".tr,
              style: CustomThemeDate.wWhiteTitleStyle.copyWith(fontSize: 27),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rsc = Get.put(RegisterScreenController());
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
                    "Create Account".tr,
                    style:
                        CustomThemeDate.wWhiteTitleStyle.copyWith(fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  _buildAccountTF(rsc.account),
                  SizedBox(height: 10),
                  _buildEmailTF(rsc.email),
                  SizedBox(height: 10),
                  _buildPasswordTF(rsc.password),
                  SizedBox(height: 10),
                  _buildPasswordConfirmTF(rsc.passwordConfirm),
                  SizedBox(height: 10),
                  _buildRegisterBtn(rsc),
                  _buildSignupBtn(),
                ],
              ),
            ),
          ),
          _buildGoBackBtn(),
        ],
      ),
    );
  }
}
