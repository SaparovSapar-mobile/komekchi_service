import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';

/// Shared by every repository implementation: runs [call] and converts its
/// outcome into an [Either] — any thrown [Failure] passes through as-is,
/// anything else becomes an [UnknownFailure].
mixin RepositoryErrorGuard {
  Future<Either<Failure, T>> guard<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// Same as [guard] for calls with no result worth returning.
  Future<Either<Failure, void>> guardVoid(Future<void> Function() call) async {
    try {
      await call();
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
