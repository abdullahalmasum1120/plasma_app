import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'add_request_state.dart';

class AddRequestCubit extends Cubit<AddRequestState> {
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();

  AddRequestCubit() : super(AddRequestInitialState());

  Future<void> addRequest({required BloodRequest request}) async {
    emit(AddingRequestState());
    BloodRequest bloodRequest =
        await _firebaseDBRepo.createRequest(bloodRequest: request);
    if (bloodRequest.phone != null) {
      emit(RequestAddedState());
    }
  }
}
