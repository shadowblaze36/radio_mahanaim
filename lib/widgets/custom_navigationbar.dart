import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(0),
        topLeft: Radius.circular(0),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF032555),
        selectedItemColor: const Color(0xFFFDC505),
        unselectedItemColor: Colors.white60,
        onTap: ((int i) => {uiProvider.selectedMenuOpt = i}),
        elevation: 0,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.radio), label: 'Radio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contactless_outlined), label: 'Mahanaim'),
        ],
      ),
    );
  }
}
