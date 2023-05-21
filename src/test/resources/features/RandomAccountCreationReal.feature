@Regression
Feature: Setup Test Generate Token

  Background: Create Account with Random Email
    * def tokenFeature = callonce read('GenerateTokenReal.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Ceate Account With random Email
    * def dataGenerator = Java.type('data.provider.GenerateDataReal')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
        "email": "#(autoEmail)",
        "firstName": "Ahmad",
        "lastName": "Khan",
        "title": "Mr",
        "gender": "MALE",
        "maritalStatus": "MARRIED",
        "employmentStatus": "software tester",
        "dateOfBirth": "1980-05-12",
      }
      """
    When method post
    Then status 201
    And print response
