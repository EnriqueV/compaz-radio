import 'package:flutter/material.dart';
import 'package:multi_radio/model/radio_list_model.dart';

typedef OnTap = Function(RadioListModel radioListModel);

class AudioListTile extends StatelessWidget {
  final RadioListModel radioListModel;
  final VoidCallback onTap;

  const AudioListTile(
      {Key? key, required this.radioListModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          radioListModel.image,
          width: 60,
          height: 52,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(radioListModel.title,
          style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        radioListModel.subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.play_arrow,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: onTap),
    );
  }
}
