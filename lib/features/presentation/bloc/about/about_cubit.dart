import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/core/usecase/usecase.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';
import 'package:komekchi_service/features/domain/usecases/about_usecase.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  final AboutUsecase aboutUsecase;
  AboutCubit({required this.aboutUsecase}) : super(AboutInitial());

  Future<void> fetchAbout() async {
    emit(AboutLoading());

    final result = await aboutUsecase(NoParams());
    result.fold(
      (failure) => emit(AboutError(message: failure.message)),
      (about) => emit(AboutSuccess(about: about)),
    );
  }
}
