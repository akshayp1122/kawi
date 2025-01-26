import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawi_app/bloc/login_event.dart';
import 'package:kawi_app/bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }
  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final dio = Dio();
      final response = await dio.post('https://dummyjson.com/auth/login',
          data: {'username': event.username, 'password': event.password});
      final acessToken = response.data['accessToken'];
      final data = response.data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', data['username']);
      await prefs.setString('email', data['email']);
      await prefs.setString('firstName', data['firstName']);
      await prefs.setString('lastName', data['lastName']);
      await prefs.setString('gender', data['gender']);
      await prefs.setString('image', data['image']);

      emit(LoginSuccess(acessToken));
    } catch (e) {
      if (e is DioException) {
        emit(LoginFailure(e.response?.data['message'] ?? 'Login failed'));
      } else {
        emit(LoginFailure('an unknown error occured'));
      }
    }
  }
}
