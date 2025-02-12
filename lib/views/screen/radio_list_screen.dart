import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:multi_radio/model/radio_list_model.dart';
import 'package:multi_radio/utils/strings.dart';
import 'package:multi_radio/views/screen/drawer_screen.dart';
import 'package:multi_radio/widget_helper/player.dart';
import 'package:multi_radio/data/radio_list_data.dart';

// Inicializamos con la primera radio de la lista
ValueNotifier<RadioListModel?> currentlyPlaying = ValueNotifier(radioChanelList[0]);
const double playerMinHeight = 70;
const miniPlayerPercentageDeclaration = 0.2;

// Creamos un controlador para el Miniplayer
final playerController = MiniplayerController();

// Inicializamos el playerExpandProgress con la altura máxima
final ValueNotifier<double> playerExpandProgress = ValueNotifier(800);

class RadioListScreen extends StatelessWidget {
  const RadioListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Expandimos el player al iniciar
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
      // Imagen central
      Center(
        child: Container(
          width: 200, // Ajusta según necesites
          height: 200, // Ajusta según necesites
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/compaz.png'), // Asegúrate de tener esta imagen
              fit: BoxFit.contain,
            ),
            // Opcional: añadir sombra o efectos
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