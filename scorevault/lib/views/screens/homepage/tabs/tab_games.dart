import 'package:flutter/material.dart';
import 'package:scorevault/viewmodels/GamesController.dart';
import 'package:scorevault/models/game_info.dart';
import 'package:scorevault/views/widgets/Cards/game_card.dart';
import 'package:scorevault/views/widgets/headers/header_home.dart';

class TabGames extends StatefulWidget {
  const TabGames({super.key});

  @override
  State<TabGames> createState() => _TabGamesState();
}

class _TabGamesState extends State<TabGames> {
  final GamesController _controller = GamesController();

  List<GameInfo> _allGames = [];
  List<GameInfo> _filteredGames = [];

  String _searchText = '';
  final List<String> _selectedCategories = [];
  final List<int> _selectedPlayerCounts = [];
  final List<int> _selectedDifficulties = [];

  bool _filtersExpanded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    final games = await _controller.fetchGames();
    setState(() {
      _allGames = games;
      _filteredGames = games;
      _isLoading = false;
    });
  }

  void _filterGames() {
    setState(() {
      _filteredGames = _allGames.where((game) {
        final matchesSearch = game.nome.toLowerCase().contains(_searchText.toLowerCase());
        final matchesCategory = _selectedCategories.isEmpty || game.categorie.any((c) => _selectedCategories.contains(c));
        final matchesPlayers = _selectedPlayerCounts.isEmpty || _selectedPlayerCounts.any((count) => game.minPlayers <= count && game.maxPlayers >= count);
        final matchesDifficulty = _selectedDifficulties.isEmpty || _selectedDifficulties.contains(game.difficulty);
        return matchesSearch && matchesCategory && matchesPlayers && matchesDifficulty;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _searchText = '';
      _selectedCategories.clear();
      _selectedPlayerCounts.clear();
      _selectedDifficulties.clear();
      _filteredGames = _allGames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cerca un gioco...',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary, size: 30.0),
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20.0),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
                borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _searchText = value;
                _filterGames();
              },
            ),
          ),
          ExpansionPanelList(
            expansionCallback: (index, isExpanded) {
              setState(() {
                _filtersExpanded = !_filtersExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) => const ListTile(
                  title: Text('Filtri'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          const Text('Categorie:'),
                          ...['Party', 'Strategia', 'Carte', 'Famiglia'].map((category) {
                            return FilterChip(
                              label: Text(category),
                              selected: _selectedCategories.contains(category),
                              onSelected: (selected) {
                                setState(() {
                                  selected
                                      ? _selectedCategories.add(category)
                                      : _selectedCategories.remove(category);
                                  _filterGames();
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          const Text('Giocatori:'),
                          ...[2, 3, 4, 5, 6].map((count) {
                            return FilterChip(
                              label: Text('$count'),
                              selected: _selectedPlayerCounts.contains(count),
                              onSelected: (selected) {
                                setState(() {
                                  selected
                                      ? _selectedPlayerCounts.add(count)
                                      : _selectedPlayerCounts.remove(count);
                                  _filterGames();
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          const Text('Difficoltà:'),
                          ...[1, 2, 3, 4, 5].map((difficulty) {
                            return FilterChip(
                              label: Text('$difficulty⭐'),
                              selected: _selectedDifficulties.contains(difficulty),
                              onSelected: (selected) {
                                setState(() {
                                  selected
                                      ? _selectedDifficulties.add(difficulty)
                                      : _selectedDifficulties.remove(difficulty);
                                  _filterGames();
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _resetFilters,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset filtri'),
                      ),
                    ],
                  ),
                ),
                isExpanded: _filtersExpanded,
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredGames.isEmpty
                    ? const Center(child: Text('Nessun gioco trovato'))
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.builder(
                          itemCount: _filteredGames.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (context, index) {
                            final gioco = _filteredGames[index];
                            
                            return  GameCardWidget(
                              game: gioco,
                              elo: 1500,
                              matchesPlayed: 10,
                              matchesWon: 5,
                            );
                          }
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
