/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/tools/map_controller.dart';
import 'package:getout/tools/tools.dart';

class ViewingPlatform extends StatelessWidget {
  final MapController<String, bool> platforms;

  const ViewingPlatform({super.key, required this.platforms});

  @override
  Widget build(BuildContext context)
  {
    const Map<String, String> images = {
      'Netflix': 'assets/images/logo/netflix.png',
      'Prime Video': 'assets/images/logo/prime_video.png',
      'Disney +': 'assets/images/logo/disney+.png',
      'Cinema': 'assets/images/logo/cinema.png',
      'DVD': 'assets/images/logo/DVD.png'
    };

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: Tools.heightFactor(context, 0.10)),
          const PageIndicator(currentPage: 2, pageCount: 3),
          SizedBox(height: Tools.heightFactor(context, 0.05)),
          Center(
            child: SizedBox(
              width: Tools.widthFactor(context, 0.45),
              child: AutoSizeText(
                'SUPPORT DE VISIONNAGE :',
                maxLines: 2,
                minFontSize: 18.0,
                maxFontSize: 24.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: Tools.heightFactor(context, 0.03)),
          Expanded(
            child: ValueListenableBuilder(
  valueListenable: platforms,
  builder: (context, _, __) {
  return ListView(
                //padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for (var checkbox in platforms.entries)
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ),
                          width: Tools.widthFactor(context, 0.9),
                          height: Tools.heightFactor(context, 0.08),
                          child: CheckboxListTile(
                            title: Row(
                              children: [
                                SizedBox(width: Tools.widthFactor(context, 0.12)),
                                Image.asset(images[checkbox.key]!,
                                    width: 40, height: 40),
                                SizedBox(width: Tools.widthFactor(context, 0.02)),
                                AutoSizeText(checkbox.key,
                                    maxLines: 1,
                                    minFontSize: 16.0,
                                    maxFontSize: 20.0,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            value: checkbox.value,
                            onChanged: (value) {
                              platforms[checkbox.key] = !platforms[checkbox.key]!;
                            },
                            //contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            tileColor: Colors.transparent,
                            checkColor: Colors.transparent,
                            activeColor: Theme.of(context).primaryColor,
                            shape: const Border(
                              bottom: BorderSide(color: Colors.black, width: 2.0),
                              left: BorderSide(color: Colors.black, width: 2.0),
                              right: BorderSide(color: Colors.black, width: 2.0),
                              top: BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: Tools.heightFactor(context, 0.012)),
                      ],
                    ),
                ]);},
          )
      )]
    );
  }
}
