namespace at.clouddna.BusinessTrips;

using { managed, cuid } from '@sap/cds/common';

@odata.draft.enabled
@Capability: {
    Insertable: true,
    Updatable: true,
    Deletable: true
}
entity BusinessTrips    : managed, cuid {
    startDate           : Date @mandatory @assert.range: ['$now', '9999-12-31'];
    endDate             : Date @mandatory @assert.range: ['$self.startDate', '9999-12-31'];
    destination         : Association to Destinations @mandatory;
    transportMode       : Association to TransportModes @mandatory;
    returnFlightRoute   : Association to FlightRoutes;
    outboundFlightRoute : Association to FlightRoutes;
    departureDate       : Date @assert.range: ['$self.startDate', '9999-12-31'];
    returnDate          : Date @assert.range: ['$self.departureDate', '9999-12-31'];
    needHotel           : Boolean default false;
    freeText            : LargeString;
    comments            : Composition of many Comments on comments.businessTrip = $self;
    attachments         : Composition of many Attachments on attachments.businessTrip = $self;
    status              : Association to Status @mandatory;
    flightBookingId     : String(100);
    hotelBookingId      : String(100);
}

entity CanceledTrips : managed, cuid {
    businessTrip     : Association to BusinessTrips @mandatory;
    reason           : LargeString @mandatory;
    cancelledAt      : Timestamp @default: $now;
}

entity ArchivedTrips : managed, cuid {
    businessTrip     : Association to BusinessTrips @mandatory;
    archivedAt       : Timestamp @default: $now;
}

@Capability: {
    Insertable: true
}
entity Comments   : managed, cuid {
    businessTrip  : Association to BusinessTrips @mandatory;
    text          : LargeString @mandatory;
}

@Capability: {
    Insertable: true
}
entity Destinations : managed, cuid {
    city            : String(100) @mandatory;
}

@Capability: {
    Insertable: true
}
entity TransportModes : managed, cuid {
    mode              : String(50) @mandatory;
}

@Capability: {
    Insertable: true
}
entity Airports     : managed {
    key code        : String(3) @mandatory @assert.format: '^[A-Z]{3}$'; // IATA code
    name            : String(100) @mandatory;
    city            : String(100) @mandatory;
}

@Capability: {
    Insertable: true
}
entity Status       : managed, cuid {
    name            : String(50) @mandatory;
}

@Capability: {
    Insertable: true
}
entity Attachments : managed, cuid {
    businessTrip   : Association to BusinessTrips @mandatory;
    image          : LargeBinary @Core.MediaType: 'image/*';
    description    : LargeString;
}

@Capability: {
    Insertable: true
}
entity Airlines   : managed {
    key code      : String(3) @mandatory @assert.format: '^[A-Z]{3}$'; // IATA airline code
    name          : String(100) @mandatory;
}

@Capability: {
    Insertable: true
}
entity FlightRoutes : managed, cuid {
    airline         : Association to Airlines @mandatory;
    flightNumber    : Association to FlightNumbers @mandatory;
}

@Capability: {
    Insertable: true
}
entity FlightNumbers  : managed, cuid {
    number            : String(4) @mandatory @assert.format: '^[0-9]{1,4}$'; // Flight number (1 to 4 digits)
    departureLocation : Association to Airports @mandatory;
    arrivalLocation   : Association to Airports @mandatory;
    departureTime     : Time @mandatory @assert.range: ['00:00:00', '23:59:59'];
    arrivalTime       : Time @mandatory @assert.range: ['00:00:00', '23:59:59'];
}