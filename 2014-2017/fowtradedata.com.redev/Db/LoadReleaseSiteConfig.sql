update siteconfig
set siteconfig.value = siteconfigrelease.value
from siteconfigrelease
where siteconfigrelease.id = siteconfig.id