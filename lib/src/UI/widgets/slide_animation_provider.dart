import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

class SlideAnimationWrapper extends StatefulWidget {
  final Duration slideDuration;
  final Duration fadeDuration;
  final Widget child;
  SlideAnimationWrapper({
    @required this.slideDuration,
    @required this.fadeDuration,
    @required this.child
  });

  @override
  _SlideAnimationWrapperState createState() => _SlideAnimationWrapperState();
}

class _SlideAnimationWrapperState extends State<SlideAnimationWrapper> with TickerProviderStateMixin{
  
  
  AnimationController _slideController;
  AnimationController _fadeController; 
  Animation<Offset> _offset;
  Animation<double> _opacity;


  @override
  void initState() {
    _slideController = AnimationController(
      duration: widget.slideDuration,
      vsync: this
    )..forward();

    _fadeController = AnimationController(
      duration: widget.fadeDuration,
      vsync: this
    )..forward();

    _offset = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0,0)
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutBack
        
      )
    );
    
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.ease)
    ); 

    super.initState();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: FadeTransition(
        opacity: _opacity,
        child: widget.child,
      ),
    ); 
  }
}