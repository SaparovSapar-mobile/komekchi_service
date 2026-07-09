import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class SearchParams {
  final String query;
  final int page;
  final int limit;

  const SearchParams({required this.query, this.page = 1, this.limit = 20});
}

class SearchUsecase implements UseCases<SearchResult, SearchParams> {
  final GetAppRepository getAppsRepository;

  SearchUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, SearchResult>> call(SearchParams params) async {
    return await getAppsRepository.searchServices(
      query: params.query,
      page: params.page,
      limit: params.limit,
    );
  }
}
