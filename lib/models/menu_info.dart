import 'package:flutter/foundation.dart';

import '../menu_type.dart';

class MenuInfoProvider extends ChangeNotifier{

  MenuType menuType;
  String ?title;
  String ?imageSource;

  MenuInfoProvider(this.menuType,{this.title,this.imageSource});

  updateMenu(MenuInfoProvider menuInfo){
    menuType=menuInfo.menuType;
    title=menuInfo.title;
    imageSource=menuInfo.imageSource;
    notifyListeners();
  }



}