import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_flutter/pokedetail.dart';
import 'dart:io';

import 'package:pokemon_flutter/pokemon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String _apiUrl = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  PokedexClass pokedex;
  
  fetchData() async {
    final httpClient = HttpClient();
    final url = Uri.tryParse(_apiUrl);
    var request = await httpClient.getUrl(url);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseJson = jsonDecode(responseBody);

    // trigger rerender
    setState(() {
      pokedex = PokedexClass.fromJson(responseJson);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pokedex App')),
        backgroundColor: Colors.cyan,
      ),
      body: pokedex == null ? Center(child: CircularProgressIndicator()) : GridView.count(
        crossAxisCount: 2,
        children: pokedex.pokemon.map((poke) => Padding(
          child: InkWell(
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokedetail: poke))); },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img)
                        )
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
              )
          ),
        ),
        padding: EdgeInsets.all(4),
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
