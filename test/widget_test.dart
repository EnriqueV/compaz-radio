import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YouTubeHomePage(),
    );
  }
}

class YouTubeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube'),
      ),
      body: YouTubeBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class YouTubeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Display a larger video at the top
          return Container(
            height: 300.0,
            color: Colors.grey[200],
            child: Center(
              child: Text('Large Video Placeholder'),
            ),
          );
        } else {
          // Display smaller video cards
          return VideoCard(video: videoList[index - 1]);
        }
      },
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            video.thumbnailUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  video.channelName,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Video {
  final String title;
  final String thumbnailUrl;
  final String channelName;

  Video({
    required this.title,
    required this.thumbnailUrl,
    required this.channelName,
  });
}

final List<Video> videoList = [
  Video(
    title: 'Video Title 1',
    thumbnailUrl: 'https://via.placeholder.com/300x150',
    channelName: 'Channel Name 1',
  ),
  Video(
    title: 'Video Title 2',
    thumbnailUrl: 'https://via.placeholder.com/300x150',
    channelName: 'Channel Name 2',
  ),
  // Add more videos as needed
];
