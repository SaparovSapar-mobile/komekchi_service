import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/repositories/notification_repository.dart';
import '../../../core/error/failure.dart';

class UpdateNotificationPreferenceUsecase {
  final NotificationRepository repository;

  UpdateNotificationPreferenceUsecase({required this.repository});

  Future<Either<Failure, void>> call({required bool isNotification}) {
    return repository.updateNotificationPreference(
      isNotification: isNotification,
    );
  }
}
