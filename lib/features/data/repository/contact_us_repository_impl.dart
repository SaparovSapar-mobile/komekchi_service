import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/contact_us_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/repositories/contact_us_repository.dart';

class ContactUsRepositoryImpl
    with RepositoryErrorGuard
    implements ContactUsRepository {
  final ContactUsDataSource dataSource;

  ContactUsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> sendContactUs({
    String? email,
    String? phone,
    required String message,
  }) {
    return guardVoid(() => dataSource.sendContactUs(
          email: email,
          phone: phone,
          message: message,
        ));
  }
}
