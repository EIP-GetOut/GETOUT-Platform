/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/tools/launch_webview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/alert.dart';

class StoryNewsCard extends StatelessWidget {
  const StoryNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryNewsBloc, StoryNewsState>(
        builder: (context, state) {
      return Center(
          child: GestureDetector(
              onTap: () => showAlertDialog(
                  context,
                  'Aller vers le site',
                  'Redirection',
                  'Êtes-vous sûr de vouloir être redirigé vers un site externe ?',
                  () => launchWebView(state.storyNews.sourceUrl)),
              child: SizedBox(
                width: 500,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(appL10n(context)!.story_news,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/draw/question.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('${state.storyNews.quote}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              state.storyNews.sourceStr != 'Source inconnue'
                                  ? '${state.storyNews.sourceStr}'
                                  : '${state.storyNews.author}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                ),
              )));
    });
  }
}
