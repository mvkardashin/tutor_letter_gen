// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:tutor_letter_gen/screens/check_teacher_page.dart' as _i1;
import 'package:tutor_letter_gen/screens/home_page.dart' as _i2;
import 'package:tutor_letter_gen/screens/tabs_page.dart' as _i3;

/// generated route for
/// [_i1.CheckTeacherPage]
class CheckTeacherRoute extends _i4.PageRouteInfo<void> {
  const CheckTeacherRoute({List<_i4.PageRouteInfo>? children})
      : super(CheckTeacherRoute.name, initialChildren: children);

  static const String name = 'CheckTeacherRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.CheckTeacherPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.TabsPage]
class TabsRoute extends _i4.PageRouteInfo<void> {
  const TabsRoute({List<_i4.PageRouteInfo>? children})
      : super(TabsRoute.name, initialChildren: children);

  static const String name = 'TabsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.TabsPage();
    },
  );
}
