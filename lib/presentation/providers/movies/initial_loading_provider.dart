import 'package:cinemapediafernadoherrera/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_slideshow_provider.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final getPopularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProviders).isEmpty;
  final slideShowMovies = ref.watch(moviesSlideshowProvider).isEmpty;

  return nowPlayingMovies ||
      getPopularMovies ||
      topRatedMovies ||
      slideShowMovies;
});
