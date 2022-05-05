using System.Collections.Generic;
using UsersDb.DataContext;

namespace UsersDb.Code
{

    public class EntityComparer : IEqualityComparer<IAuditable>
    {
        private EntityComparer() { }
        
        public static EntityComparer Instance = new EntityComparer();

        public bool Equals(IAuditable x, IAuditable y)
        {
            return x.Id == y.Id;
        }

        public int GetHashCode(IAuditable obj)
        {
            return obj.GetHashCode();
        }
    }
}
