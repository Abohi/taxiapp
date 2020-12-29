import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HitchykeDashBoardEvent extends Equatable {
  HitchykeDashBoardEvent();
}

class DashBoardStartEvent extends HitchykeDashBoardEvent {
  @override
  List<Object> get props => null;
}

class DashBoardDriverTripEvent extends HitchykeDashBoardEvent {
  @override
  List<Object> get props => null;
}

class DashBoardDriverEnterTripEvent extends HitchykeDashBoardEvent {
  @override
  List<Object> get props => null;
}
class DashBoardBackPressedEvent extends  HitchykeDashBoardEvent {
  String pageName;
  DashBoardBackPressedEvent({@required this.pageName} );

  @override
  List<Object> get props => [pageName];
}


