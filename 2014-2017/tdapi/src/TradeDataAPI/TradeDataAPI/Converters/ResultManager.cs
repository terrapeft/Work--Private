namespace TradeDataAPI.Converters
{
	using UsersDb.Helpers;

	/// <summary>
	/// Converters factory, chooses the right converter.
	/// </summary>
	public class ResultManager
	{
		/// <summary>
		/// Finds the appropriate converter.
		/// </summary>
		/// <param name="params">The parameters.</param>
		/// <returns>
		/// Converter instance.
		/// </returns>
		public static IResultConverter GetConverter(RequestParameters @params)
		{
			switch (@params.SearchParameters.Export.OutputFormat)
			{
				case ResultType.Xml:
					return new XmlConverter();
				case ResultType.Csv:
					return new CsvConverter(@params);
				case ResultType.Json:
					return new JsonConverter(@params);
				case ResultType.Count:
					return new ResultsCounter();
				default:
					// Just provides the "Not implemented" message.
					return new DefaultConverter();
			}
		}
	}
}
