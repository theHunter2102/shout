class Validator{

  static String? validateEmail(String email){
    if(email.isEmpty){
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }
  static String? validateUsername(String username){
    if(username.isEmpty){
      return 'Username cannot be empty';
    }
    if(username.length < 3){
      return 'Username must be at least 3 characters';
    }

    return null;
  }
  static String? validatePassword(String password){
    if(password.isEmpty){
      return 'Password cannot be empty';
    }
    if(password.length < 6){
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? validateRePassword(String password, String rePassword,){
    if(password.isEmpty){
      return 'Please confirm your password';
    }
    if(password != rePassword){
      return 'Passwords do not match';
    }
    return null;
  }


}