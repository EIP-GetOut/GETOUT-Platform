import 'package:flutter/material.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/tools/launch_webview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryNewsCard extends StatelessWidget {
  const StoryNewsCard({super.key});

  // final StoryNewsResponse news;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryNewsBloc, StoryNewsState>(builder: (context, state) {
    return Center(
        child: GestureDetector(
      onTap: () => launchWebView(state.storyNews.sourceUrl),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2), // Couleur et épaisseur de la bordure
          borderRadius: BorderRadius.circular(25),
        ),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Le saviez-vous ?',
                  style: TextStyle(
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
              Text(
                  '${state.storyNews.quote}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('${state.storyNews.sourceStr}',
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
    ));
  });
  }
}
