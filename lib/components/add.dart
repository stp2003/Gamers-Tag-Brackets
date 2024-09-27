import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddPlayerDialog extends StatefulWidget {
  final Function(String, String) onAddPlayer;

  const AddPlayerDialog({super.key, required this.onAddPlayer});

  @override
  _AddPlayerDialogState createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  final _nameController = TextEditingController();
  final _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[800]!, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45.w,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'ADD PLAYER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Enter New Players Name',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter Player Name',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter Gamers Tag ID',
                      hintStyle: TextStyle(color: Colors.red[100]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(17),
                          ),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(17),
                              ),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(17),
                          ),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () {
                            widget.onAddPlayer(
                                _nameController.text, _tagController.text);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(17),
                              ),
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}

class AddPlayerButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddPlayerButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(double.infinity, 50),
              painter: _ButtonPainter(),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                child: Center(
                  child: Text(
                    'ADD PLAYER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    final path = Path()
      ..moveTo(0, 10)
      ..lineTo(10, 0)
      ..lineTo(size.width - 10, 0)
      ..lineTo(size.width, 10)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width - 10, size.height)
      ..lineTo(10, size.height)
      ..lineTo(0, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
