import { LightningElement, api, wire } from 'lwc';
// Import the Apex method via its file path!
import getRelatedContacts from '@salesforce/apex/AccountDataController.getRelatedContacts';

export default class HelloWorld extends LightningElement {
    // 1. This magically grabs the ID of the Account we are looking at
    @api recordId; 

    // 2. This calls the Apex method, passes the recordId, and stores the result in "contacts"
    // The '$' tells the wire to re-run if the recordId ever changes
    @wire(getRelatedContacts, { accountId: '$recordId' })
    contacts;
}