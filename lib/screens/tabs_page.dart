import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tutor_letter_gen/router/router.gr.dart';

@RoutePage()
class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        EmailAnswerRoute(),
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
                  label: 'По анкетам', icon: Icon(Icons.accessibility_sharp)),
              BottomNavigationBarItem(
                  label: 'Для почты', icon: Icon(Icons.email_outlined)),
            ],
          ),
        );
      },
    );
  }
}
