import '../repositories/favorites-news.repository.dart';

class FavoritesState {
  static final FavoritesState _favoritesState =
      FavoritesState._privateConstructor();

  factory FavoritesState() => _favoritesState;

  FavoritesState._privateConstructor();

  final _favoritesNewsRepository = FavoritesNewsRepository();

  // === FAVORITES NEWS ===

  void getFavoriteNewsById({required String newsId}) async {
    try {
      _favoritesNewsRepository.getFavoritesNewsById(
        id: newsId,
      );
    } on Exception {
      // TODO add something to catch the error. See example in VS.
    }
  }

// // Get repositories documents
// void getRepositoryDocsByRoute(HFActivityRoute route) async {
//   try {
//     bool isSpace = route.subspacePath == '';
//     bool isSubspace = !isSpace && route.activityPath == '';
//     bool isActivity = route.activityPath != '';
//     _pageLoaderService.showPageLoader();
//     if (isSpace) {
//       final documents =
//       await _repositoriesRepository.getSpaceRepositoryDocsByRoute(
//         route.spacePath,
//       );
//       _state$.add(AppStateOk(documents));
//       _pageLoaderService.hidePageLoader();
//     }
//     if (isSubspace) {
//       final documents =
//       await _repositoriesRepository.getSubspaceRepositoryDocsByRoute(
//         route.spacePath,
//         route.subspacePath,
//       );
//       _state$.add(AppStateOk(documents));
//       _pageLoaderService.hidePageLoader();
//     }
//     if (isActivity) {
//       final documents =
//       await _repositoriesRepository.getActivityRepositoryDocsByRoute(
//         route.spacePath,
//         route.subspacePath,
//         route.activityPath,
//       );
//       _state$.add(AppStateOk(documents));
//       _pageLoaderService.hidePageLoader();
//     }
//   } on Exception {
//     _state$.add(AppStateErr());
//   }
// }
}
