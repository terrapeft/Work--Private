update siteconfig
set siteconfig.value = siteconfigdebug.value
from siteconfigdebug
where siteconfigdebug.id = siteconfig.id