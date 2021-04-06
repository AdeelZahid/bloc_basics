import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  final dynamic image;
  const NewsImage({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 30.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 40.0),
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
