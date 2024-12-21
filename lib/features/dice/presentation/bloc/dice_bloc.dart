import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dice_event.dart';
part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  DiceBloc() : super(DiceInitial()) {
    on<DiceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
