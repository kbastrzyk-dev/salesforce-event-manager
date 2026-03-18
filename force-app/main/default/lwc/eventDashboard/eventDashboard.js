import { LightningElement, wire } from 'lwc';
import getUpcomingEvents from '@salesforce/apex/EventDashboardController.getUpcomingEvents';

export default class EventDashboard extends LightningElement {
    
    // This automatically fetches the events when the component loads
    @wire(getUpcomingEvents)
    events; 

}