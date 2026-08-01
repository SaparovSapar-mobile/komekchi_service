import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/repositories/search_repository.dart';

import '../../../core/error/failure.dart';

class SearchParams {
  final String query;
  final int page;
  final int limit;

  const SearchParams({required this.query, this.page = 1, this.limit = 20});
}

class SearchUsecase {
  final SearchRepository repository;

  SearchUsecase({required this.repository});

  Future<Either<Failure, SearchResult>> call(SearchParams params) async {
    return await repository.searchServices(
      query: params.query,
      page: params.page,
      limit: params.limit,
    );
  }
}
