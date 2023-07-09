import 'package:get/get.dart';

class BaseModel extends GetxController {
  var loading = false.obs;
  var error = ''.obs;

  bool get isLoading => loading.value;
  bool get hasError => error.value.isNotEmpty;

  setError(String err) {
    error.value = err;
  }

  clearError() {
    error.value = '';
  }

  setLoading(bool val) {
    loading.value = val;
    
  }
}
