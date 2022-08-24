abstract class ProductPageStates {}

class ProductPageInitState extends ProductPageStates {}

class ProductPageLoadingState extends ProductPageStates {}

class ProductPageSuccessState extends ProductPageStates {}

class ProductPageErrorState extends ProductPageStates {
  final String error;
  ProductPageErrorState(this.error);
}

class IncressCounterState extends ProductPageStates {}

class DecressCounterState extends ProductPageStates {}

class OpenDataBaseState extends ProductPageStates {}

class AddToCartState extends ProductPageStates {}

class GetFromMyCartState extends ProductPageStates {}

class DeleteFromMyCartState extends ProductPageStates {}
