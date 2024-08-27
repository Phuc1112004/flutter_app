import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicScreen(),
    );
  }
}

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final TextEditingController controller = TextEditingController();
  String singerName = '';
  String videoTitle = '';
  String channelTitle = '';
  String videoId = '';

  void fetchMusic() async {
    final apiKey = 'AIzaSyDEELLP8yhcvHbhaeRDnZYiEJQ1iLjRVfM';
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=${Uri.encodeComponent(singerName)}&type=video&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'].isNotEmpty) {
        setState(() {
          videoId = data['items'][0]['id']['videoId'];
          videoTitle = data['items'][0]['snippet']['title'];
          channelTitle = data['items'][0]['snippet']['channelTitle'];
        });
        print('Video ID: $videoId');
      } else {
        setState(() {
          videoId = '';
          videoTitle = 'Không tìm thấy bài hát';
          channelTitle = '';
        });
      }
    } else {
      setState(() {
        videoId = '';
        videoTitle = 'Lỗi kết nối';
        channelTitle = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Music App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Nhập tên ca sĩ',
                ),
                onSubmitted: (value) {
                  setState(() {
                    singerName = value;
                    fetchMusic();
                  });
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    singerName = controller.text;
                    fetchMusic();
                  });
                },
                child: Text('Xem bài hát'),
              ),
              SizedBox(height: 20),
              if (videoId.isNotEmpty) ...[
                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
                SizedBox(height: 20),
                Text(
                  'Bài hát: $videoTitle',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ca sĩ: $channelTitle',
                  style: TextStyle(fontSize: 16),
                ),
              ] else if (videoTitle.isNotEmpty) ...[
                Text(
                  videoTitle,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
