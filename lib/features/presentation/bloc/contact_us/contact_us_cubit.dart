import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/usecases/contact_us_usecase.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactUsUsecase contactUsUsecase;

  ContactUsCubit({required this.contactUsUsecase}) : super(ContactUsInitial());

  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  }) async {
    emit(ContactUsLoading());

    final result = await contactUsUsecase(
      ContactUsParams(email: email, phone: phone, message: message),
    );

    result.fold(
      (failure) => emit(ContactUsError(failure.message)),
      (_) => emit(ContactUsSuccess()),
    );
  }
}
