sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'at/clouddna/employee/test/integration/FirstJourney',
		'at/clouddna/employee/test/integration/pages/BusinessTripsList',
		'at/clouddna/employee/test/integration/pages/BusinessTripsObjectPage'
    ],
    function(JourneyRunner, opaJourney, BusinessTripsList, BusinessTripsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('at/clouddna/employee') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBusinessTripsList: BusinessTripsList,
					onTheBusinessTripsObjectPage: BusinessTripsObjectPage
                }
            },
            opaJourney.run
        );
    }
);