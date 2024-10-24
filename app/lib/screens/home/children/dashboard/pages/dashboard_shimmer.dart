/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ShimmerRefreshTimeCard(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ShimmerSpentTimeCard()),
                SizedBox(width: 10),
                Expanded(child: ShimmerSpentTimeCard()),
              ],
            ),
            SizedBox(height: 10),
            ShimmerNewsCard(),
            SizedBox(height: 20),
            ShimmerStoryNewsCard(),
          ],
        ),
      ),
    );
  }
}

class ShimmerRefreshTimeCard extends StatelessWidget {
  const ShimmerRefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]!, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: ListTile(
            leading:
                Icon(Icons.access_time_filled, size: 30, color: Colors.grey),
            title: SizedBox(
              width: double.infinity,
              height: 20,
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerNewsCard extends StatelessWidget {
  const ShimmerNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 250,
                    height: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerSpentTimeCard extends StatelessWidget {
  const ShimmerSpentTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]!, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 20,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Icon(Icons.book, color: Colors.grey[400]!, size: 30),
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerStoryNewsCard extends StatelessWidget {
  const ShimmerStoryNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]!, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Container(
                width: 80,
                height: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
