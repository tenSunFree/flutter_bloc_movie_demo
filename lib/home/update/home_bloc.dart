import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_movie_demo/home/model/home_model.dart';
import 'package:flutter_bloc_movie_demo/home/model/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState());
  final HomeRepository repository = HomeRepository();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataHomeEvent) {
      yield LoadingHomeState();
      try {
        final data = await repository.getData();
        yield ResponseHomeState(list: data[0]);
      } catch (e) {
        yield HomeFailureState(failureModel: HomeFailureModel(e.toString()));
      }
    }
  }
}
