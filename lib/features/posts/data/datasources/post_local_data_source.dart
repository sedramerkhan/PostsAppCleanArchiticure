import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachedPosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  final key = "CACHED_POSTS";

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachedPosts(List<PostModel> postModels) {
    List postModelToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(key, json.encode(postModelToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);

      List<PostModel> jsonPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return Future.value(jsonPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
