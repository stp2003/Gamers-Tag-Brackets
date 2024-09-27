import 'package:flutter/material.dart';
import 'package:gamers_tag/screen/semi_final_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/add.dart';
import '../components/shuffle.dart';

class BracketScreen extends StatefulWidget {
  const BracketScreen({super.key});

  @override
  _BracketScreenState createState() => _BracketScreenState();
}

class _BracketScreenState extends State<BracketScreen> {
  List<Map<String, String>> players = [];
  List<Map<String, String>> winners = [];

  void _addPlayer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPlayerDialog(
          onAddPlayer: (String name, String tag) {
            setState(() {
              players.add({
                'name': name,
                'tag': tag,
              });
            });
          },
        );
      },
    );
  }

  void _shufflePlayers() {
    setState(() {
      players.shuffle();
    });
  }

  void _selectWinner(Map<String, String> player) {
    if (!winners.contains(player)) {
      setState(() {
        winners.add(player);
      });
    }
  }

  void _goToSemifinals() {
    if (winners.length >= 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SemiFinalScreen(semiFinalists: winners),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset('assets/top.png'),
                  Positioned(
                    top: 4.h,
                    left: 40.w,
                    child: Column(
                      children: [
                        const Text(
                          'BRACKET',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset('assets/tc.png'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w),
                child: Row(
                  children: [
                    ShuffleMatchesWidget(
                      onShuffle: _shufflePlayers,
                      lastShuffledTime: '4m ago',
                    ),
                    SizedBox(width: 2.w),
                    InkWell(
                      onTap: _addPlayer,
                      child: Container(
                        width: 12.w,
                        height: 6.2.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              const Center(
                child: Text(
                  'Quarter Finals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (players.length / 2).ceil(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        'MATCH ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      MatchUpRow(
                        player: players.length > index * 2
                            ? players[index * 2]
                            : null,
                        onTap: players.length > index * 2
                            ? () => _selectWinner(players[index * 2])
                            : null,
                      ),
                      SizedBox(height: 0.5.h),
                      MatchUpRow(
                        player: players.length > index * 2 + 1
                            ? players[index * 2 + 1]
                            : null,
                        onTap: players.length > index * 2 + 1
                            ? () => _selectWinner(players[index * 2 + 1])
                            : null,
                      ),
                      SizedBox(height: 1.h),
                    ],
                  );
                },
              ),
              SizedBox(height: 2.h),
              Center(
                child: ElevatedButton(
                  onPressed: winners.length >= 2 ? _goToSemifinals : null,
                  style: ElevatedButton.styleFrom(
                    primary: winners.length >= 2 ? Colors.blue : Colors.grey,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  ),
                  child: const Text(
                    'Go to Semifinals',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchUpRow extends StatelessWidget {
  final Map<String, String>? player;
  final VoidCallback? onTap;

  const MatchUpRow({super.key, this.player, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(width: 2.w),
          Image.asset('assets/ppf.png'),
          Container(
            width: 75.w,
            height: 6.9.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            margin: EdgeInsets.only(bottom: 2.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[900]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      player?['name'] ?? 'TBD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'GT ID ${player?['tag'] ?? ''}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
