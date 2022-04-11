import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailNotifier
])
void main() {
  late MockMovieDetailNotifier mockMovieDetailNotifier;

  setUp(() {
    mockMovieDetailNotifier = MockMovieDetailNotifier();
  });


  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockMovieDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when movie not added to watchlist', (WidgetTester tester) async {
        when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
        when(mockMovieDetailNotifier.recommenddationsState).thenReturn(RequestState.Loaded);
        when(mockMovieDetailNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });


  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed', (WidgetTester tester) async {
    when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommenddationsState).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockMovieDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when movie is added to wathclist', (WidgetTester tester) async {
    when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommenddationsState).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });



}