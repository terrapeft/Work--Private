using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace SharedLibraryTests.RadGridTests
{
    [MetadataType(typeof(CarDesignerMetadata))]
    public partial class CarDesigner
    {
    }

    [ReadOnly(true)]
    public class CarDesignerMetadata
    {
        [ScaffoldColumn(false)]
        public object Name { get; set; }

        [HideIn(PageTemplate.Edit)]
        public object Address { get; set; }
    }
}
