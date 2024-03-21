import 'package:cinemapediafernadoherrera/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<Movie> getNowPlaying({int page = 1});
}
