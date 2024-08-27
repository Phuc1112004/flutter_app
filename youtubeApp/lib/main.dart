import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController controller = TextEditingController();
  String  singerName = '';
  String  musicInfo = '';

  void fetchMusic() async {
    final apiKey = 'AIzaSyDEELLP8yhcvHbhaeRDnZYiEJQ1iLjRVfM';
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=${Uri.encodeComponent(singerName)}&type=video&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'].isNotEmpty) {
        final videoId = data['items'][0]['id']['videoId'];
        final videoTitle = data['items'][0]['snippet']['title'];
        final videoUrl = 'https://www.youtube.com/watch?v=$videoId';
        final channelTitle = data['items'][0]['snippet']['channelTitle'];

        setState(() {
          musicInfo =
          'Bài hát: $videoTitle\nCa sĩ: $channelTitle\nXem video tại: $videoUrl';
        });
      } else {
        setState(() {
          musicInfo = 'Không tìm thấy bài hát của ca sĩ $singerName';
        });
      }
    } else {
      setState(() {
        musicInfo = 'Không tìm thấy thông tin bài hát của ca sĩ $singerName';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            Text(
              musicInfo,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}