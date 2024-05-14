import 'package:cinemapediafernadoherrera/config/constants/enviroment.dart';
import 'package:cinemapediafernadoherrera/domain/datasource/movies_datasource.dart';
import 'package:cinemapediafernadoherrera/domain/entities/movie.dart';
import 'package:cinemapediafernadoherrera/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapediafernadoherrera/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio =
      Dio(BaseOptions(baseUrl: "http://api.themoviedb.org/3", queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": "es-MX",
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        //Aqui con el metodo del movieMapper es q llevamos los datos a un modelo mas usado en la app
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      "/movie/now_playing",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await dio.get(
      "/movie/popular",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final response = await dio.get(
      "/movie/top_rated",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }
}
