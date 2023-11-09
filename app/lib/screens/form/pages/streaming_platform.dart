/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/bloc/streaming_platform_bloc.dart';
import 'package:getout/screens/form/pages/end_form.dart';
import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/screens/form/widgets/streaming_platform.dart';

class StreamingPlatform extends StatelessWidget {
  const StreamingPlatform({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StreamingPlatformBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('VOS PRÉFÉRENCES'.padRight(
              '             '.length,
              String.fromCharCodes([0x00A0 /*No-Break Space*/ ])), // don't know but print white space,
              style: Theme.of(context).textTheme.titleLarge),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const PageIndicator(currentPage: 4, pageCount: 5),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'SUPPORT DE VISIONAGE :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetStreamingPlatform(),
              const SizedBox(height: 20),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text('Suivant',
                      style: Theme.of(context).textTheme.bodyLarge),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EndForm()),
                    );
                    context.read<StreamingPlatformBloc>();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
