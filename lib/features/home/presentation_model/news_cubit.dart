import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/data/api/api_helpers.dart';
import 'package:news_app/features/home/data/models/models.dart';
import 'package:news_app/core/base_state/base_state.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final ApiHelpers apiHelpers = ApiHelpers();

  NewsCubit()
    : super(const NewsState(fetchNewsState: BaseInitialState<Articles>()));

  Future<void> fetchNews() async {
    emit(state.copyWith(fetchNewsState: const BaseLoadingState<Articles>()));

    try {
      final result = await apiHelpers.getArticles();

      if (result.articles != null && result.articles!.isNotEmpty) {
        emit(
          state.copyWith(
            fetchNewsState: BaseSuccessState<Articles>(data: result),
          ),
        );
      } else {
        emit(
          state.copyWith(
            fetchNewsState: const BaseFailureState<Articles>(
              errorMessage: "No articles found",
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          fetchNewsState: const BaseFailureState<Articles>(
            errorMessage: "Error fetching articles",
          ),
        ),
      );
    }
  }
}
