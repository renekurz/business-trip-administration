using { at.clouddna.BusinessTrips as bt } from '../db/schema';

service BusinessTripService @(requires: 'authenticated') {
    // Hauptentitäten
    entity BusinessTrips as projection on bt.BusinessTrips;
    entity Comments as projection on bt.Comments;
    entity Attachments as projection on bt.Attachments;
    entity CanceledTrips as projection on bt.CanceledTrips;
    entity ArchivedTrips as projection on bt.ArchivedTrips;
    
    // Stammdaten
    entity Destinations as projection on bt.Destinations;
    entity TransportModes as projection on bt.TransportModes;
    entity Airports as projection on bt.Airports;
    entity Status as projection on bt.Status;
    entity Airlines as projection on bt.Airlines;
    entity FlightRoutes as projection on bt.FlightRoutes;
    entity FlightNumbers as projection on bt.FlightNumbers;
    
    // Aktionen für alle Benutzertypen
    action updateFlightBooking(businessTripId: UUID, flightBookingId: String) returns String;
    action updateHotelBooking(businessTripId: UUID, hotelBookingId: String) returns String;
    action changeStatus(businessTripId: UUID, newStatus: String) returns String;
    action cancelTrip(businessTripId: UUID, reason: String) returns String;
    action archiveOldTrips(olderThan: Date) returns String;
    action whoami() returns String;
}
