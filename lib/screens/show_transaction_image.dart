import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowTransactionDetails extends StatelessWidget {
  final String imageURL;
  ShowTransactionDetails(this.imageURL);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height:double.infinity,
        width: double.infinity,
        decoration: gradient,
        child:Card(
          elevation: 10,
          margin: EdgeInsets.all(15),
          child:FittedBox(
              child: CachedNetworkImage(
                imageUrl: imageURL,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              fit: BoxFit.fill,
            ),

        )
      )
      
    );
  }
}