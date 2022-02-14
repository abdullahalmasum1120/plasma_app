import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'requests_event.dart';

part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  List<BloodRequest> _requests = <BloodRequest>[];
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();

  RequestsBloc() : super(RequestsLoadingState()) {
    _firebaseDBRepo.requestsStream().listen((List<BloodRequest> requests) {
      _requests = requests;
      add(const LoadRequestsEvent());
    });
    on<LoadRequestsEvent>((event, emit) {
      if (event.searchKey == null) {
        emit(RequestsLoadedState(requests: _requests));
      } else {
        List<BloodRequest> searchedRequests = <BloodRequest>[];
        for (BloodRequest request in _requests) {
          if (request.bloodGroup!.contains(event.searchKey!)) {
            searchedRequests.add(request);
          }
        }
        emit(RequestsLoadedState(requests: searchedRequests));
      }
    });
  }
}
