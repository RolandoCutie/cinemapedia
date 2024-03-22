import 'package:cinemapediafernadoherrera/config/constants/enviroment.dart';
import 'package:cinemapediafernadoherrera/domain/datasource/movies_datasource.dart';
import 'package:cinemapediafernadoherrera/domain/entities/movie.dart';
import 'package:cinemapediafernadoherrera/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapediafernadoherrera/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio =
      Dio(BaseOptions(baseUrl: "http://api.themoviedb.org/3", queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": "es-MX",
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      "/movie/now_playing",
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
