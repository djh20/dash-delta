
import 'package:dash_delta/constants.dart';
import 'package:dash_delta/model.dart';
import 'package:dash_delta/themes.dart';
import 'package:dash_delta/widgets/drawer/card.dart';
import 'package:dash_delta/widgets/drawer/metrics_card.dart';
import 'package:dash_delta/widgets/drawer/navigation_card.dart';
import 'package:dash_delta/widgets/drawer/performance_card.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = 
      ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        elevation: 0
      );

    final model = PropertyChangeProvider.of<AppModel, String>(
      context, 
      listen: false
    )?.value;

    return OverflowBox(
      minWidth: 0,
      maxWidth: 295,
      alignment: Alignment.centerRight,
      child: PageView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        controller: model?.hPageController,
        onPageChanged: model?.hPageChanged,
        scrollBehavior: NoGlowBehavior(),
        children: [
          const SizedBox(), // Empty page
          PageView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.vertical,
            controller: model?.vPageController,
            onPageChanged: model?.vPageChanged,
            //scrollBehavior: NoGlowBehavior(),
            children: [
              const DrawerCard(
                title: 'Map (Beta)',
                icon: Icons.map,
                children: [
                  NavigationCardContent()
                ],
              ),
              /*const DrawerCard(
                title: 'Battery',
                icon: Icons.battery_full,
                children: [
                  //PerformanceCardContent()
                ],
              ),*/
              const DrawerCard(
                title: 'Performance',
                icon: Icons.speed,
                children: [
                  PerformanceCardContent()
                ],
              ),
              DrawerCard(
                title: 'Settings',
                icon: Icons.settings,
                children: [
                  ElevatedButton(
                    child: const Text("LIGHT THEME"),
                    style: buttonStyle,
                    onPressed: () {
                      model?.setAutoTheme(false);
                      model?.setTheme(Themes.light);
                    },
                  ),
                  ElevatedButton(
                    child: const Text("DARK THEME"),
                    style: buttonStyle,
                    onPressed: () {
                      model?.setAutoTheme(false);
                      model?.setTheme(Themes.dark);
                    },
                  ),
                  ElevatedButton(
                    child: const Text("AUTO THEME"),
                    style: buttonStyle,
                    onPressed: () => model?.setAutoTheme(true),
                  ),
                  ElevatedButton(
                    child: const Text("CONNECT TO DEV SERVER"),
                    style: buttonStyle,
                    onPressed: () {
                      model?.vehicle.ip = Constants.devIp;
                      model?.vehicle.reconnect();
                    },
                  ),
                ],
              ),
              const DrawerCard(
                title: 'Metrics',
                icon: Icons.data_usage,
                children: [
                  MetricsCardContent()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}