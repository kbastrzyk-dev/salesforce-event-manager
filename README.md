# Salesforce Event & Waitlist Automation Engine

## Project Overview
Full-stack Salesforce application built for a fictional client ("Astro Tech") to automate their event registration process. The system automatically manages event capacity, blocks overbooking, and features a self-healing waitlist engine that automatically promotes users when spots open up.

## Key Features
* **Automated Capacity Management:** Apex Triggers automatically block users from registering for full events and route them to a Waitlist.
* **Auto-Promotion Engine:** When a registered user cancels, the backend automatically queries the database for the oldest waitlisted user and upgrades their status to 'Registered'.
* **Full-Stack Dashboard:** A custom Lightning Web Component (LWC) that queries live database metrics to display a reactive, real-time UI grid of upcoming events and their current capacity.
* **Declarative Foundation:** Utilizes Custom Objects (`Event__c`, `Attendee__c`), Master-Detail relationships, and Roll-Up Summary fields to minimize code and maximize platform limits.

## Technology Stack
* **Backend:** Apex (Triggers, Handler Pattern, SOQL)
* **Frontend:** Lightning Web Components (LWC), JavaScript, HTML, SLDS (Salesforce Lightning Design System)
* **Database:** Salesforce SOQL, Custom Objects, Roll-Up Summaries
