import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'player_state.dart';

class Player extends StatefulWidget {
  final String url;

  const Player({Key key, this.url}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;
  // get _isPaused => _playerState == PlayerState.paused;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();

    _durationSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) {
        setState(() => _duration = duration);

        if (Theme.of(context).platform == TargetPlatform.iOS) {
          // (Optional) listen for notification updates in the background
          _audioPlayer.startHeadlessService();

          // set at least title to see the notification bar on ios.
          _audioPlayer.setNotification(
            title: 'Feed Book',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30), // default is 30s
            backwardSkipInterval: const Duration(seconds: 30), // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0),
          );
        }
      },
    );

    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = _audioPlayer.onPlayerCompletion.listen(
      (event) {
        _onComplete();
        setState(() => _position = _duration);
      },
    );

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen(
      (msg) {
        print('audioPlayer error : $msg');
        setState(() {
          _playerState = PlayerState.stopped;
          _duration = Duration(seconds: 0);
          _position = Duration(seconds: 0);
        });
      },
    );

    _audioPlayer.onPlayerStateChanged.listen(
      (state) {
        if (!mounted) return;
        setState(() => _audioPlayerState = state);
      },
    );

    _audioPlayer.onNotificationPlayerStateChanged.listen(
      (state) {
        if (!mounted) return;
        setState(() => _audioPlayerState = state);
      },
    );
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(widget.url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  // Future<int> _stop() async {
  //   final result = await _audioPlayer.stop();
  //   if (result == 1) {
  //     setState(() {
  //       _playerState = PlayerState.stopped;
  //       _position = Duration();
  //     });
  //   }
  //   return result;
  // }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _isPlaying
              ? IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => _pause(),
                )
              : IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => _play(),
                ),
          Expanded(
            child: Slider(
              value: (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position.inMilliseconds / _duration.inMilliseconds
                  : 0.0,
              onChanged: (v) {
                // ignore: non_constant_identifier_names
                final Position = v * _duration.inMilliseconds;
                _audioPlayer.seek(Duration(milliseconds: Position.round()));
              },
            ),
          ),
          Text(
            _position != null
                ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                : _duration != null ? _durationText : '00.00 / 00.00',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
