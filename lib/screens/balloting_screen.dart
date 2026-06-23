import 'package:flutter/material.dart';
import '../models/society_models.dart';
import 'result_screen.dart';

class BallotingScreen extends StatefulWidget {
  const BallotingScreen({Key? key}) : super(key: key);

  @override
  State<BallotingScreen> createState() => _BallotingScreenState();
}

class _BallotingScreenState extends State<BallotingScreen> {
  bool _isRunning = false;
  double _progress = 0.0;
  String _statusMsg = "System Idle - Awaiting Command";

  void _triggerBallotProcess() async {
    setState(() {
      _isRunning = true;
      _progress = 0.0;
      _statusMsg = "Running Randomization Seed Allocation...";
    });

    for (int i = 0; i < 10; i++) {
      if (!_isRunning) break;
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _progress += 0.1;
        if (_progress >= 0.3) _statusMsg = "Resolving Applicants with Cleared Slips...";
        if (_progress >= 0.7) _statusMsg = "Mapping Verified plots into Ballots...";
      });
    }

    if (_isRunning) {
      setState(() {
        _progress = 1.0;
        _isRunning = false;
        _statusMsg = "Drawing completed successfully.";
      });
      _showSuccessFinish();
    }
  }

  void _showSuccessFinish() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF22C55E)),
            SizedBox(width: 8),
            Text('Ballot Successful'),
          ],
        ),
        content: const Text('Lottery draw complete. 24 Verified users allocated into available residential zones.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B4DFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Verify Results UI', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Live Balloting', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildMetricsOverview(),
            const SizedBox(height: 20),
            _buildMainControlCard(),
            const SizedBox(height: 20),
            _buildProgressCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricCol('Verified Users', '248 Users'),
          const VerticalDivider(width: 20, thickness: 1.5, color: Color(0xFFF5F3FF)),
          _buildMetricCol('Unbooked Lots', '114 plots'),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F1F39))),
      ],
    );
  }

  Widget _buildMainControlCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF7B4DFF), Color(0xFF9C6BFF)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.casino_outlined, color: Colors.white, size: 50),
          const SizedBox(height: 12),
          const Text('Smart Randomizer Drawing', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            'Draw uses real-time cryptography securely indexing available numbers with zero bias.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isRunning ? null : _triggerBallotProcess,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              disabledBackgroundColor: Colors.white.withOpacity(0.5),
              foregroundColor: const Color(0xFF7B4DFF),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              _isRunning ? 'Processing...' : 'Start Active Ballot',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LIVE STATUS', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8E8EA9), fontSize: 10)),
          const SizedBox(height: 8),
          Text(_statusMsg, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: const Color(0xFFF5F3FF),
            color: const Color(0xFF7B4DFF),
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(_progress * 100).toStringAsFixed(0)}% Complete', style: const TextStyle(fontSize: 12, color: Color(0xFF8E8EA9))),
              if (_isRunning)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = false;
                      _statusMsg = "Process Interrupted by Admin.";
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444).withOpacity(0.08), foregroundColor: const Color(0xFFEF4444), elevation: 0),
                  child: const Text('Halt'),
                )
            ],
          )
        ],
      ),
    );
  }
}
