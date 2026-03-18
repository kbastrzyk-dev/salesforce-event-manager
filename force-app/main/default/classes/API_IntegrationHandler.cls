public with sharing class API_IntegrationHandler {
    
    // 1. We use the @future annotation and explicitly tell Salesforce it includes a web callout
    @future(callout=true)
    public static void fetchRandomCatFact() {
        
        // 2. Set up the HTTP Request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // 3. Configure the Request (Where are we going, and how?)
        request.setEndpoint('https://catfact.ninja/fact');
        request.setMethod('GET'); 
        
        // 4. Send the Request and capture the Response
        HttpResponse response = http.send(request);
        
        // 5. Check if it was successful (HTTP Status Code 200 means OK)
        if(response.getStatusCode() == 200) {
            // Print the payload we got back from the external server!
            System.debug('External System Response: ' + response.getBody());
        } else {
            System.debug('The callout failed with status: ' + response.getStatusCode());
        }
    }
}