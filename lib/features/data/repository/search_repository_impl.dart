import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/search_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/repositories/search_repository.dart';

class SearchRepositoryImpl with RepositoryErrorGuard implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, SearchResult>> searchServices({
    required String query,
    int page = 1,
    int limit = 20,
  }) {
    return guard(
      () => dataSource.searchServices(query: query, page: page, limit: limit),
    );
  }
}
