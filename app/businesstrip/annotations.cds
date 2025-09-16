using BusinessTripService as service from '../../srv/services';

annotate service.BusinessTrips with @(
    UI.SelectionFields : [
        startDate,
        endDate,
        destination_ID
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Value : destination.city,
            Label : '{i18n>Destination}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : '{i18n>Status}',
        },
        {
            $Type : 'UI.DataField',
            Value : transportMode.mode,
            Label : '{i18n>Transport}',
        },
        {
            $Type : 'UI.DataField',
            Value : needHotel,
            Label : '{i18n>Hotel}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
    ],
);

annotate service.BusinessTrips with {
    startDate @Common.Label : '{i18n>Startdate}';
    endDate @Common.Label : '{i18n>Enddate}';
    destination @(
        Common.Label : '{i18n>Destination}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Destinations',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : destination_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : destination.city,
    );
    ID @(
        Common.Label : '{i18n>Employee}',
        Common.ExternalID : createdBy,
    );
    createdBy @Common.ExternalID : createdBy;
    createdBy @Common.Label : '{i18n>Employee}';
};

annotate service.Destinations with {
    ID @(
        Common.Text : city,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

