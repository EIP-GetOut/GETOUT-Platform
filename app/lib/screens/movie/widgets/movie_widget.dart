import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/screens/movie/pages/movie.dart';
import 'package:getout/screens/movie/pages/movie_shimmer.dart';
import 'package:getout/widgets/transition_page.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MovieSuccessWidget();
        } else {
          if (state.status.isLoading) {
            return const MovieSuccessShimmer();
          } else if (state.status.isError) {
            return TransitionPage(
                    title: appL10n(context)!.error_unknown_short,
                    description: appL10n(context)!.error_unknown_description,
                    image: 'assets/images/draw/error.svg',
                    buttonText: appL10n(context)!.error_ok,
                    nextPage: () => {
                          Navigator.pop(context),
                        });
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
