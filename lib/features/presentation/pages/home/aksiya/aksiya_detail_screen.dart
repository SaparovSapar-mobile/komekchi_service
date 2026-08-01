import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_detail_cubit.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class AksiyaDetailScreen extends StatelessWidget {
  const AksiyaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = AppColor.pageBg(context);
    final textColor = AppColor.titleText(context);

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                    Text(
                      'Aksiýa',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<AksiyaDetailCubit, AksiyaDetailState>(
                  builder: (context, state) {
                    if (state is AksiyaDetailLoading ||
                        state is AksiyaDetailInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AksiyaDetailError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final item = (state as AksiyaDetailSuccess).item;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              ApiConstants.imageUrl(item.img(context)),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 200,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (item.durationStart.isNotEmpty &&
                              item.durationEnd.isNotEmpty)
                            Text(
                              '${item.durationStart} — ${item.durationEnd}',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.descriptionText(context),
                              ),
                            ),
                          if (item.hourStart.isNotEmpty &&
                              item.hourEnd.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${item.hourStart} — ${item.hourEnd}',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.descriptionText(context),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
