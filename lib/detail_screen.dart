import 'package:flutter/material.dart';
import 'package:helloworld/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.place}) : super(key: key);

  final TourismPlace place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Image.asset(place.imageAsset),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Lobster',
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget> [
                      Icon(Icons.calendar_today),
                      Text(place.openDay),
                    ],
                  ),
                  Column(
                    children: <Widget> [
                      Icon(Icons.access_time),
                      Text(place.hours),
                    ],
                  ),
                  Column(
                    children: <Widget> [
                      Icon(Icons.attach_money),
                      Text(place.price),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network('https://media-cdn.tripadvisor.com/media/photo-m/1280/16/a9/33/43/liburan-di-farmhouse.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(place.gallery[0]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(place.gallery[1]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(place.gallery[2]),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
