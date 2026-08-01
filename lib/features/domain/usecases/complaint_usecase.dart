import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';
import 'package:komekchi_service/features/domain/repositories/complaint_repository.dart';

import '../../../core/error/failure.dart';

class GetComplaintsUsecase {
  final ComplaintRepository repository;

  GetComplaintsUsecase({required this.repository});

  Future<Either<Failure, List<ComplaintItem>>> call() {
    return repository.getComplaints();
  }
}

class SubmitComplaintUsecase {
  final ComplaintRepository repository;

  SubmitComplaintUsecase({required this.repository});

  Future<Either<Failure, void>> call(String message) {
    return repository.submitComplaint(message: message);
  }
}
