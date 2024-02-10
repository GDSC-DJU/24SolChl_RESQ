import 'package:flutter/material.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/theme.dart';

class RectangleIconCard extends StatefulWidget {
  final String title;
  final String iconPath;
  final String description;

  RectangleIconCard({required this.title, required this.iconPath, required this.description});

  @override
  _RectangleIconCardState createState() => _RectangleIconCardState();
}

class _RectangleIconCardState extends State<RectangleIconCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: AppColors.backgroundSecondary,
      end: AppColors.backgroundPrimary,
    ).animate(_controller);
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
      onTapDown: (details) {
        _controller.forward();
      },
      onTapUp: (details) {
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Card(
        color: _colorAnimation.value,
        elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: AppTheme.subText,
              ),
              SizedBox(height: 4.0),
              Image.asset(widget.iconPath,
                height: 42,
              ),    
              SizedBox(height: 4.0),
              Text(
                widget.description,
                style: AppTheme.body,
              ),
            ],
          ),
        );}
      ),
    ),),
    );
  }
}

class IconCardDevide extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      width: 1.5,
      color: AppColors.textSecondary,
    );
  }
}
