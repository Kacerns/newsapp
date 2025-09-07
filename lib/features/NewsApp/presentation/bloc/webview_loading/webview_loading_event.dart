import 'package:equatable/equatable.dart';

abstract class WebViewLoadingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WebViewStartedLoading extends WebViewLoadingEvent {}

class WebViewFinishedLoading extends WebViewLoadingEvent {}
