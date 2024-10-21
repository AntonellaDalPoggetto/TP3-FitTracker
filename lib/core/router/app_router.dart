import 'package:fittracker/presentation/screens/exercise_registration_screen.dart';
import 'package:fittracker/presentation/screens/exercises_list_screen.dart';
import 'package:fittracker/presentation/screens/graphics_modifier_screen.dart';
import 'package:fittracker/presentation/screens/home.dart';
import 'package:fittracker/presentation/screens/login.dart';
import 'package:fittracker/presentation/screens/main_container.dart';
import 'package:fittracker/presentation/screens/meals_list_screen.dart';
import 'package:fittracker/presentation/screens/meals_registration_screen.dart';
import 'package:fittracker/presentation/screens/register.dart';
import 'package:fittracker/presentation/screens/user_options.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: Home.name,
      builder: (context, state) => MainContainer(child: const Home()),
    ),
    GoRoute(
      path: '/login',
      name: Login.name,
      builder: (context, state) => const Login(),
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
      path: '/exercises_list',
      name: ExercisesListScreen.name,
      builder: (context, state) =>  MainContainer(child: const ExercisesListScreen()),
    ),
    GoRoute(
      path: '/graphics_modifier',
      name: GraphicsModifierScreen.name,
      builder: (context, state) =>  MainContainer(child: const GraphicsModifierScreen()),
    ),
    GoRoute(
      path: '/meals_list',
      name: MealsListScreen.name,
      builder: (context, state) =>  MainContainer(child: const MealsListScreen()),
    ),
    GoRoute(
      path: '/meals_registration',
      name: MealsRegistrationScreen.name,
      builder: (context, state) => const MealsRegistrationScreen(),
    ),
    GoRoute(
      path: '/user_options',
      name: UserOptions.name,
      builder: (context, state) =>  MainContainer(child: const UserOptions()),
    ),
  ],
);
