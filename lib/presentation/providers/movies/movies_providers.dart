//final nowPlayingMoviesProvider

import 'package:cinemapediafernadoherrera/domain/entities/movie.dart';
import 'package:cinemapediafernadoherrera/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



typedef MovieCallback = Future<List<Movie>> Function({int page});

//This variable will access to the value of the state and controll the same state with the metods implemented in the movie
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopularMovies;
  return MoviesNotifier(fetchMovies: fetchMoreMovies);
});

final topRatedMoviesProviders =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRatedMovies;
  return MoviesNotifier(fetchMovies: fetchMoreMovies);
});





//Todo:este es el controlladxor que se encarga de recibir un calbacck que seria un
//acceso directo por asi decirlo a donde esta la implentacion del repositorio
// eso lo definimos en el movies repository provider

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMovies;
  bool isLoading = false;

  MoviesNotifier({required this.fetchMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

//Future<List<Movie>>
} //Future<void>
