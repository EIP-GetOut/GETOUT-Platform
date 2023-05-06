import 'package:flutter/material.dart';
import 'package:getout/layouts/welcome.dart';
import 'package:getout/models/sign/fields.dart';
import 'package:getout/services/requests/sign.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _password2Key = GlobalKey<FormState>();
  bool isLoading = false;

  Future<VoidCallback?> registerPressed() async {
    if (_emailKey.currentState!.validate() && _passwordKey.currentState!.validate() && _password2Key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var res = await register(context, email: emailController.text, password: passwordController.text);
      if (res == 'OK') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/entire_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: MailField(formKey: _emailKey, controller: emailController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: PasswordField(formKey: _passwordKey, controller: passwordController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: SecondPasswordField(formKey: _password2Key, controller: password2Controller, fstPassword: passwordController.text)
                        ),
                        SizedBox(
                          // height: perHeight(context, (isLandscape ? 40 : 50)),
                          // width: perWidth(context, (isLandscape ? 40 : 100)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/separation.png',
                                fit: BoxFit.contain,
                              )),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // <-- SEE HERE
                          children: [
                            SizedBox(
                              // height: perHeight(context, (isLandscape ? 40 : 50)),
                              // width: perWidth(context, (isLandscape ? 40 : 100)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/Twitter.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            SizedBox(
                              // height: perHeight(context, (isLandscape ? 40 : 50)),
                              // width: perWidth(context, (isLandscape ? 40 : 100)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/Google.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            SizedBox(
                              // height: perHeight(context, (isLandscape ? 40 : 50)),
                              // width: perWidth(context, (isLandscape ? 40 : 100)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/Facebook.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ],
                        ),
                        // Row(
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
        startButton(context, MediaQuery.of(context).size.width));
  }

  Widget startButton(BuildContext context, double phoneWidth) {
    return SizedBox(
        width: 85 * phoneWidth / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color.fromRGBO(213, 86, 65, 0.992),
            onPressed: registerPressed,
            child: const Text('S\'inscrire',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}
