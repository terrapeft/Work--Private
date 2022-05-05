0. Restore db backup.

1. To setup the site in IIS, simply create a new site and point it to:
\stash\FOW TradeData On Umbraco\FowTradeDataU\
I use the fowu.com alias and the same name for application pool.

2. To open the site itself, type its ip or alias e.g. http://fowu.com/
The user with app pool name e.g. IIS APPPOOL\fowu.com must be the owner of FOWTradeDataUmbraco db.

3.To open administrative interface, type

http://fowu.com/umbraco 
which stands for the folder
\stash\FOW TradeData On Umbraco\FowTradeDataU\umbraco

to log in into admin ui use credentials:

admin@local.ru
1234