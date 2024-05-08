import 'package:cinemapediafernadoherrera/domain/entities/movie.dart';
import 'package:cinemapediafernadoherrera/presentation/providers/movies/movies_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);
  if (movies.isEmpty) return [];
  return movies.sublist(0, 6);
});
