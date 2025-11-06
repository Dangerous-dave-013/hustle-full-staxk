import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/courses/screens/course_detail_screen.dart';
import '../../features/courses/screens/my_courses_screen.dart';
import '../../features/courses/screens/course_player_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/wishlist/screens/wishlist_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/payment/screens/payment_options_screen.dart';
import '../../features/payment/screens/fake_payment_app_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/course/:id',
        name: 'course-detail',
        pageBuilder: (context, state) {
          final courseId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: CourseDetailScreen(courseId: courseId),
          );
        },
      ),
      GoRoute(
        path: '/my-courses',
        name: 'my-courses',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyCoursesScreen(),
        ),
      ),
      GoRoute(
        path: '/course-player/:id',
        name: 'course-player',
        pageBuilder: (context, state) {
          final courseId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: CoursePlayerScreen(courseId: courseId),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        path: '/payment-options',
        name: 'payment-options',
        pageBuilder: (context, state) {
          // courseIds may be passed as comma separated query param 'ids' or via extra
          List<String> courseIds = [];
          if (state.extra is List<String>) {
            courseIds = List<String>.from(state.extra as List<String>);
          } else if (state.uri.queryParameters['ids'] != null) {
            courseIds = state.uri.queryParameters['ids']!.split(',');
          }

          return MaterialPage(
            key: state.pageKey,
            child: PaymentOptionsScreen(courseIds: courseIds),
          );
        },
      ),
      GoRoute(
        path: '/fake-pay/:id',
        name: 'fake-pay',
        pageBuilder: (context, state) {
          final sessionId = state.pathParameters['id']!;
          final method = state.uri.queryParameters['method'] ?? 'card';
          final amount = double.tryParse(state.uri.queryParameters['amount'] ?? '0') ?? 0.0;
          return MaterialPage(
            key: state.pageKey,
            child: FakePaymentAppScreen(sessionId: sessionId, method: method, amount: amount),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/wishlist',
        name: 'wishlist',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WishlistScreen(),
        ),
      ),
    ],
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isAuthenticated = authProvider.isAuthenticated;
      
      final isSplashPage = state.matchedLocation == '/splash';
      final isLoginPage = state.matchedLocation == '/login';
      final isRegisterPage = state.matchedLocation == '/register';

      // Allow splash screen always
      if (isSplashPage) {
        return null;
      }

      if (!isAuthenticated && !isLoginPage && !isRegisterPage) {
        return '/login';
      }
      
      if (isAuthenticated && (isLoginPage || isRegisterPage)) {
        return '/';
      }

      return null;
    },
  );
}
