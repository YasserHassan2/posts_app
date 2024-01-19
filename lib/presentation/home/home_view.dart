import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/presentation/main/view/main_view.dart';

import '../../utils/resources/color_manager.dart';
import '../../utils/resources/font_manager.dart';
import '../../utils/resources/strings_manager.dart';
import '../../utils/resources/styles_manager.dart';
import '../../utils/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _title = AppStrings.home.tr();
  List<Widget> pages = [
    MainView(),
    TabTwo(),
    TabThree(),
  ];
  List<String> titles = [
    AppStrings.home.tr(),
    'Tab2',
    'Tab3',
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
          ]),
          child: BottomNavigationBar(
            selectedItemColor: ColorManager.headersTextColor,
            unselectedItemColor: ColorManager.hintTextColor,
            currentIndex: _currentIndex,
            backgroundColor: ColorManager.thirdAccentColor,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.wordpress),
                  label: 'Tab One',
                  activeIcon: Icon(
                    Icons.wordpress,
                    color: ColorManager.primary,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wordpress),
                  label: 'Tab Two',
                  activeIcon: Icon(
                    Icons.wordpress,
                    color: ColorManager.primary,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wordpress),
                  label: 'Tab Three',
                  activeIcon: Icon(
                    Icons.wordpress,
                    color: ColorManager.primary,
                  )),
            ],
          ),
        ));
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}

class TabTwo extends StatelessWidget {
  const TabTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Coming Soon!",
          style: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s17),
        ),
      ),
    );
  }
}
class TabThree extends StatelessWidget {
  const TabThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Coming Soon!",
          style: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s17),
        ),
      ),
    );
  }
}
