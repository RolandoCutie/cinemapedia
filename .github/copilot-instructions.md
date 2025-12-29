# Copilot Instructions for Cinemapedia (Flutter)

## Arquitectura y flujo
- **Capas**: Dominio ([lib/domain](lib/domain)), Infraestructura ([lib/infraestructure](lib/infraestructure)), Presentación ([lib/presentation](lib/presentation)).
- **Flujo de datos**: `GoRouter` inicia en [lib/config/router/app_router.dart](lib/config/router/app_router.dart) → UI en [lib/presentation/screens/movies/home_screen.dart](lib/presentation/screens/movies/home_screen.dart) → `Riverpod` providers ([lib/presentation/providers/movies](lib/presentation/providers/movies)) → `MoviesRepository` ([lib/domain/repository/movies_repository.dart](lib/domain/repository/movies_repository.dart)) → `MoviesDatasource` ([lib/domain/datasource/movies_datasource.dart](lib/domain/datasource/movies_datasource.dart)) → implementación TMDB con `dio` ([lib/infraestructure/datasource/the_moviedb_datasource.dart](lib/infraestructure/datasource/the_moviedb_datasource.dart)) → mapeo a entidad con `MovieMapper` ([lib/infraestructure/mappers/movie_mapper.dart](lib/infraestructure/mappers/movie_mapper.dart)).
- **Entidad principal**: `Movie` ([lib/domain/entities/movie.dart](lib/domain/entities/movie.dart)); usa `posterPath` con centinela `no-poster` y URLs de imágenes de TMDB.

## Puesta en marcha
- **Requisitos**: Flutter 3.2+ y SDK Dart `>=3.2.6`.
- **Variables**: Copiar `.env.template` a `.env` y definir `THE_MOVIEDB_KEY` (ver [lib/config/constants/enviroment.dart](lib/config/constants/enviroment.dart)).
- **Dependencias**: Ejecutar:
  - `flutter pub get`
- **Ejecución**: Arranca la app desde [lib/main.dart](lib/main.dart) que carga `.env` y `ProviderScope`.
  - `flutter run`
- **Análisis/Lint**: `flutter analyze` (configurado por [analysis_options.yaml](analysis_options.yaml)).
- **Tests**: `flutter test` (base presente, no hay suites específicas aún).

## Patrones clave del proyecto
- **Navegación**: `GoRouter` con rutas nombradas usando `HomeScreen.name` ([lib/presentation/screens/movies/home_screen.dart](lib/presentation/screens/movies/home_screen.dart)). Añade rutas en [lib/config/router/app_router.dart](lib/config/router/app_router.dart).
- **Estado (Riverpod)**:
  - Repositorio global: `movieRepositoryProvider` ([lib/presentation/providers/movies/movies_repository_provider.dart](lib/presentation/providers/movies/movies_repository_provider.dart)).
  - Listas paginadas: `StateNotifierProvider` + `MoviesNotifier.loadNextPage()` ([lib/presentation/providers/movies/movies_providers.dart](lib/presentation/providers/movies/movies_providers.dart)). Usa `isLoading` para evitar duplicados y `currentPage` para paginación.
  - Carga inicial: `initialLoadingProvider` controla `FullScreenLoader` ([lib/presentation/providers/movies/initial_loading_provider.dart](lib/presentation/providers/movies/initial_loading_provider.dart)).
- **Red/Mapeos**:
  - `dio` con `BaseOptions` y query `api_key`/`language` ([lib/infraestructure/datasource/the_moviedb_datasource.dart](lib/infraestructure/datasource/the_moviedb_datasource.dart)).
  - Modelos de TMDB ([lib/infraestructure/models/moviedb](lib/infraestructure/models/moviedb)) → `MovieMapper` produce entidad `Movie` con URLs completas.

## Cómo extender (ejemplo: categoría "upcoming")
1. **Dominio**: Añade método a [lib/domain/datasource/movies_datasource.dart](lib/domain/datasource/movies_datasource.dart) y [lib/domain/repository/movies_repository.dart](lib/domain/repository/movies_repository.dart): `Future<List<Movie>> getUpcoming({int page = 1});`.
2. **Infraestructura**: Implementa en [lib/infraestructure/datasource/the_moviedb_datasource.dart](lib/infraestructure/datasource/the_moviedb_datasource.dart) usando endpoint `/movie/upcoming` y `_jsonToMovies`.
3. **Repositorio**: Expone en [lib/infraestructure/repositories/movie_repository_impl.dart](lib/infraestructure/repositories/movie_repository_impl.dart).
4. **Provider**: Crea `upcomingMoviesProvider` como `StateNotifierProvider` en [lib/presentation/providers/movies/movies_providers.dart](lib/presentation/providers/movies/movies_providers.dart).
5. **UI**: Consume en [lib/presentation/screens/movies/home_screen.dart](lib/presentation/screens/movies/home_screen.dart) con `MovieHorizontalListView`.

## Convenciones
- **Separación de capas**: Dominio libre de dependencias externas; Infraestructura integra APIs/IO; Presentación solo consume providers/repositorios.
- **Paginación**: Incrementa `currentPage` y concatena resultados en `state = [...state, ...movies]`.
- **Imágenes**: Usa base `https://image.tmdb.org/t/p/w500/` y coloca marcador cuando no haya `posterPath`.
- **Assets**: `pubspec.yaml` lista `lib/presentation/widgets/movies/` para recursos.

## Integraciones
- Principales paquetes: `go_router`, `flutter_riverpod`, `dio`, `flutter_dotenv`, `intl`, `animate_do`, `card_swiper` (ver [pubspec.yaml](pubspec.yaml)).

¿Algo poco claro o faltante? Dime qué sección ajustar o ampliar y lo iteramos.
