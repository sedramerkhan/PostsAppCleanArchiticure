import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_date_source.dart';

import 'package:clean_architecture_posts_app/features/posts/domain/entities/posts.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/post_repo.dart';
import '../models/post_model.dart';

typedef Future<Unit> CRUD();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDateSource;
  final PostLocalDataSource localDateSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.networkInfo,
    required this.remoteDateSource,
    required this.localDateSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDateSource.getAllPosts();
        localDateSource.cachedPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDateSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDateSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() {
      return remoteDateSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await _getMessage(() {
      return remoteDateSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(CRUD fun) async {
    if (await networkInfo.isConnected) {
      try {
        await fun();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
