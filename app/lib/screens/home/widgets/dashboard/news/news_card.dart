import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/launch_webview.dart';
import 'package:getout/screens/home/widgets/dashboard/news/news_bloc.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      return Center(
          child: GestureDetector(
              onTap: () => launchWebView(state.news.url),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: /* state.news.picture != ''
                        ? Image.network(
                            '${state.news.picture}',
                            fit: BoxFit.cover,
                            height: 400,
                            width: 500,
                            color: const Color.fromRGBO(150, 150, 150, 255)
                                .withOpacity(1),
                            colorBlendMode: BlendMode.modulate,
                          )
                        :*/ Container(
                            height: 400,
                            width: 500,
                            color: Color.fromARGB(255, 21, 21, 21),
                          ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${state.news.title}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      )),
                  // Positioned(
                  //     bottom: 200,
                  //     left: 10,
                  //     right: 10,
                  //     child: Image.network(
                  //       '${state.news.sourceLogo}',
                  //       fit: BoxFit.fill,
                  //       height: 100,
                  //       width: 100,
                  //       colorBlendMode: BlendMode.modulate,
                  //     ))
              ]),
              )));
    });
  }
}
