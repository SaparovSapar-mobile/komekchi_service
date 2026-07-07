import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class ContactUsParams {
  final String? email;
  final String? phone;
  final String message;

  const ContactUsParams({this.email, this.phone, required this.message});
}

class ContactUsUsecase implements UseCases<void, ContactUsParams> {
  final GetAppRepository getAppsRepository;

  ContactUsUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, void>> call(ContactUsParams params) async {
    return await getAppsRepository.sendContactUs(
      email: params.email,
      phone: params.phone,
      message: params.message,
    );
  }
}
