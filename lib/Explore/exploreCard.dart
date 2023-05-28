import 'package:flutter/material.dart';
import '/Post/post.dart';

class ExploreCard extends StatelessWidget {
  Post po;
  ExploreCard({required this.po});
  goToSpecificPost(BuildContext myContext) {
    Navigator.of(myContext).pushNamed("/postRoute", arguments: {"post": po});
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToSpecificPost(context),
      child: Stack(
        children: [
// child 1 of stack is the recipe image
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Image.network(
              po.imageURL,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

// child 2 of stack is the recipe title
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15) ),
              child: Container(
                color: Colors.black38,
                child: Center(
                    child: Text(
                  po.title,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}