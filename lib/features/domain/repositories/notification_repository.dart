import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> updateNotificationPreference({
    required bool isNotification,
  });
}
