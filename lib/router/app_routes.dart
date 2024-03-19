import '../screen/screens.dart';

class AppRoutes {
  static const initialroute = 'home';
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const LoginPage(),
    '/home': (context) => const HomePage(),
    '/register': (context) => const RegisterPage(),
  };
}
