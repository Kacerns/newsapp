import 'package:equatable/equatable.dart';

abstract class WebViewLoadingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WebViewLoading extends WebViewLoadingState {}

class WebViewLoaded extends WebViewLoadingState {}
