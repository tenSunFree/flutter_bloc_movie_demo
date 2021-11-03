part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ResponseHomeState extends HomeState {
  final List<HomeResponseDetailModel> list;

  ResponseHomeState({required this.list});
}

class HomeFailureState extends HomeState {
  final HomeFailureModel failureModel;

  HomeFailureState({
    required this.failureModel,
  });
}
