import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, void>> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });
}
