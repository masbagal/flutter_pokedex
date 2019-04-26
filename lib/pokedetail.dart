import 'package:flutter/material.dart';
import 'package:pokemon_flutter/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokedetail;

  PokemonDetail({ this.pokedetail });

  Widget bodyWidget () => Stack(
    children: <Widget>[
      Container(
        child: Card(
          child: Column(
            children: <Widget>[
              Text(pokedetail.name),
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
      body: bodyWidget(),
    );
  }
}