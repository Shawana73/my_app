// lib/screens/result_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'ALL';

  final List<Map<String, String>> _winners = [
    {'name': 'Ayesha Bibi', 'id': 'APP-0991', 'plotNo': 'PL-D77', 'sector': 'Sector D', 'status': 'SELECTED'},
    {'name': 'Muhammad Ali Raza', 'id': 'APP-4011', 'plotNo': 'PL-A12', 'sector': 'Sector A', 'status': 'SELECTED'},
    {'name': 'Zainab Fatima', 'id': 'APP-4013', 'plotNo': 'PL-A03', 'sector': 'Sector A', 'status': 'SELECTED'},
    {'name': 'Bilal Siddique', 'id': 'APP-3082', 'plotNo': 'PL-C15', 'sector': 'Sector C', 'status': 'SELECTED'},
    {'name': 'Usman Tariq', 'id': 'APP-4025', 'plotNo': 'N/A', 'sector': 'Sector E', 'status': 'NOT_SELECTED'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredWinners = _winners.where((winner) {
      final matchesSearch = winner['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          winner['plotNo']!.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = false;
      if (_selectedFilter == 'ALL') {
        matchesFilter = true;
      } else if (_selectedFilter == 'SELECTED' && winner['status'] == 'SELECTED') {
        matchesFilter = true;
      } else if (_selectedFilter == 'NOT_SELECTED' && winner['status'] == 'NOT_SELECTED') {
        matchesFilter = true;
      }
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('BALLOTING RESULTS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting results...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter & Search box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Search Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.lightLavender,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: AppTheme.greyText),
                      hintText: 'Search winner, plot ID...',
                      hintStyle: TextStyle(color: AppTheme.greyText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Tab Filters
                Row(
                  children: [
                    _buildTabFilter('ALL', 'All Draw'),
                    const SizedBox(width: 8),
                    _buildTabFilter('SELECTED', 'Selected'),
                    const SizedBox(width: 8),
                    _buildTabFilter('NOT_SELECTED', 'Unsuccessful'),
                  ],
                ),
              ],
            ),
          ),

          // Winners List
          Expanded(
            child: filteredWinners.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.military_tech_outlined, size: 64, color: AppTheme.greyText),
                  SizedBox(height: 12),
                  Text(
                    'No Results Found',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredWinners.length,
              itemBuilder: (context, index) {
                final winner = filteredWinners[index];
                return _buildWinnerCard(winner);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabFilter(String code, String label) {
    final isSelected = _selectedFilter == code;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = code;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryPurple : AppTheme.lightLavender,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppTheme.primaryPurple.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWinnerCard(Map<String, String> winner) {
    final isSelected = winner['status'] == 'SELECTED';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: isSelected ? AppTheme.success.withOpacity(0.1) : AppTheme.rejected.withOpacity(0.1),
                  child: Icon(
                    isSelected ? Icons.emoji_events_outlined : Icons.sentiment_dissatisfied,
                    color: isSelected ? AppTheme.success : AppTheme.rejected,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        winner['name']!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                      ),
                      Text(
                        winner['id']!,
                        style: const TextStyle(fontSize: 12, color: AppTheme.greyText),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.success.withOpacity(0.1) : AppTheme.rejected.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isSelected ? 'SUCCESS' : 'FAILED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppTheme.success : AppTheme.rejected,
                    ),
                  ),
                ),
              ],
            ),
            if (isSelected) ...[
              const Divider(height: 24, color: AppTheme.lightLavender),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('ALLOCATED UNIT', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('PL-D77', style: TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('BLOCK/SECTOR', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Sector D - Premier Block', style: TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
