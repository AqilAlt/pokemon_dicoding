import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_dicoding/models/pokemon.dart';
import 'package:pokemon_dicoding/widget/type_chip.dart';

class PokemonDetailPage extends StatefulWidget {
  // Properties utk nerima data dari home page
  final Pokemon pokemon;
  final bool isFavorite;
  const PokemonDetailPage({
    super.key,
    required this.pokemon,
    required this.isFavorite,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // variable lokal utk mempermudah akses data
    // jadi kita tidak perlu menulist widget.pokemon terus

    final pkm = widget.pokemon;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _isFavorite);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(pkm.name),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.pink : Colors.grey,
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Variable lebar layar
            final isWide = constraints.maxWidth >= 700;

            // Widget imageBox
            final imageBox = Hero(
              tag: pkm,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset(
                  pkm.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );

            // WIdget info box
            final infoBox = Card(
              margin: EdgeInsets.all(12.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pkm.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    PokemonTypeChip(type: pkm.type),

                    SizedBox(height: 16),

                    Text(
                      "Base Power ${pkm.basePower}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(pkm.description, textAlign: TextAlign.justify),

                    SizedBox(height: 10),

                    Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Wrap(
                      spacing: 8.0,
                      children: pkm.skills.map((skills) {
                        return Chip(
                          label: Text('skills'),
                          avatar: Icon(Icons.star),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );

            if (isWide) {
              return Row(
                children: <Widget>[
                  Expanded(flex: 1, child: imageBox),
                  Expanded(flex: 1, child: infoBox),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(12.0), child: imageBox),
                  infoBox,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
