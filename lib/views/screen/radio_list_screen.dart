import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:compaz_radio/model/radio_list_model.dart';
import 'package:compaz_radio/utils/strings.dart';
import 'package:compaz_radio/views/screen/drawer_screen.dart';
import 'package:compaz_radio/widget_helper/player.dart';
import 'package:compaz_radio/data/radio_list_data.dart';
import 'dart:ui'; // Añadido para el efecto glassmorphism

ValueNotifier<RadioListModel?> currentlyPlaying = ValueNotifier(radioChanelList[0]);
const double playerMinHeight = 70;
const miniPlayerPercentageDeclaration = 0.2;

final playerController = MiniplayerController();
final ValueNotifier<double> playerExpandProgress = ValueNotifier(800);

class RadioListScreen extends StatelessWidget {
  const RadioListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerController.animateToHeight(state: PanelState.MAX);
    });

    Future<bool> _onBackPress() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Strings.multiRadio.tr),
            content: Text(Strings.exitFromApp.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      ).then((value) => value ?? false);
    }

    return PopScope(
      onPopInvoked: (value) {
        _onBackPress;
      },
      child: Scaffold(
        drawer: DrawerScreen(),
        body: _bodyWidget(context),
      ),
    );
  }
}

Widget _bodyWidget(BuildContext context) {
  return Stack(
    children: [
      // Background con imagen
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'), // Asegúrate de tener esta imagen
            fit: BoxFit.cover,
          ),
        ),
      ),
      
      // Capa de glassmorphism
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ),

      // Imagen central
      Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/compaz.png'),
              fit: BoxFit.contain,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
      ),
      
      // Player
      ValueListenableBuilder(
        valueListenable: currentlyPlaying,
        builder: (BuildContext context, RadioListModel? radioListModel,
                Widget? child) =>
            DetailedPlayer(
              radioListModel: radioListModel ?? radioChanelList[0],
              controller: playerController,
            ),
      ),
    ],
  );
}