const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { BusinessTrips } = this.entities;

    this.before('READ', '*', (req) => {
        if (!req.user || !req.user.id) req.reject(401, 'Not authenticated');
    });

    this.before('READ', BusinessTrips, (req) => {
        // Admin and BackofficeEmployee can see all BusinessTrips
        if(req.user.is('Admin') || req.user.is('BackofficeEmployee')) return;

        // Employees can only see their own BusinessTrips
        if(req.user.is('Employee')) {
            req.query.where('createdBy', '=', req.user.id);
            return;
        }

        // If no suitable role found, reject the request
        return req.reject(403, 'No suitable role found');
    });

    this.on('whoami', (req) => {
        return {
            id: req.user.id,
            roles: req.user.roles,
            isEmployee: req.user.is('Employee'),
            isBackofficeEmployee: req.user.is('BackofficeEmployee'),
            isAdmin: req.user.is('Admin')
        }
    });
});