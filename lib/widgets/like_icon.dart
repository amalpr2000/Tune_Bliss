import 'package:flutter/material.dart';

import '../database/functions/liked_db_function.dart';
import '../model/song_model.dart';
import '../screens/liked/liked_screen.dart';

class LikedButton extends StatefulWidget {
  LikedButton({super.key, required this.isfav, required this.currentSongs});
  Songs currentSongs;
  bool isfav;

  @override
  State<LikedButton> createState() => _LikedButtonState();
}

class _LikedButtonState extends State<LikedButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            if (widget.isfav) {
              widget.isfav = false;

              removeFromLiked(widget.currentSongs);
              snack(context, message: 'removed from liked', color: Colors.red);
            } else {
              widget.isfav = true;
              addToLiked(widget.currentSongs);
              snack(context, message: 'added to liked', color: Colors.green);
            }
            likedSongsNotifier.notifyListeners();
          });
        },
        icon: widget.isfav
            ? Icon(
                Icons.favorite_rounded,
              )
            : Icon(
                Icons.favorite_outline_rounded,
                color: Color(0xFF9DA8CD),
              ));
  }
}
