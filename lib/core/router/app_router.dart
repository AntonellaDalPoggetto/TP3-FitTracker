import 'package:fittracker/presentation/screens/about_screen.dart';
import 'package:fittracker/presentation/screens/change_password_screen.dart';
import 'package:fittracker/presentation/screens/exercise_registration_screen.dart';
import 'package:fittracker/presentation/screens/exercises_list_screen.dart';
import 'package:fittracker/presentation/screens/graphics_modifier_screen.dart';
import 'package:fittracker/presentation/screens/home.dart';
import 'package:fittracker/presentation/screens/login_screen.dart';
import 'package:fittracker/presentation/screens/main_container.dart';
import 'package:fittracker/presentation/screens/meals_list_screen.dart';
import 'package:fittracker/presentation/screens/meals_registration_screen.dart';
import 'package:fittracker/presentation/screens/register.dart';
import 'package:fittracker/presentation/screens/user_options.dart';
import 'package:fittracker/presentation/screens/user_screen.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: Register.name,
      builder: (context, state) => const Register(),
    ),
    GoRoute(
      path: '/exercise_registration',
      name: ExerciseRegistrationScreen.name,
      builder: (context, state) => const ExerciseRegistrationScreen(),
    ),
    GoRoute(
      path: '/meals_registration',
      name: MealsRegistrationScreen.name,
      builder: (context, state) => const MealsRegistrationScreen(),
    ),
    GoRoute(
      path: '/change_password',
      name: ChangePasswordScreen.name,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/user_screen',
      name: UserScreen.name,
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const MainContainer(),
      routes: [
        GoRoute(
          path: 'home',
          name: Home.name,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: 'exercises_list',
          name: ExercisesListScreen.name,
          builder: (context, state) => const ExercisesListScreen(),
        ),
        GoRoute(
          path: 'graphics_modifier',
          name: GraphicsModifierScreen.name,
          builder: (context, state) => const GraphicsModifierScreen(),
        ),
        GoRoute(
          path: 'meals_list',
          name: MealsListScreen.name,
          builder: (context, state) => const MealsListScreen(),
        ),
        GoRoute(
          path: 'user_options',
          name: UserOptions.name,
          builder: (context, state) => const UserOptions(),
        ),
        GoRoute(
          path: 'about_screen',
          name: AboutScreen.name,
          builder: (context, state) => const AboutScreen(),
        ),
      ],
    ),
  ],
);