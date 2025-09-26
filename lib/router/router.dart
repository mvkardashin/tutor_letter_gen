import 'package:auto_route/auto_route.dart';
import 'package:tutor_letter_gen/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TabsRoute.page, initial: true, children: [
          AutoRoute(page: CheckTeacherRoute.page),
          AutoRoute(page: HomeRoute.page),
          // AutoRoute(page: EmailAnswerRoute.page),
        ])
      ];
}
