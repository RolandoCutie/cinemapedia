import 'package:cinemapediafernadoherrera/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProviders.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final getPopularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProviders);
    final slideShowMovies = ref.read(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(children: [
          MoviesSlideshow(movies: slideShowMovies),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            title: 'En cine',
            subTitle: 'Lunes',
          ),
          MovieHorizontalListView(
            movies: getPopularMovies,
            loadNextPage: () =>
                ref.read(popularMoviesProvider.notifier).loadNextPage(),
            title: 'Populares',
            subTitle: 'Lunes',
          ),
          MovieHorizontalListView(
            movies: topRatedMovies,
            loadNextPage: () =>
                ref.read(topRatedMoviesProviders.notifier).loadNextPage(),
            title: 'Mejor calificadas',
            subTitle: 'Lunes',
          )
        ]);
      }, childCount: 1)),
    ]);
  }
}
