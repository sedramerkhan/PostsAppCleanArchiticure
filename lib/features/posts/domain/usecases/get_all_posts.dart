import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/posts.dart';
import '../repositories/post_repo.dart';

class GetAllPostsUseCase{
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);


  Future<Either<Failure,List<Post>>> call()  async{
    return await repository.getAllPosts();
  }
}