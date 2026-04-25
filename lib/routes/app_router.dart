import 'package:go_router/go_router.dart';
import '../views/dashboard_view.dart';
import '../views/departments/department_list_view.dart';
import '../views/departments/department_detail_view.dart';
import '../views/presidents/president_list_view.dart';
import '../views/presidents/president_detail_view.dart';
import '../views/airports/airport_list_view.dart';
import '../views/airports/airport_detail_view.dart';
import '../views/holidays/holiday_list_view.dart';
import '../views/touristic/touristic_list_view.dart';
import '../views/touristic/touristic_detail_view.dart';
import '../views/natural/natural_list_view.dart';
import '../views/natural/natural_detail_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardView(),
      ),

      // Departments
      GoRoute(
        path: '/departments',
        name: 'departments',
        builder: (context, state) => const DepartmentListView(),
      ),
      GoRoute(
        path: '/departments/:id',
        name: 'department-detail',
        builder: (context, state) =>
            DepartmentDetailView(id: int.parse(state.pathParameters['id']!)),
      ),

      // Presidents
      GoRoute(
        path: '/presidents',
        name: 'presidents',
        builder: (context, state) => const PresidentListView(),
      ),
      GoRoute(
        path: '/presidents/:id',
        name: 'president-detail',
        builder: (context, state) =>
            PresidentDetailView(id: int.parse(state.pathParameters['id']!)),
      ),

      // Airports
      GoRoute(
        path: '/airports',
        name: 'airports',
        builder: (context, state) => const AirportListView(),
      ),
      GoRoute(
        path: '/airports/:id',
        name: 'airport-detail',
        builder: (context, state) =>
            AirportDetailView(id: int.parse(state.pathParameters['id']!)),
      ),

      // Holidays
      GoRoute(
        path: '/holidays',
        name: 'holidays',
        builder: (context, state) => const HolidayListView(),
      ),

      // Touristic Attractions
      GoRoute(
        path: '/touristic',
        name: 'touristic',
        builder: (context, state) => const TouristicListView(),
      ),
      GoRoute(
        path: '/touristic/:id',
        name: 'touristic-detail',
        builder: (context, state) =>
            TouristicDetailView(id: int.parse(state.pathParameters['id']!)),
      ),

      // Natural Areas
      GoRoute(
        path: '/natural',
        name: 'natural',
        builder: (context, state) => const NaturalListView(),
      ),
      GoRoute(
        path: '/natural/:id',
        name: 'natural-detail',
        builder: (context, state) =>
            NaturalDetailView(id: int.parse(state.pathParameters['id']!)),
      ),
    ],
  );
}
