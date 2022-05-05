namespace UsersDb.DataContext
{
	/// <summary>
	/// Used to ease the logging.
	/// </summary>
	public interface IAuditable
	{
		int Id { get; set; }
		//string Key { get; }
	}
}
