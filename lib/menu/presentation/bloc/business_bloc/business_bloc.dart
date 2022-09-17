import 'package:ariztia_app/menu/data/models/business_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'business_event.dart';
part 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  BusinessBloc() : super(BusinessInitial()) {
    on<BusinessEvent>((event, emit) {});
    on<BusinessGetListEvent>((event, emit) {
      emit(BusinessListState(event.lisBusiness));
    });
    on<BusinessSelectOneEvent>((event, emit) {
      emit(BusinessSelectedState(event.id!, event.name!, const []));
    });
  }
}
