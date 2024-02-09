import 'dart:async';

import 'package:api_bloc_practise/app_exceptions.dart';
import 'package:api_bloc_practise/quote_model.dart';
import 'package:api_bloc_practise/urls.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api_helper.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  ApiHelper apiHelper;

  QuoteBloc({required this.apiHelper}) : super(QuoteInitialState()) {
    on<GetQuotesEvent>((event, emit) async{
      emit(QuoteLoadingState());

      try {
        var resJson = await apiHelper.getAPI(url: Urls.getQuotesUrl);
        if(resJson!=null){
          var mResData = DataModel.fromJson(resJson);
          emit(QuoteLoadedState(resData: mResData));
        } else {
          emit(QuoteErrorState(errorMsg: "uhh..No!!, Error Occurred."));
        }
      } catch(e){
        emit(QuoteErrorState(errorMsg: (e as AppExceptions).toErrorMsg()));
      }

      
    });
  }
}
