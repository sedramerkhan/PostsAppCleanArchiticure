import 'package:bloc/bloc.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/posts.dart';
import '../../../presentation/bloc/posts/posts_state.dart'
    show ErrorPostsState, LoadedPostsState, LoadingPostsState, PostsInitial, PostsState;
import 'posts_event.dart';
import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/usecases/get_all_posts.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
//
// import 'posts_event.dart';
// import 'posts_state.dart';
//
// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   PostsBloc() : super(const PostsState().init());
//
//   @override
//   Stream<PostsState> mapEventToState(PostsEvent event) async* {
//
//     final GetAllPostsUseCase getAllPostsUseCase;
//
//
//     if (event is GetAllPostsEvent) {
//       yield await init();
//     }else if(event is RefreshPostsEvent){
//
//     }
//   }
//
//   Future<PostsState> init() async {
//     return state.clone();
//   }
// }
