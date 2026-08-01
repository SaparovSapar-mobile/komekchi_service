import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/complaint_model.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';

abstract class ComplaintDataSource {
  Future<List<ComplaintItem>> getComplaints();
  Future<void> submitComplaint({required String message});
}

class ComplaintDataSourceImpl extends BaseRemoteDataSource
    implements ComplaintDataSource {
  ComplaintDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<ComplaintItem>> getComplaints() {
    return handle(
      () => api.dio.get('/complaints'),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => ComplaintItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load complaints',
    );
  }

  @override
  Future<void> submitComplaint({required String message}) {
    return handleVoid(
      () => api.dio.post('/complaints', data: {'message': message}),
      errorMessage: 'Failed to submit complaint',
      successCodes: const {200, 201},
    );
  }
}
