using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace SharedLibraryTests.RadGridTests
{
    [MetadataType(typeof(CarMetadata))]
    public partial class Car
    {
    }

    public class CarMetadata
    {
        [ScaffoldColumn(false)]
        public object ModelName { get; set; }

        [HideIn(PageTemplate.Edit)]
        public object Manufacturer { get; set; }

        [HideIn(PageTemplate.List)]
        public object VIN { get; set; }
    }
}
