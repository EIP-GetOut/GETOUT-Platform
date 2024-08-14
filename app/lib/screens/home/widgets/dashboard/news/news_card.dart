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
                        :Container(
                            height: 400,
                            width: 500,
                            color: Color.fromARGB(255, 21, 21, 21),
                          ),
                  ),*/
                          Image.network(
                        'https://media.ouest-france.fr/v1/pictures/MjAyNDA1MTE3NGE5YWUzMjVmYzRjM2I3YzNmODBlMmU0YWI0Yzc?width=1260&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=eee2fc2d863daae83cce5bfed30764d2db552be1832f38238548bc53ab643268',
                        fit: BoxFit.cover,
                        height: 400,
                        width: 500,
                        color: const Color.fromRGBO(150, 150, 150, 255)
                            .withOpacity(1),
                        colorBlendMode: BlendMode.modulate,
                      )),
                  const Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          // '${state.news.title}',
                          "TikTok, Instagram, X...Les Français s'inquiètent des réseaux sociaux et demandent plus de régulation",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      )),
                  Positioned(
                      bottom: 200,
                      left: 10,
                      right: 10,
                      child: Image.network(
                        // '${state.news.sourceLogo}',
                        'https://www.lachance.media/wp-content/uploads/2018/09/ouestfrance-e1599137740364.png',
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                        colorBlendMode: BlendMode.modulate,
                      ))
                ]),
              )));
    });
  }
}
