import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/utils/utils.dart';

import '../../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFF),
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            Container(
              width: width,
              height: height * 0.2,
              // color: Colors.amber,
            ),
            Container(
              width: width,
              height: height * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF222B45),
                        fontSize: 37,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Please sign in to continue.',
                      style: TextStyle(
                        color: Color(0xFF8F9BB3),
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.07),
                      child: Container(
                        width: width,
                        height: height * 0.085,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0xFFEAF2F4)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14202020),
                              blurRadius: 15,
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            var reg = RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$');
                            if (value == null) {
                              return 'Please enter a valid email';
                            } else if (reg.hasMatch(value)) {
                              return null;
                            }
                            return 'Please enter a valid email';
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline),
                              border: InputBorder.none,
                              // label: "Password"
                              labelText: "Email"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: Container(
                        width: width,
                        height: height * 0.085,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0xFFEAF2F4)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14202020),
                              blurRadius: 15,
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.8,
                              child: TextFormField(
                                obscureText: isVisible,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outline),
                                    border: InputBorder.none,
                                    // label: "Password"
                                    labelText: "Password"),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                isVisible = !isVisible;
                                setState(() {});
                              },
                              child: Container(
                                child: Center(
                                  child: Icon(isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            )
                            // const Text(
                            //   'FORGOT',
                            //   style: TextStyle(
                            //     color: Utils.backgroudColor,
                            //     fontSize: 14,
                            //     fontFamily: 'Poppins',
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.07),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            final controller = Provider.of<LoginProvider>(
                                context,
                                listen: false);
                            await controller.checkLogin(emailController.text,
                                passwordController.text, context);
                          },
                          child: Container(
                            width: 146,
                            height: 54,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(1.00, 0.06),
                                end: Alignment(-1, -0.06),
                                colors: [
                                  Utils.lightbackgroudColor,
                                  Utils.backgroudColor
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
