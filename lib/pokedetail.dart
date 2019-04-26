import 'package:flutter/material.dart';
import 'package:pokemon_flutter/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokedetail;

  PokemonDetail({ this.pokedetail });

  Widget bodyWidget (context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height /1.5,
        width: MediaQuery.of(context).size.width - 40,
        left: 20,
        top:MediaQuery.of(context).size.height * 0.1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 70),
              Text(pokedetail.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Text('Height: ${pokedetail.height}'),
              Text('Weight: ${pokedetail.weight}'),
              Text('Types'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokedetail.type.map((t) => FilterChip(onSelected:(t){}, label: Text(t), backgroundColor: Colors.amber)).toList(),
              ),
              Text('Weakness'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokedetail.weaknesses.map((t) => FilterChip(
                  onSelected:(t){}, 
                  label: Text(t, style: TextStyle(color: Colors.white)), 
                  backgroundColor: Colors.red[300])
                ).toList(),
              ),
              Text('Next Evolution'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokedetail.nextEvolution.map((t) => FilterChip(onSelected:(t){}, label: Text(t.name))).toList(),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag:pokedetail.img,
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(pokedetail.img), fit: BoxFit.cover)
            ),
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text(pokedetail.name),
        centerTitle: true,
      ),
      body: bodyWidget(context),
    );
  }
}