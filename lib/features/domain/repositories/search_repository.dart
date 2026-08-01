import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResult>> searchServices({
    required String query,
    int page,
    int limit,
  });
}
