abstract class PostsEvent {}

class InitEvent extends PostsEvent {}

class GetAllPostsEvent extends PostsEvent{}
class RefreshPostsEvent extends PostsEvent{}
