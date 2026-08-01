import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/notification_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl
    with RepositoryErrorGuard
    implements NotificationRepository {
  final NotificationDataSource dataSource;

  NotificationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> updateNotificationPreference({
    required bool isNotification,
  }) {
    return guardVoid(
      () => dataSource.updateNotificationPreference(
        isNotification: isNotification,
      ),
    );
  }
}
