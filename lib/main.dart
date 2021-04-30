import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_demo/jitsi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Meeting());
  }
}

class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {

  JitsiMeeting m = JitsiMeeting(
      room: 'demomic21',
      name: 'Samuel Calegari',
      subject: 'Mic21',
      email: 'samuel.calegari@univ-perp.fr',
      isAudioOnly: true,
      isAudioMuted: true,
      isVideoMuted: true);

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: m.onConferenceWillJoin,
        onConferenceJoined: m.onConferenceJoined,
        onConferenceTerminated: m.onConferenceTerminated,
        onError: m.onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jistsi demo example'),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      m.joinMeeting();
                    },
                    child: Text(
                      "Join Meeting (App)",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      m.joinMeetingFromWeb();
                    },
                    child: Text(
                      "Join Meeting (Web)",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue)),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
