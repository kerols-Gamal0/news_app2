part of 'news_cubit.dart';

@immutable
class NewsState {
  final BaseState<Articles> fetchNewsState;

  const NewsState({required this.fetchNewsState});

  NewsState copyWith({BaseState<Articles>? fetchNewsState}) {
    return NewsState(fetchNewsState: fetchNewsState ?? this.fetchNewsState);
  }
}
