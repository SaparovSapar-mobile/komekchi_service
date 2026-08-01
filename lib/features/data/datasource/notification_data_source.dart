import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';

abstract class NotificationDataSource {
  Future<void> updateNotificationPreference({required bool isNotification});
}

class NotificationDataSourceImpl extends BaseRemoteDataSource
    implements NotificationDataSource {
  NotificationDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<void> updateNotificationPreference({required bool isNotification}) {
    return handleVoid(
      () => api.dio.put(
        '/notification',
        data: {'is_notification': isNotification},
      ),
      errorMessage: 'Failed to update notification preference',
    );
  }
}
