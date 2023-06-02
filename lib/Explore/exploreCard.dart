import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final Map<String, dynamic> postData;

  ExploreCard({required this.postData});

  void goToSpecificPost(BuildContext context) {
    Navigator.of(context).pushNamed("/postRoute", arguments: {'postId': postData['id']});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToSpecificPost(context),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              postData['imageURL'],
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.black38,
                child: Center(
                  child: Text(
                    postData['title'],
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            bottom: 0,
          ),
        ],
      ),
    );
  }
}