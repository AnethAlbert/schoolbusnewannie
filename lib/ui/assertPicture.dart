import'package:flutter/material.dart';

class assertImae extends StatelessWidget {
  const assertImae({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Image(
              image:AssetImage('assets/black.jpg'),
              width: 250,
              height: 230,
              fit: BoxFit.fitWidth ,

            )
          // CachedNetworkImage(
          //   imageUrl:
          //       'https://assets-global.website-files.com/5f778340ed26b167bd087abe/634977d065e230e42f4de4dc_school%20bus.png',
          //   width: 250.0,
          //   height: 230.0,
          //   fit: BoxFit.fitWidth,
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   // Placeholder widget
          //   errorWidget: (context, url, error) =>
          //       Icon(Icons.error), // Error widget
          // ),
        ),
      ),
    );
  }
}
