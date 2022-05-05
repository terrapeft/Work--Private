using System.Collections.Generic;
using System.Data.Objects;

namespace UsersDb.DataContext
{
    interface IEntity
	{
		void BeforeSave(UsersDataContext context, ObjectStateEntry entry);
        void AfterSave(UsersDataContext context, IEnumerable<ObjectStateEntry> entries);
	}
}
