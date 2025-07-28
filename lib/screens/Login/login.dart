import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:harcama_takibi/screens/Login/login_view.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void login(BuildContext context) {
    _setLoading(true);

    // Simulate login process
    Future.delayed(const Duration(seconds: 1), () {
      _setLoading(false);
      context.go(Rotalar.anasayfaPath);
    });
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = LoginProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: const LoginView(),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
