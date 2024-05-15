
import 'package:clock_app_flutter/constants/color_constants.dart';
import 'package:clock_app_flutter/data/data.dart';
import 'package:clock_app_flutter/menu_type.dart';
import 'package:clock_app_flutter/models/menu_info.dart';
import 'package:clock_app_flutter/screens/alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'clock_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((e) => buildMenuButton(e)).toList(),
            ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfoProvider>(
              builder: (BuildContext context, MenuInfoProvider value, Widget? child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else
                  return Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: 'execute later\n'),
                          TextSpan(
                            text: value.title,
                            style: TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            )
          ),
        ],
      ),
    );
  }

   Widget buildMenuButton(MenuInfoProvider currentMenuInfo) {
    return Consumer(
      builder: (BuildContext context,MenuInfoProvider value, Widget? child) {
        return Container(
          width: 80,
          child: ElevatedButton(
              onPressed: () {
                var menuInfo=Provider.of<MenuInfoProvider>(context,listen: false);
                menuInfo.updateMenu(currentMenuInfo);
              },
              style: ElevatedButton.styleFrom(

                elevation: 0,
                backgroundColor: currentMenuInfo.menuType == value.menuType ? color2 : Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    currentMenuInfo.imageSource!,
                    scale: 1.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      currentMenuInfo.title!,
                      style: TextStyle(color: Colors.white, fontSize: 12,overflow:TextOverflow.visible),
                    ),
                  ),
                ],
              )),
        );
      },

    );
  }
}
