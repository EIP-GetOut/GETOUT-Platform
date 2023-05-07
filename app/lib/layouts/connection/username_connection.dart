import 'package:flutter/material.dart';
import 'package:GetOut/layouts/welcome.dart';
import 'package:GetOut/layouts/connection/register.dart';
import 'package:GetOut/models/sign/fields.dart';
import 'package:GetOut/services/requests/sign.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<VoidCallback?> loginPressed() async {
    if (_emailKey.currentState!.validate() && _passwordKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var res = await login(email: emailController.text, password: passwordController.text);
      if (res != '0K') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
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
                        SizedBox(
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
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/Twitter.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            SizedBox(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/Google.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            SizedBox(
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
                        new GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                          },
                          child: Text.rich(
                          TextSpan(
                            text: 'Première connection ?',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <InlineSpan>[
                              
                              TextSpan(
                                text: ' Créer un compte',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(213, 86, 65, 0.992)),
                              ),
                            ],
                          ),
                        ),
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
            onPressed: loginPressed,
            child: const Text('Se connecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}
