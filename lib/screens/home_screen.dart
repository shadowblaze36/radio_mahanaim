import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_mahanaim/screens/menu_screen.dart';
import 'package:radio_mahanaim/screens/radio_screen.dart';

import '../providers/ui_provider.dart';
import '../widgets/custom_navigationbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title:
            // Image.asset(
            //   'assets/logo2.jpg',
            //   height: 70,
            // ),
            // toolbarHeight: 75,

            const Text(
          'Radio Mahanaim',
          style: TextStyle(color: Color(0xFFFDC505)),
        ),
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return IndexedStack(
      index: currentIndex,
      children: const [RadioScreen(), MenuScreen()],
    );
  }
}
