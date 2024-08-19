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
              onTap: () => launchWebView(
                  'https://www.radiofrance.fr/franceinter/meta-tiktok-x-snapchat-les-reseaux-sociaux-accuses-de-malmener-la-sante-mentale-des-plus-jeunes-6968044'),
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
                        'https://leseng.rosselcdn.net/sites/default/files/dpistyles_v2/ls_16_9_864w/2024/07/09/node_600692/31311605/public/2024/07/09/21232853.jpeg?itok=GZ_Dj6ws1720604025',
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
                        padding: EdgeInsets.all(10),
                        child: Text(
                          // '${state.news.title}',
                          'Meta, TikTok, X, Snapchat... Les réseaux sociaux accusés de malmener la santé mentale des plus jeunes',
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
                        'https://lh4.googleusercontent.com/proxy/btuZBXctiokcEue8M8c1jdMBTHjAA7RQd6XZdhmruPrv9SxfAYZldWZCqXtpSx1QTPczBLLvntJAxMl3g-V8U5-uQFsrJOPcal3rBV0XSOgg0EcIGp7H4QB9r2fTWQ',
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
