
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_event.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_state.dart';



class HitchykeDashBoardBloc extends Bloc<HitchykeDashBoardEvent, HitchykeDashBoardState> {

  @override
  HitchykeDashBoardState get initialState => DashBoardNotInitializedState();

  @override
  Stream<HitchykeDashBoardState> mapEventToState(HitchykeDashBoardEvent event) async* {
     if  (event is DashBoardStartEvent) {

      yield DashBoardNotInitializedState();
    }else if(event is DashBoardDriverTripEvent){

       yield DashBoardDriverTripState();
     }
     else if (event is DashBoardBackPressedEvent){
       if(event.pageName=="home"){
         yield DashBoardNotInitializedState();
       }

     }

     else if (event is DashBoardDriverEnterTripEvent){
       yield DashBoardDriverEnterTripState();
     }

  }
}