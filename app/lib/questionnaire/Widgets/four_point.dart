import 'package:flutter/material.dart';

class FourPointsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: Container(
            width: 30,
            height: 10,
            decoration: const BoxDecoration(
            color: Color.fromRGBO(213, 86, 65, 1),
            shape: BoxShape.circle,
          ),
          ),
        ),
        Container(
          width: 30,
          height: 10,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(213, 86, 65, 1),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 30,
          height: 10,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(213, 86, 65, 1),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 30,
          height: 10,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(213, 86, 65, 1),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  PageIndicator({required this.currentPage, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        double opacity = index == currentPage ? 1.0 : 0.5;
        return Container(
          width: 50.0,
          height: 8.0,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            shape: BoxShape.rectangle,
            color: const Color.fromRGBO(213, 86, 65, 1).withOpacity(opacity),
            
          ),
        );
      }),
    );
  }
}

