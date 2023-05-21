@Regression
Feature: Create Account Test One

  #Scenario 10:
  #Endpoint = /api/accounts/add-primary-account.
  #This Endpoint is to create new account and data will store in primary_person table.
  #assert email address
  #Status Code = 201
  #Notes:
  #duplicate email not accepted
  #For Gender and maritalStatus You have to use the Predefined values.
  #Once you create Account validate database and take screenshot.
  #FirstName and LastName should be your name.
  #In Request body we don't need id and isNew field (you can remove them).
  Background: Setup URL for test
  Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateTokenReal.feature')
    And print result
    * def generatedToken =  result.response.token

  Scenario: Create Account Test
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "yama9@tek.us",
      "firstName": "yama",
      "lastName": "khan",
      "title": "Mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Driver",
      "dateOfBirth": "1989-05-12",
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.email == "yama9@tek.us"
    
    #delete the created account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
    
