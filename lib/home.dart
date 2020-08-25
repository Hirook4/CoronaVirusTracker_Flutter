import 'package:flutter/material.dart';
import 'countries.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona Virus Tracker'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  'Carregando Dados...',
                  style: TextStyle(fontSize: 22.0),
                ),
              );
            } else {
              return Container(
                color: Colors.red,
                child: Column(
                  children: [],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<Countries>> getData() async {
  String url = "https://coronavirus-19-api.herokuapp.com/countries";
  http.Response response = await http.get(url);
  return countriesFromJson(response.body);
}
