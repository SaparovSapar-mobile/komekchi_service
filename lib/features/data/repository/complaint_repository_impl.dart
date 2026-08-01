import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/complaint_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';
import 'package:komekchi_service/features/domain/repositories/complaint_repository.dart';

class ComplaintRepositoryImpl
    with RepositoryErrorGuard
    implements ComplaintRepository {
  final ComplaintDataSource dataSource;

  ComplaintRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ComplaintItem>>> getComplaints() {
    return guard(() => dataSource.getComplaints());
  }

  @override
  Future<Either<Failure, void>> submitComplaint({required String message}) {
    return guardVoid(() => dataSource.submitComplaint(message: message));
  }
}
