import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int starCount;
  final int rating;
  final void Function(int) onRatingChanged;

  StarRating(
      {this.starCount = 5, this.rating = 0, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  Widget _buildStar(BuildContext context, int index) {
    IconData iconData =
        _currentRating >= index + 1 ? Icons.star : Icons.star_border;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentRating = index + 1;
          widget.onRatingChanged.call(_currentRating);
        });
      },
      child: Icon(iconData, color: Colors.amber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          widget.starCount, (index) => _buildStar(context, index)),
    );
  }
}
