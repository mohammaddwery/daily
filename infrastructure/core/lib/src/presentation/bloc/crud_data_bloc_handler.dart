import 'package:core/src/presentation/bloc/ui_state.dart';
import 'package:flutter/material.dart';
import '../../core/core_constants.dart';

/// Handle All the Async requests (remote or local)
/// This class handle the single object or list of objects case.
///
/// Please Use it when you deal with APIs or local caching(Shared Preferences)
///
abstract class CrudDataBlocHandler {

  int _setInitialState<T>({
    int? skip,
    required UiState<List<T>>? Function() getPrevState,
    required Function(UiState<List<T>>? uiState) setCurrentState,
  }) {
   if (skip == null) {
      if (getPrevState()?.data?.isNotEmpty ?? false) {
        skip = getPrevState()!.data!.length;
        setCurrentState(UiState.loadingMore(getPrevState()!.data!));
      } else {
        skip = 0;
        setCurrentState(UiState.loading());
      }
    } else {
      setCurrentState(UiState.loading());
    }
    return skip;
  }

  _setFinalState<T>({
    required int skip,
    required int limit,
    required onData,
    required UiState<List<T>>? Function() getPrevState,
    required List<T> currentData,
    required Function(UiState<List<T>>? uiState) setCurrentState,
  }) {
    UiState<List<T>>? uiState;
    bool loadMore = true;
    if (getPrevState()?.data?.isNotEmpty ?? false) {
      if (currentData.isNotEmpty) {
        if (currentData.length < limit) {
          loadMore = false;
          uiState = UiState.noMoreResults(getPrevState()!.data!..addAll(currentData));
        } else {
          uiState = UiState.success(skip == 0 ? currentData : getPrevState()!.data!
            ..addAll(currentData));
        }
      } else {
        loadMore = false;
        uiState = UiState.noMoreResults(getPrevState()!.data!);
      }
    } else {
      if (currentData.isNotEmpty) {
        if (currentData.length < limit) {
          loadMore = false;
          uiState = UiState.noMoreResults(currentData);
        } else {
          uiState = UiState.success(currentData);
        }
      } else {
        uiState = UiState.noResults();
      }
    }

    setCurrentState(uiState);
    onData(loadMore,);
  }

  _handleExceptionError<T>({
    required String message,
    required String debugPrintMessage,
    Function(UiState<T>? uiState)? setCurrentState,
    UiState<T>? Function()? getCurrentState,
    Function(String message)? onFailed,
  }) {
    debugPrint(debugPrintMessage);
    if(getCurrentState!=null && getCurrentState()?.data==null && setCurrentState!=null) {
      UiState<T> uiState = UiState.failure(message, oldData: getCurrentState()?.data);
      setCurrentState(uiState);
    }
    if (onFailed != null) onFailed(message);
  }

  /// Handle the Async requests (remote or local) which are dealing with list of objects with paging
  /// Use this when you want to display list of objects with paging that returned in response's body.
  ///
  ///
  handleCrudPagingDataList<T>({
    int? skip,
    required int limit,
    required UiState<List<T>>? Function() getCurrentState,
    required Function(UiState<List<T>>? uiState) setCurrentState,
    required Future<List<T>> Function(int calculatedSkip,) crudDataList,
    required Function(bool loadMore) onData,
    String? exceptionTag,
    Function(String message)? onError,
  }) async {
    try {
      int calculatedSkip = _setInitialState<T>(
        getPrevState: getCurrentState,
        skip: skip,
        setCurrentState: setCurrentState,
      );

      List<T> items = await crudDataList(calculatedSkip,);
      _setFinalState<T>(
        skip: calculatedSkip,
        limit: limit,
        getPrevState: getCurrentState,
        currentData: items,
        setCurrentState: setCurrentState,
        onData: onData,
      );
    } on FormatException catch (error) {
      debugPrint('$exceptionTag: FormatException: ${error.toString()}');
      UiState<List<T>>? uiState = UiState.failure(error.message, oldData: getCurrentState()?.data);
      setCurrentState(uiState);
      if (onError != null) onError(CoreConstants.generalErrorMessageKey);
    } catch (error) {
      debugPrint('$exceptionTag Exception: ${error.toString()}');
      UiState<List<T>>? uiState = UiState.failure(CoreConstants.generalErrorMessageKey, oldData: getCurrentState()?.data);
      setCurrentState(uiState);
      if (onError != null) onError(CoreConstants.generalErrorMessageKey);
    }
  }


  /// Handle the Async requests (remote or local) which don't need set or get functionalities.
  /// Use this when you need to make async request but only you need to display loading indicator
  /// Or when you want to start async operation but you don't want to wait the response.
  ///
  /// Example:
  ///   void signUp(BuildContext context) => handleVoidCrudDataItem(
  ///     onFailed: (message) => onSignUpFailed(context, message),
  ///     onSucceed: () => onSignUpSucceed(context),
  ///     exceptionTag: 'UserEmailSignUpScreenController signUp()',
  ///     voidCrudDataItem: () async {
  ///       AuthenticationModel authenticationModel = await _signUpUseCase.call(
  ///           createSignUpByEmailModel(),
  ///       );
  ///       await _saveUserLocallyUseCase.call(authenticationModel);
  ///       /// Nothing need to be returned here.
  ///     },
  ///   );
  ///
  handleVoidCrudDataItem({
    Function(String message)? onFailed,
    VoidCallback? onSucceed,
    required Function() voidCrudDataItem,
    required exceptionTag,
  }) async {
    try {
      await voidCrudDataItem();
      if(onSucceed!=null) onSucceed();
    } on FormatException catch (error) {
      _handleExceptionError(
        debugPrintMessage: '$exceptionTag: FormatException: ${error.message}',
        message: error.message,
        onFailed: onFailed,
      );
    } catch (error) {
      _handleExceptionError(
        debugPrintMessage: '$exceptionTag: Exception: ${error.toString()}',
        message: CoreConstants.generalErrorMessageKey,
        onFailed: onFailed,
      );
    }
  }

  /// Handle the Async requests (remote or local) which need set or get functionalities.
  /// Use this when you have UiState that need to be updated depending on
  /// the response of an async request.
  ///
  /// Example:
  ///   fetchProvider(int id) => handleCrudDataItem<Provider>(
  ///     exceptionTag: 'fetchProvider()',
  ///     getCurrentState: providerController.getValue,
  ///     setCurrentState: providerController.setValue,
  ///     crudDataItem: () async {
  ///       Provider provider = await _fetchProviderUseCase.call(id);
  ///       return provider;
  ///     },
  ///   );
  ///
  ///
  handleCrudDataItem<T>({
    UiState<T>? Function()? getCurrentState,
    Function(UiState<T>? uiState)? setCurrentState,
    Function(T value)? onSucceed,
    Function(String)? onFailed,
    required Future<T> Function() crudDataItem,
    required exceptionTag,
  }) async {
    try {
      UiState<T> uiState;
      if(setCurrentState!=null) {
        uiState = UiState.loading();
        setCurrentState(uiState);
      }
      T result = await crudDataItem();
      if(setCurrentState!=null) setCurrentState(UiState.success<T>(result));
      if(onSucceed!=null) onSucceed(result);
    } on FormatException catch (error) {
      _handleExceptionError<T>(
        debugPrintMessage: '$exceptionTag: FormatException: ${error.message}',
        message: error.message,
        setCurrentState: setCurrentState,
        getCurrentState: getCurrentState,
        onFailed: onFailed,
      );
    } catch (error) {
      _handleExceptionError<T>(
        debugPrintMessage: '$exceptionTag: Exception: ${error.toString()}',
        message: CoreConstants.generalErrorMessageKey,
        setCurrentState: setCurrentState,
        getCurrentState: getCurrentState,
        onFailed: onFailed,
      );
    }
  }

  /// Handle the Async requests (remote or local) which are dealing with list of objects
  /// Use this when you want to display list of objects that returned in response's body.
  ///
  ///   search(int categoryId) => handleCrudDataList<Provider>(
  ///     exceptionTag: 'searchForProviders()',
  ///     getCurrentState: searchResultsController.getValue,
  ///     setCurrentState: searchResultsController.setValue,
  ///     crudDataList: () async => _fetchProvidersSearchResultsUseCase.call(SearchQueryParam(
  ///       categoryId: categoryId,
  ///       keyword: '',
  ///     )),
  ///   );
  ///
  handleCrudDataList<T>({
    required UiState<List<T>>? Function() getCurrentState,
    required Function(UiState<List<T>>? uiState) setCurrentState,
    required Future<List<T>> Function() crudDataList,
    String? exceptionTag,
    Function(String)? onError,
    Function()? onData,
  }) async {
    try {
      UiState<List<T>>? uiState;
      if(getCurrentState()?.data?.isEmpty??true) {
        uiState = UiState.loading();
        setCurrentState(uiState);
      }
      List<T> result = await crudDataList();
      if (result.isNotEmpty) {
        uiState = UiState.success(result);
      } else {
        uiState = UiState.noResults();
      }
      setCurrentState(uiState);
      if(onData!=null) onData();
    } on FormatException catch (error) {
      _handleExceptionError<List<T>>(
        debugPrintMessage: '$exceptionTag FormatException: ${error.message}',
        message: error.message,
        setCurrentState: setCurrentState,
        getCurrentState: getCurrentState,
        onFailed: onError,
      );
    } catch (error) {
      _handleExceptionError<List<T>>(
        debugPrintMessage: '$exceptionTag: Exception: ${error.toString()}',
        message: CoreConstants.generalErrorMessageKey,
        setCurrentState: setCurrentState,
        getCurrentState: getCurrentState,
        onFailed: onError,
      );
    }
  }

  void dispose();
}
