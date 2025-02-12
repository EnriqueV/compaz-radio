import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:compaz_radio/model/radio_list_model.dart';

typedef OnTap = Function(RadioListModel radioListModel);

List<RadioListModel> radioChanelList = [
  RadioListModel(
    title: 'Compaz Radio',
    subTitle: 'SubTitle',
    image: 'assets/images/compaz.png',
    id: 0,
  ),
  /*RadioListModel(
    title: 'Channel 2',
    subTitle: 'SubTitle',
    image: 'assets/images/channel-two.jpeg',
    id: 1,
  ),
  RadioListModel(
    title: 'Channel 3',
    subTitle: 'SubTitle',
    image: 'assets/images/channel-three.jpg',
    id: 2,
  ),*/
];

final audios = <Audio>[
  Audio.network(
    'https://c11.radioboss.fm:8423/stream',
    metas: Metas(
      title: 'channel one',
      // image: const MetasImage.asset('assets/images/channel-one.jpg'),
    ),
  ),

];
