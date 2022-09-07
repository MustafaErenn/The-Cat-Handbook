import 'package:flutter/material.dart';

class BaseView<T> extends StatefulWidget {
  final T? viewModel;
  final Function(T? model)? onModelReady;
  final VoidCallback? onDispose;
  final Widget Function(BuildContext? context, T? model) onPageBuilder;
  const BaseView({Key? key, this.viewModel, this.onModelReady, this.onDispose, required this.onPageBuilder})
      : super(key: key);
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends State<BaseView<T>> {
  T? model;
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, model);
  }
}
