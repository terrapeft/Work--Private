use newcentralusers

/*
	BACO-263
*/


/* Rename group */
update [NewCentralUsers].[dbo].[EdenGroup]
set edgText = 'Area of Responsibility'
where edgPublicationID = 5027 and edgText = 'Areas of Interest'

commit 