import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/bloc/welcome_bloc.dart';
import 'package:getout/screens/form/pages/social_media_spent_time.dart';
import 'package:getout/tools/flex_size.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final WelcomeBloc _welcomeBloc = WelcomeBloc();

  @override
  void dispose() {
    _welcomeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      bloc: _welcomeBloc,
      builder: (context, state) {
        bool isLandscape = (MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height);

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(width: perWidth(context, (isLandscape ? 28 : 16))),
                    SizedBox(
                      height: uniHeight(context, 13, isLandscape),
                      width: uniWidth(context, 27, isLandscape),
                      child: Image.asset('assets/images/Logo_GetOut.png'),
                    ),
                    SizedBox(width: perWidth(context, 4)),
                    const Text('GETOUT',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: perHeight(context, (isLandscape ? 40 : 50)),
                width: perWidth(context, (isLandscape ? 40 : 100)),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/Draw_Welcome_image.png')),
              ),
              SizedBox(
                height: perHeight(context, 15),
                width: perWidth(context, 95),
                child: const Text(
                  'Devenez plus productif en réduisant le temps passé sur les réseaux sociaux',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SocialMediaSpentTime())));
            },
            child: const Text(
              'Commencer l\'aventure',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
        );
      },
    );
  }
}
