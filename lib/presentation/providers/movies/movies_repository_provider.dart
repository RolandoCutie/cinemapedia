import 'package:cinemapediafernadoherrera/infraestructure/datasource/the_moviedb_datasource.dart';
import 'package:cinemapediafernadoherrera/infraestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final movieRepositoryProvider =
    Provider((ref) => MovieRepositoryImpl(MoviedbDatasource())); //provider
