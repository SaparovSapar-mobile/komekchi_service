import 'package:dartz/dartz.dart';

import '../error/faiulre.dart';



abstract interface class UseCases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
