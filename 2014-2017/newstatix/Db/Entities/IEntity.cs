using System.Collections.Generic;
using System.Data.Objects;

namespace Db
{
    interface IEntity
	{
		void BeforeSave(StatixEntities context, ObjectStateEntry entry);
        void AfterSave(StatixEntities context, IEnumerable<ObjectStateEntry> entries);
	}
}
