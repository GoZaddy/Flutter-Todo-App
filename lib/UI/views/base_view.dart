import 'package:provider/provider.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/locator.dart';



class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({
    @required this.builder,
    this.onModelReady
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {

  T model = locator<T>(); 
  @override
  void initState() {
    
    if(widget.onModelReady != null){
      widget.onModelReady(model);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ), 
    );
  }
}