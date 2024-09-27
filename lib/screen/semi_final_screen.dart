import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/add.dart';
import '../components/shuffle.dart';
import 'bracket_screen.dart';
import 'final_screen.dart';

class SemiFinalScreen extends StatefulWidget {
  final List<Map<String, String>> semiFinalists;

  const SemiFinalScreen({super.key, required this.semiFinalists});

  @override
  _SemiFinalScreenState createState() => _SemiFinalScreenState();
}

class _SemiFinalScreenState extends State<SemiFinalScreen> {
  List<Map<String, String>> selectedWinners = [];

  void _navigateToFinal() {
    if (selectedWinners.length == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalScreen(finalists: selectedWinners),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Select exactly two players to proceed to the final!',
          ),
        ),
      );
    }
  }

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
        body: Column(
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
                        'STAGES',
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
            const Text(
              'Semi-Finalists',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            ListView.builder(
              itemCount: (widget.semiFinalists.length / 2).ceil(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      'MATCH ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    MatchUpRow(
                      player: widget.semiFinalists[index * 2],
                      onTap: () {
                        setState(() {
                          if (selectedWinners
                              .contains(widget.semiFinalists[index * 2])) {
                            selectedWinners
                                .remove(widget.semiFinalists[index * 2]);
                          } else {
                            if (selectedWinners.length < 2) {
                              selectedWinners
                                  .add(widget.semiFinalists[index * 2]);
                            }
                          }
                        });
                      },
                    ),
                    MatchUpRow(
                      player: widget.semiFinalists.length > index * 2 + 1
                          ? widget.semiFinalists[index * 2 + 1]
                          : null,
                      onTap: widget.semiFinalists.length > index * 2 + 1
                          ? () {
                              setState(() {
                                if (selectedWinners.contains(
                                    widget.semiFinalists[index * 2 + 1])) {
                                  selectedWinners.remove(
                                      widget.semiFinalists[index * 2 + 1]);
                                } else {
                                  if (selectedWinners.length < 2) {
                                    selectedWinners.add(
                                        widget.semiFinalists[index * 2 + 1]);
                                  }
                                }
                              });
                            }
                          : null,
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              },
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: _navigateToFinal,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              ),
              child: const Text('Go to Final'),
            ),
          ],
        ),
      ),
    );
  }
}
