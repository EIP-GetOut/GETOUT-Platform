/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'tools.dart';

class EmptySizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final double? heightFactor;
  final double? widthFactor;

  const EmptySizedBox({
    super.key,
    this.height,
    this.width,
    this.heightFactor,
    this.widthFactor,
  });

  @override
  Widget build(BuildContext context)
  {
    double? boxHeight = (heightFactor == null) ? height :
                        MediaQuery.of(context).size.height * heightFactor!;
    double? boxWidth = (widthFactor == null) ? width :
                        MediaQuery.of(context).size.width * widthFactor!;

    return SizedBox(
      key: key,
      height: boxHeight,
      width: boxWidth,
    );
  }
}