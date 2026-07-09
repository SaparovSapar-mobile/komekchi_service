import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class GetComplaintsUsecase implements UseCases<List<ComplaintItem>, NoParams> {
  final GetAppRepository getAppsRepository;

  GetComplaintsUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, List<ComplaintItem>>> call(NoParams params) {
    return getAppsRepository.getComplaints();
  }
}

class SubmitComplaintUsecase implements UseCases<void, String> {
  final GetAppRepository getAppsRepository;

  SubmitComplaintUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, void>> call(String message) {
    return getAppsRepository.submitComplaint(message: message);
  }
}
