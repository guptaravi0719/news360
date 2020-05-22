import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerDemoApp extends StatefulWidget {
  String AppBarTitle;
  String videoId;

  YoutubePlayerDemoApp(this.videoId, this.AppBarTitle);

  @override
  _YoutubePlayerDemoAppState createState() => _YoutubePlayerDemoAppState();
}

class _YoutubePlayerDemoAppState extends State<YoutubePlayerDemoApp> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  //String videoId;
  @override
  void initState() {
    debugPrint(widget.videoId);
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: true,
        forceHideAnnotation: true,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
              bottomLeft: const Radius.circular(00.0),
              bottomRight: const Radius.circular(00.0))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).size.height / 6,
            10, MediaQuery.of(context).size.height / 6),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),
      ),
    );
  }
}
