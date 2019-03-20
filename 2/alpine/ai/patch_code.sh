#!/bin/bash
set -x
echo "Adding NodeJS Application Insights Initialization"
sed  -i.bak -e "/var startTime = Date.now(),/a appInsights = require('applicationinsights'), " -e "/ghost, express, common, urlService, parentApp;/a appInsights.setup().start();\nif(process.env.AI_CLOUD_ROLE) { appInsights.defaultClient.context.tags['ai.cloud.role'] = process.env.AI_CLOUD_ROLE; };\nif(process.env.AI_CLOUD_ROLE_INSTANCE) { appInsights.defaultClient.context.tags['ai.cloud.roleInstance'] = process.env.AI_CLOUD_ROLE_INSTANCE; };" current/index.js
echo "Adding Admin Application Insights Initialization"
sed  -i.bak -e "/<\/head>/i$(cat app-insights-js-init.htm)" current/core/server/web/admin/views/default-prod.html
sed -i -e "s/%%APPINSIGHTS_INSTRUMENTATIONKEY%%/$APPINSIGHTS_INSTRUMENTATIONKEY/g" -e "s/%%AI_ROLE_NAME%%/$AI_CLOUD_ROLE/g" -e "s/%%AI_ROLE_INSTANCE%%/$AI_CLOUD_ROLE_INSTANCE/g" current/core/server/web/admin/views/default-prod.html
