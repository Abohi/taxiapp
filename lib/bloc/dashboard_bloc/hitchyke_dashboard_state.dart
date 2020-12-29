
import 'package:equatable/equatable.dart';


abstract class HitchykeDashBoardState extends Equatable {
  HitchykeDashBoardState();
}

class DashBoardNotInitializedState extends HitchykeDashBoardState {
  DashBoardNotInitializedState();
  @override
  List<Object> get props => null;
}

class DashBoardDriverTripState extends HitchykeDashBoardState {
  DashBoardDriverTripState();
  @override
  List<Object> get props => null;
}

class DashBoardDriverEnterTripState extends HitchykeDashBoardState {
  @override
  List<Object> get props => null;
}