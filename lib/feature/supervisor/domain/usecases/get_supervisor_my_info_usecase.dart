import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_info_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorMyInfoUsecase {
  final SupervisorRepository repository;

  GetSupervisorMyInfoUsecase(this.repository);

  Future<Either<Failure, SupervisorInfoEntity>> call() {
    return repository.getMyInfo();
  }
}
