import 'package:flutter/material.dart';
class MainAppbar extends StatelessWidget implements PreferredSizeWidget{
  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppBar(

        // leading: IconButton(
        //   icon: const Icon(Icons.sort),
        //   onPressed: () {
        //     final homeController = Get.find<HomeController>();
        //     homeController.toggleSort();
        //   },
        // ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        // title: Text('Freely', style: montserratHeader.copyWith(fontSize: 22)),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(12);

}
