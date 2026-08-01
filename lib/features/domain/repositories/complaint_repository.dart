import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';

abstract class ComplaintRepository {
  Future<Either<Failure, List<ComplaintItem>>> getComplaints();
  Future<Either<Failure, void>> submitComplaint({required String message});
}
