import 'package:flutter/material.dart';
// import 'package:getout/playgrounds/main_playground.dart';
// import 'package:getout/models/flex_size.dart';
// import 'package:getout/layouts/preference/preference.dart';
import 'package:getout/layouts/welcome.dart';
// import 'package:flutter/foundation.dart';
import 'dart:developer';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool isLandscape = (MediaQuery.of(context).size.width >
    //     MediaQuery.of(context).size.height);
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
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText:
                                    'Adresse mail ou nom d\'utilisateur'),
                            validator: (value) {
                              log('value: $value');
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre adresse mail ou nom d\'utilisateur';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mot de passe'),
                            validator: (value) {
                              if (value != 'test') {
                                return 'Mot de passe incorrecte';
                              }
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre mot de passe';
                              }
                              return null;
                            },
                          ),
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
                        const Text.rich(
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
                        )
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
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WelcomePage())),
            child: const Text('Se connecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}
