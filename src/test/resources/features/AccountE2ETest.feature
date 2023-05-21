#End 2 End Account Testing
#Create Account
#Add Address
#Add Phone
#Add Car
#Get Account
@Regression
Feature: End To End Testing

  Background: Setup Url and steps
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = callonce read('GenerateTokenReal.feature')
    * def token = token.response.token

  #Create Account
  Scenario: Create Account Add Address ,Phone and Car then get the Account
    * def dataGenerator = Java.type('data.provider.GenerateDataReal')
    * def newData = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
       
       "email": "#(newData)",
       "firstName": "Ahmad",
       "lastName": "Omar",
       "title": "Mr",
       "gender": "MALE",
       "maritalStatus": "MARRIED",
       "employmentStatus": "Software Tester",
       "dateOfBirth": "1990-05-13",
       
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == newData
    * def id = response.id
    #Add Address
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      
      "addressType": "Home",
      "addressLine1": "1234 somthing Ave N",
      "city": "Seattle",
      "state": "Washington",
      "postalCode": "12345",
      "countryCode": "001",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.city == "Seattle"
    #Add Car
    * def carPlate = Java.type('data.provider.GenerateDataReal')
    * def newPlate = carPlate.getPlate()
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      
      "make": "Audi",
      "model": "A7",
      "year": "2020",
      "licensePlate": "#(newPlate)"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == newPlate
    #Add Phone
    * def phoneGenerator = Java.type('data.provider.GenerateDataReal')
    * def newPhone = phoneGenerator.getPhone()
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      
      "phoneNumber": "#(newPhone)",
      "phoneExtension": "8725",
      "phoneTime": "Mornings",
      "phoneType": "CellPhone"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneExtension == 8725
    #Get Account
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == newData
