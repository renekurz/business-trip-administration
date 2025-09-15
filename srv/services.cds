using { at.clouddna.BusinessTrips as bt } from '../db/schema';

service EmployeeService @(requires: 'Employee') {
    entity BusinessTrips @(restrict: [
        { grant: 'READ', to: 'Employee' },
        { grant: 'CREATE', to: 'Employee' },
        { grant: 'UPDATE', to: 'Employee', where: 'createdBy = $user and status.name = "NEU"' },
        { grant: 'DELETE', to: 'Employee', where: 'createdBy = $user and status.name = "NEU"' }
    ]) as projection on bt.BusinessTrips;
    
    entity Comments @(restrict: [
        { grant: 'READ', to: 'Employee' },
        { grant: 'CREATE', to: 'Employee' }
    ]) as projection on bt.Comments;
    
    entity Attachments @(restrict: [
        { grant: 'READ', to: 'Employee' },
        { grant: 'CREATE', to: 'Employee' },
        { grant: 'DELETE', to: 'Employee', where: 'createdBy = $user' }
    ]) as projection on bt.Attachments;
    
    entity Destinations @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.Destinations;

    entity TransportModes @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.TransportModes;

    entity Airports @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.Airports;

    entity Status @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'name = "BEREIT"' }
    ]) as projection on bt.Status;

    entity Airlines @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.Airlines;

    entity FlightRoutes @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.FlightRoutes;

    entity FlightNumbers @(restrict: [
        { grant: 'READ', to: 'Employee', where: 'exists (SELECT 1 FROM BusinessTrips WHERE status.name = "BEREIT")' }
    ]) as projection on bt.FlightNumbers;
}

service BackofficeEmployeeService @(requires: 'BackofficeEmployee') {
    entity BusinessTrips as projection on bt.BusinessTrips;
    entity Comments as projection on bt.Comments;
    entity Attachments as projection on bt.Attachments;
    
    // Stammdaten: nur lesen (außer Buchungscodes)
    @readonly entity Destinations as projection on bt.Destinations;
    @readonly entity TransportModes as projection on bt.TransportModes;
    @readonly entity Airports as projection on bt.Airports;
    entity Status as projection on bt.Status;
    @readonly entity Airlines as projection on bt.Airlines;
    @readonly entity FlightRoutes as projection on bt.FlightRoutes;
    @readonly entity FlightNumbers as projection on bt.FlightNumbers;
    
    // Aktionen für Backoffice
    action updateflightBooking(businessTripId: UUID, flightBookingId: String) returns String;
    action updateHotelBooking(businessTripId: UUID, hotelBookingId: String) returns String;
    action changeStatus(businessTripId: UUID, newStatus: String) returns String;
    action cancelTrip(businessTripId: UUID, reason: String) returns String;
}

service AdminService @(requires: 'Admin') {
    // Administrator hat Vollzugriff auf alle Entitäten
    entity BusinessTrips as projection on bt.BusinessTrips;
    entity Comments as projection on bt.Comments;
    entity Attachments as projection on bt.Attachments;
    
    // Stammdatenpflege
    entity Destinations as projection on bt.Destinations;
    entity TransportModes as projection on bt.TransportModes;
    entity Airports as projection on bt.Airports;
    entity Status as projection on bt.Status;
    entity Airlines as projection on bt.Airlines;
    entity FlightRoutes as projection on bt.FlightRoutes;
    entity FlightNumbers as projection on bt.FlightNumbers;
    
    // Aktionen für Administrator
    action archiveOldTrips(olderThan: Date) returns String;
}