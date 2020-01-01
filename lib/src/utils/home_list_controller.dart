import 'dart:ui';

import 'package:flutter/material.dart';


class HomeScrollController{
  ScrollController scrollController;
  int selectedTab = 0;

  void initState(VoidCallback scrollListener){
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void dispose(){
    scrollController.dispose();
  }
}

HomeScrollController controller = HomeScrollController();
