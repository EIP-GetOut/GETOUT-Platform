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
          title: const Text('VOS PRÉFÉRENCES'),
          leading: const BackButton(),
        ),
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 140),
              PageIndicator(currentPage: 4, pageCount: 5),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'SUPPORT DE VISIONAGE :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              CheckboxListWidgetStreamingPlatform(),
              SizedBox(height: 20),
            ],
          ),
          floatingActionButton: SizedBox(
            width: 90 * MediaQuery.of(context).size.width / 100,
            height: 65,
            child: FloatingActionButton(
              child: Text('Suivant', style: Theme.of(context).textTheme.labelMedium),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EndForm()),
                );
                context.read<StreamingPlatformBloc>();
              },
            ),
          )

      ),
    );
  }
}
