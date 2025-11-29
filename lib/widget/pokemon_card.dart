import 'package:flutter/material.dart';
import 'package:pokemon_dicoding/models/pokemon.dart';
import 'package:pokemon_dicoding/widget/type_chip.dart';

class PokemonCard extends StatelessWidget {

// Properties
  final Pokemon pokemon;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onTapFavorite;

  const PokemonCard({super.key,
  required this.pokemon,
    required this.isFavorite,
    required this.onTap,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Hero(
              tag: pokemon.name, 
              child: Image.asset(
                pokemon.image, 
                width: double.infinity, 
                fit:  BoxFit.cover,
              ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.name, 
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold),
                            ),
                        SizedBox(height: 5,),
                        PokemonTypeChip(type: pokemon.type),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.pink : Colors.grey,
                        ), 
                    onPressed: onTapFavorite, 
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}