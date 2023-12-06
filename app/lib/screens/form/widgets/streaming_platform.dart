/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';


class CheckboxListWidgetStreamingPlatform extends StatefulWidget {
  const CheckboxListWidgetStreamingPlatform({super.key});

  @override
  State<CheckboxListWidgetStreamingPlatform> createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidgetStreamingPlatform> {
  final List<bool> _checkboxValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(16.0),
      child : Column(
      children: [
        CheckboxListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 70.0),
            Image.network('https://upload.wikimedia.org/wikipedia/commons/f/ff/Netflix-new-icon.png',  width: 32.0, height: 32.0,),
            const SizedBox(width: 8.0),
            Text('Netflix', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        value: _checkboxValues[0],
        onChanged: (value) {
                  setState(() {
                    _checkboxValues[0] = value!;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
          activeColor: Theme.of(context).primaryColor,
        ),       
        const SizedBox(height: 5),
        CheckboxListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 70.0),
            Image.network('https://upload.wikimedia.org/wikipedia/commons/f/f1/Prime_Video.png',  width: 56.0, height: 56.0,),
            const SizedBox(width: 8.0),
            Text('Prime Video', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        value: _checkboxValues[1],
        onChanged: (value) {
                  setState(() {
                    _checkboxValues[1] = value!;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 70.0),
            Image.network('https://logos-marques.com/wp-content/uploads/2022/03/Disney-Plus-logo.png',  width: 56.0, height: 56.0,),
            const SizedBox(width: 8.0),
            Text('Disney +', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        value: _checkboxValues[2],
        onChanged: (value) {
                  setState(() {
                    _checkboxValues[2] = value!;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const SizedBox(width: 70.0),
          Image.asset('assets/images/Logo_Cinema.png', width: 48, height: 48),
          const SizedBox(width: 8.0),
          Text('Cinema', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        value: _checkboxValues[3],
        onChanged: (value) {
                  setState(() {
                    _checkboxValues[3] = value!;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const SizedBox(width: 80.0),
          Image.asset('assets/images/Logo_DVD.png', width: 48, height: 48),
          const SizedBox(width: 8),
          Text('DVD', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        value: _checkboxValues[4],
        onChanged: (value) {
                  setState(() {
                    _checkboxValues[4] = value!;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    ),);
  }
}