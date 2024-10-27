import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial(index: 0)) {
    on<PageChangeEvent>((event, emit) {
      emit(HomeInitial(index: event.index));
    });
  }
}
