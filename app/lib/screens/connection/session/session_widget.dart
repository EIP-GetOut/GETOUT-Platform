
/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/connection/bloc/connection_provider.dart';
import 'package:getout/screens/connection/session/session_bloc.dart';
import 'package:getout/screens/home/bloc/home_provider.dart';

import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/widgets/loading.dart';

import 'package:getout/tools/status.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state.status.isFound) {
          return const HomeProvider();
        } else {
          if (state.status.isLoading) {
            return const Center(child: LoadingPage());
          } else if (state.status.isError) {
            return const ObjectLoadingErrorWidget(object: 'la session');
          } else if (state.status.isNotFound) {
            return const ConnectionProvider();
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
