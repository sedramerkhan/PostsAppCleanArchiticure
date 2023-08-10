
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repo.dart';

class DeletePostUseCase{
  final PostRepository repository;

  DeletePostUseCase(this.repository);


  Future<Either<Failure,Unit>> call(int postId)  async{
    return await repository.deletePost(postId);
  }
}