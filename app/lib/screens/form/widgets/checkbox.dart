/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/tools/tools.dart';

class FormCheckbox extends StatelessWidget {
  const FormCheckbox({super.key,required this.checkboxList, required this.event, this.checkboxImages});

  final Map<String, bool> checkboxList;
  final Map<String, String>? checkboxImages;
  final FormEvent event;

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(
      builder: (context, state) {
        return ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: <Widget>[
              for (var checkbox in checkboxList.entries)
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<FormBloc>()
                            .add(event.setKey(checkbox.key));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: checkbox.value ? Theme.of(context).primaryColor : Colors.white,
                            width: checkbox.value ? 4.0 : 1.0,
                          ),
                              boxShadow: [
                                if (!checkbox.value) BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                    color: Colors.grey.shade600,
                                    spreadRadius: 0.1,
                                    blurRadius: 5
                                )
                              ],
                        ),
                        width: Tools.widthFactor(context, 0.9),
                        height: Tools.heightFactor(context, 0.075),
                        child: (checkboxImages == null) ?
                          Center(
                            child: Text(checkbox.key,
                                style: Theme.of(context).textTheme.bodyMedium
                            ),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: Tools.widthFactor(context, 0.25)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(checkboxImages![checkbox.key]!,
                                    width: 50),
                              ),
                              const SizedBox(width: 22),
                              AutoSizeText(checkbox.key,
                                  maxLines: 1,
                                  minFontSize: 16.0,
                                  maxFontSize: 20.0,
                                  style:
                                  Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: Tools.heightFactor(context, 0.016)),
                  ],
                ),
            ]);
      },
    );
  }
}
