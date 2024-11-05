import 'package:fpdart/fpdart.dart';
import 'package:trackpot/core/exception/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repository/group_repository.dart';

class GetUserBalanceStats
    implements UseCase<Map<String, double>, GetUserBalanceStatsParams> {
  final GroupRepository repository;

  GetUserBalanceStats(this.repository);

  @override
  Future<Either<Failure, Map<String, double>>> call(
      GetUserBalanceStatsParams params) {
    return repository.getUserBalanceStats(params.id);
  }
}

class GetUserBalanceStatsParams {
  final String id;

  GetUserBalanceStatsParams({
    required this.id,
  });
}
