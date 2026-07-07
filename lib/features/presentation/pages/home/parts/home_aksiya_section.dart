import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../domain/entities/aksiya.dart';
import '../../../bloc/aksiya/aksiya_cubit.dart';

class HomeAksiyaSection extends StatelessWidget {
  final AksiyaCubit aksiyaCubit;
  const HomeAksiyaSection({super.key, required this.aksiyaCubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<AksiyaCubit, AksiyaState>(
        bloc: aksiyaCubit,
        builder: (context, state) {
          if (state is AksiyaLoading || state is AksiyaInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AksiyaError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final items = (state as AksiyaSuccess).items;
          if (items.isEmpty) {
            return const Center(child: Text('Aksiýa ýok'));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return AksiyaPreviewCard(item: items[index]);
            },
          );
        },
      ),
    );
  }
}

class AksiyaPreviewCard extends StatelessWidget {
  final AksiyaItem item;
  const AksiyaPreviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/aksiyaDetail", extra: {"uuid": item.uuid});
      },
      child: Container(
        width: 174,
        margin: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9.46),
          child: Image.network(
            ApiConstants.imageUrl(item.imgTm),
            width: 174,
            height: 106,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 174,
                height: 106,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, color: Colors.grey),
              );
            },
          ),
        ),
      ),
    );
  }
}
