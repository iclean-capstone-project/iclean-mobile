import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class ListTransactionLoading extends StatelessWidget {
  const ListTransactionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return ListTile(
          leading: const ShimmerLoadingWidget.circular(height: 24, width: 24),
          title: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerLoadingWidget.rectangular(
                width: MediaQuery.of(context).size.width * 0.4, height: 18),
          ),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerLoadingWidget.rectangular(
                width: MediaQuery.of(context).size.width * 0.3, height: 16),
          ),
          trailing: ShimmerLoadingWidget.rectangular(
              width: MediaQuery.of(context).size.width * 0.15, height: 16),
        );
      }),
    );
  }
}
