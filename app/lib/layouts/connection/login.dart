import 'package:getout/form/pages/social_media_spent_time.dart';
import 'package:getout/models/requests/login.dart';
import 'package:flutter/material.dart';
import 'package:getout/layouts/connection/register.dart';
import 'package:getout/models/sign/fields.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/services/google/google_signin_api.dart';
import 'package:getout/layouts/home/load.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String textState = '';

  Future<void> loginPressed() {
    if (!_formKey.currentState!.validate()) {
      return Future(() => null);
    }
    setState(() {
      isLoading = true;
    });
    return RequestsService.instance
        .login(LoginRequest(
            email: emailController.text, password: passwordController.text))
        .then((LoginResponseInfo res) {
      if (res.statusCode == LoginResponseInfo.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SocialMediaSpentTime()));
      }
      setState(() {
        isLoading = false;
      });
      if (res.statusCode == 200) {
        textState = 'Connecté';
      } else if (res.statusCode == 403) {
        textState = 'Le mot de passe ou l\'adresse mail est incorrect';
      } else if (res.statusCode == 502) {
        textState = 'Pas de connexion internet';
      } else if (res.statusCode == 500) {
        textState = 'Une erreur s\'est produite, veuillez reesayer plus tard';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(textState),
          backgroundColor: (res.statusCode != 200
              ? const Color.fromARGB(255, 239, 46, 46)
              : const Color.fromARGB(255, 109, 154, 3))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadPage()
        : Scaffold(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: MailField(controller: emailController),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child:
                                  PasswordField(controller: passwordController),
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
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              icon: Image.asset(
                                'assets/Google.png',
                                width: 40,
                              ),
                              // Falcon label: Text('Sign Up with Google'),
                              label: const Text('Se connecter ave Google'),
                              onPressed: signIn,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Première connection ?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' Créer un compte',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              213, 86, 65, 0.992)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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

  void signIn() {
    GoogleSignInApi.login().then((final user) {
      if (user != null && user.displayName != null && user.photoUrl != null) {
        debugPrint(
            "${user.email} ${user.displayName ?? ""} ${user.photoUrl ?? ""}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Info ${user.email} ${user.displayName ?? ""} ${user.photoUrl ?? ""}")));
      }
    });
  }
}
