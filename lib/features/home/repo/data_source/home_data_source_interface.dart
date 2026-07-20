import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/home/data/models/models.dart';

abstract interface class HomeDataSourceInterface {
  Future<BaseState<Articles>> getArticles();
}
