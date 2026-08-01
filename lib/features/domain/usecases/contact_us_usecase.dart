import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/repositories/contact_us_repository.dart';

import '../../../core/error/failure.dart';

class ContactUsParams {
  final String? email;
  final String? phone;
  final String message;

  const ContactUsParams({this.email, this.phone, required this.message});
}

class ContactUsUsecase {
  final ContactUsRepository repository;

  ContactUsUsecase({required this.repository});

  Future<Either<Failure, void>> call(ContactUsParams params) async {
    return await repository.sendContactUs(
      email: params.email,
      phone: params.phone,
      message: params.message,
    );
  }
}
