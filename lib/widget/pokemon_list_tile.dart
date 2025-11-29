import 'package:flutter/material.dart';
import 'package:pokemon_dicoding/models/pokemon.dart';
import 'package:pokemon_dicoding/widget/type_chip.dart';

class PokemonListTile extends StatelessWidget {
// Properties
  final Pokemon pokemon;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onTapFavorite;

// Constructor
  const PokemonListTile({
    super.key,
    required this.pokemon,
    required this.isFavorite,
    required this.onTap,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Hero(tag: pokemon.name, child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(12),
        child: Image.asset(
          pokemon.image, 
          width: 56, 
          height: 56, 
          fit: BoxFit.cover,),
        ),
        ),
        title: Text(
          pokemon.name, 
          style: TextStyle(
            fontWeight: FontWeight.bold),
            ),
            subtitle: PokemonTypeChip(type: pokemon.type),
            trailing: IconButton(
              onPressed: onTapFavorite, 
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.pink : Colors.grey,
              ),
              ),
      ),
    );
  }
}
