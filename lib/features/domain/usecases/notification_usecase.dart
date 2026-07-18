import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class UpdateNotificationPreferenceUsecase {
  final GetAppRepository getAppsRepository;

  UpdateNotificationPreferenceUsecase({required this.getAppsRepository});

  Future<Either<Failure, void>> call({required bool isNotification}) {
    return getAppsRepository.updateNotificationPreference(
      isNotification: isNotification,
    );
  }
}
