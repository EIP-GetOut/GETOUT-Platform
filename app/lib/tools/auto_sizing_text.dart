/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'tools.dart';

class AutoSizingText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final double minSize;
  final double maxSize;
  final double sizeFactor;
  final double? height;
  final bool wrapWords;
  final bool softWrap;
  final TextWidthBasis textWidthBasis;

  const AutoSizingText(this.text, {
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.sizeFactor,
    this.height,
    this.style = const TextStyle(),
    this.textAlign, // = null
    this.maxLines, // = null
    this.overflow = TextOverflow.clip,
    this.wrapWords = true,
    this.softWrap = true,
    this.textWidthBasis = TextWidthBasis.parent,
  });

  @override
  Widget build(BuildContext context)
  {
    double widthSize = MediaQuery.of(context).size.width * sizeFactor;
    widthSize = widthSize.clamp(minSize, maxSize);

    return LayoutBuilder(
      builder: (context, size) {
        return Container(
          height: height,
          width: widthSize,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: style,
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: overflow,
              softWrap: softWrap,
              textWidthBasis: textWidthBasis,
            ),
          ),
        );
      }
    );
  }
}