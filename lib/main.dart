
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Fact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatFactScreen(),
    );
  }
}

class CatFactScreen extends StatefulWidget {
  @override
  _CatFactScreenState createState() => _CatFactScreenState();
}

class _CatFactScreenState extends State<CatFactScreen> {
  String _catFact = "";
  int _catFactLength = 0;

  Future<void> _fetchCatFact() async {
    final response = await http.get(Uri.parse('https://catfact.ninja/fact'));
    final decodedResponse = json.decode(response.body);
    setState(() {
      _catFact = decodedResponse['fact'];
      _catFactLength = _catFact.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCatFact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Fact App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Random Cat Fact:',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              _catFact,
              style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Length: $_catFactLength',
              style: TextStyle(fontSize: 18),
            ),
  /*      TextButton(onPressed: _fetchCatFact,
          child:
          Text('Refresh',
        ),*/
        ElevatedButton(
          onPressed: _fetchCatFact ,
          child: Text('Refresh'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

        ),
          ],

        ),
      ),

    );
  }
}
