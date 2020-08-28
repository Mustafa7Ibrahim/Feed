import 'dart:async';
import 'dart:io';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';

class RecordServices {
  Future startRecording(String time) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String path = '${appDocDirectory.path}/${time.hashCode}';
    await AudioRecorder.start(
      path: path,
      audioOutputFormat: AudioOutputFormat.AAC,
    );
  }

  Future<File> stopRecording() async {
    var recording = await AudioRecorder.stop();
    File recordingFile = File(recording.path);
    return recordingFile;
  }

  Future uploadRecord({File recordingFile, String chatId, @required time}) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child('$chatId/$time/${recordingFile.toString()}');
    StorageUploadTask uploadTask = reference.putFile(
      recordingFile,
      StorageMetadata(
        contentType: 'audio/m4a',
        customMetadata: <String, String>{'file': 'audio'},
      ),
    );
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    dynamic url = await taskSnapshot.ref.getDownloadURL();

    if (url != null) {
      return url;
    }
  }
}
