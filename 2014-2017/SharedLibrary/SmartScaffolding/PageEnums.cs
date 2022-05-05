using System;

namespace SharedLibrary.SmartScaffolding
{

    /// <summary>
    /// Available page templates for dynamic data based sites.
    /// </summary>
	[Flags]
	public enum PageTemplate
	{
		Details = 1,
		Edit = 2,
		Insert = 4,
		List = 8,
		ListDetails = 16,
		CustomerView = 32,
		Delete = 64,
		Clone = 128,
        Popup = 256,
        Unknown = 512,
	}
}
