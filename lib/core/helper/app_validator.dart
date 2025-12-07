abstract class AppValidator
{
  static String? emailValidator(String? value)
  {
    var emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[\w\.]+$');
    if(!emailRegex.hasMatch(value??''))
    {
      return 'Please enter valid email';
    }
    return null;
  }
  static String? passwordValidator(String? value)
  {
    if(value == null || value.isEmpty)
    {
      return 'Please enter password';
    }
    if(value.length < 6)
    {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? confirmPasswordValidator(String? value, String password)
  {
    if(value == null || value.isEmpty)
    {
      return 'Please enter password';
    }
    if(value != password)
    {
      return 'passwords do not match';
    }
    return null;
  }

  static String? phoneValidator(String? value)
  {
    var regex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    if(!regex.hasMatch(value??""))
    {
      return 'Please enter valid phone number';
    }
    return null;
  }

  static String? requiredValidator(String? value)
  {
    if(value == null || value.isEmpty)
    {
      return 'Please enter name';
    }
    return null;
  }
}