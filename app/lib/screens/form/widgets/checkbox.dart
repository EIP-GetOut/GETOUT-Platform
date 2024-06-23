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
            padding: (checkboxImages == null) ? const EdgeInsets.all(16.0) : null,
            shrinkWrap: true,
            children: <Widget>[
              for (var checkbox in checkboxList.entries)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      width: (checkboxImages == null) ? null : Tools.widthFactor(context, 0.9),
                      height: (checkboxImages == null) ? null : Tools.heightFactor(context, 0.08),
                      child: CheckboxListTile(
                        title: (checkboxImages == null) ?
                        Text(checkbox.key,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                        ) : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: Tools.widthFactor(context, 0.10)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(checkboxImages![checkbox.key]!,
                                  width: 50),
                            ),
                            SizedBox(width: Tools.widthFactor(context, 0.03)),
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
                          context
                              .read<FormBloc>()
                              .add(event.setKey(checkbox.key));
                        },
                        contentPadding: (checkboxImages == null) ? EdgeInsets.zero : null,
                        controlAffinity: ListTileControlAffinity.leading,
                        tileColor: Colors.transparent,
                        checkColor: Colors.transparent,
                        activeColor: Theme.of(context).primaryColor,
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
