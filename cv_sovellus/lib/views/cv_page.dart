import 'package:flutter/material.dart';
import '../constants.dart';

class CV_page extends StatelessWidget {
  const CV_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contents = Column(
      children: [
        const CircleAvatar(
          radius: 80,
          // Polku asset kuvalle
          foregroundImage: AssetImage('assets/avatar.jpg'),
        ),
        const Text(
          'Mikko Mallikas',
          style: titleTekstiTyyli,
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter kehittäjä',
          style: tekstiTyyli,
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.place_rounded),
            Text(
              'Mallikkaankatu 13 B',
              style: tekstiTyyli,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(
                Icons.call,
                color: Colors.black87,
                size: 30,
              ),
              title: Center(
                child: Text(
                  '+358441234567',
                  style: korttiTekstiTyyli,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.email_rounded,
                color: Colors.indigo,
                size: 30,
              ),
              title: Center(
                child: Text(
                  'mikko.mallikas@flutter.fi',
                  style: korttiTekstiTyyli,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              children: const [
                Text(
                  'Koulutus',
                  textAlign: TextAlign.center,
                  style: paksuTyyli,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Flutter-kehittäjä',
                  textAlign: TextAlign.center,
                  style: tekstiTyyli,
                )
              ],
            )),
            Expanded(
                child: Column(
              children: const [
                Text(
                  'Työkokemus',
                  textAlign: TextAlign.center,
                  style: paksuTyyli,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'puhelinmyyjä',
                  textAlign: TextAlign.center,
                  style: tekstiTyyli,
                )
              ],
            )),
          ],
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: contents,
      ),
    );
  }
}
