import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=ab2d25a5";

void main() async {
  print(await getData());
  runApp(MaterialApp(
    home: Home()
  ));
}
Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('\$ Conversor de Moedas \$'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando Dados...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                  ),
                )
              );
            default:
              if(snapshot.hasError){
                return Center(
                    child: Text(
                      'Erro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                      ),
                    )
                );
              } else {
                return Container(color: Colors.green,);
              }
          }
        }),
    );
  }
}

