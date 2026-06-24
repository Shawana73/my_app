// lib/screens/balloting_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import 'result_screen.dart';

class BallotingScreen extends StatefulWidget {
  const BallotingScreen({super.key});

  @override
  State<BallotingScreen> createState() => _BallotingScreenState();
}

class _BallotingScreenState extends State<BallotingScreen> with SingleTickerProviderStateMixin {
  bool _isDrawing = false;
  double _progress = 0.0;
  String _statusMessage = 'System Idle - Awaiting Command';

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animController.addListener(() {
      setState(() {
        _progress = _animController.value;
        if (_progress > 0 && _progress < 1.0) {
          _statusMessage = 'Computing Randomized Cryptographic Hashes... ${(_progress * 100).toStringAsFixed(0)}%';
        } else if (_progress >= 1.0) {
          _statusMessage = 'Allocation complete! All lots resolved';
          _isDrawing = false;
          _showWinnerDialog();
        }
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _startDrawingBallot() {
    setState(() {
      _isDrawing = true;
      _progress = 0.0;
      _statusMessage = 'Initializing Decryptor Decoders...';
    });
    _animController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('BALLOTING CONTROL'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Statistics Card Block (matching layout in screenshots exactly)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.borderRadius,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        Text('VERIFIED APPLICANTS', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('643 Users', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: AppTheme.lightLavender),
                  Expanded(
                    child: Column(
                      children: const [
                        Text('PLOTS AVAILABLE', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('94 Plots', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Smart Randomized Launcher Box
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryPurple, AppTheme.secondaryPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppTheme.borderRadius,
                boxShadow: AppTheme.softShadows,
              ),
              child: Column(
                children: [
                  const Icon(Icons.bookmark, size: 48, color: Colors.white70),
                  const SizedBox(height: 16),
                  const Text(
                    'Smart Randomized Decryptor Launcher',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Launch secure resident lot drawings immediately linking vetted claims to available locations using fair cryptographic algorithms.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Clickable Launcher Button
                  ElevatedButton(
                    onPressed: _isDrawing ? null : _startDrawingBallot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      _isDrawing ? 'Computing...' : 'Launch Active Ballot Drawing',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Live Draw Tracker Progress card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LIVE DRAW TRACKER',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.greyText, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _statusMessage,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                    ),
                    const SizedBox(height: 16),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: AppTheme.lightLavender,
                        color: AppTheme.primaryPurple,
                        minHeight: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(_progress * 100).toStringAsFixed(0)}% Drawn',
                          style: const TextStyle(fontSize: 12, color: AppTheme.greyText, fontWeight: FontWeight.bold),
                        ),
                        if (_isDrawing)
                          const Text(
                            'DRAWING IN PROGRESS',
                            style: TextStyle(fontSize: 10, color: AppTheme.warning, fontWeight: FontWeight.bold),
                          )
                        else
                          const Text(
                            'STANDBY',
                            style: TextStyle(fontSize: 10, color: AppTheme.greyText, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Navigate to Winners Queue Queue list button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResultScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('View Balloting Winners queue', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: AppTheme.success, size: 48),
              ),
              const SizedBox(height: 16),
              const Text(
                'Draw allocations success!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Congratulations! Machine cryptography automatically mapped and allocated residents into active phase sectors.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.greyText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              // Winner Card matching screens
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightLavender,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('WINNER RECORD', style: TextStyle(fontSize: 10, color: AppTheme.primaryPurple, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Ayesha Bibi', style: TextStyle(fontSize: 14, color: AppTheme.darkText, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('UNIT NO', style: TextStyle(fontSize: 10, color: AppTheme.primaryPurple, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('PL-D77', style: TextStyle(fontSize: 14, color: AppTheme.darkText, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Dismiss'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResultScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Verify Winners portfolio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
