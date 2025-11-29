import 'package:flutter/material.dart';


class PokemonTypeChip extends StatelessWidget {
  
  final String type;
  const PokemonTypeChip({super.key, required this.type});


  Color _typeColor() {
    if (type.contains("Electric")) return Colors.amber;
    if (type.contains("Water")) return Colors.blueAccent;
    if (type.contains("Grass")) return Colors.green;
    if (type.contains("Ghost")) return Colors.deepPurple;
    if (type.contains("Posion")) return Colors.purple;
    if (type.contains("Fairy")) return Colors.redAccent;
    if (type.contains("Dragon")) return Colors.indigo;
    if (type.contains("Steel")) return Colors.blueGrey;
    if (type.contains("Fighting")) return Colors.orange;
    if (type.contains("Fire")) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: _typeColor().withOpacity(0.2),
        border: Border.all(
          color: _typeColor(),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          type, 
          style: TextStyle(
            fontSize: 11, 
            fontWeight: FontWeight.w600, 
            color: _typeColor().withOpacity(0.8),
            ),
            ),
      ),
    );
  }
}
