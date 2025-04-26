class LoadScenarioAction {}
class LoadScenarioSuccessAction {}
class LoadScenarioFailureAction {
  final String error;
  LoadScenarioFailureAction(this.error);
}