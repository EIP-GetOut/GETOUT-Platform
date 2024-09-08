import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieSuccessShimmer extends StatelessWidget {
  const MovieSuccessShimmer({super.key});

  Widget buildShimmerPlaceholder(
      {double height = 100, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 220),
                child: buildShimmerPlaceholder(height: 200),
              ),
              Positioned(
                top: 100,
                child: buildShimmerPlaceholder(height: 300, width: 200),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 300, right: 340),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildShimmerPlaceholder(height: 30),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildShimmerPlaceholder(height: 20, width: 100),
                    const SizedBox(width: 16),
                    buildShimmerPlaceholder(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 16),
                buildShimmerPlaceholder(height: 150),
                const SizedBox(height: 16),
                buildShimmerPlaceholder(height: 30),
                const SizedBox(height: 16),
                buildShimmerPlaceholder(height: 80, width: 80),
                const SizedBox(height: 16),
                buildShimmerPlaceholder(height: 30),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildShimmerPlaceholder(height: 80, width: 80),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
