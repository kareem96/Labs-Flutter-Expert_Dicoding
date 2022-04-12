

import 'package:core/domain/entities/movie.dart';
import 'package:movie/usecase/get_top_rated_movies.dart';
import '../../../../../movie/lib/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../movie_list/movie_list_notifier_test.mocks.dart';


@GenerateMocks([
  GetTopRatedMovies
])
void main(){
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesNotifier notifier;
  late int listenerCallCount;

  setUp((){
    listenerCallCount = 0;
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    notifier = TopRatedMoviesNotifier(getTopRatedMovies: mockGetTopRatedMovies)..addListener(() {
      listenerCallCount++;
    });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('should change state to loading when usecase is called', () async {
    ///arrange
    when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovieList));
    ///act
    notifier.fetchTopRatedMovies();
    ///assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    ///arrange
    when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovieList));
    ///act
    await notifier.fetchTopRatedMovies();
    ///assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movie, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    ///arrange
    when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    ///act
    await notifier.fetchTopRatedMovies();
    ///assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}