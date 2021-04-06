import 'package:bloc_beginner/constants/strings.dart';
import 'package:bloc_beginner/screen/news_imge.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;
  final String formattedTime;

  const NewsDetailScreen({Key key, this.article, this.formattedTime})
      : super(key: key);

  initState() => {
        print(
            'Article: ${article.toString()} \n Formatted Time: ${formattedTime.toString()}'),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detial Screen'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsImage(image: article.urlToImage),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    formattedTime,
                    style: kTimeTextStyle,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    article.title,
                    style: kTitleTextStyle,
                    maxLines: 3,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    article.description,
                    style: KNewsDetailText,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Text(
          'Back',
          style: TextStyle(fontSize: 20.0),
        ),
        icon: Icon(Icons.arrow_back, size: 30.0),
        backgroundColor: Colors.green,
      ),
    );
  }
}
