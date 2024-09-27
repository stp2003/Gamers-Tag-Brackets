import 'package:flutter/material.dart';
import 'package:gamers_tag/screen/semi_final_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/add.dart';
import 'bracket_screen.dart';

class FinalScreen extends StatefulWidget {
  final List<Map<String, String>> finalists;

  const FinalScreen({super.key, required this.finalists});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  void _declareWinner(BuildContext context, Map<String, String> winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Winner Declared!'),
          content: Text('${winner['name']} is the winner!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
            SizedBox(height: 2.h),
            const Text(
              'Finalists',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            ListView.builder(
              itemCount: widget.finalists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MatchUpRow(
                  player: widget.finalists[index],
                  onTap: () {
                    _declareWinner(context, widget.finalists[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
