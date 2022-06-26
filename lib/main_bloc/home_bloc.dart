import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int counter = 0;
  bool isDarkMode = false;

  HomeBloc() : super(const HomeLoad(counter: 0, isDarkMode: false)) {
    on<HomeStarting>((event, emit) async {
      var prefs = await SharedPreferences.getInstance();
      counter = prefs.getInt('mainCounter') ?? 0;
      isDarkMode = prefs.getBool('darkMode') ?? false;
      emit(HomeLoad(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeIncrementButtonTapEvent>((event, emit) async {
      counter++;
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt('mainCounter', counter);
      emit(HomeLoad(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeDecrementButtonTapEvent>((event, emit) async {
      counter--;
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt('mainCounter', counter);
      emit(HomeLoad(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeToggleButtonTapEvent>((event, emit) async {
      isDarkMode = !isDarkMode;
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool('darkMode', isDarkMode);
      emit(HomeLoad(counter: counter, isDarkMode: isDarkMode));
    });
  }
}
