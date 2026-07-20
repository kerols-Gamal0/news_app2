import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/home/data/models/models.dart';
import 'package:news_app/features/home/repo/data_source/home_data_source_interface.dart';
import 'package:news_app/features/home/repo/repo/home_repo_interface.dart';

class HomeRepoImplementation implements HomeRepoInterface {
  final HomeDataSourceInterface _homeDataSource;

  HomeRepoImplementation(this._homeDataSource);

  @override
  Future<BaseState<Articles>> getArticles() {
    return _homeDataSource.getArticles();
  }
}
