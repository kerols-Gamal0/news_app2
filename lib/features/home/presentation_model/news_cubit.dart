import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/data/models/models.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/home/repo/repo/home_repo_interface.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._homeRepo)
    : super(const NewsState(fetchNewsState: BaseInitialState<Articles>()));
  final HomeRepoInterface _homeRepo;

  Future<void> fetchNews() async {
    emit(state.copyWith(fetchNewsState: const BaseLoadingState<Articles>()));

    final resultState = await _homeRepo.getArticles();

    emit(state.copyWith(fetchNewsState: resultState));
  }
}
