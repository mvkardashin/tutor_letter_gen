import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tutor_letter_gen/router/router.gr.dart';
import 'package:tutor_letter_gen/screens/home_page.dart';
import 'package:tutor_letter_gen/screens/%D1%81heck_teacher_page.dart';

@RoutePage()
class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return TestPage();
    return AutoTabsRouter(
      routes: const [
        CheckTeacherRoute(),
        HomeRoute(),
        // EmailAnswerRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              // here we switch between tabs
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  label: 'Пречек анкеты', icon: Icon(Icons.email_outlined)),
              BottomNavigationBarItem(
                  label: 'Генератор письма',
                  icon: Icon(Icons.accessibility_sharp)),
            ],
          ),
        );
      },
    );
  }
}
