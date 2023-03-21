import 'package:flutter/material.dart';
import 'package:helloworld/detail_screen.dart';
import 'package:helloworld/list_item.dart';
import 'package:helloworld/model/tourism_place.dart';
import 'package:helloworld/provider/done_tourism_provider.dart';
import 'package:provider/provider.dart';

class TourismList extends StatefulWidget{
  const TourismList({Key? key}) : super(key: key);

  @override
  _TourismListState createState() => _TourismListState();
}

class _TourismListState extends State<TourismList>{
  final List<TourismPlace> tourismPlaceList = [
    TourismPlace(
        name: 'Surabaya Submarine Monument',
        location: 'Jl Pemuda',
        imageAsset: 'assets/images/submarine.jpg',
        gallery: [
          'assets/images/gallery/submarine1.jpg',
          'assets/images/gallery/submarine2.jpg',
          'assets/images/gallery/submarine3.jpg',
        ],
        openDay:'Open Everyday',
        hours:'10.00 - 17.00',
        price: 'Rp 5000,-',
        description: 'The Submarine Monument, or abbreviated as Monkasel, is a submarine museum located in Embong Kaliasin, Genteng, Surabaya. Located in the city center, namely on Jalan Pemuda, right next to Plaza Surabaya, and there is an access gate to access the mall from inside the monument. This monument is actually a KRI Pasopati 410 submarine, one of the Republic of Indonesia Navy fleets made by the Soviet Union in 1952. This submarine was involved in the Battle of the Aru Sea to liberate West Irian from Dutch occupation.'
    ),
    TourismPlace(
        name: 'Kelenteng Sanggar Agung',
        location: 'Kenjeran',
        imageAsset: 'assets/images/klenteng.jpg',
        gallery: [
          'assets/images/gallery/klenteng1.jpg',
          'assets/images/gallery/klenteng2.jpg',
          'assets/images/gallery/klenteng3.jpg',
        ],
        openDay:'Open Everyday',
        hours:'10.00 - 17.00',
        price: 'Rp 5000,-',
        description: 'Sanggar Agung Temple or Hong San Tang Temple is a temple in the city of Surabaya. The address is at Jalan Sukolilo Number 100, Pantai Ria Kenjeran, Surabaya. This temple, apart from being a place of worship for adherents of the Tridharma, is also a tourist destination for tourists. This temple opened in 1999.'
    ),
    TourismPlace(
        name: 'House of Sampoerna',
        location: 'Krembangan Utara',
        imageAsset: 'assets/images/house.jpg',
        gallery: [
          'assets/images/gallery/sampoerna1.jpg',
          'assets/images/gallery/sampoerna2.jpg',
          'assets/images/gallery/sampoerna3.jpg',
        ],
        openDay:'Open Everyday',
        hours:'10.00 - 17.00',
        price: 'Rp 5000,-',
        description: 'House of Sampoerna (HOS) is one of the museums that occupies the house of the Liem Seng Tee family. In addition to the museum area, it is also equipped with art galleries, halls, cafes, and also a free tour bus called the Surabaya Heritage Track (SHT).'
    ),
    TourismPlace(
        name: 'Tugu Pahlawan',
        location: 'Alun-alun contong',
        imageAsset: 'assets/images/tugu.jpg',
        gallery: [
          'assets/images/gallery/tugu1.jpg',
          'assets/images/gallery/tugu2.jpg',
          'assets/images/gallery/tugu3.jpg',
        ],
        openDay:'Open Everyday',
        hours:'10.00 - 17.00',
        price: 'Rp 5000,-',
        description: 'Tugu Pahlawan is a monument which is a landmark of the City of Surabaya. The height of this monument is 41.15 meters and is in the form of an inverted phallus or nail. The body of the monument is in the form of 10 arches (canalures), and is divided into 11 segments. Height, segment and canalures contain the meaning of the 10th, 11th month, 1945.'
    ),
    TourismPlace(
        name: 'Patung Suro Boyo',
        location: 'Wonokromo',
        imageAsset: 'assets/images/patung.jpg',
        gallery: [
          'assets/images/gallery/patung1.jpg',
          'assets/images/gallery/patung2.jpeg',
          'assets/images/gallery/patung3.jpg',
        ],
        openDay:'Open Everyday',
        hours:'10.00 - 17.00',
        price: 'Rp 5000,-',
        description: 'The statue of Sura and Baya (Javanese: Statue of Suro lan Boyo) is a statue which is the symbol of the city of Surabaya. This statue is in front of the Surabaya Zoo. This statue consists of two animals, namely a crocodile and a shark which inspired the name of the city of Surabaya: ikan sura (shark) and baya (crocodile).'
    ),
  ];

  @override
  Widget build(BuildContext) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(place: place);
            }));
          },
          child: Consumer<DoneTourismProvider>(
              builder: (context, DoneTourismProvider data, widget) {
                return ListItem(
                  place: place,
                  isDone: data.doneTourismPlaceList.contains(place),
                  onCheckboxClick: (bool? value) {
                    data.complete(place, value!);
                  },
                );
              }),
        );
      },
      itemCount: tourismPlaceList.length,
    );
  }
}