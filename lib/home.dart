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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Countries data = snapshot.data[index];
                          return ListTile(
                            title: Text(
                              data.country,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    data.cases.toString() + ' Casos',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.blue),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    data.deaths.toString() + ' Mortes',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            )),
                          );
                        })
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// Metodo que busca os dados
Future<List<Countries>> getData() async {
  String url = "https://coronavirus-19-api.herokuapp.com/countries";
  http.Response response = await http.get(url);
  return countriesFromJson(response.body);
}
