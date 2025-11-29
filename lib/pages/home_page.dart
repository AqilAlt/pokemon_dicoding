import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_dicoding/data/pokemon_data.dart';
import 'package:pokemon_dicoding/pages/detail_page.dart';
import 'package:pokemon_dicoding/widget/pokemon_card.dart';
import 'package:pokemon_dicoding/widget/pokemon_list_tile.dart';

class PokemonHomePage extends StatefulWidget {
  // COnstructor
  const PokemonHomePage({super.key});

  @override
  State<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  String _searchQuery = '';
  bool _showFavoritesOnly = false;
  final Set<String> _favorites = {};
  final TextEditingController _searchController = TextEditingController();

  Future<void> _openDetailPage(pokemon, bool isFav) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => PokemonDetailPage(pokemon: pokemon,isFavorite: isFav,)),
    );

    if (result != null) {
      setState(() {
        if (result) {
          _favorites.add(pokemon.name);
        } else {
          _favorites.remove(pokemon.name);
        }
      });
    }
  }

  void _toggleFavorite(String PokemonName) {
    setState(() {
      if (_favorites.contains(PokemonName)) {
        _favorites.remove(PokemonName);
      } else {
        _favorites.add(PokemonName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter Search

    final filtered = dataPokemon.where((p) {
      // Q for query
      final q = _searchQuery.toLowerCase();
      final matchesSearch = p.name.toLowerCase().contains(q);

      // Check Favorites
      final matchesFavorite =
          !_showFavoritesOnly || _favorites.contains(p.name);

      return matchesSearch && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Wiki Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Pokemon ...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Switch(
                  value: _showFavoritesOnly,
                  onChanged: (val) {
                    setState(() {
                      _showFavoritesOnly = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, Constraints) {
                  // Layar sempit (mobile)
                  if (Constraints.maxWidth < 600) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Pokemon = filtered[index];
                        final isFav = _favorites.contains(Pokemon.name);
                        return PokemonListTile(
                          pokemon: Pokemon,
                          isFavorite: isFav,
                          onTap: () => _openDetailPage(Pokemon, isFav),
                          onTapFavorite: () => _toggleFavorite(Pokemon.name),
                        );
                      },
                      itemCount: filtered.length,
                    );
                  }

                  // Layar lebar (tablet, desktop)
                  int count = 2;
                  if (Constraints.maxWidth >= 900)
                    count = 4;
                  else if (Constraints.maxWidth >= 650)
                    count = 3;
                  return GridView.builder(
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final pokemon = filtered[index];
                      final isFav = _favorites.contains(pokemon.name);

                      return PokemonCard(
                        pokemon: pokemon,
                        isFavorite: isFav,
                        onTap: () => _openDetailPage(pokemon, isFav),
                        onTapFavorite: () => _toggleFavorite(pokemon.name),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
