abstract class SignInEvent{}

class SignInTextChangedEvent extends SignInEvent{
  final String emailValue,passwordValue;
  SignInTextChangedEvent(this.emailValue,this.passwordValue);
}

class SignInSubmittedEvent extends SignInEvent{
  final String email,password;
  SignInSubmittedEvent(this.email,this.password);

}