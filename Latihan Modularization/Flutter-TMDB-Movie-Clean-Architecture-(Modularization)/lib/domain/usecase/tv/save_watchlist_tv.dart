


import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTv{
  final TvRepository repository;
  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail){
    return repository.saveWatchlistTv(tvDetail);
  }
}