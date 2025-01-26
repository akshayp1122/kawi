import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawi_app/bloc/login_bloc.dart';
import 'package:kawi_app/bloc/login_event.dart';
import 'package:kawi_app/bloc/login_state.dart';
import 'package:kawi_app/screen/bottom_navigationbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Login sucessfully')));
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationbar()));
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error :${state.error}')));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'password'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  state is LoginLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final username = usernameController.text;
                            final password = passwordController.text;
                            if (username.isNotEmpty && password.isNotEmpty) {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginSubmitted(password, username));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Field cannot be empty')));
                            }
                          },
                          child: Text('login'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
