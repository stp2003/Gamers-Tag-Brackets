import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShuffleMatchesWidget extends StatelessWidget {
  final VoidCallback onShuffle;
  final String lastShuffledTime;

  const ShuffleMatchesWidget({
    super.key,
    required this.onShuffle,
    required this.lastShuffledTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 83.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shuffle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SHUFFLE THE MATCHES',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Last shuffled on: ',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        lastShuffledTime,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 5.w),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(2),
                child: InkWell(
                  onTap: onShuffle,
                  child: Container(
                    width: 25.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'SHUFFLE',
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
    );
  }
}
