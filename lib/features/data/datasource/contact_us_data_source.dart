import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';

abstract class ContactUsDataSource {
  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });
}

class ContactUsDataSourceImpl extends BaseRemoteDataSource
    implements ContactUsDataSource {
  ContactUsDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  }) {
    return handleVoid(
      () => api.dio.post(
        '/contact',
        data: {
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
          'message': message,
        },
      ),
      errorMessage: 'Failed to send message',
      successCodes: const {200, 201},
    );
  }
}
