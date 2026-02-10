class Validators {
  static String? email(String? value){
    if(value == null || value.isEmpty){
      return 'Email wajib di isi';
    }
    if(!value.contains('@')){
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? password(String? value){
    if(value == null || value.isEmpty){
      return 'Password wajib di isi';
    }
    if(value.length < 6){
      return 'Password minimal 6 karakter';
    }
    return null;
  }
}