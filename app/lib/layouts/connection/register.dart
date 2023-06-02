import 'package:GetOut/models/requests/create_account.dart';
import 'package:flutter/material.dart';
import 'package:GetOut/layouts/welcome.dart';
import 'package:GetOut/models/sign/fields.dart';
import 'package:GetOut/services/requests/requests_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  final _firstnameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _birthDateKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _password2Key = GlobalKey<FormState>();
  bool isLoading = false;

  Future<VoidCallback?> registerPressed() async {
    
    if (!_emailKey.currentState!.validate() && !_nameKey.currentState!.validate() &&
        !_firstnameKey.currentState!.validate() && !_birthDateKey.currentState!.validate() &&
        !_passwordKey.currentState!.validate() && !_password2Key.currentState!.validate()) {
        return null;
    }
    setState(() {
      isLoading = true;
    });
    AccountResponseInfo res = await RequestsService.instance.register(
        CreateAccountRequest(email: emailController.text,
            password: passwordController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            bornDate: bornDateController.text));
    if (res.statusCode == AccountResponseInfo.success) {
      return Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
    }
    setState(() {
      isLoading = false;
    });
    /// TODO : show error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((res.statusCode == -42) ? ('No internet connection') : ('ERROR'))));
    return null;
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
          centerTitle: true,
                  titleSpacing: 0,
          title: const Text(
              'VOTRE PROFILE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                decorationThickness: 4,
                decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
                decoration: 
                TextDecoration.underline,
                ),
          ),
          leading: const BackButton(),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: NameField(formKey: _nameKey, controller: lastNameController)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: FirstNameField(formKey: _firstnameKey, controller: firstNameController)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: BirthDateField(formKey: _birthDateKey, controller: bornDateController)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: MailField(formKey: _emailKey, controller: emailController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: PasswordField(formKey: _passwordKey, controller: passwordController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                child: SecondPasswordField(formKey: _password2Key, controller: password2Controller, fstPassword: passwordController.text)
              ),
              const SizedBox(
                height: 70,
              ),
              startButton(context, MediaQuery.of(context).size.width),
            ])),
    );
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
