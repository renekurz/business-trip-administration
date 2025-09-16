using BusinessTripService as service from '../../srv/services';

/** Restrictions */
// annotate service.BusinessTrips with @restrict: [
//   {
//     to: 'Employee',
//     when: 'before',
//     where: {
//       employeeID: '$user.id'
//     },
//     grant: 'READ'
//   },
//   {
//     to: 'Employee',
//     when: 'before',
//     grant: 'CREATE'
//   }
// ];

// annotate service.BusinessTrips with @restrict: [
//   {
//     to: 'BackofficeEmployee',
//     when: 'before',
//     where: {
//       status: 'READY'
//     },
//     grant: 'READ'
//   },
//   {
//     to: 'BackofficeEmployee',
//     when: 'before',
//     where: {
//       employeeID: '$user.id'
//     },
//     grant: 'CREATE'
//   }
// ];

// annotate service.BusinessTrips with @restrict: [
//   {
//     to: 'Admin',
//     grant: 'ALL'
//   }
// ];


/** Tables */
// Employee role: has a table with all business trips and a filter where he can filter for everyone his trips; he has a button to create a new trip for himself
annotate service.BusinessTrips with @(
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: startDate,
            Label: '{i18n>startDate}'
        },
        {
            $Type: 'UI.DataField',
            Value: endDate,
            Label: '{i18n>endDate}'
        },
        {
            $Type: 'UI.DataField',
            Value: destination.city,
            Label: '{i18n>destination}'
        },
        {
            $Type: 'UI.DataField',
            Value: transportMode.mode,
            Label: '{i18n>transportMode}'
        },
        {
            $Type: 'UI.DataField',
            Value: status.name,
            Label: '{i18n>status}'
        }
    ],
    UI.SelectionFields: [
        startDate,
        endDate,
        destination_ID,
        transportMode_ID,
        status_ID,
        createdBy
    ]
);



// BackofficeEmployee role: has a table with all business trips with status 'READY' and a filter where he can filter for everyone his trips; he has a button to create a new trip for himself




// Admin role: has more tabs with tables included: Business Trips, Flight Routes, Airlines, Airports, Flight Numbers, Destinations, Countries, Statuses
